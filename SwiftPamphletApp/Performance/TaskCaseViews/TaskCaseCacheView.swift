//
//  TaskCaseCacheView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import SwiftUI
import Observation

@MainActor @Observable
final class CalculationViewModel {
    var results: [Int: UInt64] = [:]
    var isCalculating = false
    
    // 未优化版本：每次都重新计算
    func calculateWithoutCache(numbers: [Int]) {
        results.removeAll()
        for num in numbers {
            results[num] = fibonacci(num)
        }
    }
    
    // 优化版本：使用缓存
    private var cache: [Int: UInt64] = [:]
    func calculateWithCache(numbers: [Int]) {
        results.removeAll()
        for num in numbers {
            if let cached = cache[num] {
                results[num] = cached
            } else {
                let result = fibonacci(num)
                cache[num] = result
                results[num] = result
            }
        }
    }
    
    // 计算斐波那契数列(计算密集型操作)
    private func fibonacci(_ n: Int) -> UInt64 {
        if n <= 1 { return UInt64(n) }
        var a: UInt64 = 0
        var b: UInt64 = 1
        for _ in 2...n {
            let temp = a + b
            a = b
            b = temp
        }
        return b
    }
}

struct ResultView: View {
    let number: Int
    let result: UInt64
    
    var body: some View {
        HStack {
            Text("F(\(number)) = ")
                .font(.system(.body, design: .monospaced))
            Text("\(result)")
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct TaskCaseCacheView: View {
    @State private var viewModel = CalculationViewModel()
    @State private var selectedNumbers: Set<Int> = []

    private let numbers = Array(35...42) // 选择较大的数以显示性能差异
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(Array(viewModel.results.sorted(by: { $0.key < $1.key })), id: \.key) { number, result in
                        ResultView(number: number, result: result)
                    }
                }
                .padding()
            }
            .frame(height: 200)
            .border(Color.gray.opacity(0.2))
            
            VStack(spacing: 10) {
                Text("选择要计算的斐波那契数：")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 8) {
                    ForEach(numbers, id: \.self) { number in
                        Button(String(number)) {
                            if selectedNumbers.contains(number) {
                                selectedNumbers.remove(number)
                            } else {
                                selectedNumbers.insert(number)
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(selectedNumbers.contains(number) ? .blue : .gray)
                    }
                }
            }
            
            HStack(spacing: 20) {
                Button("不使用缓存计算(卡顿)") {
                    viewModel.calculateWithoutCache(numbers: Array(selectedNumbers))
                }
                .buttonStyle(.bordered)
                
                Button("使用缓存计算(流畅)") {
                    viewModel.calculateWithCache(numbers: Array(selectedNumbers))
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}
