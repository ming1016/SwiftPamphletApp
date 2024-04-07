//
//  FetchGitHubAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/6.
//

import Foundation

@Observable
final class APIRepoVM {
    var name: String = ""
    var repo: RepoModel = RepoModel()
    var commits: [CommitModel] = [CommitModel]()
    var issues: [IssueModel] = [IssueModel]()
    var issuesEvents: [IssueEventModel] = [IssueEventModel]()
    var readme: RepoContent = RepoContent()
    
    init(name: String) {
        self.name = name
    }
    
    func updateAllData() async {
        await obtainRepos()
        await obtainCommits()
        await obtainIssues()
        await obtainIssuesEvents()
        await obtainReadme()
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
    
    // https://docs.github.com/en/rest/issues/events?apiVersion=2022-11-28#about-events
    @MainActor
    func obtainIssuesEvents() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("repos/\(name)/issues/events"))
            issuesEvents = try GitHubReq.jsonDecoder().decode([IssueEventModel].self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28
    @MainActor
    func obtainReadme() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("repos/\(name)/readme"))
            readme = try GitHubReq.jsonDecoder().decode(RepoContent.self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
    // TODO: 下载内容
}




