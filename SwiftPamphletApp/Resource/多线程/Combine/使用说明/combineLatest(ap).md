combineLatest 会合并多个发布者发布的数据，只有当多个发布者都发布了数据后才会触发合并，合并每个发布者发布的最后一个数据。

```swift
import Combine

var cc = Set<AnyCancellable>()
        
let ps1 = PassthroughSubject<String, Never>()
let ps2 = PassthroughSubject<String, Never>()
let ps3 = PassthroughSubject<String, Never>()

let sb1 = ps1.combineLatest(ps2, ps3)
    .print("sb1")
    .sink {
        print($0)
    }
    
ps1.send("one")
ps1.send("two")
ps1.send("three")
ps2.send("1")
ps2.send("2")
ps1.send("four")
ps2.send("3")
ps3.send("一")
ps3.send("二")

sb1.store(in: &cc)
```

输出
```
sb1: receive subscription: (CombineLatest)
sb1: request unlimited
sb1: receive value: (("four", "3", "一"))
("four", "3", "一")
sb1: receive value: (("four", "3", "二"))
("four", "3", "二")
sb1: receive cancel
```
