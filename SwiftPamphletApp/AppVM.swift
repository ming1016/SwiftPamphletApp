//
//  AppVM.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/1.
//

import Foundation
import Combine

final class AppVM: ObservableObject {
    @Published var alertMsg = "" // 警告信息
    private var cc: [AnyCancellable] = []
    @Published var reposNotis = [String: Int]()
    @Published var reposCountNotis = 0
    
    private let apiSev: APISev
    
    private let apReposSj = PassthroughSubject<Void, Never>()
    private let resReposSj = PassthroughSubject<IssueModel, Never>()
    
    enum AppActionType {
        case loadDBRepoInfoFromServer, loadDBRepoInfoLocal
    }
    func doing(_ somethinglike: AppActionType) {
        switch somethinglike {
        case .loadDBRepoInfoFromServer:
            apReposSj.send(())
        case .loadDBRepoInfoLocal:
            loadDBReposLoal()
        }
    }
    
    init() {
        self.apiSev = APISev()
        // 初始化数据库
        let db = DB.shared
        do {
            try db.cTbs()
        } catch {
            
        }
        
        // 获取所有仓库通知信息
        let reqReposCustomIssues = IssueRequest(repoName: SPC.pamphletIssueRepoName, issueNumber: 31)
        let resReposSm = apReposSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqReposCustomIssues)
                    .catch { error -> Empty<IssueModel, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resReposSj)
        var ReposDic = [String: Int]()
        func switchToReposDic(issueModel: IssueModel) -> [String: Int] {
            let str = issueModel.body?.base64Decoded() ?? ""
            let data: Data
            data = str.data(using: String.Encoding.utf8)!
            var grs = [SPGoodReposModel]()
            do {
                let decoder = JSONDecoder()
                grs = try decoder.decode([SPGoodReposModel].self, from: data)
            } catch {
                grs = [SPGoodReposModel]()
                return ReposDic
            }
            for gr in grs {
                for r in gr.repos {
                    do {
                        if let fd = try ReposNotiDataHelper.find(sFullName: r.id) {
                            ReposDic[fd.fullName] = fd.unRead
                        } else {
                            do {
                                let _ = try ReposNotiDataHelper.insert(i: DBRepoNoti(fullName: r.id, lastReadCommitSha: "", unRead: 0))
                                ReposDic[r.id] = 0
                            } catch {
                                return ReposDic
                            }
                        }
                    } catch {
                        return ReposDic
                    }
                    
                } // end for
            } // end for
            return ReposDic
        }
        let repReposSm = resReposSj
            .map { issueModel in
                return switchToReposDic(issueModel: issueModel)
            } // end map
            .assign(to: \.reposNotis, on: self)
        
        cc += [
            resReposSm, repReposSm
        ]
    }
    
    func loadDBReposLoal() {
        do {
            if let arr = try ReposNotiDataHelper.findAll() {
                if arr.count > 0 {
                    var ReposDic = [String: Int]()
                    for i in arr {
                        ReposDic[i.fullName] = i.unRead
                    }
                    reposNotis = ReposDic
                }
            }
        } catch {}
    }
    
    func calculateReposCountNotis() {
        var count = 0
        for i in reposNotis {
            count += i.value
        }
        reposCountNotis = count
    }
    
    // 订阅网络状态
    func nsck() {
        Nsck.shared.pb
            .sink { _ in
                //
            } receiveValue: { [weak self] path in
                self?.alertMsg = path.debugDescription
                switch path.status {
                case .satisfied:
                    self?.alertMsg = ""
                case .unsatisfied:
                    self?.alertMsg = "😱"
                case .requiresConnection:
                    self?.alertMsg = "🥱"
                @unknown default:
                    self?.alertMsg = "🤔"
                }
                if path.status == .unsatisfied {
                    switch path.unsatisfiedReason {
                    case .notAvailable:
                        self?.alertMsg += "网络不可用"
                    case .cellularDenied:
                        self?.alertMsg += "蜂窝网不可用"
                    case .wifiDenied:
                        self?.alertMsg += "Wifi不可用"
                    case .localNetworkDenied:
                        self?.alertMsg += "网线不可用"
                    @unknown default:
                        self?.alertMsg += "网络不可用"
                    }
                }
            }
            .store(in: &cc)
    }
    
}
