

iOS 17 开始可以使用 ShapeStyle 的实例来设置背景的分层颜色，例如 secondary，tertiary 等属性。这些背景颜色会根据当前的操作系统和浅色和深色模式进行区分显示。

代码示例如下：
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.and.background.dotted")
                .font(.largeTitle)
                .background(.tint.secondary)
            Text("Hello, World!")
                .font(.largeTitle)
                .padding()
                .background(Color.yellow.tertiary)

            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
                Text("SwiftUI")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            .background(.background.secondary)
        }
    }
}
```

在这个例子中，我们创建了一个 `ContentView` 视图，其中包含了一个 `VStack`，其中包含了一个 `Image` 和一个 `Text`。我们使用了 `background` 修饰符来设置这两个视图的背景颜色。`Image` 视图的背景颜色设置为 `.tint.secondary`，`Text` 视图的背景颜色设置为 `.yellow.tertiary`。我们还创建了一个 `HStack`，其中包含了一个 `Image` 和一个 `Text`，并设置了它们的背景颜色为 `.background.secondary`。

这样，我们就可以使用 ShapeStyle 的实例来设置背景的分层颜色，使我们的视图看起来更加美观。
