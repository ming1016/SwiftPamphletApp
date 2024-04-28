// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation


public struct SMFile {
    
    // MARK: - 文件 - 沙盒
    // 获取沙盒Document目录路径
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // 保存数据到沙盒中
    public static func saveDataToSandbox(data: Data, fileName: String) {
        let fileURL = SMFile.getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL)
            print("文件保存成功：\(fileURL.path)")
        } catch {
            print("保存文件时出错：\(error)")
        }
    }
    // 删除沙盒中的文件
    public static func deleteFileFromSandbox(fileName: String) {
        let fileURL = SMFile.getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("文件删除成功：\(fileURL.path)")
        } catch {
            print("删除文件时出错：\(error)")
        }
    }
    
    // MARK: Bundle 文件
    // 从Bundle中读取并解析JSON文件生成Model
    public static func loadBundleJSONFile<T: Decodable>(_ filename: String) -> T {

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: SMFile.loadBundleData(filename))
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    // 从 Bundle 中取出 Data
    public static func loadBundleData(_ filename: String) -> Data {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            return Data()
//            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
            return data
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
    
    // 从 Bundle 中取出 String
    public static func loadBundleString(_ filename: String) -> String {
        let d = SMFile.loadBundleData(filename)
        return String(decoding: d, as: UTF8.self)
    }
    
    // 读取指定路径下文件内容
    public static func loadFileContent(path: String) -> String {
        do {
            return try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        } catch {
            return ""
        }
    }
    
    // MARK: - 调试
    public static func showSwiftDataStoreFileLocation() {
        guard let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else { return }

        let url = urlApp.appendingPathComponent("default.store")
        if FileManager.default.fileExists(atPath: url.path) {
            print("swiftdata db at \(url.absoluteString)")
        }
    }
    
    // just for test
    public static func writeToDownload(fileName: String, content: String) {
        try! content.write(toFile: "/Users/mingdai/Downloads/\(fileName)", atomically: true, encoding: String.Encoding.utf8)
    }
}


