//
//  RSSVM.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import Foundation
import HTMLEntities

final class RSSVM: ObservableObject {

    @Published private(set) var rssFeeds = [RSSModel]()
    @Published private(set) var unReadCountDic = [String: Int]()

    @Published private(set) var items = [RSSItemModel]()
    @Published private(set) var isReadDic = [String: Bool]()

    func markAllAsRead(rssLink: String) {
        for item in items {
            isReadDic[item.link] = true
        }
        do {
            _ = try RSSItemsDataHelper.markAllRead(aRssLink: rssLink)
            _ = try RSSFeedDataHelper.updateUnReadCount(rssLinkStr: rssLink, unReadCountInt: 0)
            _ = try RSSItemsDataHelper.deleteExpiredFeedItems(aRssLink: rssLink)
        } catch {}
        unReadCountDic[rssLink] = 0
    }

    func showRssFeeds() {
        do {
            if let feeds = try RSSFeedDataHelper.findAll() {
                var arr = [RSSModel]()
                for f in feeds {
                    var m = RSSModel()
                    m.title = f.title
                    m.siteLink = f.siteLink
                    m.feedLink = f.rssLink
                    m.unReadCount = f.unReadCount
                    m.description = f.des
                    arr.append(m)
                    unReadCountDic[f.rssLink] = f.unReadCount
                }
                rssFeeds = arr
            }

        } catch {}
    }

    func showItems(rssLink: String) {
        do {
            let rssItems = try RSSItemsDataHelper.findRssLink(sRssLink: rssLink)
            var arr = [RSSItemModel]()
            for i in rssItems {
                var m = RSSItemModel()
                m.title = i.title
                m.description = i.des.htmlUnescape()
                m.link = i.link
                m.pubDate = i.pubDate
                m.content = i.content.htmlUnescape()
                m.isRead = i.isRead
                arr.append(m)
                isReadDic[i.link] = i.isRead
            }
            items = arr
        } catch {}
    }

    func readContent(linkStr: String, rssLinkStr: String) {
        isReadDic[linkStr] = true
        do {
            _ = try RSSItemsDataHelper.markRead(aLink: linkStr)
            let unReadCount = try RSSItemsDataHelper.findRssLinkUnreadCount(sRssLink: rssLinkStr)
            // 未读数存储更新
            _ = try RSSFeedDataHelper.updateUnReadCount(rssLinkStr: rssLinkStr, unReadCountInt: unReadCount)
            // 未读数内存更新
            unReadCountDic[rssLinkStr] = unReadCount
        } catch {}
    }

    static func handleFetchFeed(str: String, rssModel: RSSFeedModel) {
        var rss = RSSModel()
        let root = ParseStandXML(input: str).parse()
        for n in root.subNodes {
            // MARK: - feed 的情况
            if n.name == "feed" && n.subNodes.count > 0 {
                for n1 in n.subNodes {
                    if n1.name == "title" {
                        rss.title = n1.value
                    }
                    if n1.name == "subtitle" {
                        rss.description = n1.value
                    }
                    if n1.name == "id" {
                        rss.siteLink = n1.value
                    }
                    if n1.name == "updated" {
                        rss.pubDate = n1.value
                    }
                    if n1.name == "entry" {
                        var aItem = RSSItemModel()
                        for n2 in n1.subNodes {
                            if n2.name == "title" {
                                aItem.title = n2.value
                            }
                            if n2.name == "link" {
                                if n2.attributes.count > 0 {
                                    for a in n2.attributes {
                                        if a.name == "href" {
                                            aItem.link = a.value
                                        }
                                    }
                                } else {
                                    aItem.link = n2.value
                                }
                            } // end name == link
                            if n2.name == "published" {
                                aItem.pubDate = n2.value
                            }
                            if n2.name == "summary" {
                                aItem.description = n2.value
                            }
                            if n2.name.prefix(7) == "content" {
                                aItem.content = n2.value
                            }
                        } // end for n2
                        rss.items.append(aItem)
                    } // end name == entry
                } // end for n1
            } // end n name == rss

            // MARK: - rss 的情况
            if n.name == "rss" && n.subNodes.count > 0 {
                for n1 in n.subNodes {
                    if n1.name == "channel" && n1.subNodes.count > 0 {
                        for n2 in n1.subNodes {
                            if n2.name == "title" {
                                rss.title = n2.value
                            }
                            if n2.name == "description" {
                                rss.description = n2.value
                            }
                            if n2.name == "link" {
                                rss.siteLink = n2.value
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
                    } // end if channel
                } // end for n1
            } // end if rss
        } // end n for

        // for check
//        print(rss.title)
//        print(rss.siteLink)
//        print(rss.pubDate)
//        print(rss.items.count)
//        for a in rss.items {
//            print(a.title)
//            print(a.content)
//        }

        // 数据库操作
        do {
            // 时间倒序
            let reversedRssItems = rss.items.reversed()
            // 添加新增 rss item
            for i in reversedRssItems {
                if let _ = try RSSItemsDataHelper.findLink(sLink: i.link) {

                } else {
                    _ = try RSSItemsDataHelper.insert(i: RSSItemsDataHelper.T(
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
                _ = try RSSFeedDataHelper.update(i: RSSFeedDataHelper.T(
                    title: rss.title,
                    rssLink: f.rssLink,
                    siteLink: f.siteLink,
                    des: rss.description.isEmpty ? f.des : rss.description,
                    unReadCount: unReadCount
                ))
            } else {
                _ = try RSSFeedDataHelper.insert(i: RSSFeedDataHelper.T(
                    title: rssModel.title,
                    rssLink: rssModel.feedLink,
                    siteLink: rssModel.siteLink,
                    des: rss.description.isEmpty ? rssModel.des : rss.description,
                    unReadCount: unReadCount
                ))
            }
            
            // 清理过多已读的 rss
            _ = try RSSItemsDataHelper.deleteExpiredFeedItems(aRssLink: rssModel.feedLink)

        } catch {}
    }
}
