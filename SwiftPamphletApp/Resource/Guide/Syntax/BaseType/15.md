不透明类型会隐藏类型，让使用者更关注功能。不透明类型和协议很类似，不同的是不透明比协议限定的要多，协议能够对应更多类型。

```swift
protocol P {
    func f() -> String
}
struct S1: P {
    func f() -> String {
        return "one\n"
    }
}
struct S2<T: P>: P {
    var p: T
    func f() -> String {
        return p.f() + "two\n"
    }
}
struct S3<T1: P, T2: P>: P {
    var p1: T1
    var p2: T2
    func f() -> String {
        return p1.f() + p2.f() + "three\n"
    }
}
func someP() -> some P {
    return S3(p1: S1(), p2: S2(p: S1()))
}

let r = someP()
print(r.f())
```

函数调用者决定返回什么类型是泛型，函数自身决定返回什么类型使用不透明返回类型。