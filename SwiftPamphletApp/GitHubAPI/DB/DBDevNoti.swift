//
//  DBDevNoti.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//
import SQLite
import Foundation

// MARK: - 开发者更新提醒
typealias DBDevNoti = (
    login: String,
    lastReadId: String,
    unRead: Int
)

struct DevsNotiDataHelper: DataHelperProtocol {
    static let table = Table("devsNoti")
    static let login = Expression<String>("login")
    static let lastReadId = Expression<String>("lastReadId")
    static let unRead = Expression<Int>("unRead")
    typealias T = DBDevNoti

    static func createTable() throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        do {
            _ = try db.run(table.create(ifNotExists: true) { t in
                t.column(login, unique: true)
                t.column(lastReadId, defaultValue: "")
                t.column(unRead, defaultValue: 0)
            })
        } catch {
            throw DBError.connectionErr
        }
    } // end createTable

    static func insert(i: T) throws -> Int64 {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let insert = table.insert(login <- i.login, lastReadId <- i.lastReadId, unRead <- i.unRead)
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
        let query = table.filter(login == i.login)
        do {
            let tmp = try db.run(query.delete())
            guard tmp == 1 else {
                throw DBError.deleteErr
            }
        } catch {
            throw DBError.deleteErr
        }
    } // end delete

    static func find(sLogin: String) throws -> T? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(login == sLogin)
        let items = try db.prepare(query)
        for i in items {
            return T(login: i[login], lastReadId: i[lastReadId], unRead: i[unRead])
        }
        return nil
    } // end find

    static func update(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(login == i.login)
        do {
            if try db.run(query.update(lastReadId <- i.lastReadId, unRead <- i.unRead)) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end update

    static func findAll() throws -> [T]? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        var arr = [T]()
        let items = try db.prepare(table)
        for i in items {
            arr.append(T(login: i[login], lastReadId: i[lastReadId], unRead: i[unRead]))
        }
        return arr
    } // end find all

}
