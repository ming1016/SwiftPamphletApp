//
//  CCYGitHubAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/16.
//

import Foundation
import SwiftUI

enum Github {}

// MARK: - /repos/{reponame}
extension Github {
    static func repos(_ name: String) -> Repos {
        Repos(path: "/repos/\(name)")
    }
    struct Repos {
        let path: String
        var get: Req<RepoModel> {
            .get(path)
        }
    }
}
// MARK: - /repos/{reponame}/issues/{issuenumber}
extension Github.Repos {
    func issues(_ number: Int) -> Issues {
        Issues(path: path + "/issues/\(number)")
    }
    struct Issues {
        let path: String
        var get: Req<IssueModel> {
            .get(path)
        }
    }
}
// MARK: - /repos/{reponame}/commits
extension Github.Repos {
    var commits: Commits {
        Commits(path: path + "/commits", query: [("per_page", "100")])
    }

    struct Commits {
        let path: String
        let query: [(String, String?)]?
        var get: Req<[CommitModel]> {
            .get(path, query: query)
        }
    }
}

// MARK: - /user
extension Github {
    static var user: User {
        User()
    }
    struct User {
        let path: String = "/user"
        var get: Req<UserModel> {
            .get(path)
        }
    }
}
// MARK: - /user/following
extension Github.User {
    var following: Following {
        Following()
    }
    struct Following {
        let path: String = "/user/following"
        var get: Req<[GitUserModel]> {
            .get(path)
        }
    }
}
// MARK: - /users/{username}
extension Github {
    static func users(_ name: String) -> Users {
        Users(path: "/users/\(name)")
    }
    struct Users {
        let path: String
        var get: Req<UserModel> {
            .get(path)
        }
    }
}
// MARK: - /users/{username}/followers
extension Github.Users {
    var followers: Followers {
        Followers(path: path + "/follower")
    }
    struct Followers {
        let path: String
        var get: Req<[GitUserModel]> {
            .get(path)
        }
    }
}
