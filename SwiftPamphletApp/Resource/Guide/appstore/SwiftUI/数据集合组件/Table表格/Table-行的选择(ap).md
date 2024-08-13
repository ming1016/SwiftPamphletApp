
你可以使用 Table 视图的 selection 参数来实现单选和多选。selection 参数接受一个绑定到一个可选的 Set 的变量，这个 Set 包含了被选中的元素的标识。

以下是一个使用 Table 视图实现单选和多选的例子：

```swift
struct ContentView: View {
    @State private var selectionOne: UUID? // 单选
    @State private var selection: Set<UUID> = [] // 多选

    let data = [
        Fruit(name: "Apple", color: "Red"),
        Fruit(name: "Banana", color: "Yellow"),
        Fruit(name: "Cherry", color: "Red"),
        Fruit(name: "Date", color: "Brown"),
        Fruit(name: "Elderberry", color: "Purple")
    ]

    var body: some View {
        Table(data, selection: $selectionOne) {
            TableColumn("Fruit") { item in
                Text(item.name)
            }
            TableColumn("Color") { item in
                Text(item.color)
            }
        }
    }
}

struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let color: String
}
```

在这个例子中，我们首先定义了一个 @State 变量 selection，它是一个 Set，包含了被选中的元素的标识。然后，我们将这个变量绑定到 Table 视图的 selection 参数。

现在，当用户选择或取消选择一个元素时，selection 变量就会被更新。你可以使用这个变量来判断哪些元素被选中，或者实现其他的交互功能。

