订阅者可以通过 merge 合并多个发布者发布的数据

```swift
import Combine

var cc = Set<AnyCancellable>()

let ps1 = PassthroughSubject<String, Never>()
let ps2 = PassthroughSubject<String, Never>()

let sb1 = ps1.merge(with: ps2)
    .sink {
        print($0)
    }
    
ps1.send("one")
ps1.send("two")
ps2.send("1")
ps2.send("2")
ps1.send("three")

sb1.store(in: &cc)
```

输出
```
sb1: receive subscription: (Merge)
sb1: request unlimited
sb1: receive value: (one)
one
sb1: receive value: (two)
two
sb1: receive value: (1)
1
sb1: receive value: (2)
2
sb1: receive value: (three)
three
sb1: receive cancel
```
