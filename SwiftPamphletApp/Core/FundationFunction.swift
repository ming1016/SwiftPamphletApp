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

// MARK: - Web
func wrapperHtmlContent(content: String, codeStyle: String = "lioshi.min") -> String {
    let reStr = """
<html lang="zh-Hans" data-darkmode="auto">
\(SPC.rssStyle())
<body>
    <main class="container">
        <article class="article heti heti--classic">
        \(content)
        </article>
    </main>
</body>
\(SPC.rssFooterJS())
</html>
"""
    // <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/\(codeStyle).css">
    // writeToDownload(fileName: "a.html", content: reStr)
    return reStr
}

// MARK: - 时间
func howLongAgo(date: Date) -> String {
    let simplifiedChinese = Locale(identifier: "zh_Hans")
    return date.formatted(.relative(presentation: .named,
                                    unitsStyle: .wide).locale(simplifiedChinese))
}
func howLongFromNow(timeStr: String) -> String {
    let iso8601String = timeStr
    let formatter = ISO8601DateFormatter()
    let date = formatter.date(from: iso8601String) ?? .now
    return howLongAgo(date: date)
}

// MARK: - 网络


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

// 网页的相对地址转绝对地址
func urlWithSchemeAndHost(url: URL, urlStr: String) -> String {
    var schemeStr = ""
    var hostStr = ""
    if let scheme = url.scheme, let host = url.host {
        schemeStr = scheme
        hostStr = host
    }
    
    if urlStr.hasPrefix("http") {
        return urlStr
    } else {
        var slash = ""
        if urlStr.hasPrefix("/") == false {
            slash = "/"
        }
        return "\(schemeStr)://\(hostStr)\(slash)\(urlStr)"
    }
}


// MARK: - 基础
// decoder
// extension 

extension NSPasteboard {
    func copyText(_ text: String) {
        self.clearContents()
        self.setString(text, forType: .string)
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
// 用于 SwiftData，让布尔值可排序
extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        !lhs && rhs
    }
}


extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}


