//
//  IssueVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/15.
//

import Foundation
import Combine

final class IssueVM: APIVMable {
    private var cancellables: [AnyCancellable] = []
    public let repoName: String
    public let issueNumber: Int
    public let guideName: String
    @Published private(set) var issue: IssueModel
    @Published private(set) var comments: [IssueComment]
    @Published private(set) var customIssues: [CustomIssuesModel]
    @Published private(set) var cIADs: [SPActiveDevelopersModel] // 开发者动态
    @Published var errHint = false
    @Published var errMsg = ""

    // MARK: - APISev
    private let apiSev: APISev

    private let errSj = PassthroughSubject<APISevError, Never>()

    private let apIssueSj = PassthroughSubject<Void, Never>()
    private let apCommentsSj = PassthroughSubject<Void, Never>()

    private let resIssueSj = PassthroughSubject<IssueModel, Never>()
    private let resCommetsSj = PassthroughSubject<[IssueComment], Never>()

    enum IssueActionType {
        case inInit, customIssues, ciads, update
    }
    typealias ActionType = IssueActionType // 可在定义doing函数时，通过参数类型指定，类型推导出来
    func doing(_ somethinglike: IssueActionType) {
        switch somethinglike {
        case .inInit: // 初始化
            apIssueSj.send(())
            apCommentsSj.send(())
        case .customIssues: // 内容
            customIssues = loadBundleJSONFile(guideName + ".json")
        case .ciads: // 开发者动态
            cIADs = loadBundleJSONFile("developers.json")
        case .update: // 更新
            apIssueSj.send(())
            apCommentsSj.send(())
        }
    }

    init(repoName: String = "", issueNumber: Int = 0, guideName: String = "") {
        self.repoName = repoName
        self.issueNumber = issueNumber
        self.guideName = guideName
        self.apiSev = APISev()
        self.issue = IssueModel()
        self.comments = [IssueComment]()
        self.customIssues = [CustomIssuesModel]()
        self.cIADs = [SPActiveDevelopersModel]()

        // MARK: - 议题的信息获取
        let reqIssue = IssueRequest(repoName: repoName, issueNumber: issueNumber)
        let resIssueSm = apIssueSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqIssue)
                    .catch { [weak self] error -> Empty<IssueModel, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resIssueSj)
        let repIssueSm = resIssueSj
            .assign(to: \.issue, on: self)

        // MARK: - 议题的留言获取
        let reqComments = IssueCommentsRequest(repoName: repoName, issueNumber: issueNumber)
        let resCommentsSm = apCommentsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqComments)
                    .catch { [weak self] error -> Empty<[IssueComment], Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resCommetsSj)
        let repCommentsSm = resCommetsSj
            .assign(to: \.comments, on: self)

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
            resIssueSm, repIssueSm,
            resCommentsSm, repCommentsSm,
            errMsgSm, errHintSm
        ]
    }
}

struct IssueCommentsRequest: APIReqType {
    typealias Res = [IssueComment]
    var repoName: String
    var issueNumber: Int
    var path: String {
        return "/repos/\(repoName)/issues/\(issueNumber)/comments"
    }
    var qItems: [URLQueryItem]? {
        return [
            .init(name: "per_page", value: "100")
        ]
    }
}

struct IssueRequest: APIReqType {
    typealias Res = IssueModel
    var repoName: String
    var issueNumber: Int
    var path: String {
        return "/repos/\(repoName)/issues/\(issueNumber)"
    }
    var qItems: [URLQueryItem]? {
        return nil
    }
}
