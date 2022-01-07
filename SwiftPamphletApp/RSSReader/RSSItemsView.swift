//
//  RSSItemsView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

struct RSSItemsView: View {
    @EnvironmentObject var vm: RSSVM
    var rssLink: String
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                NavigationLink {
                    RSSItemContentView(rssItemModel: item, rssLink: rssLink)
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.title)
                            .font(.headline)
                            .foregroundColor(vm.isReadDic[item.link] ?? false ? .secondary : .primary)
                        Text(item.pubDate)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        if !item.description.isEmpty {
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                } // end Navigation
                
            } // end ForEach
        } //  end List
        .onAppear {
            vm.showItems(rssLink: rssLink)
        }
    }
}

