//
//  DBRSSFeed.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SQLite
import Foundation

// MARK: - RSS源

typealias DBRSSFeed = (
    title: String,
    rssLink: String,
    siteLink: String,
    des: String,
    unReadCount: Int
)

struct RSSFeedDataHelper: DataHelperProtocol {
    static let table = Table("RSSFeed")
    static let title = Expression<String>("title")
    static let rssLink = Expression<String>("rssLink")
    static let siteLink = Expression<String>("siteLink")
    static let des = Expression<String>("des")
    static let unReadCount = Expression<Int>("unReadCount")
    typealias T = DBRSSFeed

    static func createTable() throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        do {
            _ = try db.run(table.create(ifNotExists: true) { t in
                t.column(title, defaultValue: "")
                t.column(rssLink, unique: true)
                t.column(siteLink, defaultValue: "")
                t.column(des, defaultValue: "")
                t.column(unReadCount, defaultValue: 0)
            })
        } catch _ {
            throw DBError.connectionErr
        }
    }

    static func insert(i: T) throws -> Int64 {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let insert = table.insert(
            title <- i.title,
            rssLink <- i.rssLink,
            siteLink <- i.siteLink,
            des <- i.des
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
    }

    static func delete(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(rssLink == i.rssLink)
        do {
            let tmp = try db.run(query.delete())
            guard tmp == 1 else {
                throw DBError.deleteErr
            }
        } catch {
            throw DBError.deleteErr
        }
    }

    static func find(sLink: String) throws -> T? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(rssLink == sLink)
        let items = try db.prepare(query)
        for i in items {
            return T(
                title: i[title],
                rssLink: i[rssLink],
                siteLink: i[siteLink],
                des: i[des],
                unReadCount: i[unReadCount]
            )
        }
        return nil
    } // end find

    static func update(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(rssLink == i.rssLink)
        do {
            if try db.run(query.update(
                title <- i.title,
                des <- i.des,
                unReadCount <- i.unReadCount
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end update

    static func updateUnReadCount(rssLinkStr: String, unReadCountInt: Int) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(rssLink == rssLinkStr)
        do {
            if try db.run(query.update(
                unReadCount <- unReadCountInt
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end update unread count

    static func findAll() throws -> [T]? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        var arr = [T]()
        let items = try db.prepare(table.order(unReadCount.desc))
        for i in items {
            arr.append(T(
                title: i[title],
                rssLink: i[rssLink],
                siteLink: i[siteLink],
                des: i[des],
                unReadCount: i[unReadCount]
            ))
        }
        return arr
    } // end find all

}
