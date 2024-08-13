prepend 会在发布者发布前先发送数据，发布者不结束也不会受影响。发布者和集合也可以被打平发布。

```swift
import Combine

var cc = Set<AnyCancellable>()

let pb1 = PassthroughSubject<String, Never>()
let pb2 = ["nine", "ten"].publisher

let sb = pb1
    .print("sb")
    .prepend(pb2)
    .prepend(["seven","eight"])
    .prepend("five", "six")
    .sink {
        print($0)
    }

sb.store(in: &cc)

pb1.send("one")
pb1.send("two")
pb1.send("three")
```

输出
```
five
six
seven
eight
nine
ten
sb: receive subscription: (PassthroughSubject)
sb: request unlimited
sb: receive value: (one)
one
sb: receive value: (two)
two
sb: receive value: (three)
three
sb: receive cancel
```
