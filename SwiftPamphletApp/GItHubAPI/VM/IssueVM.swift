//
//  IssueVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/15.
//

import Foundation
import Combine

final class IssueVM: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    public let repoName: String
    public let issueNumber: Int
    @Published private(set) var issue: IssueModel
    @Published private(set) var comments: [IssueComment]
    @Published private(set) var customIssues: [CustomIssuesModel]
    @Published private(set) var cIADs: [SPActiveDevelopersModel] // 开发者动态
    @Published private(set) var cIGRs: [SPGoodReposModel] // 仓库动态
    
    private let apiSev: APISev
    
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
    
    func apInInit() {
        apIssueSj.send(())
        apCommentsSj.send(())
    }
    
    func apCustomIssues() {
        apCustomIssuesSj.send(())
    }
    
    func apCIADs() {
        apCIADsSj.send(())
    }
    
    func apCIGRs() {
        apCIGRsSj.send(())
    }
    
    func update() {
        apIssueSj.send(())
        apCommentsSj.send(())
    }
    
    init(repoName: String, issueNumber: Int) {
        self.repoName = repoName
        self.issueNumber = issueNumber
        self.apiSev = APISev()
        self.issue = IssueModel()
        self.comments = [IssueComment]()
        self.customIssues = [CustomIssuesModel]()
        self.cIADs = [SPActiveDevelopersModel]()
        self.cIGRs = [SPGoodReposModel]()
        
        // 议题的信息获取
        let reqIssue = IssueRequest(repoName: repoName, issueNumber: issueNumber)
        let resIssueSm = apIssueSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqIssue)
                    .catch { error -> Empty<IssueModel, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resIssueSj)
        let repIssueSm = resIssueSj
            .assign(to: \.issue, on: self)
        
        // 议题的留言获取
        let reqComments = IssueCommentsRequest(repoName: repoName, issueNumber: issueNumber)
        let resCommentsSm = apCommentsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqComments)
                    .catch { error -> Empty<[IssueComment], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resCommetsSj)
        let repCommentsSm = resCommetsSj
            .assign(to: \.comments, on: self)
        
        // CustomIssues
        let reqCustomIssues = IssueRequest(repoName: repoName, issueNumber: issueNumber)
        let resCustomIssuesSm = apCustomIssuesSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCustomIssues)
                    .catch { error -> Empty<IssueModel, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resCustomIssuesSj)
        let repCustomIssuesSm = resCustomIssuesSj
            .map({ issueMode in
                let str = issueMode.body?.base64Decoded() ?? ""
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
        
        // 开发者动态
        let resCIADsSm = apCIADsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCustomIssues)
                    .catch { error -> Empty<IssueModel, Never> in
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
            
        
        // 仓库动态
        let resCIGRsSm = apCIGRsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqCustomIssues)
                    .catch { error -> Empty<IssueModel, Never> in
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
                    return try decoder.decode([SPGoodReposModel].self, from: data)
                } catch {
                    return [SPGoodReposModel]()
                }
            }
            .assign(to: \.cIGRs, on: self)
        
        
        cancellables += [
            resIssueSm, repIssueSm,
            resCommentsSm, repCommentsSm,
            resCustomIssuesSm, repCustomIssuesSm,
            resCIADsSm, repCIADsSm,
            resCIGRsSm, repCIGRsSm
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
