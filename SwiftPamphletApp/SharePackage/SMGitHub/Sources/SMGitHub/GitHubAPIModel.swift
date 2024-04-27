//
//  File.swift
//  
//
//  Created by Ming Dai on 2024/4/27.
//

import Foundation

protocol Jsonable : Identifiable, Decodable, Hashable {}

// MARK: - Readme
public struct RepoContent: Decodable, Hashable {
    public var content: String = ""
    public var encoding: String = ""
    public var downloadUrl: String = ""
    public var htmlUrl: String = ""
    public var name: String = ""
    public var path: String = ""
}

// MARK: - IssueComment
public struct IssueComment: Jsonable {
    public var id: Int64
    public var authorAssociation: String
    public var body: String
    public var htmlUrl: String
    public var updatedAt: String
    public var user: GitUserModel
}

// MARK: - IssueEvent
public struct IssueEventModel: Jsonable {
    public var id: Int64
    public var actor: GitUserModel
    public var createdAt: String
    public var event: String
    public var issue: IssueModel
}

// MARK: - Issue
public struct IssueModel: Jsonable {
    public var id: Int64 = 0
    public var number: Int = 0
    public var title: String = ""
    public var body: String?
    public var htmlUrl: String = ""
    public var updatedAt: String = ""
    public var comments: Int = 0
    public var user: GitUserModel = GitUserModel()
}

// MARK: - Commit
public struct CommitModel: Decodable, Hashable {
    public var sha: String?
    public var author: CommitAuthorModel?
    public var commit: CommitCommitModel

}
extension CommitModel: Identifiable {
    public var id: UUID {
        return UUID()
    }
}
public struct CommitAuthorModel: Decodable, Hashable {
    public var login: String?
    public var avatarUrl: String?
}

public struct CommitCommitModel: Decodable, Hashable {
    public var author: CommitCommitAuthor
    public var message: String?
}
public struct CommitCommitAuthor: Decodable, Hashable {
    public var date: String
    public var email: String
    public var name: String?
}

// MARK: - Event
public struct EventModel: Jsonable {
    public var id: String
    public var createdAt: String
    public var type: String
    public var repo: EventRepoModel
    public var payload: PayloadModel
    public var actor: GitUserModel
}
public struct EventRepoModel: Jsonable {
    public var id: Int64
    public var name: String
}

public struct PayloadModel: Decodable, Hashable {
    public var action: String?
    public var issue: PayloadIssueModel?
    public var commits: [PayloadCommitModel]?
    public var description: String?
    public var pullRequest: PayloadPullRequest?
    public var comment: PayloadComment?
}
public struct PayloadIssueModel: Jsonable {
    public var id: Int64
    public var number: Int
    public var title: String?
    public var body: String?

}
public struct PayloadCommitModel: Decodable, Hashable {
    public var message: String?
    public var sha: String?
}
public struct PayloadPullRequest: Decodable, Hashable {
    public var body: String?
    public var title: String?
}
public struct PayloadComment: Decodable, Hashable {
    public var body: String?
}

// MARK: - Repo

public struct SearchRepoModel: Decodable {
    public var items: [RepoModel]
}

public struct RepoModel: Jsonable {
    public var id: Int64 = 0
    public var name: String = ""
    public var fullName: String = ""
    public var description: String?
    public var stargazersCount: Int = 0
    public var forks: Int = 0
    public var openIssues: Int = 0
    public var language: String?
    public var htmlUrl: String?
    public var owner: GitUserModel = GitUserModel()
}

// MARK: - User
public struct UserModel: Jsonable {
    public var id: Int64 = 0
    public var login: String = ""
    public var avatarUrl: String = ""
    public var bio: String?
    public var blog: String?
    public var email: String?
    public var twitterUsername: String?
    public var followers: Int = 0
    public var htmlUrl: String = ""
    public var location: String?
    public var name: String?
    public var publicGists: Int = 0
    public var publicRepos: Int = 0
}
public struct UserEmailModel: Decodable {
    public var email: String
    public var verified: Bool
    public var primary: Bool
    public var visibility: String?
}

public struct GitUserModel: Jsonable {
    public var id: Int64 = 0
    public var login: String = ""
    public var name: String?
    public var avatarUrl: String = ""
}
public struct GitFoll: Jsonable {
    public var id: Int64 = 0
    public var login: String = ""
    public var name: String?
    public var avatarUrl: String = ""
}
