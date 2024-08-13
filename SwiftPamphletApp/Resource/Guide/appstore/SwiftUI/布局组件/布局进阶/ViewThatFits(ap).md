
`ViewThatFits` 是一个自动选择最适合当前屏幕大小的子视图进行显示的视图。它会根据可用空间的大小来决定如何布局和显示子视图。

`ViewThatFits` 是一个在 SwiftUI 中用于选择最适合显示的视图的组件。它的工作原理如下：

- 首先，`ViewThatFits` 会测量在特定轴（水平或垂直）或两个轴（水平和垂直）上的可用空间。这是通过 SwiftUI 的布局系统来完成的，该系统提供了当前视图的大小和位置信息。

- 接着，`ViewThatFits` 会测量第一个视图的大小。这是通过调用视图的 `measure(in:)` 方法来完成的，该方法返回一个包含视图理想大小的 `CGSize` 值。

- 如果第一个视图的大小适合可用空间，`ViewThatFits` 就会选择并放置这个视图。放置视图是通过调用视图的 `layout(in:)` 方法来完成的，该方法接受一个 `CGRect` 值，该值定义了视图在其父视图中的位置和大小。

- 如果第一个视图的大小不适合可用空间，`ViewThatFits` 会继续测量第二个视图的大小。如果第二个视图的大小适合可用空间，`ViewThatFits` 就会选择并放置这个视图。

- 如果所有视图的大小都不适合可用空间，`ViewThatFits` 会选择并放置 `ViewBuilder` 闭包中的最后一个视图。`ViewBuilder` 是一个特殊的闭包，它可以根据其内容动态创建视图。

```swift
ViewThatFits(in: .horizontal) {
    Text("晴天，气温25°") // 宽度在200到300之间
        .font(.title)
        .foregroundColor(.yellow)
    Text("晴天，25°") // 宽度在150到200之间
        .font(.title)
        .foregroundColor(.gray)
    Text("晴25") // 宽度在100到150之间
        .font(.title)
        .foregroundColor(.white)
}
.border(Color.green) // ViewThatFits所需的大小
.frame(width:200)
.border(Color.orange) // 父视图提议的大小
```

在不同的宽度下，ViewThatFits 会选择不同的视图进行显示。在上面的示例中，当父视图的宽度在100到150之间时，ViewThatFits 会选择显示 "晴25" 这个视图。

通过 ViewThatFits 来确定内容是否可滚动。

```swift
struct ContentView: View {
    @State var step: CGFloat = 3
    var count: Int {
        Int(step)
    }

    var body: some View {
        VStack(alignment:.leading) {
            Text("数量: \(count)")
                .font(.title)
                .foregroundColor(.blue)
            Stepper("数量", value: $step, in: 3...20)

            ViewThatFits {
                content
                ScrollView(.horizontal,showsIndicators: true) {
                    content
                }
            }
        }
        .padding()
    }

    var content: some View {
        HStack {
            ForEach(0 ..< count, id: \.self) { i in
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("\(i)")
                            .font(.headline)
                            .foregroundColor(.white)
                    )
            }
        }
    }
}
```


