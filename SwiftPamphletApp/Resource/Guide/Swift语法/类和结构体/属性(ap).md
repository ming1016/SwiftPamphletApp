类、结构体或枚举里的变量常量就是他们的属性。

```swift
struct S {
    static let sp = "类型属性" // 类型属性通过类型本身访问，非实例访问
    var p1: String = ""
    var p2: Int = 1
    // cp 是计算属性
    var cp: Int {
        get {
            return p2 * 2
        }
        set {
            p2 = newValue + 2
        }
    }
    // 只有 getter 的是只读计算属性
    var rcp: Int {
        p2 * 4
    }
}
print(S.sp)
print(S().cp) // 2
var s = S()
s.cp = 3
print(s.p2) // 5
print(S().rcp) // 4
```

willSet 和 didSet 是属性观察器，可以在属性值设置前后插入自己的逻辑处理。

键路径表达式作为函数

```swift
struct S2 {
    let p1: String
    let p2: Int
}

let s2 = S2(p1: "one", p2: 1)
let s3 = S2(p1: "two", p2: 2)
let a1 = [s2, s3]
let a2 = a1.map(\.p1)
print(a2) // ["one", "two"]
```