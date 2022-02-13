append 会在发布者发布结束后追加发送数据，发布者不结束，append 的数据不会发送。

```swift
import Combine

var cc = Set<AnyCancellable>()

let pb = PassthroughSubject<String, Never>()

let sb = pb
    .print("sb")
    .append("five", "six")
    .sink {
        print($0)
    }

sb.store(in: &cc)

pb.send("one")
pb.send("two")
pb.send("three")
pb.send(completion: .finished)
```

输出
```
sb: receive subscription: ([戴铭的开发小册子.AppDelegate.(unknown context at $101167070).(unknown context at $1011670f4).S(p: AnyPublisher), 戴铭的开发小册子.AppDelegate.(unknown context at $101167070).(unknown context at $1011670f4).S(p: AnyPublisher), 戴铭的开发小册子.AppDelegate.(unknown context at $101167070).(unknown context at $1011670f4).S(p: AnyPublisher)])
sb: request unlimited
sb: receive value: (S(p: AnyPublisher))
one
sb: receive value: (S(p: AnyPublisher))
two
sb: receive value: (S(p: AnyPublisher))
three
sb: receive finished
```
