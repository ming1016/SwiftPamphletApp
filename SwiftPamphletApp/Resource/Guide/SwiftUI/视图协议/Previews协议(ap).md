
Previews 协议包括：

- `PreviewContext`
- `PreviewContextKey`
- `PreviewProvider`

`PreviewProvider` 协议允许我们为视图提供预览。这些预览可以在 Xcode 的预览窗口中显示，帮助我们在编写代码时看到视图的外观。

例如，我们可以创建一个表示漫画角色的视图，然后为它提供一个预览：

```swift
struct ComicCharacterView: View {
    var body: some View {
        Text("漫画角色")
    }
}

struct ComicCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ComicCharacterView()
    }
}
```

在这个例子中，`ComicCharacterView` 是一个自定义的视图，它显示一条表示漫画角色的文本。`ComicCharacterView_Previews` 是一个遵循 `PreviewProvider` 协议的类型，它提供了 `ComicCharacterView` 的预览。

`PreviewContext` 和 `PreviewContextKey` 是用于自定义预览环境的类型。例如，我们可以创建一个自定义的 `PreviewContextKey`，然后使用 `PreviewContext` 来设置它的值：

```swift
struct ComicStyleKey: PreviewContextKey {
    static let defaultValue: String = "普通"
}

struct ComicCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ComicCharacterView()
            .previewContext(PreviewContext(ComicStyleKey.self, "暗黑"))
    }
}
```

在这个例子中，`ComicStyleKey` 是一个自定义的 `PreviewContextKey`，它表示漫画的样式。我们在 `ComicCharacterView_Previews` 中使用 `previewContext()` 修饰符来设置它的值为 "暗黑"。
