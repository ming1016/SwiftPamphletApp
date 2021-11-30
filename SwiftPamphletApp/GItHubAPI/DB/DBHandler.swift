//
//  DBHandle.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/29.
//

import SQLite
import Foundation
import SwiftUI

struct DB {
    static let shared = DB()
    static let path = NSSearchPathForDirectoriesInDomains(
        .applicationSupportDirectory, .userDomainMask, true
    ).first!
    let BBDB: Connection?
    private init() {
        do {
            print(DB.path)
            BBDB = try Connection("\(DB.path)/github.sqlite3")
            
        } catch {
            BBDB = nil
        }
        /// Swift 类型和 SQLite 类型对标如下：
        /// Int64 = INTEGER
        /// Double = REAL
        /// String = TEXT
        /// nil = NULL
        /// SQLite.Blob = BLOB
        

    }
    
    func cTbs() throws {
        do {
            try ReposDataHelper.createTable()
        } catch {
            throw DBError.connectionErr
        }
    }
    
}

enum DBError: Error {
    case connectionErr, insertErr, deleteErr, searchErr, updateErr, nilInData
}

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(i: T) throws -> Int64
    static func delete(i: T) throws -> Void
    static func findAll() throws -> [T]?
}

typealias DBRepo = (
    fullName: String,
    lastReadCommitSha: String?,
    unRead: Int
)

struct ReposDataHelper: DataHelperProtocol {
    static let table = Table("ReposNoti")
    static let fullName = Expression<String>("fullName")
    static let lastReadCommitSha = Expression<String?>("lastReadCommitSha")
    static let unRead = Expression<Int>("unRead")
    typealias T = DBRepo
    
    
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
            
        }
    } //  end create table
    
    static func insert(i: DBRepo) throws -> Int64 {
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
    
    static func delete(i: DBRepo) throws {
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
    
    static func find(sFullName: String) throws -> DBRepo? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(fullName == sFullName)
        let items = try db.prepare(query)
        for i in items {
            return DBRepo(fullName: i[fullName], lastReadCommitSha: i[lastReadCommitSha], unRead: i[unRead])
        }
        return nil
    } // end find
    
    static func update(i: DBRepo) throws {
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
    
    static func findAll() throws -> [DBRepo]? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        var arr = [DBRepo]()
        let items = try db.prepare(table)
        for i in items {
            arr.append(DBRepo(fullName: i[fullName], lastReadCommitSha: i[lastReadCommitSha], unRead: i[unRead]))
        }
        return arr
    } // end find all
    
}
