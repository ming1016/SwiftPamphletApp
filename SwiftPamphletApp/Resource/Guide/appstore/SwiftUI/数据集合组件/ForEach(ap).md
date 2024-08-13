
## 使用

在 SwiftUI 中，`ForEach` 是一个结构体，它可以创建一组视图，每个视图都有一个与数据集中的元素相对应的唯一标识符。这对于在列表或其他集合视图中显示数据非常有用。

以下视图集会用到 ForEach：

- List
- ScrollView
- LazyVStack / LazyHStack
- Picker
- Grids (LazyVGrid / LazyHGrid)

例如，如果你有一个 `BookmarkModel` 的数组，并且你想为每个书签创建一个文本视图，你可以这样做：

```swift
struct ContentView: View {
    var bookmarks: [BookmarkModel]

    var body: some View {
        List {
            ForEach(bookmarks) { bookmark in
                Text(bookmark.name)
            }
        }
    }
}
```

`ForEach` 遍历 `bookmarks` 数组，并为每个 `BookmarkModel` 对象创建一个 `Text` 视图。`bookmark` 参数是当前遍历的 `BookmarkModel` 对象。

`BookmarkModel` 必须遵循 `Identifiable` 协议，这样 SwiftUI 才能知道如何唯一地标识每个视图。在你的代码中，`BookmarkModel` 已经有一个 `id` 属性，所以你只需要让 `BookmarkModel` 遵循 `Identifiable` 协议即可：

```swift
final class BookmarkModel: Identifiable {
    // your code here
}
```

## 使用索引范围进行编号

你可以使用 `ForEach` 结构体的另一个版本，它接受一个范围作为其数据源。这个范围可以是一个索引范围，这样你就可以为每个项目编号。

例如，如果你有一个 `BookmarkModel` 的数组，并且你想为每个书签创建一个文本视图，并在前面添加一个编号，你可以这样做：

```swift
struct ContentView: View {
    var bookmarks: [BookmarkModel]

    var body: some View {
        List {
            ForEach(bookmarks.indices, id: \.self) { index in
                Text("\(index + 1). \(bookmarks[index].name)")
            }
        }
    }
}
```

在这个例子中，`ForEach` 遍历 `bookmarks` 数组的索引，并为每个 `BookmarkModel` 对象创建一个 `Text` 视图。`index` 参数是当前遍历的索引。我们使用 `\(index + 1). \(bookmarks[index].name)` 来创建一个带有编号的文本视图。请注意，我们使用 `index + 1` 而不是 `index`，因为数组的索引是从 0 开始的，但我们通常希望编号是从 1 开始的。

## 使用 enumerated 编号

 `enumerated()` 

以下是一个例子：

```swift
struct ContentView: View {
    var bookmarks: [BookmarkModel]

    var body: some View {
        List {
            ForEach(Array(bookmarks.enumerated()), id: \.element.id) { index, bookmark in
                Text("\(index). \(bookmark.name)")
            }
        }
    }
}
```

我们使用 `Array(bookmarks.enumerated())` 来创建一个元组数组，每个元组包含一个索引和一个 `BookmarkModel` 对象。然后，我们使用 `ForEach` 遍历这个元组数组，并为每个元组创建一个 `Text` 视图。`index` 参数是当前遍历的索引，`bookmark` 参数是当前遍历的 `BookmarkModel` 对象。

## 使用 zip 编号

`zip(_:_:)` 函数可以将两个序列合并为一个元组序列。你可以使用这个函数和 `ForEach` 结构体来为数组中的每个元素添加一个编号。

例如，如果你有一个 `BookmarkModel` 的数组，并且你想为每个书签创建一个文本视图，并在前面添加一个编号，你可以这样做：

```swift
struct ContentView: View {
    var bookmarks: [BookmarkModel]

    var body: some View {
        List {
            ForEach(Array(zip(1..., bookmarks)), id: \.1.id) { index, bookmark in
                Text("\(index). \(bookmark.name)")
            }
        }
    }
}
```

写出扩展，方便调用

```swift
@dynamicMemberLookup
struct Numbered<Element> {
    var number: Int
    var element: Element
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Element, T>) -> T {
        get { element[keyPath: keyPath] }
        set { element[keyPath: keyPath] = newValue }
    }
}

extension Sequence {
    func numbered(startingAt start: Int = 1) -> [Numbered<Element>] {
        zip(start..., self)
            .map { Numbered(number: $0.0, element: $0.1) }
    }
}

extension Numbered: Identifiable where Element: Identifiable {
    var id: Element.ID { element.id }
}
```

使用：

```swift
ForEach(bookmark.numbered()) { numberedBookmark in
    Text("\(numberedBookmark.number). \(numberedBookmark.name)")
}
```
