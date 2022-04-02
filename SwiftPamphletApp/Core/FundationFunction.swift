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
import SwiftDate
import InstrProfiling

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
func howLongFromNow(timeStr: String) -> String {
    let cn = Region(zone: Zones.asiaShanghai, locale: Locales.chineseChina)
    SwiftDate.defaultRegion = cn

    // 两个 DateInRegion 相差时间 interval
    var r = DateInRegion(timeStr, region: cn)
    if r == nil && !timeStr.isEmpty {
        r = timeStr.toRSSDate(alt: false)
    }
    guard let r = r else {
        return ""
    }

    let i = DateInRegion(Date(), region: cn) - r
    let s = i.toString {
        $0.maximumUnitCount = 1
        $0.allowedUnits = [.year, .day, .hour, .minute]
        $0.collapsesLargestUnit = true
        $0.unitsStyle = .abbreviated
        $0.locale = Locales.chineseChina
    }
    var reStr = s + "前"
    if s == "0年" {
        reStr = "\(r.year)年\(r.month)月\(r.day)日"
    }
    return reStr
}

// MARK: - 网络
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

// MARK: - 文件
// just for test
func writeToDownload(fileName: String, content: String) {
    try! content.write(toFile: "/Users/mingdai/Downloads/\(fileName)", atomically: true, encoding: String.Encoding.utf8)
}

// 从Bundle中读取并解析JSON文件生成Model
func loadBundleJSONFile<T: Decodable>(_ filename: String) -> T {

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: loadBundleData(filename))
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// 从 Bundle 中取出 Data
func loadBundleData(_ filename: String) -> Data {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
        return data
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
}
// 从 Bundle 中取出 String
func loadBundleString(_ filename: String) -> String {
    let d = loadBundleData(filename)
    return String(decoding: d, as: UTF8.self)
}

// 读取指定路径下文件内容
func loadFileContent(path: String) -> String {
    do {
        return try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    } catch {
        return ""
    }
}

// MARK: - 基础
// decoder
// extension 

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

// MARK: - 调试
extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

// MARK: - 代码覆盖率
func codeCoverageProfrawDump(fileName: String = "cc") {
    let name = "\(fileName).profraw"
    let fileManager = FileManager.default
    do {
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let filePath: NSString = documentDirectory.appendingPathComponent(name).path as NSString
        __llvm_profile_set_filename(filePath.utf8String)
        print("File at: \(String(cString: __llvm_profile_get_filename()))")
        __llvm_profile_write_file()
    } catch {
        print(error)
    }
}
