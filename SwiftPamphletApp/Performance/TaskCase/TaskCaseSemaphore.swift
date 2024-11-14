//
//  TaskCaseSemaphore.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/14.
//

import Foundation

extension TaskCase {
    static func badSemaphore() {
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            // 模拟耗时操作
            sleep(2)
            semaphore.signal()
        }
        
        // 等待信号量，会阻塞主线程
        semaphore.wait()
        Perf.showTime("未优化信号量")
    }
    
    static func goodSemaphore() {
        Task {
            await performAsyncTask()
            Perf.showTime("异步优化信号量")
        }
        
        // 异步任务函数
        @Sendable
        func performAsyncTask() async {
            try? await Task.sleep(for: .seconds(2))
        }
    }
}
