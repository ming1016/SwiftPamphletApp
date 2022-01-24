遵循 Equatable 协议可以使用 == 和 != 来判断是否相等

```swift
print(1 > 2) // false

struct S: Equatable {
    var p1: String
    var p2: Int
}
let s1 = S(p1: "one", p2: 1)
let s2 = S(p1: "two", p2: 2)
let s3 = S(p1: "one", p2: 2)
let s4 = S(p1: "one", p2: 1)

print(s1 == s2) // false
print(s1 == s3) // false
print(s1 == s4) // true
```

类需要实现 == 函数

```swift
class C: Equatable {
    var p1: String
    var p2: Int
    init(p1: String, p2: Int) {
        self.p1 = p1
        self.p2 = p2
    }
    
    static func == (l: C, r: C) -> Bool {
        return l.p1 == r.p1 && l.p2 == r.p2
    }
}

let c1 = C(p1: "one", p2: 1)
let c2 = C(p1: "one", p2: 1)
print(c1 == c2)
```

```swift
// 元组比较
// 会先比较第一个数，第一个无法比较才会比较第二个数
// 字符串比较和字母大小还有长度有关。先比较字母大小，在比较长度
("apple", 1) < ("apple", 2) // true
("applf", 1) < ("apple", 2) // false
("appl", 2) < ("apple", 1) // true
("appm", 2) < ("apple", 1) // false
```
