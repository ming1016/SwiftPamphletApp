```swift
enum E: String {
    case one, two, three
    func showRawValue() {
        print(rawValue)
    }
}

let e = E.three
e.showRawValue() // three

// 可变的实例方法，使用 mutating 标记
struct S {
    var p: String
    mutating func addFullStopForP() {
        p += "."
    }
}
var s = S(p: "hi")
s.addFullStopForP()
print(s.p)

// 类方法
class C {
    class func cf() {
        print("类方法")
    }
}
```

static和class关键字修饰的方法类似 OC 的类方法。static 可以修饰存储属性，而 class 不能；class 修饰的方法可以继承，而 static 不能。在协议中需用 static 来修饰。

静态下标方法

```swift
// 静态下标
struct S2 {
    static var sp = [String: Int]()
    
    static subscript(_ s: String, d: Int = 10) -> Int {
        get {
            return sp[s] ?? d
        }
        set {
            sp[s] = newValue
        }
    }
}

S2["key1"] = 1
S2["key2"] = 2
print(S2["key2"]) // 2
print(S2["key3"]) // 10

```

自定义类型中实现了 callAsFunction() 的话，该类型的值就可以直接调用。

```swift
// callAsFunction()
struct S3 {
    var p1: String
    
    func callAsFunction() -> String {
        return "show \(p1)"
    }
}
let s2 = S3(p1: "hi")
print(s2()) // show hi
```