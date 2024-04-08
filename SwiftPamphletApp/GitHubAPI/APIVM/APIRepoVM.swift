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
            repo = try await GitHubReq.req("repos/\(name)", type: RepoModel.self)
        } catch { print("问题是：\(error)") }
    }

    // https://docs.github.com/en/rest/commits/commits?apiVersion=2022-11-28
    @MainActor
    func obtainCommits() async {
        do {
            commits = try await GitHubReq.req("repos/\(name)/commits", type: [CommitModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/issues/issues?apiVersion=2022-11-28
    @MainActor
    func obtainIssues() async {
        do {
            issues = try await GitHubReq.req("repos/\(name)/issues", type: [IssueModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/issues/events?apiVersion=2022-11-28#about-events
    @MainActor
    func obtainIssuesEvents() async {
        do {
            issuesEvents = try await GitHubReq.req("repos/\(name)/issues/events", type: [IssueEventModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28
    @MainActor
    func obtainReadme() async {
        do {
            readme = try await GitHubReq.req("repos/\(name)/readme", type: RepoContent.self)
        } catch { print("问题是：\(error)") }
    }
    
    // TODO: 下载内容
}




