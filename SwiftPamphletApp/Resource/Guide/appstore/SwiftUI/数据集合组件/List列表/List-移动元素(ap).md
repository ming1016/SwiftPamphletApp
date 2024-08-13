
你可以使用 `.onMove(perform:)` 修饰符来允许用户移动 List 中的元素。以下是一个例子：

```swift
struct ContentView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onMove(perform: move)
            }
            .toolbar {
                EditButton()
            }
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}
```

在这个例子中，我们创建了一个包含五个元素的 List。我们使用 `.onMove(perform:)` 修饰符来允许用户移动这些元素，并提供了一个 `move(from:to:)` 方法来处理移动操作。我们还添加了一个 `EditButton`，用户可以点击它来进入编辑模式，然后就可以移动元素了。

