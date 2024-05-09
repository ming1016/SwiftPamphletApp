
SwiftData 模型上下文有个方法叫 `enumerate()`，可以高效遍历大量数据。

```swift
let descriptor = FetchDescriptor<Article>()
...

do {
    try modelContext.enumerate(descriptor, batchSize: 1000) { article in
        ...
    }
} catch {
    print("Failed.")
}
```

其中 batchSize 参数是调整批量处理的数量，也就是一次加载多少对象。因此可以通过这个值来权衡内存和IO数量。这个值默认是 5000。
