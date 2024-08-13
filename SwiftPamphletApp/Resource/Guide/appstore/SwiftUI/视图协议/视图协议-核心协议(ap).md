
核心协议包括：

- `View`
- `ViewModifier`
- `App`
- `Scene`

以下是 SwiftUI 的核心协议的介绍和示例：

- `View`：这是所有 SwiftUI 视图的基础协议。它定义了一个视图的基本接口，包括其主体和一些关联类型。例如，我们可以创建一个表示漫画书的视图：

```swift
struct ComicBookView: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.title)
            .padding()
    }
}
```

- `ViewModifier`：这个协议定义了可以修改视图并返回新视图的类型。例如，我们可以创建一个修改器，使文本看起来像漫画对话框：

```swift
struct ComicSpeechModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
    }
}
```

然后，我们可以使用这个修改器来修改我们的 `ComicBookView`：

```swift
ComicBookView(title: "Hello, Comic World!")
    .modifier(ComicSpeechModifier())
```

- `App`：这个协议定义了一个应用程序的结构。它包括一个场景的主体，这个场景是应用程序的入口点。例如，我们可以创建一个漫画应用程序：

```swift
@main
struct ComicApp: App {
    var body: some Scene {
        WindowGroup {
            ComicBookView(title: "Hello, Comic World!")
                .modifier(ComicSpeechModifier())
        }
    }
}
```

- `Scene`：这个协议定义了应用程序的一个场景，例如一个窗口或者一个文档。在上面的 `ComicApp` 示例中，我们使用了 `WindowGroup`，它是 `Scene` 的一个具体实现，用于管理应用程序的主窗口。
