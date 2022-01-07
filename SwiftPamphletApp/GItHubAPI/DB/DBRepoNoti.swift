//
//  DBRepoNoti.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SQLite
import Foundation


// MARK: - 仓库更新提醒
typealias DBRepoNoti = (
    fullName: String,
    lastReadCommitSha: String?,
    unRead: Int
)

struct ReposNotiDataHelper: DataHelperProtocol {
    static let table = Table("ReposNoti")
    static let fullName = Expression<String>("fullName")
    static let lastReadCommitSha = Expression<String?>("lastReadCommitSha")
    static let unRead = Expression<Int>("unRead")
    typealias T = DBRepoNoti
    
    
    static func createTable() throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        do {
            let _ = try db.run(table.create(ifNotExists: true) { t in
                t.column(fullName, unique: true)
                t.column(lastReadCommitSha)
                t.column(unRead, defaultValue: 0)
            })
        } catch _ {
            throw DBError.connectionErr
        }
    } //  end create table
    
    static func insert(i: T) throws -> Int64 {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        guard let lastReadCommitShaEnsure = i.lastReadCommitSha else {
            throw DBError.nilInData
        }
        let insert = table.insert(fullName <- i.fullName, lastReadCommitSha <- lastReadCommitShaEnsure, unRead <- i.unRead)
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
        let query = table.filter(fullName == i.fullName)
        do {
            let tmp = try db.run(query.delete())
            guard tmp == 1 else {
                throw DBError.deleteErr
            }
        } catch {
            throw DBError.deleteErr
        }
    } // end delete
    
    static func find(sFullName: String) throws -> T? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(fullName == sFullName)
        let items = try db.prepare(query)
        for i in items {
            return T(fullName: i[fullName], lastReadCommitSha: i[lastReadCommitSha], unRead: i[unRead])
        }
        return nil
    } // end find
    
    static func update(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(fullName == i.fullName)
        guard let lastReadCommitShaEnsure = i.lastReadCommitSha else {
            throw DBError.nilInData
        }
        do {
            if try db.run(query.update(lastReadCommitSha <- lastReadCommitShaEnsure, unRead <- i.unRead)) > 0 {
                
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
            arr.append(T(fullName: i[fullName], lastReadCommitSha: i[lastReadCommitSha], unRead: i[unRead]))
        }
        return arr
    } // end find all
    
}
