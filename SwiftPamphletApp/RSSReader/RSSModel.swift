//
//  RSSModel.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import Foundation

struct RSSModel: Identifiable {
    var id = UUID()
    var title = ""
    var description = ""
    var feedLink = ""
    var siteLink = ""
    var language = ""
    var lastBuildDate = ""
    var pubDate = ""
    var items = [RSSItemModel]()
    var unReadCount = 0
}

struct RSSItemModel: Identifiable {
    var id = UUID()
    var guid = ""
    var title = ""
    var description = ""
    var link = ""
    var pubDate = ""
    var content = ""
    var isRead = false
}
