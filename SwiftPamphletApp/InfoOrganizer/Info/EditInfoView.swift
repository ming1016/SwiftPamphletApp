//
//  EditInfoView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData
import SwiftSoup
import Ink
import PhotosUI

struct EditInfoView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var info: IOInfo
    
    @Query(IOCategory.all) var categories: [IOCategory]
    
    @State var isShowInspector = false
    @State var cate:IOCategory? = nil
    
    @State var selectedTab = 1
    
    @State var isStopLoadingWeb = false
    // webarchive
    @State var savingDataTrigger = false

    // 图集
    @State var selectedPhotos = [PhotosPickerItem]()
    @State var addWebImageUrl = ""
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        TextField("标题:", text: $info.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Toggle(isOn: $info.star) {
                            Image(systemName: info.star ? "star.fill" : "star")
                        }
                        .toggleStyle(.button)
                        
                        Button(action: {
                            info.updateDate = Date.now
                        }, label: {
                            Image(systemName: "arrow.up.square")
                        })
                    }
                    HStack {
                        TextField("地址:", text: $info.url, prompt: Text("输入或粘贴 url，例如 https://www.starming.com"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onSubmit {
                                Task {
                                    // MARK: 获取 Web 内容
                                    info.name = "获取标题中......"
                                    let re = await fetchTitleFromUrl(urlString:info.url)
                                    DispatchQueue.main.async {
                                        if re.title.isEmpty == false {
                                            info.name = re.title
                                            if re.imageUrl.isEmpty == false {
                                                IOInfo.updateCoverImage(info: info, img: IOImg(url: re.imageUrl))
                                            }
                                            info.imageUrls = re.imageUrls
                                        }
                                    }
                                } // end Task
                            }
                        if info.url.isEmpty == false {
                            Button {
                                gotoWebBrowser(urlStr: info.url)
                            } label: {
                                Image(systemName: "safari")
                            }
                            // 本地存
                            Button {
                                if info.webArchive == nil {
                                    savingDataTrigger = true
                                } else {
                                    info.webArchive = nil
                                }
                            } label: {
                                if info.webArchive == nil {
                                    Image(systemName: "square.and.arrow.down")
                                } else {
                                    Image(systemName: "square.and.arrow.down.fill")
                                }
                            }
                        } // end if
                    }
                } // end Section
                
                Section {
                    
                    HStack {
                        Picker("分类:", selection: $info.category) {
                            Text("未分类")
                                .tag(Optional<IOCategory>.none)
                            if categories.isEmpty == false {
                                Divider()
                                ForEach(categories) { cate in
                                    HStack {
                                        if cate.pin == 1 {
                                            Image(systemName: "pin.fill")
                                        }
                                        Text(cate.name)
                                    }
                                    .tag(Optional(cate))
                                }
                            }
                        }
                        .onHover(perform: { hovering in
                            info.category?.updateDate = Date.now
                        })
                        Button("添加分类", action: addCate)
                        Button("管理分类", action: manageCate)
                    }
                }
                // MARK: Tab 切换
                Section(footer: Text("文本支持 markdown 格式")) {
                    // TODO: markdown 获取图片链接，并能显示
                    TabView(selection: $selectedTab) {
                        TextEditor(text: $info.des)
                            .overlay(
                                Rectangle()
                                    .stroke(.secondary, lineWidth: 1)
                                    .opacity(0.5)
                              )
                            .disableAutocorrection(true)
                            .padding(10)
                            .tabItem { Label("文本", systemImage: "circle") }
                            .tag(1)
                        WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: info.des)), baseURLStr: "")
                            .tabItem { Label("预览", systemImage: "circle") }
                            .tag(2)
                        if let url = URL(string: info.url) {
                            VStack {
                                WebUIViewWithSave(
                                    urlStr: url.absoluteString,
                                    savingDataTrigger: $savingDataTrigger,
                                    savingData: $info.webArchive,
                                    isStop: $isStopLoadingWeb
                                )
                                TextField(text: $info.des, prompt: Text("输入文本进行记录"), axis: .vertical) {}
                                    .padding(5)
                            }
                                .tabItem { Label("网页", systemImage: "circle") }
                                .tag(4)
                        }
                        VStack {
                            HStack {
                                PhotosPicker(selection: $selectedPhotos, matching: .not(.videos)) {
                                    Label("选择照片图片", systemImage: "photo.on.rectangle.angled")
                                }
                                .onChange(of: selectedPhotos) { oldValue, newValue in
                                    convertDataToImage()
                                }
                                TextField("添加图片 url:", text: $addWebImageUrl)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onSubmit {
                                        if let webImageUrl = URL(string: addWebImageUrl) {
                                            info.imgs?.append(IOImg(url: webImageUrl.absoluteString))
                                            addWebImageUrl = ""
                                        }
                                    }
                            }
                            ScrollView {
                                if let infoImgs = info.imgs {
                                    if infoImgs.count > 0 {
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150),spacing: 10)]) {
                                            ForEach(Array(infoImgs.enumerated()), id:\.0) {i, img in
                                                VStack {
                                                    if let data = img.imgData {
                                                        if let nsImg = NSImage(data: data) {
                                                            Image(nsImage: nsImg)
                                                                .resizable()
                                                                .scaledToFit()
                                                                .cornerRadius(5)
                                                                .contextMenu {
                                                                    Button {
                                                                        IOInfo.updateCoverImage(info: info, img: img)
                                                                    } label: {
                                                                        Label("设为封面图", image: "doc.text.image")
                                                                    }
                                                                    Button {
                                                                        info.imgs?.remove(at: i)
                                                                        IOImg.delete(img)
                                                                    } label: {
                                                                        Label("删除", image: "circle")
                                                                    }

                                                                }
                                                        }
                                                    } else if img.url.isEmpty == false {
                                                        NukeImage(url: img.url)
                                                        .contextMenu {
                                                            Button {
                                                                IOInfo.updateCoverImage(info: info, img: IOImg(url: img.url))
                                                            } label: {
                                                                Label("设为封面图", image: "doc.text.image")
                                                            }
                                                            Button {
                                                                info.imgs?.remove(at: i)
                                                                IOImg.delete(img)
                                                            } label: {
                                                                Label("删除", image: "circle")
                                                            }
                                                        }
                                                    }
                                                } // end VStack
                                            } // end ForEach
                                        } // end LazyVGrid
                                    }
                                } // end if let
                                if info.imageUrls.isEmpty == false {
                                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 10)]) {
                                        ForEach(info.imageUrls, id:\.self) { img in
                                            NukeImage(url: img)
                                            .contextMenu {
                                                Button {
                                                    IOInfo.updateCoverImage(info: info, img: IOImg(url: img))
                                                } label: {
                                                    Label("设为封面图", image: "doc.text.image")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(10)
                        .tabItem { Label("图集", systemImage: "circle")}
                        .tag(5)
                    }
                    .onChange(of: info.url) { oldValue, newValue in
                        tabSwitch()
                        isStopLoadingWeb = false
                    }
                    .onAppear {
                        tabSwitch()
                    }
                }
            } // end form
            .padding(10)
            .inspector(isPresented: $isShowInspector) {
                EditCategoryView(cate: cate ?? IOCategory(name: "unavailable.com", pin: 0, createDate: Date.now, updateDate: Date.now))
            }
            .toolbar {
                Button("关闭", systemImage: "sidebar.right") {
                    isShowInspector.toggle()
                }
                
            }
            Spacer()
        } // end VStack
    }
    
    
    // MARK: 数据管理
    func tabSwitch() {
        if info.url.isEmpty {
            selectedTab = 1
        } else {
            selectedTab = 4
        }
    }
    func addCate() {
        cate = IOCategory(name: "", pin: 0, createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cate!)
        isShowInspector = true
    }
    func manageCate() {
        isShowInspector.toggle()
    }
    
    // MARK: 图集处理
    @MainActor
    func convertDataToImage() {
        if !selectedPhotos.isEmpty {
            for item in selectedPhotos {
                Task {
                    if let imageData = try? await item.loadTransferable(type: Data.self) {
                        info.imgs?.append(IOImg(url: "", imgData: imageData))
                    }
                }
            }
        }
        selectedPhotos.removeAll()
    }
    
    // MARK: 获取网页内容
    func fetchTitleFromUrl(urlString: String, isFetchContent: Bool = false) async -> (title:String, imageUrl:String, imageUrls:[String]) {
        var title = "没找到标题"
        guard let url = URL(string: urlString) else {
            return (title,"",[String]())
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return (title,"",[String]())
        }
        guard let homepageHTML = String(data: data, encoding: .utf8), let soup = try? SwiftSoup.parse(homepageHTML) else {
            return (title,"",[String]())
        }
        
        // 获取标题
        let soupTitle = try? soup.title()
        let h1Title = try? soup.select("h1").first()?.text()
        
        var imageUrl = ""
        var imageUrls = [String]()
        
        // 获取图集
        
        do {
            let imgs = try soup.select("img").array()
            if imgs.count > 0 {

                for elm in imgs {
                    if let elmUrl = try? elm.attr("src") {
                        if elmUrl.isEmpty == false {
                            imageUrls.append(urlWithSchemeAndHost(url: url, urlStr: elmUrl))
                        }
                    }
                }
                var imgUrl:String?
                if imageUrls.count > 0 {
                    if imageUrls.count > 3 {
                        imgUrl = imageUrls.randomElement()
                    } else {
                        imgUrl = imageUrls.first
                    }
                    if let okImgUrl = imgUrl {
                        imageUrl = urlWithSchemeAndHost(url: url, urlStr: okImgUrl)
                    }
                }
                
            }
        } catch {}


        if let okH1Title = h1Title {
            title = okH1Title
        }
        if soupTitle?.isEmpty == false {
            title = soupTitle ?? "没找到标题"
        }
        
        return (title, imageUrl, imageUrls)
    }
}


