//
//  CCYGitHubAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/16.
//

import Foundation

enum Github {}

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
