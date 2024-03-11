//
//  EditInfoView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData

struct EditInfoView: View {
    @Bindable var info: IOInfo
    @Binding var navigationPath: NavigationPath
    
    @Query(sort: [
        SortDescriptor(\IOCategory.updateDate)
    ]) var categories: [IOCategory]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Form {
            Section {
                TextField("名字", text: $info.name)
                TextField("地址", text: $info.url)
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
                Button("添加一个新分类", action: addCate)
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
    }
    func addCate() {
        let cate = IOCategory(name: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cate)
        navigationPath.append(cate)
    }
}


