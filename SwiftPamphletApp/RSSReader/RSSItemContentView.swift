//
//  RSSItemContentView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

struct RSSItemContentView: View {
    @EnvironmentObject var vm: RSSVM
    var rssItemModel: RSSItemModel
    var rssLink: String
    var body: some View {
        WebUIView(html: SPC.rssStyle() + "<body><h1><a href=\"\(rssItemModel.link)\">\(rssItemModel.title)</a></h1>" + (rssItemModel.content.isEmpty ? rssItemModel.description : rssItemModel.content) + "<p><a href=\"\(rssItemModel.link)\">阅读原文</a></p></body>")
            .onAppear {
                vm.readContent(linkStr: rssItemModel.link, rssLinkStr: rssLink)
            }
    }
}


