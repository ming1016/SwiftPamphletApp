//
//  RSSModel.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import Foundation

struct RSSModel {
    var title = ""
    var description = ""
    var link = ""
    var language = ""
    var lastBuildDate = ""
    var pubDate = ""
    var items = [RSSItemModel]()
}

struct RSSItemModel {
    var guid = ""
    var title = ""
    var description = ""
    var link = ""
    var pubDate = ""
    var content = ""
}





