//
//  InfoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData

struct InfoListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var searchText = ""
    @Binding var selectInfo:IOInfo?
    @State private var sortOrder = [SortDescriptor(\IOInfo.updateDate, order: .reverse)]
    
    @Query(sort: [SortDescriptor(\IOCategory.updateDate, order: .reverse)]) var cates: [IOCategory]
    @State private var filterCate = ""
    
    var body: some View {
        if filterCate.isEmpty {
            InfosView(searchString: searchText, selectInfo: $selectInfo, sortOrder: sortOrder)
                .navigationTitle("资料列表")
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button("添加资料", systemImage: "plus", action: addInfo)
                    }
                    ToolbarItem(placement: .navigation) {
                        Menu("Sort", systemImage: "tag") {
                            
                            Picker("分类", selection: $filterCate) {
                                Text("全部")
                                    .tag("")
                                
                                ForEach(cates) { cate in
                                    Text(cate.name)
                                        .tag(cate.name)
                                }
                            }
                            Picker("排序", selection: $sortOrder) {
                                Text("正序")
                                    .tag([SortDescriptor(\IOInfo.updateDate)])
                                Text("倒序")
                                    .tag([SortDescriptor(\IOInfo.updateDate, order: .reverse)])
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            modelContext.undoManager?.undo()
                        }, label: {
                            Image(systemName: "arrow.left")
                        })
                        .disabled(modelContext.undoManager?.canUndo == false)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            modelContext.undoManager?.redo()
                        }, label: {
                            Image(systemName: "arrow.right")
                        })
                        .disabled(modelContext.undoManager?.canRedo == false)
                    }
                }
                .searchable(text: $searchText)
        } else {
            InfosFilterWithCateView(filterCateName: filterCate, selectInfo: $selectInfo, sortOrder: sortOrder)
                .navigationTitle("分类 - \(filterCate)")
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button("添加资料", systemImage: "plus", action: addInfoWithCate)
                    }
                    ToolbarItem(placement: .navigation) {
                        Menu("Sort", systemImage: "tag") {
                            Picker("分类", selection: $filterCate) {
                                Text("全部")
                                    .tag("")
                                ForEach(cates) { cate in
                                    Text(cate.name)
                                        .tag(cate.name)
                                }
                            }
                            Picker("排序", selection: $sortOrder) {
                                Text("正序")
                                    .tag([SortDescriptor(\IOInfo.updateDate)])
                                Text("倒序")
                                    .tag([SortDescriptor(\IOInfo.updateDate, order: .reverse)])
                            }
                            
                        }
                    }
                }
        }
        
    }
    
    func addInfo() {
        let info = IOInfo(name: "简单记录", url: "", des: "\n", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(info)
        selectInfo = info
    }
    func addInfoWithCate() {
        let info = IOInfo(name: "\(filterCate) - 简单记录", url: "", des: "\n", createDate: Date.now, updateDate: Date.now)
        for cate in cates {
            if cate.name == filterCate {
                info.category = cate
            }
        }
        modelContext.insert(info)
        selectInfo = info
    }
    
}


