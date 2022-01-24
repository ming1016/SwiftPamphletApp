```swift
import Combine

var cc = Set<AnyCancellable>()
struct S {
    let p1: String
    let p2: String
}

let ept = Empty<S, Never>() // 加上 completeImmediately: false 后面即使用 replaceEmpty 也不会接受值
ept
    .print("ept")
    .sink { c in
        print("completion:", c)
    } receiveValue: { s in
        print("receive:", s)
    }
    .store(in: &cc)

ept.replaceEmpty(with: S(p1: "1", p2: "one"))
    .sink { c in
        print("completion:", c)
    } receiveValue: { s in
        print("receive:", s)
    }
    .store(in: &cc)
```

输出
```
ept: receive subscription: (Empty)
ept: request unlimited
ept: receive finished
completion: finished
receive: S(p1: "1", p2: "one")
completion: finished
```
