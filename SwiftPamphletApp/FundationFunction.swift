//
//  BaseFunction.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/9.
//

import Foundation
import SwiftUI
import Combine
import Network

final class AppVM: ObservableObject {
    @Published var alertMsg = "" // 警告信息
    private var cc: [AnyCancellable] = []
    @Published var reposNotis = [String: Int]()
    @Published var reposCountNotis = 0
    
    private let apiSev: APISev
    
    private let apReposSj = PassthroughSubject<Void, Never>()
    private let resReposSj = PassthroughSubject<IssueModel, Never>()
    
    enum AppActionType {
        case loadDBRepoInfo
    }
    func doing(_ somethinglike: AppActionType) {
        switch somethinglike {
        case .loadDBRepoInfo:
            apReposSj.send(())
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
        let reqReposCustomIssues = IssueRequest(repoName: SPConfig.pamphletIssueRepoName, issueNumber: 31)
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
                        if let fd = try ReposDataHelper.find(sFullName: r.id) {
                            ReposDic[fd.fullName] = fd.unRead
                        } else {
                            do {
                                let _ = try ReposDataHelper.insert(i: DBRepo(fullName: r.id, lastReadCommitSha: "", unRead: 0))
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

// 网络状态检查 network state check
final class Nsck: ObservableObject {
    static let shared = Nsck()
    private(set) lazy var pb = mkpb()
    @Published private(set) var pt: NWPath
    
    private let monitor: NWPathMonitor
    private lazy var sj = CurrentValueSubject<NWPath, Never>(monitor.currentPath)
    private var sb: AnyCancellable?
    
    init() {
        monitor = NWPathMonitor()
        pt = monitor.currentPath
        monitor.pathUpdateHandler = { [weak self] path in
            self?.pt = path
            self?.sj.send(path)
        }
        monitor.start(queue: DispatchQueue.main)
    }
    
    deinit {
        monitor.cancel()
        sj.send(completion: .finished)
    }
    
    private func mkpb() -> AnyPublisher<NWPath, Never> {
        return sj.eraseToAnyPublisher()
    }
}

// base64
extension String {
    func base64Encoded() -> String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

// 从数组中随机取一个元素
extension Array {
    public var randomElement: Element? {
        guard count > 0 else {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}

// 跳到浏览器中显示网址内容
func gotoWebBrowser(urlStr: String) {
    if !urlStr.isEmpty {
        let validUrlStr = validHTTPUrlStrFromUrlStr(urlStr: urlStr)
        NSWorkspace.shared.open(URL(string: validUrlStr)!)
    } else {
        print("error: url is empty!")
    }
}

// 检查地址是否有效
func validHTTPUrlStrFromUrlStr(urlStr: String) -> String {
    let httpPrefix = "http://"
    let httpsPrefix = "https://"
    if (urlStr.hasPrefix(httpPrefix) || urlStr.hasPrefix(httpsPrefix)) {
        return urlStr
    }
    return httpsPrefix + urlStr
}

// 从Bundle中读取并解析JSON文件生成Model
func loadBundleJSONFile<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// 读取指定路径下文件内容
func loadFileContent(path: String) -> String {
    do {
        return try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    } catch {
        return ""
    }
}






























