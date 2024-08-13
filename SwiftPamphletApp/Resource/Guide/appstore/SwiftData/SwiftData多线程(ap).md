
创建一个 Actor，然后 SwiftData 上下文在其中执行操作。

```swift
@ModelActor
actor DataHandler {}

extension DataHandler {
    func addInfo() throws -> IOInfo {
        let info = IOInfo()
        modelContext.insert(info)
        try modelContext.save()
        return info
    }
    ...
}
```

使用

```swift
Task.detached {
    let handler = DataHandler()
    let item = try await handler.addInfo()   
    ...
}
```
