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
//    @Binding var selectedBM: BookmarkModel?
    @Query(BookmarkModel.all) var bms: [BookmarkModel]
    @State private var limit: Int = 50
    @State private var trigger = false
    var body: some View {
        List {
            ForEach(bms) { bm in
                NavigationLink(destination: GuideDetailView(t: bm.name, plName: bm.pamphletName, limit: $limit, trigger: $trigger)) {
                    Text(bm.name)
                }
            }
        }
        .listStyle(.sidebar)
    }
}
