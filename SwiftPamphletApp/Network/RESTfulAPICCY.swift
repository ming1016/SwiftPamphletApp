//
//  RESTfulAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/13.
//

import Foundation
import SwiftUI
/// 参考: https://kean.blog/post/new-api-client

// MARK: RESTfulDelegate
public protocol RESTfulDelegate {
    func restful(_ restful: RESTful, willSendReq req: inout URLRequest)
    func retry(_ restful: RESTful, withErr err: Error) async -> Bool
    func restful(_ restful: RESTful, invalidRes res: HTTPURLResponse, data: Data) -> Error
}
public extension RESTfulDelegate {
    func restful(_ restful: RESTful, willSendReq req: inout URLRequest) {}
    func retry(_ restful: RESTful, withErr err: Error) async -> Bool {
        return false
    }
    func restful(_ restful: RESTful, invalidRes res: HTTPURLResponse, data: Data) -> Error {
        return RESTfulError.wrongStateCode(res.statusCode)
    }
}
private struct DefaultRESTfulDelegate: RESTfulDelegate {}

public actor RESTful {
    private let session: URLSession
    private let host: String
    private let delegate: RESTfulDelegate
    
    public init(host: String, configuration: URLSessionConfiguration = .default, delegate: RESTfulDelegate? = nil) {
        self.host = host
        self.session = URLSession(configuration: configuration)
        self.delegate = delegate ?? DefaultRESTfulDelegate()
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

// MARK: 请求和响应

public struct Req<Res> {
    public typealias ReqQType = [String: String?]?
    
    var method: String
    var path: String
    var query: ReqQType
    var body: AnyEncodable?
    public var id: String?
    
    public static func get(_ path: String, query: ReqQType = nil) -> Req {
        Req(method: "GET", path: path, query: query) // GET请求传 body URLSession 会报错
    }
    
    public static func post(_ path: String, query: ReqQType = nil) -> Req {
        Req(method: "POST", path: path, query: query)
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
