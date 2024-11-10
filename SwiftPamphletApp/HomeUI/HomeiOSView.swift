//
//  HomeiOSView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/10.
//

import SwiftUI

struct HomeiOSView: View {
    var body: some View {
        TabView {
            GuideListView()
                .tabItem {
                    Label("Apple技术", systemImage: "applelogo")
                }
            BookmarkListView()
                .tabItem {
                    Label("书签", systemImage: "bookmark")
                }
        }
    }
}

