```swift
struct H: Hashable {
    var p1: String
    var p2: Int
    
    // 提供随机 seed
    func hash(into hasher: inout Hasher) {
        hasher.combine(p1)
    }
}

let h1 = H(p1: "one", p2: 1)
let h2 = H(p1: "two", p2: 2)

var hs1 = Hasher()
hs1.combine(h1)
hs1.combine(h2)
print(h1.hashValue) // 7417088153212460033 随机值
print(h2.hashValue) // -6972912482785541972 随机值
print(hs1.finalize()) // 7955861102637572758 随机值
print(h1.hashValue) // 7417088153212460033 和前面 h1 一样

let h3 = H(p1: "one", p2: 1)
print(h3.hashValue) // 7417088153212460033 和前面 h1 一样
var hs2 = Hasher()
hs2.combine(h3)
hs2.combine(h2)
print(hs2.finalize()) // 7955861102637572758 和前面 hs1 一样
```

应用生命周期内，调用 combine() 添加相同属性哈希值相同，由于 Hasher 每次都会使用随机的 seed，因此不同应用生命周期，也就是下次启动的哈希值，就会和上次的哈希值不同。
