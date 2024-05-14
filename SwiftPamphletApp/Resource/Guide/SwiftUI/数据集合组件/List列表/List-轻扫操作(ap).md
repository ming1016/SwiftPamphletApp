
你可以使用 `.swipeActions()` 修饰符来添加轻扫操作。以下是一个例子：

```swift
struct ContentView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
                .swipeActions {
                    Button(action: {
                        // 这里是你的删除操作
                        if let index = items.firstIndex(of: item) {
                            items.remove(at: index)
                        }
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        }
    }
}
```

在这个例子中，我们创建了一个包含五个元素的 List，并为每个元素添加了一个滑动操作。当用户向左轻扫一个元素时，会显示一个 "Delete" 按钮，用户可以点击这个按钮来删除该元素。
