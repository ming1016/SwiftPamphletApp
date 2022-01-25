//
//  RESTfulAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/13.
//

import Foundation
import SwiftUI
/// 参考: https://kean.blog/post/new-api-client

// MARK: - RESTful
public actor RESTful {
    enum Host: String {
        case github = "api.github.com"
    }

    private let conf: Conf
    private let session: URLSession
    private let serializer: Serializer

    convenience init(host: Host, conf: URLSessionConfiguration = .default) {
        self.init(conf: Conf(host: host, sessionConf: conf))
    }

    public init(conf: Conf) {
        self.conf = conf
        self.session = URLSession(configuration: conf.sessionConf)
        self.serializer = Serializer()
    }
    // MARK: - Conf
    public struct Conf {
        var host: Host
        var port: Int?
        var isInsecure = false // false 用 https，true 为 http
        var sessionConf: URLSessionConfiguration = .default

        init(host: Host, port: Int? = nil, isInsecure: Bool = false, sessionConf: URLSessionConfiguration = .default, decoder: JSONDecoder? = nil, encoder: JSONEncoder? = nil) {
            self.host = host
            self.port = port
            self.isInsecure = isInsecure
            self.sessionConf = sessionConf
        } // end init
    } // end struct Conf

    // MARK: - Return Value
    public func value<T: Decodable>(for req: Req<T>) async throws -> T {
        try await send(req).value
    }

}
extension RESTful {

    // MARK: - send
    public func send<T: Decodable>(_ req: Req<T>) async throws -> Res<T> {
        try await send(req) { data in
            if T.self == Data.self {
                return data as! T
            } else if T.self == String.self {
                guard let string = String(data: data, encoding: .utf8) else {
                    throw URLError(.badServerResponse)
                }
                return string as! T
            } else {
                return try await self.serializer.decode(data)
            }
        }
    }

    @discardableResult
    public func send(_ req: Req<Void>) async throws -> Res<Void> {
        try await send(req) { _ in () }
    }

    private func send<T>(_ req: Req<T>, _ decode: @escaping (Data) async throws -> T) async throws -> Res<T> {
        let res = try await data(for: req)
        let value = try await decode(res.value)
        return res.map { _ in
            value
        }
    }

    public func data<T>(for req: Req<T>) async throws -> Res<Data> {
        let req = try await makeRequest(for: req)
        return try await send(req)
    }

    private func send(_ req: URLRequest) async throws -> Res<Data> {
        do {
            return try await actuallySend(req)
        } catch {
            throw error
        }
    }

    private func actuallySend(_ req: URLRequest) async throws -> Res<Data> {
        let (data, res) = try await session.data(for: req, delegate: nil)
        try validate(res: res, data: data)
        let hRes = (res as? HTTPURLResponse) ?? HTTPURLResponse()
        return Res(value: data, data: data, req: req, res: hRes, sCode: hRes.statusCode)
    }

    // MARK: - Make
    private func makeRequest<T>(for req: Req<T>) async throws -> URLRequest {
        let url = try makeURL(path: req.path, query: req.query)
        return try await makeRequest(url: url, method: req.method, body: req.body, headers: req.headers)
    }
    private func makeRequest(url: URL, method: String, body: AnyEncodable?, headers: [String: String]?) async throws -> URLRequest {
        var req = URLRequest(url: url)
        req.allHTTPHeaderFields = headers
        req.httpMethod = method
        if let body = body {
            req.httpBody = try await serializer.encode(body)
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        // 不同平台接口的 token
        switch self.conf.host {
        case .github:
            req.setValue("token \(SPC.gitHubAccessToken)", forHTTPHeaderField: "Authorization")
        }

        return req
    }
    private func makeURL(path: String, query: [(String, String?)]?) throws -> URL {
        guard let url = URL(string: path), var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        if path.starts(with: "/") {
            comps.scheme = conf.isInsecure ? "http" : "https"
            comps.host = conf.host.rawValue
            if let port = conf.port {
                comps.port = port
            }
        }
        if let query = query {
            comps.queryItems = query.map(URLQueryItem.init)
        }
        guard let url = comps.url else {
            throw URLError(.badURL)
        }
        return url
    }
    private func validate(res: URLResponse, data: Data) throws {
        guard let hRes = res as? HTTPURLResponse else {
            return
        }
        if !(200..<300).contains(hRes.statusCode) {
            print("Wrong, statusCode is \(hRes.statusCode)")
            throw URLError(.badServerResponse)
        }
    }
}

public enum RESTfulError: Error, LocalizedError {
    case wrongStateCode(Int)
    public var des: String? {
        switch self {
        case .wrongStateCode(let sCode):
            return "错误的状态码 \(sCode)"
        }
    }
}

// MARK: - Serializer
private actor Serializer {
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    init() {
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601

        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }

    func decode<T: Decodable>(_ data: Data) async throws -> T {
        try decoder.decode(T.self, from: data)
    }
    func encode<T: Encodable>(_ entity: T) async throws -> Data {
        try encoder.encode(entity)
    }
}

// MARK: - 请求和响应

public struct Req<Res> {
    public typealias ReqQType = [(String, String?)]?
    public typealias ReqHType = [String: String]?

