//
//  RSSItemContentView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

struct RSSItemContentView: View {
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var vm: RSSVM
    var rssItemModel: RSSItemModel
    var rssLink: String
    var body: some View {
        WebUIView(html:wrapperHtmlContent(content: "<h1><a href=\"\(rssItemModel.link.replacingOccurrences(of: "http://", with: "https://"))\">\(rssItemModel.title)</a></h1>" + (rssItemModel.content.isEmpty ? rssItemModel.description : rssItemModel.content) + "<p><a href=\"\(rssItemModel.link.replacingOccurrences(of: "http://", with: "https://"))\">阅读原文</a></p>"), baseURLStr: rssItemModel.link)
            .onAppear {
                vm.readContent(linkStr: rssItemModel.link, rssLinkStr: rssLink)
                appVM.updateWebLink(s: rssItemModel.link)
                appVM.rssUpdateNotis()
            }
            .frame(minWidth: SPC.detailMinWidth)
    }
}
