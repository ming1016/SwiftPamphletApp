reduce 可以将迭代中返回的结果用于下个迭代中，并，还能让你设个初始值。

```swift
let a1 = ["a", "b", "c", "call my name.", "get it?"]
let a2 = a1.reduce("Hey u,", { partialResult, s in
    // partialResult 是前面返回的值，s 是遍历到当前的值
    partialResult + " \(s)"
})

print(a2) // Hey u, a b c call my name. get it?
```
