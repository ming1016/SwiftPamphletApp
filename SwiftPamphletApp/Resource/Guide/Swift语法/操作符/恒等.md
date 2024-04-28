恒等返回是否引用了相同实例。

```swift
class C {
    var p: String
    init(p: String) {
        self.p = p
    }
}

let c1 = C(p: "one")
let c2 = C(p: "one")
let c3 = c1

print(c1 === c2) // false
print(c1 === c3) // true
print(c1 !== c2) // true
```
