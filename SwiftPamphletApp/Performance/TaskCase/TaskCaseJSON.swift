//
//  TaskCaseJSON.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/14.
//

import Foundation

// 数据模型
struct TCItem: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
}

extension TaskCase {
    static func badJSONDecode() {
        let jsonData = TaskCase.generateLargeJSON()
        do {
            _ = try JSONDecoder().decode([TCItem].self, from: jsonData)
            
        } catch {
            print("解析失败: \(error)")
        }
        Perf.showTime("未优化JSON解析")
    }
    
    static func goodJSONDecode() {
        Task.detached(priority: .background) {
            do {
                _ = try await parseJSON()
                Perf.showTime("异步优化JSON解析")
            } catch {
                print("解析失败: \(error)")
            }
        }
    }
    
    // 异步解析JSON
    @Sendable
    static func parseJSON() async throws -> [TCItem] {
        let jsonData = TaskCase.generateLargeJSON()
        return try JSONDecoder().decode([TCItem].self, from: jsonData)
    }
    
    static func generateLargeJSON() -> Data {
        var items: [[String: Any]] = []
        for i in 0...10000 {
            items.append([
                "id": i,
                "title": "标题 \(i)",
                "description": "这是一段很长的描述文本，用来模拟实际场景中的数据量 \(i)"
            ])
        }
        return try! JSONSerialization.data(withJSONObject: items)
    }
}
