//
//  TaskCasePriorityView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import SwiftUI
import Combine

// 计算任务
struct CalculationTask: Sendable {
    let id: Int
    let iterations: Int
}

// 算结果
struct CalculationResult: Sendable {
    let taskId: Int
    let result: Double
}

// 视图模型
@MainActor
final class CalculationPriorityViewModel: ObservableObject, @unchecked Sendable {
    @Published var results: [Int: Double] = [:]
    @Published var isCalculating = false
    @Published var animationOffset: CGFloat = 0
    private var animationTimer: AnyCancellable?
    
    // 不当使用高优先级(会导致UI卡顿)
    func runHighPriorityTasks(iter: Int = 1) async {
        isCalculating = true
        let tasks = (1...10).map { id in
            CalculationTask(id: id, iterations: iter)
        }
        
        // 使用高优先级运行所有任务
        await withTaskGroup(of: CalculationResult.self) { group in
            for task in tasks {
                group.addTask(priority: .high) { // 默认优先级
                    await self.heavyCalculation(task)
                }
            }
            
            for await result in group {
                results[result.taskId] = result.result
            }
        }
        
        isCalculating = false
    }
    
    // 使用合适的优先级(UI流畅)
    func runOptimizedTasks(iter: Int = 1) async {
        isCalculating = true
        let tasks = (1...10).map { id in
            CalculationTask(id: id, iterations: iter)
        }
        
        // 使用较低优先级运行计算任务
        await withTaskGroup(of: CalculationResult.self) { group in
            for task in tasks {
                group.addTask(priority: .background) { // 低优先级
                    await self.heavyCalculation(task)
                }
            }
            
            for await result in group {
                results[result.taskId] = result.result
            }
        }
        
        isCalculating = false
    }
    
    // 密集计算函数
    private func heavyCalculation(_ task: CalculationTask) async -> CalculationResult {
        var result = 0.0
        for i in 0..<task.iterations {
            result += sin(Double(i))
        }
        return CalculationResult(taskId: task.id, result: result)
    }
    
    // 启动UI动画
    func startAnimation() {
        animationTimer = Timer.publish(every: 1/60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateAnimation()
            }
    }
    
    // 停止UI动画
    func stopAnimation() {
        animationTimer?.cancel()
        animationTimer = nil
    }
    
    private func updateAnimation() {
        withAnimation(.linear(duration: 1/60)) {
            animationOffset = animationOffset < 100 ? animationOffset + 1 : 0
        }
    }
}

struct TaskCasePriorityView: View {
    @StateObject private var viewModel = CalculationPriorityViewModel()
    var isBad = true
    
    var body: some View {
        VStack(spacing: 30) {
            // 动画指示器
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .offset(x: viewModel.animationOffset)
                .animation(.linear(duration: 1/60), value: viewModel.animationOffset)
            
            // 计算结果显示
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(Array(viewModel.results.sorted(by: { $0.key < $1.key })), id: \.key) { id, result in
                        Text("Task \(id): \(String(format: "%.2f", result))")
                            .font(.system(.body, design: .monospaced))
                    }
                }
            }
            .frame(height: 200)
            .border(Color.gray.opacity(0.2))
            
            HStack(spacing: 20) {
                Button("高优先级执行(卡顿)") {
                    Task {
                        await viewModel.runHighPriorityTasks()
                    }
                }
                .buttonStyle(.bordered)
                
                Button("优化优先级执行(流畅)") {
                    Task {
                        await viewModel.runOptimizedTasks()
                    }
                }
                .buttonStyle(.bordered)
            }
            
            if viewModel.isCalculating {
                ProgressView()
                    .padding()
            }
        }
        .padding()
        .onAppear {
            viewModel.startAnimation()
            if isBad == true {
                Task {
                    await viewModel.runHighPriorityTasks(iter: 500000)
                    Perf.showTime("高优先级执行完成")
                }
            } else {
                var tasks = [@Sendable () async -> Void]()
                for _ in 0...10 {
                    tasks.append {
                        await viewModel.runOptimizedTasks(iter: 50000)
                    }
                }
                performLowPriorityTasks(tasks: tasks)
                Perf.showTime("低优先级执行完成")
            }
        }
        .onDisappear {
            viewModel.stopAnimation()
        }
    }
}
