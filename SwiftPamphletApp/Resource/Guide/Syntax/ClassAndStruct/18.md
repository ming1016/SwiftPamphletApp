结构体是值类型，可以定义属性、方法、构造器、下标操作。结构体使用扩展来扩展功能，遵循协议。

```swift
struct S {
    var p1: String = ""
    var p2: Int
}

extension S {
    func f() -> String {
        return p1 + String(p2)
    }
}

var s = S(p2: 1)
s.p1 = "1"
print(s.f()) // 11
```
