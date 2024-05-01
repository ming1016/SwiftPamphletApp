```swift
// if
let s = "hi"
if s.isEmpty {
    print("String is Empty")
} else {
    print("String is \(s)")
}

// 三元条件
s.isEmpty ? print("String is Empty again") : print("String is \(s) again")

// if let-else
func f(s: String?) {
    if let s1 = s {
        print("s1 is \(s1)")
    } else {
        print("s1 is nothing")
    }
    // nil-coalescing
    let s2 = s ?? "nothing"
    print("s2 is \(s2)")
}
f(s: "something")
f(s: nil)

// if case let
enum E {
    case c1(String)
    case c2([String])
    
    func des() {
        switch self {
        case .c1(let string):
            print(string)
        case .c2(let array):
            print(array)
        }
    }
}

E.c1("enum c1").des()
E.c2(["one", "two", "three"]).des()
```
