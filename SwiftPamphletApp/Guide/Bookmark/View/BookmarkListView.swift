//
//  BookmarkListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/10.
//

import SwiftUI
import SwiftData

struct BookmarkListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(BookmarkModel.all) var bms: [BookmarkModel]
//    var bms: [BookmarkModel] = [BookmarkModel]() // 测试空数据用
    @Binding var selectedItem: L?
    @State private var limit: Int = 50
    @State private var trigger = false
    var body: some View {
        List(selection: $selectedItem) {
            ForEach(bms) { bm in
                HStack {
                    if bm.icon.isEmpty == false {
                        Image(systemName: bm.icon)
                            .foregroundStyle(Color.secondary)
                    }
                    Text(bm.name)
                    Spacer()
                    Image(systemName: "bookmark")
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
                .tag(L(t: bm.name, icon: bm.icon, type: bm.type))
                .contextMenu {
                    Button("前移") {
                        bm.updateDate = Date.now
                    }
                    Button("删除") {
                        BookmarkModel.delBM(bm)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .overlay {
            if bms.isEmpty {
                ContentUnavailableView {
                    Label("无书签", systemImage: "bookmark.slash")
                } description: {
                    Text("请到手册中添加书签")
                }
            }
        } // end overlay
    }
    
}
