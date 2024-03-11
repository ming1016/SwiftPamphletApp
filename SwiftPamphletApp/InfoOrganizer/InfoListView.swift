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
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\IOInfo.updateDate, order: .reverse)]
    
    var body: some View {
        NavigationStack(path: $path) {
            InfosView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("资料列表")
                .navigationDestination(for: IOInfo.self) { info in
                    EditInfoView(info: info, navigationPath: $path)
                }
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
    }
    
    func addInfo() {
        let info = IOInfo(name: "", url: "", des: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(info)
        path.append(info)
    }
}


