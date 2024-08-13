
你可以使用 `Table` 视图的 `sortOrder` 参数来实现多属性排序。`sortOrder` 参数接受一个绑定到一个 `SortDescriptor` 数组的变量，这个数组定义了排序的顺序和方式。

以下是一个使用 `Table` 视图实现多属性排序的例子：

```swift
struct ContentView: View {
    @State private var sortOrder: [KeyPathComparator<Fruit>] = [.init(\.name, order: .reverse)]

    @State var data = [
        Fruit(name: "Apple", color: "Red"),
        Fruit(name: "Banana", color: "Yellow"),
        Fruit(name: "Cherry", color: "Red"),
        Fruit(name: "Date", color: "Brown"),
        Fruit(name: "Elderberry", color: "Purple")
    ]

    var body: some View {
        sortKeyPathView() // 排序状态
        Table(data, sortOrder: $sortOrder) {
            TableColumn("Fruit", value: \.name)
            TableColumn("Color", value: \.color)
            // 不含 value 参数的不支持排序
            TableColumn("ColorNoOrder") {
                Text("\($0.color)")
                    .font(.footnote)
                    .foregroundStyle(.mint)
            }
        }
        .task {
            data.sort(using: sortOrder)
        }
        .onChange(of: sortOrder) { oldValue, newValue in
            data.sort(using: newValue)
        }
        .padding()
    }
    
    @ViewBuilder
    func sortKeyPathView() -> some View {
        HStack {
            ForEach(sortOrder, id: \.self) { order in
                Text(order.keyPath == \Fruit.name ? "名字" : "颜色")
                Image(systemName: order.order == .reverse ? "chevron.down" : "chevron.up")
            }
        }
        .padding(.top)
    }
}

struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let color: String
}
```

在这个例子中，我们首先定义了一个 `@State` 变量 `sortOrder`，它是一个 `SortDescriptor` 数组，定义了排序的顺序和方式。然后，我们将这个变量绑定到 `Table` 视图的 `sortOrder` 参数。

现在，当用户点击表头来排序一个列时，`sortOrder` 变量就会被更新。你可以使用这个变量来实现多属性排序，或者实现其他的交互功能。

