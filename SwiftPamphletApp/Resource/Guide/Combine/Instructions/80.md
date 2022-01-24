使用 removeDuplicates，重复的值就不会发送了。

```swift
import Combine

var cc = Set<AnyCancellable>()

let pb = ["one","two","three","three","four"]
    .publisher

let sb = pb
    .print("sb")
    .removeDuplicates()
    .sink {
        print($0)
    }
    
sb.store(in: &cc)
```

输出
```
sb: receive subscription: (["one", "two", "three", "three", "four"])
sb: request unlimited
sb: receive value: (one)
one
sb: receive value: (two)
two
sb: receive value: (three)
three
sb: receive value: (three)
sb: request max: (1) (synchronous)
sb: receive value: (four)
four
sb: receive finished
```
