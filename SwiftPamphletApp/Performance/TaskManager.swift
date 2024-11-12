//
//  TaskManager.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/12.
//

import Foundation

// 按组执行异步任务
func executeTasksConcurrently(tasks: [@Sendable () async -> Void]) async {
    await withTaskGroup(of: Void.self) { group in
        // 将每个任务闭包添加到任务组中
        for task in tasks {
            group.addTask {
                await task()
            }
        }
    }
}

// 执行低优先级任务
func performLowPriorityTasks(tasks: [@Sendable () async -> Void]) {
    for task in tasks {
        Task.detached(priority: .background) {
            await task()
        }
    }
}

func taskgroupDemo() {
    var tasks: [@Sendable () async -> Void] = [
        {
            await performTaskOne()
        },
        {
            await performTaskTwo()
        },
        {
            await performTaskThree()
        }
    ]
    tasks.append {
        await wait()
        print("Task Four Completed")
    }
    tasks.append {
        await wait()
        print("Task Five Completed")
    }
    
    // 示例异步任务函数
    @Sendable func performTaskOne() async {
        await wait()
        print("Task One Completed")
    }

    @Sendable func performTaskTwo() async {
        await wait()
        print("Task Two Completed")
    }

    @Sendable func performTaskThree() async {
        await wait()
        print("Task Three Completed")
    }
    
    @Sendable func wait() async {
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
    
    // 低优先级示例函数
    @Sendable func backgroundTaskOne() async {
        await wait()
        print("Background Task One Executed")
    }

    @Sendable func backgroundTaskTwo() async {
        await wait()
        print("Background Task Two Executed")
    }
    
    var backgroundTasks: [@Sendable () async -> Void] = [
        { await backgroundTaskOne() },
        { await backgroundTaskTwo() }
    ]
    
    backgroundTasks.append {
        await wait()
        print("Background Task Three Executed")
    }
    backgroundTasks.append {
        await wait()
        print("Background Task Four Executed")
    }
    
    // 开始执行任务
    performLowPriorityTasks(tasks: backgroundTasks)
    Task {
        await executeTasksConcurrently(tasks: tasks)
        print("first group of tasks completed.")
        await executeTasksConcurrently(tasks: tasks)
        print("second group of tasks completed.")
        await executeTasksConcurrently(tasks: tasks)
        print("third group of tasks completed.")
        print("All tasks completed.")
    }
}


