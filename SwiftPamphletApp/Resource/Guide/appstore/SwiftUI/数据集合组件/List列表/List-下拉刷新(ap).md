
你可以使用 `.refreshable()` 修饰符来添加下拉刷新功能。以下是一个例子：

```swift
struct ContentView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
        }
        .refreshable {
            await refresh()
        }
    }

    func refresh() async {
        // 这里是你的刷新逻辑
        // 例如，你可以从网络获取新的数据，然后更新 items 数组
        // 这里我们只是简单地将 items 数组反转
        items.reverse()
    }
}
```

在这个例子中，我们创建了一个包含五个元素的 List，并添加了下拉刷新功能。当用户下拉 List 时，`refresh()` 方法会被调用，然后我们将 items 数组反转，从而模拟刷新操作。注意，`refresh()` 方法需要是一个异步方法，因为刷新操作通常需要一些时间来完成。
