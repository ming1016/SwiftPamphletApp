//
//  TaskCaseUIUpdate.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import SwiftUI

struct CardItem: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
}

// 用户数据模型
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let company: Company
    
    struct Company: Codable {
        let name: String
    }
}

struct TaskCaseUIUpdateView: View {
    @State private var users: [User] = []
    @State private var cards: [CardItem] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    var isBad = true
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                ProgressView("正在生成卡片...")
            }
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 150), spacing: 16)
                ], spacing: 16) {
                    ForEach(cards) { card in
                        CardView(item: card)
                    }
                }
                .padding()
            }
            
            HStack(spacing: 20) {
                // 同步更新UI - 会卡顿
                Button("同步更新(会卡顿)") {
                    updateCardsSynchronously()
                }
                
                // 异步更新UI - 推荐方式
                Button("异步更新(推荐)") {
                    Task {
                        await updateCardsAsynchronously()
                    }
                }
                
                // 清空按钮
                Button("清空") {
                    cards.removeAll()
                }
            }
        }
        .onAppear {
            if isBad == true {
                updateCardsSynchronously()
            } else {
                Task {
                    await updateCardsAsynchronously()
                }
            }
        }
        .padding()
        .frame(height: 300)
    }
    
    // 卡片视图组件
    struct CardView: View {
        let item: CardItem
        
        var body: some View {
            VStack {
                Text(item.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(item.color)
                    .cornerRadius(8)
            }
        }
    }
    
    // 同步更新 - 会阻塞主��程
    private func updateCardsSynchronously() {
        // 一次性生成1000个卡片
        var newCards: [CardItem] = []
        for i in 1...1000 {
            // 模拟复杂的UI计算
            Thread.sleep(forTimeInterval: 0.001) // 每张卡片增加1毫秒延迟
            let color = Color(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1)
            )
            newCards.append(CardItem(title: "卡片 #\(i)", color: color))
        }
        cards = newCards
    }
    
    // 异步更新 - 推荐使用
    @MainActor
    private func updateCardsAsynchronously() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let newCards = try await withThrowingTaskGroup(of: [CardItem].self) { group in
                // 分批处理，每批100个卡片
                let batchSize = 100
                let totalCards = 1000
                var allCards: [CardItem] = []
                
                for batchStart in stride(from: 0, to: totalCards, by: batchSize) {
                    group.addTask {
                        var batchCards: [CardItem] = []
                        let end = min(batchStart + batchSize, totalCards)
                        
                        for i in (batchStart + 1)...end {
                            // 模拟复杂的UI计算
                            try await Task.sleep(nanoseconds: 1_000_000) // 1毫秒
                            let color = Color(
                                red: .random(in: 0...1),
                                green: .random(in: 0...1),
                                blue: .random(in: 0...1)
                            )
                            batchCards.append(CardItem(title: "卡片 #\(i)", color: color))
                        }
                        return batchCards
                    }
                }
                
                // 收集所有批次的结果
                for try await batchCards in group {
                    allCards.append(contentsOf: batchCards)
                }
                
                return allCards
            }
            
            // 更新UI
            self.cards = newCards
            self.isLoading = false
            
        } catch {
            self.errorMessage = "生成卡片失败: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}
