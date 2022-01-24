根据指定条件返回

```swift
let a1 = ["a", "b", "c", "call my name"]
let a2 = a1.filter {
    $0.prefix(1) == "c"
}
print(a2) // ["c", "call my name"]
```
