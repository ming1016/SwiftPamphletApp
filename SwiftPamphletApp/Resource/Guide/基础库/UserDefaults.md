使用方法如下：

```swift
enum UDKey {
    static let k1 = "token"
}
let ud = UserDefaults.standard
ud.set("xxxxxx", forKey: UDKey.k1)
let tk = ud.string(forKey: UDKey.k1)
print(tk ?? "")
```
