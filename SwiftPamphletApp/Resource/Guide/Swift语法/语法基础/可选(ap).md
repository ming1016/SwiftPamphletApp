可能会是 nil 的变量就是可选变量。当变量为 nil 通过??操作符可以提供一个默认值。

```swift
var o: Int? = nil
let i = o ?? 0
```

[SE-0345 if let shorthand for shadowing an existing optional variable](https://github.com/apple/swift-evolution/blob/main/proposals/0345-if-let-shorthand.md) 引入的新语法，用于 unwrapping optinal。
```swift
let s1: String? = "hey"
let s2: String? = "u"
if let s1 {
    print(s1)
}

guard let s1, let s2 else { return }
print(s1 + " " + s2)
```
