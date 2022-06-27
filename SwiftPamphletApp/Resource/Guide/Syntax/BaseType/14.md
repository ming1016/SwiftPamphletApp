泛型可以减少重复代码，是一种抽象的表达方式。where 关键字可以对泛型做约束。

```swift
func fn<T>(p: T) -> [T] {
    var r = [T]()
    r.append(p)
    return r
}
print(fn(p: "one"))

// 结构体
struct S1<T> {
    var arr = [T]()
    mutating func add(_ p: T) {
        arr.append(p)
    }
}

var s1 = S1(arr: ["zero"])
s1.add("one")
s1.add("two")
print(s1.arr) // ["zero", "one", "two"]
```

关联类型

```swift
protocol pc {
    associatedtype T
    mutating func add(_ p: T)
}

struct S2: pc {
    typealias T = String // 类型推导，可省略
    var strs = [String]()
    mutating func add(_ p: String) {
        strs.append(p)
    }
}
```

泛型适用于嵌套类型
```swift
struct S3<T> {
    struct S4 {
        var p: T
    }
    
    var p1: T
    var p2: S4
}

let s2 = S3(p1: 1, p2: S3.S4(p: 3))
let s3 = S3(p1: "one", p2: S3.S4(p: "three"))
print(s2,s3)
```

session [Embrace Swift generics](https://developer.apple.com/videos/play/wwdc2022/110352/) 、[Design protocol interfaces in Swift](https://developer.apple.com/videos/play/wwdc2022-110353)

swift 5.6 和之前编写泛型接口如下：
```swift
func feed<A>(_ animal: A) where A: Animal

// 👆🏻👇🏻 Equivalents

func feed<A: Animal>(_ animal: A)
```

swift 5.7 可以这样写：
```swift
func feed(_ animal: some Animal)
```

some 关键字可以用于参数和结构类型。some 会保证类型关系，而 any 会持有任意具体类型，删除类型关系。

[SE-0347 Type inference from default expressions](https://github.com/apple/swift-evolution/blob/main/proposals/0347-type-inference-from-default-exprs.md) 扩展 Swift 泛型参数类型的默认值能力。如下代码示例：
```swift
func suffledArray<T: Sequence>(from options: T = 1...100) -> [T.Element] {
    Array(options.shuffled())
}

print(suffledArray())
print(suffledArray(from: ["one", "two", "three"]))
```

[SE-0341 Opaque Parameter Declarations](https://github.com/apple/swift-evolution/blob/main/proposals/0341-opaque-parameters.md) 使用 some 参数简化泛型参数声明。[SE-0328 Structural opaque result types](https://github.com/apple/swift-evolution/blob/main/proposals/0328-structural-opaque-result-types.md) 扩大不透明结果返回类型可以使用的范围。[SE-0360 Opaque result types with limited availability](https://github.com/apple/swift-evolution/blob/main/proposals/0360-opaque-result-types-with-availability.md) 可用性有限的不透明结果类型，比如 `if #available(macOS 13.0, *) {}` 就可以根据系统不同版本返回不同类型，新版本出现新类型的 View 就可以和以前的 View 类型区别开。

[SE-0309 Unlock existentials for all protocols](https://github.com/apple/swift-evolution/blob/main/proposals/0309-unlock-existential-types-for-all-protocols.md) 改进了 existentials 和 泛型的交互。这样就可以更方便的检查 Any 类型的两个值是否相等

any 关键字充当的是类型擦除的助手，是通过告知编译器你使用 existential 作为类型，此语法可兼容以前系统。

[SE-0346 Lightweight same-type requirements for primary associated types](https://github.com/apple/swift-evolution/blob/main/proposals/0346-light-weight-same-type-syntax.md) 引入一种新语法，用于符合泛型参数并通过相同类型要求约束关联类型。[SE-0358 Primary Associated Types in the Standard Library](https://github.com/apple/swift-evolution/blob/main/proposals/0358-primary-associated-types-in-stdlib.md) 引入主要关联类型概念，并将其带入了标准库。这些关联类型很像泛型，允许开发者将给定关联类型的类型指定为通用约束。

[SE-0353 Constrained Existential Types](https://github.com/apple/swift-evolution/blob/main/proposals/0353-constrained-existential-types.md) 基于 SE-0309 和 SE-0346 提案，在 existential 类型的上下文中重用轻量关联类型的约束。

[SE-0352 Implicitly Opened Existentials](https://github.com/apple/swift-evolution/blob/main/proposals/0352-implicit-open-existentials.md)  允许 Swift 在很多情况下使用协议调用泛型函数。

Swift 论坛上一个对 any 和 some 关键字语法使用场景的讨论，[Do `any` and `some` help with “Protocol Oriented Testing” at all?](https://forums.swift.org/t/do-any-and-some-help-with-protocol-oriented-testing-at-all/58113) 。
