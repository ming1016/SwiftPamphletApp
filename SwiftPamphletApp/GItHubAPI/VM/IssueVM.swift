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
    @Published private(set) var issue: IssueModel
    @Published private(set) var comments: [IssueComment]
    @Published private(set) var customIssues: [CustomIssuesModel]
    @Published private(set) var cIADs: [SPActiveDevelopersModel] // 开发者动态
    @Published private(set) var cIGRs: [SPReposModel] // 仓库动态
    
    @Published var errHint = false
    @Published var errMsg = ""
    
    
    // MARK: - APISev
    private let apiSev: APISev
    
    private let errSj = PassthroughSubject<APISevError, Never>()
    
    private let apIssueSj = PassthroughSubject<Void, Never>()
    private let apCommentsSj = PassthroughSubject<Void, Never>()
    private let apCustomIssuesSj = PassthroughSubject<Void, Never>()
    private let apCIADsSj = PassthroughSubject<Void, Never>()
    private let apCIGRsSj = PassthroughSubject<Void, Never>()
    
    private let resIssueSj = PassthroughSubject<IssueModel, Never>()
    private let resCommetsSj = PassthroughSubject<[IssueComment], Never>()
    private let resCustomIssuesSj = PassthroughSubject<IssueModel, Never>()
    private let resCIADsSj = PassthroughSubject<IssueModel, Never>()
    private let resCIGRsSj = PassthroughSubject<IssueModel, Never>()
    
    enum IssueActionType {
        case inInit, customIssues, ciads, cigrs, update
    }
    typealias ActionType = IssueActionType // 可在定义doing函数时，通过参数类型指定，类型推导出来
    func doing(_ somethinglike: IssueActionType) {
        switch somethinglike {
        case .inInit: // 初始化
            apIssueSj.send(())
            apCommentsSj.send(())
        case .customIssues: // 内容
            apCustomIssuesSj.send(())
        case .ciads: // 开发者动态
            apCIADsSj.send(())
        case .cigrs: // 仓库动态
            apCIGRsSj.send(())
        case .update: // 更新
            apIssueSj.send(())
            apCommentsSj.send(())
        }
    }
    
    init(repoName: String, issueNumber: Int) {
        self.repoName = repoName
        self.issueNumber = issueNumber
        self.apiSev = APISev()
        self.issue = IssueModel()
        self.comments = [IssueComment]()
        self.customIssues = [CustomIssuesModel]()
        self.cIADs = [SPActiveDevelopersModel]()
        self.cIGRs = [SPReposModel]()
        
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
        
        // MARK: - CustomIssues
        let reqCustomIssues = IssueRequest(repoName: repoName, issueNumber: issueNumber)
        let resCustomIssuesSm = apCustomIssuesSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCustomIssues)
                    .catch { [weak self] error -> Empty<IssueModel, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resCustomIssuesSj)
        let repCustomIssuesSm = resCustomIssuesSj
            .map({ issueModel in
                let str = issueModel.body?.base64Decoded() ?? ""
                let data: Data
                data = str.data(using: String.Encoding.utf8)!
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode([CustomIssuesModel].self, from: data)
                } catch {
                    return [CustomIssuesModel]()
                }
            })
            .assign(to: \.customIssues, on: self)
        
        // MARK: - 开发者动态
        let resCIADsSm = apCIADsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCustomIssues)
                    .catch { [weak self] error -> Empty<IssueModel, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resCIADsSj)
        let repCIADsSm = resCIADsSj
            .map { issueModel in
                let str = issueModel.body?.base64Decoded() ?? ""
                let data: Data
                data = str.data(using: String.Encoding.utf8)!
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode([SPActiveDevelopersModel].self, from: data)
                } catch {
                    return [SPActiveDevelopersModel]()
                }
            }
            .assign(to: \.cIADs, on: self)
            
        
        // MARK: - 仓库动态
        let resCIGRsSm = apCIGRsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCustomIssues)
                    .catch { [weak self] error -> Empty<IssueModel, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resCIGRsSj)
        let repCIGRsSm = resCIGRsSj
            .map { issueModel in
                let str = issueModel.body?.base64Decoded() ?? ""
                let data: Data
                data = str.data(using: String.Encoding.utf8)!
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode([SPReposModel].self, from: data)
                } catch {
                    return [SPReposModel]()
                }
            }
            .assign(to: \.cIGRs, on: self)
        
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
            resCustomIssuesSm, repCustomIssuesSm,
            resCIADsSm, repCIADsSm,
            resCIGRsSm, repCIGRsSm,
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
