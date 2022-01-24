Scheduler 处理队列。

```swift
import Combine

var cc = Set<AnyCancellable>()
        
let sb1 = ["one","two","three"].publisher
    .print("sb1")
    .subscribe(on: DispatchQueue.global())
    .handleEvents(receiveOutput: {
        print("receiveOutput",$0)
    })
    .receive(on: DispatchQueue.main)
    .sink {
        print($0)
    }
sb1.store(in: &cc)
```

输出
```
sb1: receive subscription: ([1, 2, 3])
sb1: request unlimited
sb1: receive value: (1)
receiveOutput 1
sb1: receive value: (2)
receiveOutput 2
sb1: receive value: (3)
receiveOutput 3
sb1: receive finished
1
2
3
```
