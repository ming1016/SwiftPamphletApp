flatMap 能将多个发布者的值打平发送给订阅者

```swift
import Combine

var cc = Set<AnyCancellable>()

struct S {
    let p: AnyPublisher<String, Never>
}

let s1 = S(p: Just("one").eraseToAnyPublisher())
let s2 = S(p: Just("two").eraseToAnyPublisher())
let s3 = S(p: Just("three").eraseToAnyPublisher())

let pb = [s1, s2, s3].publisher
    
let sb = pb
    .print("sb")
    .flatMap {
        $0.p
    }
    .sink {
        print($0)
    }

sb.store(in: &cc)
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
