session [Eliminate data races using Swift Concurrency](https://developer.apple.com/videos/play/wwdc2022-110351) 、[Visualize and optimize Swift concurrency](https://developer.apple.com/videos/play/wwdc2022-110350) 、[Meet Swift Async Algorithms](https://developer.apple.com/videos/play/wwdc2022-110355) 。

表示持续时间有了新的放来来表达，对应提案是 [SE-0329 Clock, Instant, and Duration](https://github.com/apple/swift-evolution/blob/main/proposals/0329-clock-instant-duration.md) ，continuous clock 是在系统睡眠状态还会增加时间，suspending clock 在系统睡眠状态不会增加时间。Instants 表示一个确定的时间。Duration 表示两个时间经历了多久。

新增 [SE-0338 Clarify the Execution of Non-Actor-Isolated Async Functions](https://github.com/apple/swift-evolution/blob/main/proposals/0338-clarify-execution-non-actor-async.md) 通过收紧可发送性检查的规则来避免潜在的数据竞争。

[SE-0343 Concurrency in Top-level Code](https://github.com/apple/swift-evolution/blob/main/proposals/0343-top-level-concurrency.md) 这个提案主要是更好地支持命令行工具的开发，可以直接将 concurrency 代码写到 main.swift 文件里。

[SE-0340 Unavailable From Async Attribute](https://github.com/apple/swift-evolution/blob/main/proposals/0340-swift-noasync.md) 提供 noasync 语法以允许我们将类型和函数标记为在异步上下文不可用。

Task 是按顺序执行的，是异步的，在 await 时可以暂停任意次数。task 是自包含的，有自己的资源，可以独立于任何其他 task 独立运行。task 通过在 body 末尾返回一个值来传递对象，值类型没问题，如果是引用类型有可能出现数据竞争。

通过 Sendable 协议 Swift 可以帮助告诉我们什么时候 task 之间共享数据是安全的。Sendable 描述的类型可以跨隔离 domain，不会有数据竞争，Swift 编译器会在构建时检查数据竞争。task 的返回类型要符合 Sendable。

引用类型只能在很少的情况下符合 Sendable。比如 final class 只有不可变的存储。对于自己内部同步的引用类型，比如锁，可以用 `@unchecked Sendable` 。
```swift
class ConcurrentCache<Key: Hashable & Sendable, Value: Sendable>: @unchecked Sendable {
  var lock: NSLock
  var storage: [Key: Value]

  // ...
}
```

Actor 提供了一种隔离状态的方法可以消除数据竞争。使用 task 来执行 actor 定义的代码。一次只能在一个 actor 上执行一个 task。actor 也是依赖 Sendable。actor 是引用类型，但隔离了他们所有属性和代码来防止并发访问。`@MainActor` 表示的是主线程，你要在应用中更新 UI 时来用它。
```swift
@MainActor func updateView() { … }

Task { @MainActor in
  // update UI here
}
```

`@MainActor` 也可以用于类，类的属性和方法只能在主 main actor 上访问，除非标记为 `nonisolated` 。
```swift
@MainActor
class ChickenValley: Sendable {
  var flock: [Chicken]
  var food: [Pineapple]

  func advanceTime() {
    for chicken in flock {
      chicken.eat(from: &food)
    }
  }
}
```


