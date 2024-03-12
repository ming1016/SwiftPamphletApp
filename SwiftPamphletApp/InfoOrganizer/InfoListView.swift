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
    
    var body: some View {
        InfosView(searchString: searchText, selectInfo: $selectInfo, sortOrder: sortOrder)
        .navigationTitle("资料列表")
//        .navigationDestination(for: IOInfo.self) { info in
//            EditInfoView(info: info)
//        }
        .toolbar {
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("排序", selection: $sortOrder) {
                    Text("正序")
                        .tag([SortDescriptor(\IOInfo.updateDate)])
                    Text("倒序")
                        .tag([SortDescriptor(\IOInfo.updateDate, order: .reverse)])
                }
            }
            Button("添加资料", systemImage: "plus", action: addInfo)
            
        }
        .searchable(text: $searchText)
    }
    
    func addInfo() {
        let info = IOInfo(name: "无标题", url: "", des: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(info)
        selectInfo = info
    }
    
}


