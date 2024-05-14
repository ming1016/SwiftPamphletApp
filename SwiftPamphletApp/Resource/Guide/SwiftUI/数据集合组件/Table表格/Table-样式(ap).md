
在 SwiftUI 中，`Table` 视图的 `.tableStyle` 修改器可以用来设置表格的样式。目前，SwiftUI 提供了以下几种表格样式：

- inset：默认
- `inset(alternatesRowBackgrounds: Bool)`：是否开启行交错背景
- bordered：加边框
- `bordered(alternatesRowBackgrounds: Bool)`： 是否开启行交错背景

你可以使用 `.tableStyle` 修改器来设置表格的样式，例如：

```swift
Table(data) {
    // ...
}
.tableStyle(InsetGroupedListStyle())
```

这段代码会将表格的样式设置为 `InsetGroupedListStyle`。
