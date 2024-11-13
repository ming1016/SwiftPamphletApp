//
//  BadCase.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import Foundation

struct TaskCase {
    func bad() {
        // 读取文件
        loadFileSynchronously()
        
    }
    
    func good() {
        // 读取文件
        Task {
            await loadFileAsynchronously()
        }
    }
    
    // MARK: - 读取文件
    // 同步读取方式 - 会阻塞主线程
    func loadFileSynchronously() {
        // 模拟耗时操作，减少循环次数并添加延迟
        var content = ""
        for i in 1...10 {
            content += "这是第\(i)行内容\n"
            Thread.sleep(forTimeInterval: 0.3) // 每次循环暂停0.3秒
        }
        print("同步读取文件成功")
        Perf.showTime(des: "异步读取文件")
    }
    
    // 异步读取方式 - 推荐使用
    func loadFileAsynchronously() async {
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
                print("异步读取文件成功")
                Perf.showTime(des: "异步读取文件")
            }
        } catch {
            await MainActor.run {
                print("读取文件失败")
            }
        }
    }
}
