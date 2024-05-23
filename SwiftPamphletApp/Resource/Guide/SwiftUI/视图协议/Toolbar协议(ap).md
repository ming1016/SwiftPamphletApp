
Toolbar 协议包括：

- `ToolbarContent`
- `CustomizableToolbarContent`

在 SwiftUI 中，`Toolbar` 是一个用于在视图中添加工具栏的修饰符。这个修饰符可以接受一个遵循 `ToolbarContent` 协议的类型，这个类型定义了工具栏的内容。

例如，我们可以创建一个视图，它有一个工具栏，工具栏中有一个按钮，点击这个按钮可以切换漫画的显示模式：

```swift
struct ComicView: View {
    @State private var isDarkMode = false

    var body: some View {
        Text(isDarkMode ? "暗黑模式的漫画" : "普通模式的漫画")
            .toolbar {
                ToolbarItem {
                    Button("切换模式") {
                        isDarkMode.toggle()
                    }
                }
            }
    }
}
```

在这个例子中，`ComicView` 是一个自定义的视图，它有一个 `@State` 属性 `isDarkMode`，这个属性表示是否是暗黑模式。视图的主体是一个文本，它根据 `isDarkMode` 的值来显示不同的漫画。视图还有一个工具栏，工具栏中有一个按钮，点击这个按钮可以切换 `isDarkMode` 的值。

`CustomizableToolbarContent` 是一个协议，它允许我们定义一个可以自定义的工具栏内容。例如，我们可以创建一个遵循 `CustomizableToolbarContent` 协议的类型，然后在视图中使用它：

```swift
struct ComicToolbar: CustomizableToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem {
            Button("切换模式") {
                // 切换漫画的显示模式
            }
        }
    }

    var placement: ToolbarItemPlacement {
        .navigationBarTrailing
    }
}

struct ComicView: View {
    var body: some View {
        Text("漫画")
            .toolbar {
                ComicToolbar()
            }
    }
}
```

在这个例子中，`ComicToolbar` 是一个遵循 `CustomizableToolbarContent` 协议的类型，它定义了一个工具栏项，这个工具栏项是一个按钮，点击这个按钮可以切换漫画的显示模式。`ComicToolbar` 还定义了工具栏项的位置，它是在导航栏的尾部。我们在 `ComicView` 中使用 `.toolbar` 修饰符来添加这个工具栏。
