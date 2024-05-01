Swift 允许全局编写 Swift 代码，实际上 clang 会自动将代码包进一个模拟 C 的函数中。Swift 也能够指定入口点，比如 @UIApplicationMain 或 @NSApplicationMain，UIKit 启动后生命周期管理是 AppDelegate 和 SceneDelegate，《 [Understanding the iOS 13 Scene Delegate](https://www.donnywals.com/understanding-the-ios-13-scene-delegate/) 》这篇有详细介绍。

@UIApplicationMain 和 @NSApplicationMain 会自动生成入口点。这些入口点都是平台相关的，Swift 发展来看是多平台的，这样在 Swift 5.3 时引入了 @main，可以方便的指定入口点。代码如下：
```swift
@main // 要定义个静态的 main 函数
struct M {
  static func main() {
    print("let's begin")
  }
}
```

 [ArgumentParser](https://github.com/apple/swift-argument-parser)  库，Swift 官方开源的一个开发命令行工具的库，也支持 @main。使用方法如下：
```swift
import ArgumentParser

@main
struct C: ParsableCommand {
  @Argument(help: "Start")
  var phrase: String
   
  func run() throws {
    for _ in 1...5 {
      print(phrase)
    }
  }
}
```
