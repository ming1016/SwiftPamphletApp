//
//  EditInfoView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData
import SwiftSoup
import CodeEditor

struct EditInfoView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var info: IOInfo
    
    @Query(sort: [
        SortDescriptor(\IOCategory.updateDate, order: .reverse)
    ]) var categories: [IOCategory]
    
    @State var isShowInspector = false
    @State var cate:IOCategory? = nil
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("标题", text: $info.name)
                    HStack {
                        TextField("地址", text: $info.url)
                            .onChange(of: info.url) { oldValue, newValue in
                                Task {
                                    await fetchTitleFromUrl(urlString:newValue)
                                }
                            }
                        Button {
                            gotoWebBrowser(urlStr: info.url)
                        } label: {
                            Label("浏览器打开", systemImage: "safari")
                        } // end Button
                    }
                }
                
                Section("选择分类") {
                    Picker("分类", selection: $info.category) {
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
                
                Section("备注") {
                    TextEditor(text: $info.des)
                }
            }
            .navigationTitle("编辑资料")
            .padding(30)
            .inspector(isPresented: $isShowInspector) {
                EditCategoryView(cate: cate ?? IOCategory(name: "unavailable.com", createDate: Date.now, updateDate: Date.now))
            }
            .toolbar {
                Button("关闭", systemImage: "sidebar.right") {
                    isShowInspector.toggle()
                }
                
            }
            Spacer()
        }
    }
    func addCate() {
        cate = IOCategory(name: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cate!)
        isShowInspector = true
    }
    func manageCate() {
        isShowInspector.toggle()
    }

    func fetchTitleFromUrl(urlString: String) async {
        guard let url = URL(string: urlString) else {
            return
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return
        }
        guard let homepageHTML = String(data: data, encoding: .utf8), let soup = try? SwiftSoup.parse(homepageHTML) else {
            return
        }
        
        var title = "无标题"
        let soupTitle = try? soup.title()
        let h1Title = try? soup.select("h1").first()?.text()
        if let okH1Title = h1Title {
            title = okH1Title
        }
        if soupTitle?.isEmpty == false {
            title = soupTitle ?? "没找到标题"
        }
        info.name = title
    }
}


