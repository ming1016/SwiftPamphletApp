Just 是发布者，发布的数据在初始化时完成

```swift
import Combine
var cc = Set<AnyCancellable>()
struct S {
    let p1: String
    let p2: String
}

let pb = Just(S(p1: "1", p2: "one"))
pb
    .print("pb")
    .sink {
        print($0)
    }
    .store(in: &cc)
```

输出
```
pb: receive subscription: (Just)
pb: request unlimited
pb: receive value: (S(p1: "1", p2: "one"))
S(p1: "1", p2: "one")
pb: receive finished
```
