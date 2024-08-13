actor 具有分布式形式工作能力，也就是可以 RPC 通过网络读取和写入属性或者调用方法。设计为保护在跨多个进程中的低级别数据竞争。Distributed actors 可以在两个进程间建立通道，隔离它们状态，并在它们之间异步通信。每个 distributed actors 在 actor 初始化时分配一个不可以手动创建的 id，在它所属整个 distributed actor 系统中唯一标识所指 actor，这样无论 distributed actors 在哪，都可以以相同的方式与之交互。

session [Meet distributed actors in Swift](https://developer.apple.com/videos/play/wwdc2022/110356/) 。这里有个 distributed actors 的代码示例 [TicTacFish: Implementing a game using distributed actors](https://developer.apple.com/documentation/swift/tictacfish_implementing_a_game_using_distributed_actors)

[SE-0336 Distributed Actor Isolation](https://github.com/apple/swift-evolution/blob/main/proposals/0336-distributed-actor-isolation.md) 和 [SE-0344 Distributed Actor Runtime](https://github.com/apple/swift-evolution/blob/main/proposals/0344-distributed-actor-runtime.md) 是两个 Distributed Actors 的相关提案。

Apple 提供了一个参考的服务端 cluster actor 系统实现示例，[cluster actor system implementation](https://github.com/apple/swift-distributed-actors) 。

