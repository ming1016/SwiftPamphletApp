//
//  EditInfoView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData
import SwiftSoup

struct EditInfoView: View {
    @Bindable var info: IOInfo
    @Binding var navigationPath: NavigationPath
    
    @Query(sort: [
        SortDescriptor(\IOCategory.updateDate)
    ]) var categories: [IOCategory]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("标题", text: $info.name)
                    TextField("地址", text: $info.url)
                        .onChange(of: info.url) { oldValue, newValue in
                            Task {
                                await fetchTitleFromUrl(urlString:newValue)
                            }
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
                    Button("添加和管理分类", action: addCate)
                }
                
                Section("描述") {
                    TextField("详细描述", text: $info.des, axis: .vertical)
                }
            }
            .navigationTitle("编辑资料")
            .navigationDestination(for: IOCategory.self) { cate in
                EditCategoryView(cate: cate)
            }
            .padding(30)
            Spacer()
        }
    }
    func addCate() {
        let cate = IOCategory(name: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cate)
        navigationPath.append(cate)
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


