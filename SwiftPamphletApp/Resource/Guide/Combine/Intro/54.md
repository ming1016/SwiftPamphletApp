WWDC 2019苹果推出Combine，Combine是一种响应式编程范式，采用声明式的Swift API。

Combine 写代码的思路是你写代码不同于以往命令式的描述如何处理数据，Combine 是要去描述好数据会经过哪些逻辑运算处理。这样代码更好维护，可以有效的减少嵌套闭包以及分散的回调等使得代码维护麻烦的苦恼。

声明式和过程时区别可见如下代码：
```swift
// 所有数相加
// 命令式思维
func sum1(arr: [Int]) -> Int {
  var sum: Int = 0
  for v in arr {
    sum += v
  }
  return sum
}

// 声明式思维
func sum2(arr: [Int]) -> Int {
  return arr.reduce(0, +)
}
```


Combine 主要用来处理异步的事件和值。苹果 UI 框架都是在主线程上进行 UI 更新，Combine 通过 Publisher 的 receive 设置回主线程更新UI会非常的简单。

已有的 RxSwift 和 ReactiveSwift 框架和 Combine 的思路和用法类似。

Combine 的三个核心概念
- 发布者
- 订阅者
- 操作符

简单举个发布数据和类属性绑定的例子：

```swift
let pA = Just(0)
let _ = pA.sink { v in
    print("pA is: \(v)")
}

let pB = [7,90,16,11].publisher
let _ = pB
    .sink { v in
        print("pB: \(v)")
    }

class AClass {
    var p: Int = 0 {
        didSet {
            print("property update to \(p)")
        }
    }
}
let o = AClass()
let _ = pB.assign(to: \.p, on: o)
```
