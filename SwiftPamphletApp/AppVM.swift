//
//  AppVM.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/1.
//

import Foundation
import Combine
import AppKit

final class AppVM: ObservableObject {
    @Published var alertMsg = "" // 警告信息
    private var cc: [AnyCancellable] = []
    @Published var reposNotis = [String: Int]()
    @Published var reposCountNotis = 0
    @Published var devsNotis = [String: Int]()
    @Published var devsCountNotis = 0
    
    private let apiSev: APISev
    
    private let apReposSj = PassthroughSubject<Void, Never>()
    private let resReposSj = PassthroughSubject<IssueModel, Never>()
    private let apDevsSj = PassthroughSubject<Void, Never>()
    private let resDevsSj = PassthroughSubject<IssueModel, Never>()
    
    enum AppActionType {
        case loadDBRepoInfoFromServer
        case loadDBRepoInfoLocal
        case loadDBDevInfoFromServer
        case loadDBDevInfoLocal
    }
    func doing(_ somethinglike: AppActionType) {
        switch somethinglike {
        case .loadDBRepoInfoFromServer:
            apReposSj.send(())
        case .loadDBRepoInfoLocal:
            loadDBReposLoal()
        case .loadDBDevInfoFromServer:
            apDevsSj.send(())
        case .loadDBDevInfoLocal:
            loadDBDevsLoal()
        }
    }
    
    init() {
        self.apiSev = APISev()
        // MARK: 初始化数据库
        let db = DB.shared
        do {
            try db.cTbs()
        } catch {
            
        }
        
        // MARK: 获取所有开发者通知信息
        let reqDevsCustomIssues = IssueRequest(repoName: SPC.pamphletIssueRepoName, issueNumber: 30)
        let resDevsSm = apDevsSj
            .flatMap { [apiSev] in
                apiSev.response(from: reqDevsCustomIssues)
                    .catch { error -> Empty<IssueModel, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resDevsSj)
        var devsDic = [String: Int]()
        func switchToDevsDic(issueModel: IssueModel) -> [String: Int] {
            let str = issueModel.body?.base64Decoded() ?? ""
            let data = str.data(using: String.Encoding.utf8)!
            var ads = [SPActiveDevelopersModel]()
            do {
                let decoder = JSONDecoder()
                ads = try decoder.decode([SPActiveDevelopersModel].self, from: data)
            } catch {
                return devsDic
            }
            for ad in ads {
                for d in ad.users {
                    do {
                        if let fd = try DevsNotiDataHelper.find(sLogin: d.id) {
                            devsDic[fd.login] = fd.unRead
                        } else {
                            do {
                                let _ = try DevsNotiDataHelper.insert(i: DBDevNoti(login: d.id, lastReadId: "", unRead: 0))
                                devsDic[d.id] = 0
                            } catch {
                                return devsDic
                            }
                        }
                    } catch {
                        return devsDic
                    } // end do
                } // end for
            } // end for
            
            // 远程已经删除的开发者，同步本地删除
            if !(devsDic.count > 0) {
                return devsDic
            }
            let devsDicKeys = devsDic.keys
            do {
                if let dvsn = try DevsNotiDataHelper.findAll() {
                    for dvn in dvsn {
                        if !devsDicKeys.contains(dvn.login) {
                            do {
                                try DevsNotiDataHelper.delete(i: dvn)
                            } catch {
                                return devsDic
                            } // end do
                        } // end if
                    } // end for
                } // end if let
            } catch {
                return devsDic
            }
            
            return devsDic
        }
        let repDevsSm = resDevsSj
            .map { issueModel in
                return switchToDevsDic(issueModel: issueModel)
            } // end map
            .assign(to: \.devsNotis, on: self)
        
        
        // MARK: 获取所有仓库通知信息
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
        var reposDic = [String: Int]()
        func switchToReposDic(issueModel: IssueModel) -> [String: Int] {
            let str = issueModel.body?.base64Decoded() ?? ""
            let data = str.data(using: String.Encoding.utf8)!
            var grs = [SPGoodReposModel]()
            do {
                let decoder = JSONDecoder()
                grs = try decoder.decode([SPGoodReposModel].self, from: data)
            } catch {
                return reposDic
            }
            for gr in grs {
                for r in gr.repos {
                    do {
                        if let fd = try ReposNotiDataHelper.find(sFullName: r.id) {
                            reposDic[fd.fullName] = fd.unRead
                        } else {
                            do {
                                let _ = try ReposNotiDataHelper.insert(i: DBRepoNoti(fullName: r.id, lastReadCommitSha: "", unRead: 0))
                                reposDic[r.id] = 0
                            } catch {
                                return reposDic
                            }
                        }
                    } catch {
                        return reposDic
                    }
                    
                } // end for
            } // end for
            
            // 远程已经删除的仓库，同步本地删除
            if !(reposDic.count > 0) {
                return reposDic
            }
            let reposDicKeys = reposDic.keys
            do {
                if let rpsn = try ReposNotiDataHelper.findAll() {
                    for rpn in rpsn {
                        if !reposDicKeys.contains(rpn.fullName) {
                            do {
                                try ReposNotiDataHelper.delete(i: rpn)
                            } catch {
                                return reposDic
                            } // end do
                        } // end if
                    } // end for
                } // end if let
            } catch {
                return reposDic
            }
            
            return reposDic
        }
        let repReposSm = resReposSj
            .map { issueModel in
                return switchToReposDic(issueModel: issueModel)
            } // end map
            .assign(to: \.reposNotis, on: self)
        
        cc += [
            resReposSm, repReposSm,
            resDevsSm, repDevsSm
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
    
    func loadDBDevsLoal() {
        do {
            if let arr = try DevsNotiDataHelper.findAll() {
                if arr.count > 0 {
                    var devsDic = [String: Int]()
                    for i in arr {
                        devsDic[i.login] = i.unRead
                    }
                    devsNotis = devsDic
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
        showAppBadgeLabel()
        
    }
    
    func calculateDevsCountNotis() {
        var count = 0
        for i in devsNotis {
            count += i.value
        }
        devsCountNotis = count
        showAppBadgeLabel()
    }
    
    func showAppBadgeLabel() {
        if reposCountNotis + devsCountNotis > 0 {
            let count = reposCountNotis + devsCountNotis
            NSApp.dockTile.showsApplicationBadge = true
            NSApp.dockTile.badgeLabel = "\(count)"
        } else {
            NSApp.dockTile.badgeLabel = nil
        }
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
