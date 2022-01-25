//
//  DBRepoStore.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SQLite
import Foundation

// MARK: - 探索更多库更新提醒
typealias DBRepoStore = (
    id: Int64,
    name: String,
    fullName: String,
    description: String,
    stargazersCount: Int,
    openIssues: Int,
    language: String,
    htmlUrl: String,
    lastReadCommitSha: String,
    unRead: Int,
    type: Int,
    extra: String
)
struct RepoStoreDataHelper: DataHelperProtocol {
    static let table = Table("RepoStore")
    typealias T = DBRepoStore

    static let id = Expression<Int64>("id")
    static let name = Expression<String>("name")
    static let fullName = Expression<String>("fullName")
    static let description = Expression<String>("description")
    static let stargazersCount = Expression<Int>("stargazersCount")
    static let openIssues = Expression<Int>("openIssues")
    static let language = Expression<String>("language")
    static let htmlUrl = Expression<String>("htmlUrl")
    static let lastReadCommitSha = Expression<String>("lastReadCommitSha")
    static let unRead = Expression<Int>("unRead")
    static let type = Expression<Int>("type")
    static let extra = Expression<String>("extra")

    static func createEmptyDBRepoStore(_ pFullName: String) -> T {
        return T(
            id: 0,
            name: "",
            fullName: pFullName,
            description: "",
            stargazersCount: 0,
            openIssues: 0,
            language: "",
            htmlUrl: "",
            lastReadCommitSha: "",
            unRead: 0,
            type: 0,
            extra: ""
        )
    }

    static func createTable() throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        do {
            _ = try db.run(table.create(ifNotExists: true) { t in
                t.column(id, defaultValue: 0)
                t.column(name, defaultValue: "")
                t.column(fullName, unique: true)
                t.column(description, defaultValue: "")
                t.column(stargazersCount, defaultValue: 0)
                t.column(openIssues, defaultValue: 0)
                t.column(language, defaultValue: "")
                t.column(htmlUrl, defaultValue: "")
                t.column(lastReadCommitSha, defaultValue: "")
                t.column(unRead, defaultValue: 0)
                t.column(type, defaultValue: 0)
                t.column(extra, defaultValue: "")
            })
        } catch {
            throw DBError.connectionErr
        }
    } // end createTable

    static func insert(i: T) throws -> Int64 {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let insert = table.insert(
            id <- i.id,
            name <- i.name,
            fullName <- i.fullName,
            description <- i.description,
            stargazersCount <- i.stargazersCount,
            openIssues <- i.openIssues,
            language <- i.language,
            htmlUrl <- i.htmlUrl,
            lastReadCommitSha <- i.lastReadCommitSha,
            unRead <- i.unRead,
            type <- i.type,
            extra <- i.extra
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
            return T(
                id: i[id],
                name: i[name],
                fullName: i[fullName],
                description: i[description],
                stargazersCount: i[stargazersCount],
                openIssues: i[openIssues],
                language: i[language],
                htmlUrl: i[htmlUrl],
                lastReadCommitSha: i[lastReadCommitSha],
                unRead: i[unRead],
                type: i[type],
                extra: i[extra]
            )
        }
        return nil
    } // end find

    static func update(i: T) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(fullName == i.fullName)
        do {
            if try db.run(query.update(
                id <- i.id,
                name <- i.name,
                fullName <- i.fullName,
                description <- i.description,
                stargazersCount <- i.stargazersCount,
                openIssues <- i.openIssues,
                language <- i.language,
                htmlUrl <- i.htmlUrl,
                lastReadCommitSha <- i.lastReadCommitSha,
                unRead <- i.unRead
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    } // end update

    static func updateUnread(name: String, unread: Int) throws {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        let query = table.filter(fullName == name)
        do {
            if try db.run(query.update(
                unRead <- unread
            )) > 0 {

            } else {
                throw DBError.updateErr
            }
        } catch {
            throw DBError.updateErr
        }
    }

    static func findAll() throws -> [T]? {
        guard let db = DB.shared.BBDB else {
            throw DBError.connectionErr
        }
        var arr = [T]()
        let items = try db.prepare(table)
        for i in items {
            arr.append(T(
                id: i[id],
                name: i[name],
                fullName: i[fullName],
                description: i[description],
                stargazersCount: i[stargazersCount],
                openIssues: i[openIssues],
                language: i[language],
                htmlUrl: i[htmlUrl],
                lastReadCommitSha: i[lastReadCommitSha],
                unRead: i[unRead],
                type: i[type],
                extra: i[extra]
            ))
        }
        return arr
    } // end find all

} // end RepoStore
