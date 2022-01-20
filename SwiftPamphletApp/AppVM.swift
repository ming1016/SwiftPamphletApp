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
    
    // 仓库动态
    @Published var reposNotis = [String: Int]()
    @Published var reposCountNotis = 0
    // 开发者动态
    @Published var devsNotis = [String: Int]()
    @Published var devsCountNotis = 0
    // 博客动态
    @Published var rssCountNotis = 0
    
    // MARK: - CCY
    // 探索更多库
    @Published var expNotis = [String: DBRepoStore]()
    @Published var expCountNotis = 0
    @Published var exps = [SPReposModel]()
    
    // MARK: - RSS 读取
    func rssFetch() {
        Task {
            do {
                let rssFeed = SPC.rssFeed() // 获取所有 rss 源的模型
                var i = 0
                let count = rssFeed.count
                let ics = ["🚶","🏃🏽","👩‍🦽","💃🏿","🐕","🤸🏻‍♀️","🤾🏾","🏂","🏊🏻","🚴🏼","🛩","🚠","🚕","🛴","🛸","🚁"]
                for r in rssFeed {
                    i += 1
                    let progressStr = "(\(i)/\(count))"
                    await updateAlertMsg(msg: "\(progressStr) 正在更新 \(ics.randomElement ?? "") \(r.title) ：\(r.des)")
                    let str = try await RSSReq(r.feedLink)
                    guard let str = str else {
                        break
                    }
                    RSSVM.handleFetchFeed(str: str, rssModel: r)
                    // 在 Main Actor 更新通知数
                    await rssUpdateNotis()
                }
            } catch {}
            await updateAlertMsg(msg: "")
        }
    }
    
    @MainActor
    func rssUpdateNotis() {
        do {
            rssCountNotis = try RSSItemsDataHelper.findAllUnreadCount()
        } catch {}
    }
    
    @MainActor
    func updateAlertMsg(msg: String) {
        alertMsg = msg
    }
    
    
    // MARK: - 获取所有探索更多库通知信息
    func loadExpFromServer() {
        
        Task {
            var expDic = [String: DBRepoStore]()
            let gAPI = RESTful(host: .github)
            do {
                let issueModel = try await gAPI.value(for: Github.repos(SPC.pamphletIssueRepoName).issues(108).get)
                let str = issueModel.body?.base64Decoded() ?? ""
                let data = str.data(using: String.Encoding.utf8)!
                var grs = [SPReposModel]()
                
                let decoder = JSONDecoder()
                grs = try decoder.decode([SPReposModel].self, from: data)
                
                for gr in grs {
                    for r in gr.repos {
                        expDic[r.id] = RepoStoreDataHelper.createEmptyDBRepoStore(r.id)
                        if let fd = try RepoStoreDataHelper.find(sFullName: r.id) {
                            expDic[r.id]?.unRead = fd.unRead
                        } else {
                            let _ = try RepoStoreDataHelper.insert(i: RepoStoreDataHelper.createEmptyDBRepoStore(r.id))
                            expDic[r.id]?.unRead = 0
                        } // end if
                    } // end for
                } // end for
                
                // 远程已经删除的仓库，同步本地删除
                if !(expDic.count > 0) { return }
                let expDicKeys = expDic.keys
                if let expsn = try RepoStoreDataHelper.findAll() {
                    for expn in expsn {
                        if !expDicKeys.contains(expn.fullName) {
                            do {
                                try RepoStoreDataHelper.delete(i: expn)
                            } catch { return }
                        } else {
//                            let aExp = SPReposModel
                            expDic[expn.fullName] = expn
                        } // end if else
                    } // end for
                } // end if let
                
                await updateExps(exps: grs)
                await updateExpNotis(expNotis: expDic)
                
            } catch {
                print("wrong")
            } // end do
        }
    }
    
    @MainActor
    func updateExps(exps: [SPReposModel]) {
        self.exps = exps
    }
    @MainActor
    func updateExpNotis(expNotis: [String: DBRepoStore]) {
        self.expNotis = expNotis
    }
    
    // MARK: - Timer for get intervals data
    // 仓库动态
    private var stepCountRepos = 0
    private var reposNotisKeys = [String]()
    // 开发者动态
    private var stepCountDevs = 0
    private var devsNotisKeys = [String]()
    // 探索库
    private var stepCountExp = 0
    private var expNotisKeys = [String]()
    
    // 探索库
    func timeForExpEvent() {
        Task {
            if expNotis.count > 0 {
                if stepCountExp >= expNotis.count {
                    stepCountExp = 0
                }
                if expNotisKeys.count == 0 {
                    for (k, _) in expNotis {
                        expNotisKeys.append(k)
                    }
                }
                guard stepCountExp < expNotisKeys.count else {
                    stepCountExp = 0
                    return
                }
                let repoName = expNotisKeys[stepCountExp]
                await updateAlertMsg(msg: "已同步 \(repoName)：\(expNotis[repoName]?.description ?? "")")
                // 网络请求 repo 的 commit，然后更新未读数
                let gAPI = RESTful(host: .github)
                do {
                    let repoModel = try await gAPI.value(for: Github.repos(repoName).get)
                    let commits = try await gAPI.value(for: Github.repos(repoName).commits.get)
                    if let f = try RepoStoreDataHelper.find(sFullName: repoName) {
                        var i = 0
                        var lrcs = f.lastReadCommitSha
                        for cm in commits {
                            if i == 0 {
                                lrcs = cm.sha ?? ""
                            }
                            if cm.sha == f.lastReadCommitSha {
                                break
                            }
                            i += 1
                        } // end for
                        i = f.unRead + i
                        if i > 0 {
                            await updateAlertMsg(msg: "有更新 \(repoName)：\(expNotis[repoName]?.description ?? "")")
                        }
                        let _ = try RepoStoreDataHelper.update(i: DBRepoStore(
                            id: repoModel.id,
                            name: repoModel.name,
                            fullName: repoName,
                            description: repoModel.description ?? "",
                            stargazersCount: repoModel.stargazersCount,
                            openIssues: repoModel.openIssues,
                            language: repoModel.language ?? "",
                            htmlUrl: repoModel.htmlUrl ?? "",
                            lastReadCommitSha: lrcs,
                            unRead: i,
                            type: 0,
                            extra: ""
                        ))
                    }
                    
                } catch { return }
                
                // 刷新数据
                loadDBExpLoal()
                stepCountExp += 1
            }
        }
    }
    
    // 开发者动态
    @MainActor
    func timeForDevsEvent() -> String? {
        if devsNotis.count > 0 {
            if stepCountDevs >= devsNotis.count {
                stepCountDevs = 0
            }
            if devsNotisKeys.count == 0 {
                for (k, _) in devsNotis {
                    devsNotisKeys.append(k)
                }
            }
            if stepCountDevs >= devsNotisKeys.count {
                stepCountDevs = 0
                return nil
            } else {
                let userName = devsNotisKeys[stepCountDevs]
                updateAlertMsg(msg: "已同步 \(userName)")
                loadDBDevsLoal()
                calculateDevsCountNotis()
                stepCountDevs += 1
                return userName
            }
        } else {
            return nil
        }
    }
    
    // 仓库动态
    @MainActor
    func timeForReposEvent() -> String? {
        if reposNotis.count > 0 {
            if stepCountRepos >= reposNotis.count {
                stepCountRepos = 0
            }
            if reposNotisKeys.count == 0 {
                for (k, _) in reposNotis {
                    reposNotisKeys.append(k)
                }
            }
            if stepCountRepos >= reposNotisKeys.count {
                stepCountRepos = 0
                return nil
            } else {
                let repoName = reposNotisKeys[stepCountRepos]
                updateAlertMsg(msg: "已同步 \(repoName)")
                loadDBReposLoal()
                calculateReposCountNotis()
                stepCountRepos += 1
                return repoName
            } // end if else
            
        } else {
            return nil
        }
    }
    
    // MARK: - On Appear Event
    func onAppearEvent() {
        nsck()
        // 仓库数据读取
        loadDBReposLoal()
        apReposSj.send(())
        // 开发者数据读取
        loadDBDevsLoal()
        apDevsSj.send(())
        // 探索更多库
        loadDBExpLoal()
        loadExpFromServer()
    }
    

    
    // MARK: - Combine
    
    private var cc: [AnyCancellable] = []
    
    private let apiSev: APISev
    
    private let apReposSj = PassthroughSubject<Void, Never>()
    private let resReposSj = PassthroughSubject<IssueModel, Never>()
    private let apDevsSj = PassthroughSubject<Void, Never>()
    private let resDevsSj = PassthroughSubject<IssueModel, Never>()
    
    init() {
        self.apiSev = APISev()
        // MARK: - 初始化数据库
        let db = DB.shared
        do {
            try db.cTbs()
        } catch {
            
        }
        
        // MARK: - 获取所有开发者通知信息
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
        
        
        // MARK: - 获取所有仓库通知信息
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
            var grs = [SPReposModel]()
            do {
                let decoder = JSONDecoder()
                grs = try decoder.decode([SPReposModel].self, from: data)
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
    
    // MARK: 探索更多库，本地数据库读取
    func loadDBExpLoal() {
        Task {
            do {
                if let arr = try RepoStoreDataHelper.findAll() {
                    if arr.count > 0 {
                        var rDic = [String: DBRepoStore]()
                        for i in arr {
                            rDic[i.fullName] = i
                            if expNotis[i.fullName]?.unRead ?? 0 >= SPC.unreadMagicNumber {
                                rDic[i.fullName]?.unRead = SPC.unreadMagicNumber
                            } else {
                                rDic[i.fullName]?.unRead = i.unRead
                            }
                        }
                        await updateExpNotis(expNotis: rDic)
                        await calculateExpCountNotis()
                    } // end if
                } // end if
            } catch {}
        }
    }
    
    
    // MARK: 仓库动态，本地数据库读取
    func loadDBReposLoal() {
        do {
            if let arr = try ReposNotiDataHelper.findAll() {
                if arr.count > 0 {
                    var ReposDic = [String: Int]()
                    for i in arr {
                        if reposNotis[i.fullName] ?? 0 >= SPC.unreadMagicNumber {
                            ReposDic[i.fullName] = SPC.unreadMagicNumber
                        } else {
                            ReposDic[i.fullName] = i.unRead
                        }
                    } // end for
                    reposNotis = ReposDic
                } // end if
            } // end if
        } catch {}
    }
    
    // MARK: 开发者动态，本地数据库读取
    func loadDBDevsLoal() {
        do {
            if let arr = try DevsNotiDataHelper.findAll() {
                if arr.count > 0 {
                    var devsDic = [String: Int]()
                    for i in arr {
                        if devsNotis[i.login] ?? 0 >= SPC.unreadMagicNumber {
                            devsDic[i.login] = SPC.unreadMagicNumber
                        } else {
                            devsDic[i.login] = i.unRead
                        }
                    } // end for
                    devsNotis = devsDic
                } // end if
            } // end if
        } catch {}
    }
    
    // MARK: - 计算通知数量
    @MainActor
    func calculateExpCountNotis() {
        var count = 0
        for i in expNotis {
            count += i.value.unRead
            if count > SPC.unreadMagicNumber * 10 {
                break
            }
        }
        if count >= SPC.unreadMagicNumber {
            count = count - SPC.unreadMagicNumber
        }
        expCountNotis = count
        showAppBadgeLabel()
    }
    
    @MainActor
    func calculateReposCountNotis() {
        var count = 0
        for i in reposNotis {
            count += i.value
            if count > SPC.unreadMagicNumber * 10 {
                break
            }
        }
        if count >= SPC.unreadMagicNumber {
            count = count - SPC.unreadMagicNumber
        }
        reposCountNotis = count
        showAppBadgeLabel()
        
    }
    
    @MainActor
    func calculateDevsCountNotis() {
        var count = 0
        for i in devsNotis {
            count += i.value
            if count > SPC.unreadMagicNumber * 10 {
                break
            }
        }
        if count >= SPC.unreadMagicNumber {
            count = count - SPC.unreadMagicNumber
        }
        devsCountNotis = count
        showAppBadgeLabel()
    }
    
    func showAppBadgeLabel() {
        var count = reposCountNotis + devsCountNotis + expCountNotis + rssCountNotis
        if count > 0 {
            if count > SPC.unreadMagicNumber * 10 {
                count = SPC.unreadMagicNumber * 10
            }
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
