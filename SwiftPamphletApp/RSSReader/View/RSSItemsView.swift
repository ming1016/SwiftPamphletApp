//
//  RSSItemsView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

struct RSSItemsView: View {
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var vm: RSSVM
    var rssLink: String

    var body: some View {
        HStack {
            Button {
                vm.markAllAsRead(rssLink: rssLink)
            } label: {
                Text("标记全部已读")
            }
            Spacer()
        }
        .padding(10)
        List {
            ForEach(vm.items) { item in
                NavigationLink {
                    RSSItemContentView(rssItemModel: item, rssLink: rssLink)
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.title)
                            .font(.headline)
                            .foregroundColor(vm.isReadDic[item.link] ?? false ? .secondary : .primary)
                        Text(howLongFromNow(timeStr:item.pubDate))
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        if !item.description.isEmpty && !item.content.isEmpty {
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
        .onDisappear {
            appVM.updateWebLink(s: "")
        }
    }
}
