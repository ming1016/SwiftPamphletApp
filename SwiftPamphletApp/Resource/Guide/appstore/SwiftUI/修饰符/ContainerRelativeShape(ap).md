
`ContainerRelativeShape` 是 SwiftUI 中的一个视图，它可以创建一个形状，这个形状会根据其包含的容器的形状进行变化。这意味着，如果你将 `ContainerRelativeShape` 用作视图的背景，那么这个背景的形状会自动适应视图的形状。

以下是一个简单的使用示例：

```swift
Text("Hello, World!")
    .padding()
    .background(ContainerRelativeShape().fill(Color.blue))
```

在这个示例中，`Text` 视图的背景是一个 `ContainerRelativeShape`，并且这个形状被填充了蓝色。由于 `ContainerRelativeShape` 会自动适应其容器的形状，所以这个背景的形状会自动适应 `Text` 视图的形状。

`ContainerRelativeShape` 能适应不同容器的形状。

以下代码展示怎么为 Widget 创建一个适应不同硬件容器显示不同形状边框的背景：

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.yellow)
            
            ContainerRelativeShape()
                .inset(by: 10)
                .fill(Color.indigo)
            Image(systemName: "person.and.background.dotted")
                .resizable()
                .clipShape(ContainerRelativeShape()
                           .inset(by: 10))
            Text("播放电影")
                .padding()
                .background(ContainerRelativeShape().fill(Color.white))
        }
    }
}
```

在这个示例中，我们使用 `ContainerRelativeShape` 来设置 `Color` 视图的背景，然后使用 `inset(by:)` 方法来设置 `ContainerRelativeShape` 的边距。最后，我们使用 `ContainerRelativeShape` 来设置 `Text` 视图的背景。




