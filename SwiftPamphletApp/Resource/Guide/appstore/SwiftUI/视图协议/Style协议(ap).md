
样式风格协议包括：

- `ButtonStyle`
- `DatePickerStyle` (iOS, macOS)  `DatePickerStyle` （iOS、macOS）
- `GaugeStyle` (watchOS)  `GaugeStyle` （watchOS操作系统）
- `GroupBoxStyle` (iOS, macOS)  `GroupBoxStyle` （iOS、macOS）
- `IndexViewStyle` (iOS, tvOS)  `IndexViewStyle` （iOS、tvOS）
- `LabelStyle`
- `ListStyle`
- `MenuButtonStyle` (macOS)  `MenuButtonStyle` （macOS操作系统）
- `MenuStyle` (iOS, macOS)  `MenuStyle` （iOS、macOS）
- `NavigationViewStyle`
- `PickerStyle`
- `PrimitiveButtonStyle`
- `ProgressViewStyle`
- `ShapeStyle`
- `TabViewStyle`
- `TextFieldStyle`
- `ToggleStyle`
- `WindowStyle` (macOS)  `WindowStyle` （macOS操作系统）
- `WindowToolbarStyle` (macOS)  `WindowToolbarStyle` （macOS操作系统）

在 SwiftUI 中，样式风格协议允许我们自定义各种视图的外观和行为。这些协议包括 `ButtonStyle`，`DatePickerStyle`，`ListStyle`，`PickerStyle`，`PrimitiveButtonStyle`，`ProgressViewStyle`，`ShapeStyle`，`TabViewStyle`，`TextFieldStyle`，`ToggleStyle` 等。

例如，`ButtonStyle` 协议允许我们自定义按钮的外观和行为。我们可以创建一个自定义的漫画风格按钮样式：

```swift
struct ComicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
            .shadow(color: .black, radius: 10, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
```

在这个例子中，`ComicButtonStyle` 是一个自定义的漫画风格按钮样式。按钮的字体是标题字体，四周有一定的填充，背景色是黄色，角落是圆形的，有一个黑色的阴影，当按钮被按下时，会缩小到原来的 90%。

你可以像这样使用 `ComicButtonStyle`：

```swift
Button(action: {
    print("漫画按钮被点击!")
}) {
    Text("点击我")
}
.buttonStyle(ComicButtonStyle())
```

在这个例子中，按钮的动作是打印一条消息，按钮的标签是一个文本视图。我们使用 `.buttonStyle()` 修饰符来应用 `ComicButtonStyle`。
