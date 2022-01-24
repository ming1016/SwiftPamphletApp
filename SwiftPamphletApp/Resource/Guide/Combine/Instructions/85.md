zip 会合并多个发布者发布的数据，只有当多个发布者都发布了数据后才会组合成一个数据给订阅者。

```swift
import Combine

var cc = Set<AnyCancellable>()

let ps1 = PassthroughSubject<String, Never>()
let ps2 = PassthroughSubject<String, Never>()
let ps3 = PassthroughSubject<String, Never>()

let sb1 = ps1.zip(ps2, ps3)
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

sb1.store(in: &cc)
```

输出
```
sb1: receive subscription: (Zip)
sb1: request unlimited
sb1: receive value: (("one", "1", "一"))
("one", "1", "一")
sb1: receive cancel
```
