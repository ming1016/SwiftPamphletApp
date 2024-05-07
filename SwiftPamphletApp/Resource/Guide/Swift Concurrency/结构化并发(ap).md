使用这些接口可以一边接收数据一边进行显示，AsyncSequence 的提案是 [SE-0298](https://github.com/apple/swift-evolution/blob/main/proposals/0298-asyncsequence.md) （Swift 5.5可用）。AsyncStream 是创建自己异步序列的最简单的方法，处理迭代、取消和缓冲。AsyncStream 正在路上，提案是 [SE-0314](https://github.com/apple/swift-evolution/blob/main/proposals/0314-async-stream.md) 。

Task 为一组并发任务创建一个运行环境，async let 可以让任务并发执行，结构化并发（Structured concurrency，提案在路上 [SE-0304](https://github.com/apple/swift-evolution/blob/main/proposals/0304-structured-concurrency.md) ）withTaskGroup 中 group.async 可以将并发任务进行分组。
