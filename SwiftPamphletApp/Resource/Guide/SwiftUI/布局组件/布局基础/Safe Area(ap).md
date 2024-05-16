
使用 `.ignoresSafeArea()` 可以忽略安全区域。默认是所有方向都忽略。

如果只忽略部分方向，可以按照下面方法做：

```swift
// 默认会同时包含 .keyboard 和 .container。
.ignoresSafeArea(edges: .top)
.ignoresSafeArea(edges: .vertical)
.ignoresSafeArea(edges: [.leading, .trailing])

// 可以对安全区域分别指定
.ignoresSafeArea(.keyboard, edges: .top)
.ignoresSafeArea(.container, edges: [.leading, .trailing])
```

