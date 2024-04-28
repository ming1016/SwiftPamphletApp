类能继承另一个类，继承它的方法、属性等。

```swift
// 类继承
class C1 {
    var p1: String
    var cp1: String {
        get {
            return p1 + " like ATM"
        }
        set {
            p1 = p1 + newValue
        }
    }
    init(p1: String) {
        self.p1 = p1
    }
    func sayHi() {
        print("Hi! \(p1)")
    }
}

class C2: C1 {
    var p2: String
    init(p2: String) {
        self.p2 = p2
        super.init(p1: p2 + "'s father")
    }
}

C2(p2: "Lemon").sayHi() // Hi! Lemon's father

// 重写父类方法
class C3: C2 {
    override func sayHi() {
        print("Hi! \(p2)")
    }
}

C3(p2: "Lemon").sayHi() // Hi! Lemon

// 重写计算属性
class C4: C1 {
    override var cp1: String {
        get {
            return p1 + " like Out of the blade"
        }
        set {
            p1 = p1 + newValue
        }
    }
}

print(C1(p1: "Lemon").cp1) // Lemon like ATM
print(C4(p1: "Lemon").cp1) // Lemon like Out of the blade
```

通过 final 关键字可以防止类被继承，final 还可以用于属性和方法。使用 super 关键字指代父类。
