```swift
struct S {
    static let shared = S()
    private init() {
        // 防止实例初始化
    }
}
```
