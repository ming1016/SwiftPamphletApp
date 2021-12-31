//
//  RSSVM.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import Foundation

final class RSSVM: ObservableObject {
    
    @Published private(set) var rssFeeds: [RSSFeedModel]
    
    init() {
        rssFeeds = SPC.rssFeed()
    }
    
    func listAppear() {
        
    }
    
    static func handleFetchFeed(str: String, rssModel: RSSFeedModel) {
        var rss = RSSModel()
        let root = ParseStandXML(input: str).parse()
        for n in root.subNodes {
            print("n 级 name：" + n.name)
            print(n.subNodes.count)
            if n.name == "rss" && n.subNodes.count > 0 {
                for n1 in n.subNodes {
                    print("n1 级 name：" + n1.name)
                    print(n1.subNodes.count)
                    if n1.name == "channel" && n1.subNodes.count > 0 {
                        for n2 in n1.subNodes {
                            print("n2 级 name：" + n2.name)
                            print(n2.value)
                            print(n2.subNodes.count)
                            if n2.name == "title" {
                                rss.title = n2.value
                            }
                            if n2.name == "description" {
                                rss.description = n2.value
                            }
                            if n2.name == "link" {
                                rss.link = n2.value
                            }
                            if n2.name == "language" {
                                rss.language = n2.value
                            }
                            if n2.name == "lastBuildDate" {
                                rss.lastBuildDate = n2.value
                            }
                            if n2.name == "pubDate" {
                                rss.pubDate = n2.value
                            }
                            
                            if n2.name == "item" {
                                var aItem = RSSItemModel()
                                for n3 in n2.subNodes {
                                    print("n3 级 name: " + n3.name)
                                    print(n3.value)
                                    print(n3.subNodes.count)
                                    if n3.name == "guid" {
                                        aItem.guid = n3.value
                                    }
                                    if n3.name == "title" {
                                        aItem.title = n3.value
                                    }
                                    if n3.name == "description" {
                                        aItem.description = n3.value
                                    }
                                    if n3.name == "link" {
                                        aItem.link = n3.value
                                    }
                                    if n3.name == "pubDate" {
                                        aItem.pubDate = n3.value
                                    }
                                    if n3.name.prefix(7) == "content" {
                                        aItem.content = n3.value
                                    }
                                } // end for n3
                                rss.items.append(aItem)
                            }
                        } // end for n2
                        // for check
                        print(rss.title)
                        print(rss.link)
                        print(rss.pubDate)
                        print(rss.items.count)
                        for a in rss.items {
                            print(a.content)
                        }
                    } // end if channel
                    
                } // end for n1
            } // end if rss
        } // end n for
        
        // 数据库操作
        
        do {
            
            // 添加新增 rss item
            for i in rss.items {
                if let _ = try RSSItemsDataHelper.findLink(sLink: i.link) {
                    
                } else {
                    let _ = try RSSItemsDataHelper.insert(i: RSSItemsDataHelper.T(
                        id: 0,
                        title: i.title,
                        link: i.link,
                        des: i.description,
                        content: i.content,
                        pubDate: i.pubDate,
                        rssLink: rssModel.feedLink,
                        isRead: false
                    ))
                }
            }
            
            let unReadCount = try RSSItemsDataHelper.findRssLinkUnreadCount(sRssLink: rssModel.feedLink)
            
            // 更新 rss 源的信息
            if let f = try RSSFeedDataHelper.find(sLink: rssModel.feedLink) {
                let _ = try RSSFeedDataHelper.update(i: RSSFeedDataHelper.T(
                    title: rss.title,
                    rssLink: f.rssLink,
                    siteLink: f.siteLink,
                    des: rss.description,
                    unReadCount: unReadCount
                ))
            } else {
                let _ = try RSSFeedDataHelper.insert(i: RSSFeedDataHelper.T(
                    title: rssModel.title,
                    rssLink: rssModel.feedLink,
                    siteLink: rssModel.siteLink,
                    des: rss.description,
                    unReadCount: 0
                ))
            }
            
            
        } catch {}
    }
}




































