CurrentValueSubject 的订阅者可以收到订阅时已发出的那条数据

```swift
import Combine

var cc = Set<AnyCancellable>()

let cs = CurrentValueSubject<String, Never>("one")
cs.send("two")
cs.send("three")
let sb1 = cs
    .print("cs sb1")
    .sink {
        print($0)
    }
    
cs.send("four")
cs.send("five")

let sb2 = cs
    .print("cs sb2")
    .sink {
        print($0)
    }

cs.send("six")

sb1.store(in: &cc)
sb2.store(in: &cc)
```

输出
```
cs sb1: receive subscription: (CurrentValueSubject)
cs sb1: request unlimited
cs sb1: receive value: (three)
three
cs sb1: receive value: (four)
four
cs sb1: receive value: (five)
five
cs sb2: receive subscription: (CurrentValueSubject)
cs sb2: request unlimited
cs sb2: receive value: (five)
five
cs sb1: receive value: (six)
six
cs sb2: receive value: (six)
six
cs sb1: receive cancel
cs sb2: receive cancel
```
