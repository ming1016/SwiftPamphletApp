//
//  DBRSSItems.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SQLite
import Foundation

// MARK: - RSS的数据
typealias DBRSSItems = (
    id: Int64,
    title: String,
    link: String,
    des: String,
    content: String,
    pubDate: String,
    rssLink: String,
    isRead: Bool
)

struct RSSItemsDataHelper: DataHelperProtocol {
    static let table = Table("RSSItems")
    static let id = Expression<Int64>("id")
    static let title = Expression<String>("title")
    static let link = Expression<String>("link")
    static let des = Expression<String>("des")
    static let content = Expression<String>("content")
    static let pubDate = Expression<String>("pubDate")
    static let rssLink = Expression<String>("rssLink")
    static let isRead = Expression<Bool>("isRead")
    typealias T = DBRSSItems

    static func createTable() throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        do {
            _ = try db.run(table.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(title, defaultValue: "")
                t.column(link, unique: true)
                t.column(des, defaultValue: "")
                t.column(content, defaultValue: "")
                t.column(pubDate, defaultValue: "")
                t.column(rssLink, defaultValue: "")
                t.column(isRead, defaultValue: false)
            })
        } catch {
            throw DBError.connectionErr
        }
    }

    static func insert(i: T) throws -> Int64 {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let insert = table.insert(
            title <- i.title,
            link <- i.link,
            des <- i.des,
            content <- i.content,
            pubDate <- i.pubDate,
            rssLink <- i.rssLink,
            isRead <- false
        )
        do {
            let rowId = try db.run(insert)
            guard rowId > 0 else {
                throw DBError.insertErr
            }
            return rowId
        } catch {
            throw DBError.insertErr
        }
    } // end insert

    static func delete(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(id == i.id)
        do {
            let tmp = try db.run(query.delete())
            guard tmp == 1 else {
                throw DBError.deleteErr
            }
        } catch {
            throw DBError.deleteErr
        }

    } // end delete

    static func deleteExpiredFeedItems(aRssLink: String) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let q1 = table.filter(rssLink == aRssLink && isRead == true)
        let items = try db.prepare(q1)
        var count = 0
        for _ in items {
            count += 1
        }
        if count > 200 {
            let q2 = table
                .filter(rssLink == aRssLink && isRead == true)
                .order(id.asc)
                .limit(count - 200)
            let tmp = try db.run(q2.delete())
            guard tmp > 0 else {
                throw DBError.deleteErr
            }
        }
    }

    static func findLink(sLink: String) throws -> T? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(link == sLink)
        let items = try db.prepare(query)
        for i in items {
            return T(
                id: i[id],
                title: i[title],
                link: i[link],
                des: i[des],
                content: i[content],
                pubDate: i[pubDate],
                rssLink: i[rssLink],
                isRead: i[isRead]
            )
        }
        return nil
    } // end find

    static func findRssLink(sRssLink: String) throws -> [T] {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table
            .filter(rssLink == sRssLink)
            .order(id.desc)
            .limit(100)
        let items = try db.prepare(query)
        var reArr = [T]()
        for i in items {
            reArr.append(T(
                id: i[id],
                title: i[title],
                link: i[link],
                des: i[des],
                content: i[content],
                pubDate: i[pubDate],
                rssLink: i[rssLink],
                isRead: i[isRead]
            ))
        }
        return reArr
    }

    static func findRssLinkUnreadCount(sRssLink: String) throws -> Int {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(rssLink == sRssLink && isRead == false)
        return try db.scalar(query.count)
    }

    static func findAllUnreadCount() throws -> Int {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(isRead == false)
        return try db.scalar(query.count)
    }

    static func update(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(id == i.id)
        do {
            if try db.run(query.update(
                id <- i.id,
                title <- i.title,
                link <- i.link,
                des <- i.des,
                content <- i.content,
                pubDate <- i.pubDate
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end update

    static func markRead(aLink: String) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(link == aLink)
        do {
            if try db.run(query.update(
                isRead <- true
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end markRead

    static func markAllRead(aRssLink: String) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(rssLink == aRssLink)
        do {
            if try db.run(query.update(
                isRead <- true
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end markAllRead

    static func findAll() throws -> [T]? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        var arr = [T]()
        let items = try db.prepare(table)
        for i in items {
            arr.append(T(
                id: i[id],
                title: i[title],
                link: i[link],
                des: i[des],
                content: i[content],
                pubDate: i[pubDate],
                rssLink: i[rssLink],
                isRead: i[isRead]
            ))
        }
        return arr
    } // end findAll

}
