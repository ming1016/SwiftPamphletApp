

你可以通过检测列表滚动到底部来实现加载更多的功能。以下是一个简单的例子：

```swift
struct ContentView: View {
    @State private var items = Array(0..<20)

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text("Item \(item)")
                    .onAppear {
                        if item == items.last {
                            loadMore()
                        }
                    }
            }
        }
        .onAppear(perform: loadMore)
    }

    func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let newItems = Array(self.items.count..<self.items.count + 20)
            self.items.append(contentsOf: newItems)
        }
    }
}
```

在这个例子中，我们创建了一个包含多个元素的 List。当 List 出现最后一项时，我们调用 `loadMore` 方法来加载更多的元素。在 `loadMore` 方法中，模拟在一秒后添加新的元素到 `items` 数组中。

请注意，这只是一个基本的使用示例，实际的使用方式可能会根据你的需求而变化。例如，你可能需要从网络获取新的元素，而不是像这个例子中那样直接创建新的元素。
