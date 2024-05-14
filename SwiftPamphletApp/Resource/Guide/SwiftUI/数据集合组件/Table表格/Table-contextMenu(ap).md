
```swift
struct ContentView: View {
    @State private var selection: Set<UUID> = []
    var body: some View {
        Table(Fruit.simpleData(), selection: $selection) {
            ...
        }
        .contextMenu(forSelectionType: Fruit.ID.self) { selection in
            if selection.isEmpty {
                Button("添加") {
                    // ...
                }
            } else if selection.count == 1 {
                Button("收藏") {
                    // ...
                }
            } else {
                Button("收藏多个") {
                    // ...
                }
            }
        } primaryAction: { items in
            // 双击某一行时
            debugPrint(items)
        }
    }
    ...
}
```
