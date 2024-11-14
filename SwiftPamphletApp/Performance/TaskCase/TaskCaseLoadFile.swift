//
//  TaskCaseLoadFile.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/14.
//

import Foundation

extension TaskCase {
    // 同步读取方式 - 会阻塞主线程
    static func badLoadFile() {
        // 模拟耗时操作，减少循环次数并添加延迟
        var content = ""
        for i in 1...10 {
            content += "这是第\(i)行内容\n"
            Thread.sleep(forTimeInterval: 0.3) // 每次循环暂停0.3秒
        }
        Perf.showTime("未优化文件读取")
    }
    
    // 异步读取方式 - 推荐使用
    static func goodLoadFile() {
        Task {
            do {
                _ = try await withCheckedThrowingContinuation { continuation in
                    DispatchQueue.global().async {
                        var content = ""
                        for i in 1...10 {
                            content += "这是第\(i)行内容\n"
                            Thread.sleep(forTimeInterval: 0.3) // 每次循环暂停0.3秒
                        }
                        continuation.resume(returning: content)
                    }
                }
                
                // 更新UI要在主线程
                await MainActor.run {
                    Perf.showTime("异步优化文件读取")
                }
            } catch {
                await MainActor.run {
                    print("读取文件失败")
                }
            }
        }
    }
}
