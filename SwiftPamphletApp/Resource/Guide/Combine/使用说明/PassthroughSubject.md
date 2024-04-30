PassthroughSubject 可以传递多值，订阅者可以是一个也可以是多个，send 指明 completion 后，订阅者就没法接收到新发送的值了。

```swift
import Combine

var cc = Set<AnyCancellable>()
struct S {
    let p1: String
    let p2: String
}

enum CError: Error {
    case aE, bE
}
let ps1 = PassthroughSubject<S, CError>()
ps1
    .print("ps1")
    .sink { c in
        print("completion:", c) // send 了 .finished 后会执行
    } receiveValue: { s in
        print("receive:", s)
        
    }
    .store(in: &cc)

ps1.send(S(p1: "1", p2: "one"))
ps1.send(completion: .failure(CError.aE)) // 和 .finished 一样后面就不会发送了
ps1.send(S(p1: "2", p2: "two"))
ps1.send(completion: .finished)
ps1.send(S(p1: "3", p2: "three"))

// 多个订阅者
let ps2 = PassthroughSubject<String, Never>()
ps2.send("one") // 订阅之前 send 的数据没有订阅者可以接收
ps2.send("two")

let sb1 = ps2
    .print("ps2 sb1")
    .sink { s in
    print(s)
    }

ps2.send("three") // 这个 send 的值会被 sb1

let sb2 = ps2
    .print("ps2 sb2")
    .sink { s in
        print(s)
    }

ps2.send("four") // 这个 send 的值会被 sb1 和 sb2 接受

sb1.store(in: &cc)
sb2.store(in: &cc)
ps2.send(completion: .finished)

```

输出
```
ps1: receive subscription: (PassthroughSubject)
ps1: request unlimited
ps1: receive value: (S(p1: "1", p2: "one"))
receive: S(p1: "1", p2: "one")
ps1: receive error: (aE)
completion: failure(戴铭的开发小册子.AppDelegate.(unknown context at $10b15ce10).(unknown context at $10b15cf3c).CError.aE)
ps2 sb1: receive subscription: (PassthroughSubject)
ps2 sb1: request unlimited
ps2 sb1: receive value: (three)
three
ps2 sb2: receive subscription: (PassthroughSubject)
ps2 sb2: request unlimited
ps2 sb1: receive value: (four)
four
ps2 sb2: receive value: (four)
four
ps2 sb1: receive finished
ps2 sb2: receive finished
```
