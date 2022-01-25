//
//  RepoVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import Foundation
import Combine

final class RepoVM: APIVMable {
    private var cancellables: [AnyCancellable] = []

    public let repoName: String

    @Published private(set) var repo: RepoModel
    @Published private(set) var commits: [CommitModel]
    @Published private(set) var issueEvents: [IssueEventModel]
    @Published private(set) var issues: [IssueModel]
    @Published private(set) var readme: RepoContent

    @Published var errHint = false
    @Published var errMsg = ""
    private let errSj = PassthroughSubject<APISevError, Never>()

    private let apiSev: APISev

    private let apRepoSj = PassthroughSubject<Void, Never>()
    private let apCommitsSj = PassthroughSubject<Void, Never>()

    private let apIssueEventsSj = PassthroughSubject<Void, Never>()
    private let apIssuesSj = PassthroughSubject<Void, Never>()
    private let apReadmeSj = PassthroughSubject<Void, Never>()

    private let resRepoSj = PassthroughSubject<RepoModel, Never>()
    private let resCommitsSj = PassthroughSubject<[CommitModel], Never>()
    private let resNotiCommitsSj = PassthroughSubject<[CommitModel], Never>()
    private let resIssueEventsSj = PassthroughSubject<[IssueEventModel], Never>()
    private let resIssuesSj = PassthroughSubject<[IssueModel], Never>()
    private let resReadmeSj = PassthroughSubject<RepoContent, Never>()

    enum RepoActionType {
        case inInit, inCommit, inInitJustRepo, inIssueEvents, inIssues, inReadme, clearExpUnReadCommit
    }
    func doing(_ somethinglike: RepoActionType) {
        switch somethinglike {
        case .inInit:
            apRepoSj.send(())
        case .inCommit:
            apCommitsSj.send(())
        case .inInitJustRepo:
            apRepoSj.send(())
        case .inIssueEvents:
            apIssueEventsSj.send(())
        case .inIssues:
            apIssuesSj.send(())
        case .inReadme:
            apReadmeSj.send(())
        case .clearExpUnReadCommit:
            clearExpUnReadCommit()
        }
    }

    func clearExpUnReadCommit() {
        do {
            _ = try RepoStoreDataHelper.updateUnread(name: self.repoName, unread: 0)
        } catch {}
    }

    init(repoName: String) {
        self.repoName = repoName
        self.apiSev = APISev()
        self.repo = RepoModel()
        self.commits = [CommitModel]()
        self.issueEvents = [IssueEventModel]()
        self.issues = [IssueModel]()
        self.readme = RepoContent()

        // MARK: - 仓库信息获取
        let reqRepo = RepoRequest(repoName: repoName)
        let resRepoSm = apRepoSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqRepo)
                    .catch { [weak self] error -> Empty<RepoModel, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resRepoSj)
        let repRepoSm = resRepoSj
            .assign(to: \.repo, on: self)

        // MARK: - 获取Commit
        let reqCommits = CommitsRequest(repoName: repoName)
        let resCommitsSm = apCommitsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCommits)
                    .catch { [weak self] error -> Empty<[CommitModel], Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resCommitsSj)
        let repCommitsSm = resCommitsSj
            .assign(to: \.commits, on: self)

        // MARK: - 获取议题事件
        let reqIssueEvents = IssueEventsRequest(repoName: repoName)
        let resIssueEventsSm = apIssueEventsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqIssueEvents)
                    .catch { [weak self] error -> Empty<[IssueEventModel], Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resIssueEventsSj)
        let repIssueEventsSm = resIssueEventsSj
            .assign(to: \.issueEvents, on: self)

        // MARK: - 获取议题列表
        let reqIssues = IssuesRequest(repoName: repoName)
        let resIssuesSm = apIssuesSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqIssues)
                    .catch { [weak self] error -> Empty<[IssueModel], Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resIssuesSj)
        let repIssuesSm = resIssuesSj
            .assign(to: \.issues, on: self)

        // MARK: - 获取 Readme
        let reqReadme = ReadmeRequest(repoName: repoName)
        let resReadmeSm = apReadmeSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqReadme)
                    .catch { [weak self] error -> Empty<RepoContent, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resReadmeSj)
        let repReadmeSm = resReadmeSj
            .assign(to: \.readme, on: self)

        // MARK: - 错误
        let errMsgSm = errSj
            .map { err -> String in
                err.message
            }
            .assign(to: \.errMsg, on: self)
        let errHintSm = errSj
            .map { _ in
                true
            }
            .assign(to: \.errHint, on: self)

        cancellables += [
            resRepoSm, repRepoSm,
            resCommitsSm, repCommitsSm,
            resIssueEventsSm, repIssueEventsSm,
            resIssuesSm, repIssuesSm,
            resReadmeSm, repReadmeSm,
            errMsgSm, errHintSm
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
