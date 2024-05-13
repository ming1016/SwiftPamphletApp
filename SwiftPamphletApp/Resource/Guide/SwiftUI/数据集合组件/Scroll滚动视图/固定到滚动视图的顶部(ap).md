
LazyVStack 有个参数 pinnedViews 可以用于固定滚动视图的顶部。

```swift
ScrollView {
    LazyVStack(alignment: .leading, spacing: 10, pinnedViews: .sectionHeaders) {
        Section {
            ForEach(books) { book in
                BookRowView(book: book)
            }
        } header: {
            HeaderView(title: "小说")
        }
        ....
    }
}
```
