```swift
// 版本
@available(iOS 15, *)
func f() {

}

// 版本检查
if #available(iOS 15, macOS 12, *) {
    f()
} else {
    // nothing happen
}
```
