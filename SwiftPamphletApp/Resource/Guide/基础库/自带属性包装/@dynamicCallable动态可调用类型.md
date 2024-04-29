结果生成器（Result builders），通过传递序列创建新值，SwiftUI就是使用的结果生成器将多个视图生成一个视图

```swift
@resultBuilder
struct RBS {
    // 基本闭包支持
    static func buildBlock(_ components: Int...) -> Int {
        components.reduce(0) { partialResult, i in
            partialResult + i
        }
    }
    // 支持条件判断
    static func buildEither(first component: Int) -> Int {
        component
    }
    static func buildEither(second component: Int) -> Int {
        component
    }
    // 支持循环
    static func buildArray(_ components: [Int]) -> Int {
        components.reduce(0) { partialResult, i in
            partialResult + i
        }
    }
}

let a = RBS.buildBlock(
    1,
    2,
    3
)
print(a) // 6

// 应用到函数中
@RBS func f1() -> Int {
    1
    2
    3
}
print(f1()) // 6

// 设置了 buildEither 就可以在闭包中进行条件判断。
@RBS func f2(stopAtThree: Bool) -> Int {
    1
    2
    3
    if stopAtThree == true {
        0
    } else {
        4
        5
        6
    }
}
print(f2(stopAtThree: false)) // 21

// 设置了 buildArray 就可以在闭包内使用循环了
@RBS func f3() -> Int {
    for i in 1...3 {
        i * 2
    }
}
print(f3()) // 12
```

[SE-0348 buildPartialBlock for result builders](https://github.com/apple/swift-evolution/blob/main/proposals/0348-buildpartialblock.md)  简化了实现复杂 result buiders 所需的重载。
