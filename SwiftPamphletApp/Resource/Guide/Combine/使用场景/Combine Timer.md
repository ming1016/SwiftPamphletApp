使用方式如下：
```swift
let timePb = Timer.publish(every: 1.0, on: RunLoop.main, in: .default)
let timeSk = timePb.sink { r in
    print("r is \(r)")
}
let cPb = timePb.connect()
```
