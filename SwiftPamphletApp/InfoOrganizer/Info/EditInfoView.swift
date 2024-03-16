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
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("标题:", text: $info.name)
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
//                            .onChange(of: info.url) { oldValue, newValue in
//                                
//                            }
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
                    Picker("分类:", selection: $info.category) {
                        Text("未分类")
                            .tag(Optional<IOCategory>.none)
                        if categories.isEmpty == false {
                            Divider()
                            ForEach(categories) { cate in
                                Text(cate.name)
                                    .tag(Optional(cate))
                            }
                        }
                    }
                    .onChange(of: info.category) { oldValue, newValue in
                        info.category?.updateDate = Date.now
                    }
                    HStack {
                        Button("添加分类", action: addCate)
                        Button("管理分类", action: manageCate)
                    }
                }
                
                Section {
//                    TextEditor(text: $info.des)
//                        .tabItem { Label("文本", systemImage: "circle") }
                    // TODO: markdown 获取图片链接，并能显示
                    TabView {
                        TextEditor(text: $info.des)
                            .tabItem { Label("文本", systemImage: "circle") }
                        WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: info.des)), baseURLStr: "")
                            .tabItem { Label("预览", systemImage: "circle") }
                    }
                }
            } // end form
            .navigationTitle("编辑资料")
            .padding(10)
            .inspector(isPresented: $isShowInspector) {
                EditCategoryView(cate: cate ?? IOCategory(name: "unavailable.com", createDate: Date.now, updateDate: Date.now))
            }
            .toolbar {
                Button("关闭", systemImage: "sidebar.right") {
                    isShowInspector.toggle()
                }
                
            }
            Spacer()
        } // end VStack
    }
    func addCate() {
        cate = IOCategory(name: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cate!)
        isShowInspector = true
    }
    func manageCate() {
        isShowInspector.toggle()
    }

    func fetchTitleFromUrl(urlString: String, isFetchContent: Bool = false) async -> (title:String, content:String) {
        guard let url = URL(string: urlString) else {
            return ("","")
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return ("","")
        }
        guard let homepageHTML = String(data: data, encoding: .utf8), let soup = try? SwiftSoup.parse(homepageHTML) else {
            return ("","")
        }
        
        // 获取标题
        var title = "没找到标题"
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


