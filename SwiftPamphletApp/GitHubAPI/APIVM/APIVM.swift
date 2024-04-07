//
//  FetchGitHubAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/6.
//

import Foundation
import SwiftUI

@Observable
final class APIRepoVM {
    var repo: RepoModel = RepoModel()
    
    @MainActor
    func repos(_ name: String) async {
        
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("repos/\(name)"))
            let de = JSONDecoder()
            de.keyDecodingStrategy = .convertFromSnakeCase
            repo = try de.decode(RepoModel.self, from: data)
        } catch {
            print("问题是：\(error)")
        }
    }
}

class GitHubReq {
    
    static func req(_ path: String) -> URLRequest {
        var req = URLRequest(url: URL(string: "https://api.github.com/\(path)")!)
        var githubat = ""
        if SPC.gitHubAccessToken.isEmpty == true {
            githubat = SPC.githubAccessToken()
        } else {
            githubat = SPC.gitHubAccessToken
        }
        
        req.addValue("token \(githubat)", forHTTPHeaderField: "Authorization")
        return req
    }
}


