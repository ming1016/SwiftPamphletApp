

## scrollPostion 版本

`scrollPositon(id:)` 比 ScrollViewReader 简单，但是只适用于 ScrollView。数据源遵循 Identifiable，不用显式使用 `id` 修饰符

```swift
struct ContentView: View {
    @State private var id: Int?

    var body: some View {
        VStack {
            Button("Scroll to Bookmark 3") {
                withAnimation {
                    id = 3
                }
            }
            Button("Scroll to Bookmark 13") {
                withAnimation {
                    id = 13
                }
            }
            ScrollView {
                ScrollViewReader { scrollView in
                    LazyVStack {
                        ForEach(Bookmark.simpleData()) { bookmark in
                            Text("\(bookmark.index)")
                                .id(bookmark.index)
                        }
                        
                    }
                }
            }
            .scrollPosition(id: $id)
            .scrollTargetLayout()
        }
    }
    
    struct Bookmark: Identifiable,Hashable {
        let id = UUID()
        let index: Int
        
        static func simpleData() -> [Bookmark] {
            var re = [Bookmark]()
            for i in 0...100 {
                re.append(Bookmark(index: i))
            }
            return re
        }
    }
}
```

scrollTargetLayout 可以获得当前滚动位置。锚点不可配，默认是 center。


## ScrollViewReader 版本

ScrollViewReader 这个版本可以适用于 List，也可以配置锚点

你可以使用 `ScrollViewReader` 和 `scrollTo(_:anchor:)` 方法来滚动到特定的元素。以下是一个例子：

```swift
struct ContentView: View {
    var bookmarks: [Int] = Array(1...100)
    @State private var selectedBookmarkId: Int?

    var body: some View {
        VStack {
            Button("Scroll to Bookmark 3") {
                selectedBookmarkId = 3
            }
            Button("Scroll to Bookmark 13") {
                selectedBookmarkId = 13
            }
            ScrollView {
                ScrollViewReader { scrollView in
                    LazyVStack {
                        ForEach(bookmarks.indices, id: \.self) { index in
                            Text("\(bookmarks[index])")
                                .id(index)
                        }
                        .onChange(of: selectedBookmarkId) { oldValue, newValue in
                            if let newValue = newValue {
                                withAnimation {
                                    scrollView.scrollTo(newValue, anchor: .top)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
```

在这个例子中，我们首先创建了一个 `Button`，当点击这个按钮时，`selectedBookmarkId` 的值会被设置为 3。然后，我们创建了一个 `ScrollView`，并在 `ScrollView` 中添加了一个 `ScrollViewReader`。我们在 `ScrollViewReader` 中添加了一个 `LazyVStack`，并使用 `ForEach` 遍历 `bookmarks` 数组的索引，为每个索引创建一个 `Text` 视图。我们使用 `id(_:)` 方法为每个 `Text` 视图设置了一个唯一的 ID。

我们使用 `onChange(of:perform:)` 方法来监听 `selectedBookmarkId` 的变化。当 `selectedBookmarkId` 的值改变时，我们会调用 `scrollTo(_:anchor:)` 方法来滚动到特定的元素。`anchor: .top` 参数表示我们希望滚动到的元素位于滚动视图的顶部。

