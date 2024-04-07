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
    var name: String = ""
    var repo: RepoModel = RepoModel()
    var commits: [CommitModel] = [CommitModel]()
    var issues: [IssueModel] = [IssueModel]()
    
    init(name: String) {
        self.name = name
    }
    
    func updateAllData() async {
        await obtainRepos()
        await obtainCommits()
        await obtainIssues()
    }
    
    // https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28
    @MainActor
    func obtainRepos() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("repos/\(name)"))
            repo = try GitHubReq.jsonDecoder().decode(RepoModel.self, from: data)
        } catch { print("问题是：\(error)") }
    }

    // https://docs.github.com/en/rest/commits/commits?apiVersion=2022-11-28
    @MainActor
    func obtainCommits() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("repos/\(name)/commits"))
            commits = try GitHubReq.jsonDecoder().decode([CommitModel].self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/issues/issues?apiVersion=2022-11-28
    @MainActor
    func obtainIssues() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("repos/\(name)/issues"))
            issues = try GitHubReq.jsonDecoder().decode([IssueModel].self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
}

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


