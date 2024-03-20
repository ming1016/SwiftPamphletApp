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
    @State var limit: Int = 100
    
    var body: some View {
        InfosView(filterCateName: filterCate, searchString: searchText, selectInfo: $selectInfo, sortOrder: sortOrder, limit: $limit)
            .navigationTitle("资料列表")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("添加资料", systemImage: "plus", action: addInfo)
                }
                ToolbarItem(placement: .navigation) {
                    Picker("分类", selection: $filterCate) {
                        Text("全部")
                            .tag("")
                        
                        ForEach(cates) { cate in
                            Text(cate.name)
                                .tag(cate.name)
                        }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down.square") {
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
                        Image(systemName: "arrow.uturn.backward.circle")
                        Text("撤回")
                    })
                    .disabled(modelContext.undoManager?.canUndo == false)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        modelContext.undoManager?.redo()
                    }, label: {
                        Image(systemName: "arrow.uturn.forward.circle")
                        Text("重做")
                    })
                    .disabled(modelContext.undoManager?.canRedo == false)
                }
            }
            .searchable(text: $searchText)
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


