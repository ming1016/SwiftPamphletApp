//
//  NetRequest.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/8.
//

import Foundation
import Combine

// MARK: - API Request Fundation

protocol APIReqType {
    associatedtype Res: Decodable
    var path: String { get }
    var qItems: [URLQueryItem]? { get }
}

protocol APIVMable: ObservableObject {
    associatedtype ActionType
    func doing(_ somethinglike: ActionType)
}

protocol APISevType {
    func response<Request>(from req: Request) -> AnyPublisher<Request.Res, APISevError> where Request: APIReqType
}

final class APISev: APISevType {
    private let rootUrl: URL

    init(rootUrl: URL = URL(string: "https://api.github.com")!) {
        self.rootUrl = rootUrl
    }

    func response<Request>(from req: Request) -> AnyPublisher<Request.Res, APISevError> where Request : APIReqType {
        let path = URL(string: req.path, relativeTo: rootUrl)!
        var comp = URLComponents(url: path, resolvingAgainstBaseURL: true)!
        comp.queryItems = req.qItems
//        print(comp.url?.description ?? "url wrong")
        var req = URLRequest(url: comp.url!)

        // token 处理
        // TODO: 支持 OAuth
        // TODO: 访问受限后会crash，异常待处理
        req.addValue("token \(SPC.gitHubAccessToken)", forHTTPHeaderField: "Authorization")

//        print(req.allHTTPHeaderFields!)
        let de = JSONDecoder()
        de.keyDecodingStrategy = .convertFromSnakeCase
        let sch = DispatchQueue(label: "GitHub API Queue", qos: .default, attributes: .concurrent)
        return URLSession.shared.dataTaskPublisher(for: req)
            .retry(3)
            .subscribe(on: sch)
            .receive(on: sch)
            .map { data, _ in
//                print(String(decoding: data, as: UTF8.self))
//                print(res.description)
                // 打印api访问额度
//                let hres = res as! HTTPURLResponse
//                print(hres.value(forHTTPHeaderField: "x-ratelimit-remaining") ?? "none")
                return data
            }
            .mapError { _ in
                APISevError.resError
            }
            .decode(type: Request.Res.self, decoder: de)
            .mapError { _ in
                APISevError.parseError
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

enum APISevError: Error {
    case resError
    case parseError

    var message: String {
        switch self {
        case .resError:
            return "网络无法访问"
        case .parseError:
            return "网络出错"
        }
    }
}
