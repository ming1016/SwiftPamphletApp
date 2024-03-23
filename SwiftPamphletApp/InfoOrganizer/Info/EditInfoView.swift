//
//  EditInfoView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData
import SwiftSoup
import SwiftHTMLtoMarkdown
import Ink

struct EditInfoView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var info: IOInfo
    
    @Query(IOCategory.all) var categories: [IOCategory]
    
    @State var isShowInspector = false
    @State var cate:IOCategory? = nil
    
    @State var urlContent = ""
    @State var selectedTab = 1
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        TextField("标题:", text: $info.name)
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
                        TextField("地址:", text: $info.url)
                            .onSubmit {
                                Task {
                                    info.name = "获取标题中......"
                                    let re = await fetchTitleFromUrl(urlString:info.url)
                                    DispatchQueue.main.async {
                                        if re.title.isEmpty == false {
                                            info.name = re.title
                                            urlContent = re.content
                                        }
                                    }
                                } // end Task
                            }
                            .onChange(of: info.url) { oldValue, newValue in
                                
                            }
                        if info.url.isEmpty == false {
                            Button {
                                gotoWebBrowser(urlStr: info.url)
                            } label: {
                                Image(systemName: "safari")
                            }
                            // TODO: 图片可选，下载到照片
                            Button {
                                Task {
                                    let re = await fetchTitleFromUrl(urlString:info.url, isFetchContent: true)
                                    
                                    DispatchQueue.main.async {
                                        if re.content.isEmpty == false {
                                            info.des = re.content
                                        }
                                    }
                                } // end Task
                            } label: {
                                Image(systemName: "square.and.arrow.down")
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
                
                Section(footer: Text("文本支持 markdown 格式")) {
                    // TODO: markdown 获取图片链接，并能显示
                    TabView(selection: $selectedTab) {
                        TextEditor(text: $info.des)
                            .tabItem { Label("文本", systemImage: "circle") }
                            .tag(1)
                        WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: info.des)), baseURLStr: "")
                            .tabItem { Label("预览", systemImage: "circle") }
                            .tag(2)
                        if !info.url.isEmpty {
                            WebUIView(urlStr: info.url)
                                .tabItem { Label("网页", systemImage: "circle") }
                                .tag(3)
                        }
                    }
                    .onChange(of: info.url) { oldValue, newValue in
                        tabSwitch()
                    }
                    .onAppear {
                        tabSwitch()
                    }
                }
            } // end form
            .padding(10)
            .inspector(isPresented: $isShowInspector) {
                EditCategoryView(cate: cate ?? IOCategory(name: "unavailable.com", infos: [IOInfo](), pin: 0, createDate: Date.now, updateDate: Date.now))
            }
            .toolbar {
                Button("关闭", systemImage: "sidebar.right") {
                    isShowInspector.toggle()
                }
                
            }
            Spacer()
        } // end VStack
    }
    func tabSwitch() {
        if info.url.isEmpty {
            selectedTab = 1
        } else {
            selectedTab = 3
        }
    }
    func addCate() {
        cate = IOCategory(name: "", infos: [IOInfo](), pin: 0, createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cate!)
        isShowInspector = true
    }
    func manageCate() {
        isShowInspector.toggle()
    }

    func fetchTitleFromUrl(urlString: String, isFetchContent: Bool = false) async -> (title:String, content:String) {
        var title = "没找到标题"
        guard let url = URL(string: urlString) else {
            return (title,"")
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return (title,"")
        }
        guard let homepageHTML = String(data: data, encoding: .utf8), let soup = try? SwiftSoup.parse(homepageHTML) else {
            return (title,"")
        }
        
        // 获取标题
        let soupTitle = try? soup.title()
        let h1Title = try? soup.select("h1").first()?.text()
        if let okH1Title = h1Title {
            title = okH1Title
        }
        if soupTitle?.isEmpty == false {
            title = soupTitle ?? "没找到标题"
        }
        
        // HTML 转 Markdown
        var content = ""
        if isFetchContent == true {
            do {
                var document = BasicHTML(rawHTML: homepageHTML)
                try document.parse()
                        
                content = try document.asMarkdown()
            } catch {
                print("html to markdown fail")
            }
        }
        
        return (title, content)
    }
}


