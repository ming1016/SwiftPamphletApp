闭包也可以叫做 lambda，是匿名函数，对应 OC 的 block。

```swift
let a1 = [1,3,2].sorted(by: { (l: Int, r: Int) -> Bool in
    return l < r
})
// 如果闭包是唯一的参数并在表达式最后可以使用结尾闭包语法，写法简化为
let a2 = [1,3,2].sorted { (l: Int, r: Int) -> Bool in
    return l < r
}
// 已知类型可以省略
let a3 = [1,3,2].sorted { l, r in
    return l < r
}
// 通过位置来使用闭包的参数，最后简化如下：
let a4 = [1,3,2].sorted { $0 < $1 }
```

函数也是闭包的一种，函数的参数也可以是闭包。@escaping 表示逃逸闭包，逃逸闭包是可以在函数返回之后继续调用的。@autoclosure 表示自动闭包，可以用来省略花括号。

[SE-0326](https://github.com/apple/swift-evolution/blob/main/proposals/0326-extending-multi-statement-closure-inference.md) 提高了 Swift 对闭包使用参数和类型推断的能力。如下代码：

```swift
let a = [1,2,3]
let r = a.map { i in
    if i >= 2 {
        return "\(i) 大于等于2"
    } else {
        return "\(i) 小于2"
    }
}
print(r)
```
