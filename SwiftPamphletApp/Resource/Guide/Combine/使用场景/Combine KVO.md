例子如下：
```swift
private final class KVOObject: NSObject {
  @objc dynamic var intV: Int = 0
  @objc dynamic var boolV: Bool = false
}

let o = KVOObject()
let _ = o.publisher(for: \.intV)
  .sink { v in
    print("value : \(v)")
  }
```
