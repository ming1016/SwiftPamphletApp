//
//  File.swift
//  
//
//  Created by Ming Dai on 2024/4/27.
//

import Foundation

@Observable
public final class APIRepoVM {
    public var name: String = ""
    public var repo: RepoModel = RepoModel()
    public var commits: [CommitModel] = [CommitModel]()
    public var issues: [IssueModel] = [IssueModel]()
    public var issuesEvents: [IssueEventModel] = [IssueEventModel]()
    public var readme: RepoContent = RepoContent()
    
    public init(name: String) {
        self.name = name
    }
    
    public func updateAllData() async {
        await obtainRepos()
        await obtainCommits()
        await obtainIssues()
        await obtainIssuesEvents()
        await obtainReadme()
    }
    
    // https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28
    @MainActor
    public func obtainRepos() async {
        do {
            repo = try await GitHubReq.shared.req("repos/\(name)", type: RepoModel.self)
        } catch { print("问题是：\(error)") }
    }

    // https://docs.github.com/en/rest/commits/commits?apiVersion=2022-11-28
    @MainActor
    public func obtainCommits() async {
        do {
            commits = try await GitHubReq.shared.req("repos/\(name)/commits", type: [CommitModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/issues/issues?apiVersion=2022-11-28
    @MainActor
    public func obtainIssues() async {
        do {
            issues = try await GitHubReq.shared.req("repos/\(name)/issues", type: [IssueModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/issues/events?apiVersion=2022-11-28#about-events
    @MainActor
    public func obtainIssuesEvents() async {
        do {
            issuesEvents = try await GitHubReq.shared.req("repos/\(name)/issues/events", type: [IssueEventModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28
    @MainActor
    public func obtainReadme() async {
        do {
            readme = try await GitHubReq.shared.req("repos/\(name)/readme", type: RepoContent.self)
        } catch { print("问题是：\(error)") }
    }
    
    // TODO: 下载内容
}
