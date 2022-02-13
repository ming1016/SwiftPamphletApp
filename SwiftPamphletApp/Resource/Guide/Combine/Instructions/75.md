publisher 是发布者，sink 是订阅者

```swift
import Combine

var cc = Set<AnyCancellable>()
struct S {
    let p1: String
    let p2: String
}
[S(p1: "1", p2: "one"), S(p1: "2", p2: "two")]
    .publisher
    .print("array")
    .sink {
        print($0)
    }
    .store(in: &cc)
```

 输出
 ```
 array: receive subscription: ([戴铭的开发小册子.AppDelegate.(unknown context at $10ac82d20).(unknown context at $10ac82da4).S(p1: "1", p2: "one"), 戴铭的开发小册子.AppDelegate.(unknown context at $10ac82d20).(unknown context at $10ac82da4).S(p1: "2", p2: "two")])
array: request unlimited
array: receive value: (S(p1: "1", p2: "one"))
S(p1: "1", p2: "one")
array: receive value: (S(p1: "2", p2: "two"))
S(p1: "2", p2: "two")
array: receive finished
 ```
