
## frame 对齐

```swift
.frame(width: 100, height: 50, alignment: .topLeading)
```

## 可设置对齐的视图

在 SwiftUI 中，许多视图都接受 `alignment` 参数，用于控制其子视图的对齐方式。以下是一些常见的接受 `alignment` 参数的视图：

- `HStack(alignment: .bottom)`：水平堆栈视图，可以控制其子视图在垂直方向上的对齐方式。
- `VStack(alignment: .trailing)`：垂直堆栈视图，可以控制其子视图在水平方向上的对齐方式。
- `ZStack(alignment: .center)`：深度堆栈视图，可以控制其子视图在水平和垂直方向上的对齐方式。
- `GridRow(alignment: .firstTextBaseline)`：用于定义网格的行或列的大小，可以设置行或列中的内容的对齐方式。。


## 基线对齐

你可以使用 `alignment` 参数来设置视图的对齐方式，包括基线对齐。以下是一个例子：

```swift
HStack(alignment: .firstTextBaseline) {
    Text("Hello")
    Text("World").font(.largeTitle)
}
```

在这个例子中，`HStack` 是一个水平堆栈视图，它会将其子视图水平排列。`alignment: .firstTextBaseline` 是一个参数，用于设置堆栈中的内容的对齐方式。`.firstTextBaseline` 表示所有文本视图都应该根据它们的第一行的基线对齐。基线是文本字符的底部线。

因此，这个 `HStack` 中的两个 `Text` 视图会根据它们的第一行的基线对齐，即使它们的字体大小不同。

