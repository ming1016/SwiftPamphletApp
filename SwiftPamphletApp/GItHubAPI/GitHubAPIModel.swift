//
//  GitHubAPIModel.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/8.
//

import Foundation

// MARK: Readme
struct RepoContent: Decodable, Hashable {
    var content: String = ""
    var encoding: String = ""
    var downloadUrl: String = ""
    var htmlUrl: String = ""
    var name: String = ""
    var path: String = ""
}

// MARK: IssueComment
struct IssueComment: Jsonable {
    var id: Int64
    var authorAssociation: String
    var body: String
    var htmlUrl: String
    var updatedAt: String
    var user: GitUserModel
}

// MARK: IssueEvent
struct IssueEventModel: Jsonable {
    var id: Int64
    var actor: GitUserModel
    var createdAt: String
    var event: String
    var issue: IssueModel
}

// MARK: Issue
struct IssueModel: Jsonable {
    var id: Int64 = 0
    var number: Int = 0
    var title: String = ""
    var body: String?
    var htmlUrl: String = ""
    var updatedAt: String = ""
    var comments: Int = 0
    var user: GitUserModel = GitUserModel()
}

// MARK: Commit
struct CommitModel: Decodable, Hashable {
    var sha: String?
    var author: CommitAuthorModel?
    var commit: CommitCommitModel
    
}
extension CommitModel: Identifiable {
    var id: UUID {
        return UUID()
    }
}
struct CommitAuthorModel: Decodable, Hashable {
    var login: String?
    var avatarUrl: String?
}

struct CommitCommitModel: Decodable, Hashable {
    var author: CommitCommitAuthor
    var message: String?
}
struct CommitCommitAuthor: Decodable, Hashable {
    var date: String
    var email: String
    var name: String?
}

// MARK: Event
struct EventModel: Jsonable {
    var id: String
    var createdAt: String
    var type: String
    var repo: EventRepoModel
    var payload: PayloadModel
    var actor: GitUserModel
}

struct PayloadModel: Decodable, Hashable {
    var action: String?
    var issue: PayloadIssueModel?
}

struct EventRepoModel: Jsonable {
    var id: Int64
    var name: String
}

struct PayloadIssueModel: Jsonable {
    var id: Int64
    var number: Int
}

// MARK: Repo

struct SearchRepoModel: Decodable {
    var items: [RepoModel]
}

struct RepoModel: Jsonable {
    var id: Int64 = 0
    var name: String = ""
    var fullName: String = ""
    var description: String?
    var stargazersCount: Int = 0
    var openIssues: Int = 0
    var language: String?
    var htmlUrl: String?
    var owner: GitUserModel = GitUserModel()
}

// MARK: User
struct UserModel: Jsonable {
    var id: Int64 = 0
    var login: String = ""
    var avatarUrl: String = ""
    var bio: String?
    var blog: String?
//    var company: String = ""
    var email: String?
    var twitterUsername: String?
    var followers: Int = 0
//    var following: Int = 0
    var htmlUrl: String = ""
    var location: String?
    var name: String?
    var publicGists: Int = 0
    var publicRepos: Int = 0
}

struct GitUserModel: Jsonable {
    var id: Int64 = 0
    var login: String = ""
    var name: String?
    var avatarUrl: String = ""
}