    public var method: String
    public var path: String
    public var query: ReqQType
    var body: AnyEncodable?
    public var headers: ReqHType
    public var id: String?

    public static func get(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "GET", path: path, query: query, headers: headers) // GET请求传 body URLSession 会报错
    }

    public static func post(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "POST", path: path, query: query, headers: headers)
    }

    public static func post<U: Encodable>(_ path: String, query: ReqQType = nil, body: U?, headers: ReqHType = nil) -> Req {
        Req(method: "POST", path: path, query: query, body: body.map(AnyEncodable.init), headers: headers)
    }

    public static func put(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "PUT", path: path, query: query, headers: headers)
    }
    public static func put<U: Encodable>(_ path: String, query: ReqQType = nil, body: U?, headers: ReqHType = nil) -> Req {
        Req(method: "PUT", path: path, query: query, body: body.map(AnyEncodable.init), headers: headers)
    }
    public static func patch(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "PATCH", path: path, query: query, headers: headers)
    }
    public static func patch<U: Encodable>(_ path: String, query: ReqQType = nil, body: U?, headers: ReqHType = nil) -> Req {
        Req(method: "PATCH", path: path, query: query, body: body.map(AnyEncodable.init), headers: headers)
    }
    public static func delete(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "DELETE", path: path, query: query, headers: headers)
    }
    public static func delete<U: Encodable>(_ path: String, query: ReqQType = nil, body: U?, headers: ReqHType = nil) -> Req {
        Req(method: "DELETE", path: path, query: query, body: body.map(AnyEncodable.init), headers: headers)
    }
    public static func options(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "OPTIONS", path: path, query: query, headers: headers)
    }
    public static func head(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "HEAD", path: path, query: query, headers: headers)
    }
    public static func trace(_ path: String, query: ReqQType = nil, headers: ReqHType = nil) -> Req {
        Req(method: "TRACE", path: path, query: query, headers: headers)
    }
}

struct AnyEncodable: Encodable {
    private let value: Encodable
    init(_ value: Encodable) {
        self.value = value
    }
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

public struct Res<T> {
    public let value: T
    public let data: Data // 原始数据
    public let req: URLRequest
    public let res: HTTPURLResponse
    public let sCode: Int

    // 通过闭包生成指定类型
    func map<U>(_ closure: (T) -> U) -> Res<U> {
        Res<U>(value: closure(value), data: data, req: req, res: res, sCode: sCode)
    }
}

extension URLRequest {
    public func cURLDes() -> String {
        guard let url = url, let method = httpMethod else {
            return "$ curl command generation failed"
        }
        var comps = ["curl -v"]
        comps.append("-X \(method)")
        for hd in allHTTPHeaderFields ?? [:] {
            let v = hd.value.replacingOccurrences(of: "\"", with: "\\\"")
            comps.append("-H \"\(hd.key): \(v)\"")
        }
        if let hBData = httpBody {
            let httpBody = String(decoding: hBData, as: UTF8.self)
            var eB = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            eB = eB.replacingOccurrences(of: "\"", with: "\\\"")
            comps.append("-d \"\(eB)\"")
        }
        comps.append("\"\(url.absoluteString)\"")
        return comps.joined(separator: " \\\n\t")
    }
}
