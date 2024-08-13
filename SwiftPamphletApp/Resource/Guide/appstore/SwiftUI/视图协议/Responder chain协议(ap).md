
Responder chain 协议包括：

- `Commands`
- `FocusedValueKey`

`Responder chain` 是一个事件处理机制，它允许事件从当前视图传递到视图层次结构中的其他视图。这个机制主要涉及到两个协议：`Commands` 和 `FocusedValueKey`。

`Commands` 协议允许我们定义一组命令，这些命令可以在菜单中显示，并且可以响应用户的操作。例如，我们可以创建一个命令，它允许用户切换漫画的显示模式：

```swift
struct ComicCommands: Commands {
    var body: some Commands {
        CommandMenu("漫画") {
            Button("切换模式") {
                // 切换漫画的显示模式
            }
        }
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .commands {
                    ComicCommands()
                }
        }
    }
}
```

在这个例子中，`ComicCommands` 是一个遵循 `Commands` 协议的类型，它定义了一个命令菜单，菜单中有一个按钮，点击这个按钮可以切换漫画的显示模式。我们在 `MyApp` 中使用 `.commands` 修饰符来添加这个命令菜单。

`FocusedValueKey` 协议允许我们定义一个键，这个键可以用于获取或设置焦点视图的值。例如，我们可以创建一个键，它表示当前漫画的标题：

```swift
struct ComicTitleKey: FocusedValueKey {
    typealias Value = String
}

extension FocusedValues {
    var comicTitle: ComicTitleKey.Value? {
        get { self[ComicTitleKey.self] }
        set { self[ComicTitleKey.self] = newValue }
    }
}
```

然后，我们可以在视图中使用 `.focusedValue()` 修饰符来设置这个键的值：

```swift
Text("漫画标题")
    .focusedValue(ComicTitleKey.self, "漫画标题")
```

在这个例子中，`ComicTitleKey` 是一个遵循 `FocusedValueKey` 协议的类型，它表示当前漫画的标题。我们在 `Text` 视图中使用 `.focusedValue()` 修饰符来设置这个键的值为 "漫画标题"。
