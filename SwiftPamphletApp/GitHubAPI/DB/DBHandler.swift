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
            try DevsNotiDataHelper.createTable()
            try RepoStoreDataHelper.createTable()
            try RSSFeedDataHelper.createTable()
            try RSSItemsDataHelper.createTable()
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
    static func createTable() throws
    static func insert(i: T) throws -> Int64
    static func delete(i: T) throws
    static func findAll() throws -> [T]?
}
