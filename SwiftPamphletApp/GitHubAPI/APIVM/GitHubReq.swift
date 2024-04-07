//
//  GitHubReq.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/7.
//

import Foundation

// github api 入口 https://api.github.com
class GitHubReq {
    static func jsonDecoder() -> JSONDecoder {
        let de = JSONDecoder()
        de.keyDecodingStrategy = .convertFromSnakeCase
        return de
    }
    static func req(_ path: String) -> URLRequest {
        let req = URLRequest(url: URL(string: "https://api.github.com/\(path)")!)
//        var githubat = ""
//        if SPC.gitHubAccessToken.isEmpty == true {
//            githubat = SPC.githubAccessToken()
//        } else {
//            githubat = SPC.gitHubAccessToken
//        }
//
//        req.addValue("token \(githubat)", forHTTPHeaderField: "Authorization")
        return req
    }
}
