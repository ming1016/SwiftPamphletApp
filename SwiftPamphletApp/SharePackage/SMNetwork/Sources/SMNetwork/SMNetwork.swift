// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Observation
import Network
#if os(macOS)
import AppKit
#endif

public class SMNetwork {
    // 跳到浏览器中显示网址内容
    public static func gotoWebBrowser(urlStr: String) {
        if !urlStr.isEmpty {
            let validUrlStr = SMNetwork.validHTTPUrlStrFromUrlStr(urlStr: urlStr)
            #if os(macOS)
            NSWorkspace.shared.open(URL(string: validUrlStr)!)
            #endif
        } else {
            print("error: url is empty!")
        }
    }

    // 检查地址是否有效
    public static func validHTTPUrlStrFromUrlStr(urlStr: String) -> String {
        let httpPrefix = "http://"
        let httpsPrefix = "https://"
        if (urlStr.hasPrefix(httpPrefix) || urlStr.hasPrefix(httpsPrefix)) {
            return urlStr
        }
        return httpsPrefix + urlStr
    }

    // 网页的相对地址转绝对地址
    public static func urlWithSchemeAndHost(url: URL, urlStr: String) -> String {
        var schemeStr = ""
        var hostStr = ""
        if let scheme = url.scheme, let host = url.host {
            schemeStr = scheme
            hostStr = host
        }
        url.path()
        
        if urlStr.hasPrefix("http") {
            return urlStr
        } else {
//            var slash = ""
//            if urlStr.hasPrefix("/") == false {
//                slash = "/"
//            }
            return "\(schemeStr)://\(hostStr)\(url.path())\(urlStr)"
        }
    }
}

@Observable
public final class NetworkMonitor {
    public var hasNetworkConnection = true
    public var isUsingMobileConnection = false // low data usage ( 3G / 4G / etc )
    
    private let networkMonitor = NWPathMonitor()
    
    public init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.hasNetworkConnection = path.status == .satisfied
            self?.isUsingMobileConnection = path.usesInterfaceType(.cellular)
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }
}
