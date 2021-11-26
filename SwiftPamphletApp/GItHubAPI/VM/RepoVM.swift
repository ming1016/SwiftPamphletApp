//
//  RepoVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import Foundation
import Combine

final class RepoVM: ObservableObject, APIVMable {
    private var cancellables: [AnyCancellable] = []
    
    public let repoName: String
    
    @Published private(set) var repo: RepoModel
    @Published private(set) var commits: [CommitModel]
    @Published private(set) var issueEvents: [IssueEventModel]
    @Published private(set) var issues: [IssueModel]
    @Published private(set) var readme: RepoContent

    private let apiSev: APISev
    
    private let apRepoSj = PassthroughSubject<Void, Never>()
    private let apCommitsSj = PassthroughSubject<Void, Never>()
    private let apIssueEventsSj = PassthroughSubject<Void, Never>()
    private let apIssuesSj = PassthroughSubject<Void, Never>()
    private let apReadmeSj = PassthroughSubject<Void, Never>()
    
    private let resRepoSj = PassthroughSubject<RepoModel, Never>()
    private let resCommitsSj = PassthroughSubject<[CommitModel], Never>()
    private let resIssueEventsSj = PassthroughSubject<[IssueEventModel], Never>()
    private let resIssuesSj = PassthroughSubject<[IssueModel], Never>()
    private let resReadmeSj = PassthroughSubject<RepoContent, Never>()
    
    enum RepoActionType {
        case inInit, inInitJustRepo, inIssueEvents, inIssues, inReadme
    }
    func doing(_ somethinglike: RepoActionType) {
        switch somethinglike {
        case .inInit:
            apRepoSj.send(())
            apCommitsSj.send(())
        case .inInitJustRepo:
            apRepoSj.send(())
        case .inIssueEvents:
            apIssueEventsSj.send(())
        case .inIssues:
            apIssuesSj.send(())
        case .inReadme:
            apReadmeSj.send(())
        }
    }
    
    init(repoName: String) {
        self.repoName = repoName
        self.apiSev = APISev()
        self.repo = RepoModel()
        self.commits = [CommitModel]()
        self.issueEvents = [IssueEventModel]()
        self.issues = [IssueModel]()
        self.readme = RepoContent()
        
        // 仓库信息获取
        let reqRepo = RepoRequest(repoName: repoName)
        let resRepoSm = apRepoSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqRepo)
                    .catch { error -> Empty<RepoModel, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resRepoSj)
        let repRepoSm = resRepoSj
            .assign(to: \.repo, on: self)
        
        // 获取Commit
        let reqCommits = CommitsRequest(repoName: repoName)
        let resCommitsSm = apCommitsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCommits)
                    .catch { error -> Empty<[CommitModel], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resCommitsSj)
        let repCommitsSm = resCommitsSj
            .assign(to: \.commits, on: self)
        
        // 获取议题事件
        let reqIssueEvents = IssueEventsRequest(repoName: repoName)
        let resIssueEventsSm = apIssueEventsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqIssueEvents)
                    .catch { error -> Empty<[IssueEventModel], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resIssueEventsSj)
        let repIssueEventsSm = resIssueEventsSj
            .assign(to: \.issueEvents, on: self)
        
        // 获取议题列表
        let reqIssues = IssuesRequest(repoName: repoName)
        let resIssuesSm = apIssuesSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqIssues)
                    .catch { error -> Empty<[IssueModel], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resIssuesSj)
        let repIssuesSm = resIssuesSj
            .assign(to: \.issues, on: self)
        
        // 获取 Readme
        let reqReadme = ReadmeRequest(repoName: repoName)
        let resReadmeSm = apReadmeSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqReadme)
                    .catch { error -> Empty<RepoContent, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resReadmeSj)
        let repReadmeSm = resReadmeSj
            .assign(to: \.readme, on: self)
        
        
        cancellables += [
            resRepoSm, repRepoSm,
            resCommitsSm, repCommitsSm,
            resIssueEventsSm, repIssueEventsSm,
            resIssuesSm, repIssuesSm,
            resReadmeSm, repReadmeSm
        ]
        
        
    }
    
}

struct ReadmeRequest: APIReqType {
    typealias Res = RepoContent
    var repoName: String
    var path: String {
        return "repos/\(repoName)/readme"
    }
    var qItems: [URLQueryItem]? {
        return []
    }
}

struct IssuesRequest: APIReqType {
    typealias Res = [IssueModel]
    var repoName: String
    var path: String {
        return "repos/\(repoName)/issues"
    }
    var qItems: [URLQueryItem]? {
        return [
//            .init(name: "per_page", value: "100")
        ]
    }
}

struct IssueEventsRequest: APIReqType {
    typealias Res = [IssueEventModel]
    var repoName: String
    var path: String {
        return "repos/\(repoName)/issues/events"
    }
    var qItems: [URLQueryItem]? {
        return [
            .init(name: "per_page", value: "100")
        ]
    }
}

struct CommitsRequest: APIReqType {
    typealias Res = [CommitModel]
    var repoName: String
    var path: String {
        return "repos/\(repoName)/commits"
    }
    var qItems: [URLQueryItem]? {
        return [
            .init(name: "per_page", value: "100")
        ]
    }
}

struct RepoRequest: APIReqType {
    typealias Res = RepoModel
    var repoName: String
    var path: String {
        return "/repos/\(repoName)"
    }
    var qItems: [URLQueryItem]? {
        return nil
    }
}
