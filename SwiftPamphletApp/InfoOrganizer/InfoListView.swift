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
    @State private var sortOrder = [SortDescriptor(\IOInfo.updateDate)]
    
    var body: some View {
        NavigationStack(path: $path) {
            InfosView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("资料列表")
                .navigationDestination(for: IOInfo.self) { info in
                    // TODO:
                }
        }
    }
}


