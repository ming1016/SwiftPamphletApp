
Shapes 协议包括：

- `Shape`
- `InsettableShape`

`Shape` 和 `InsettableShape` 是用于创建和修改形状的协议。

- `Shape`：这个协议定义了一个可以在画布上绘制的形状。例如，我们可以创建一个表示漫画气泡的形状：

```swift
struct ComicBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
        return path
    }
}
```

在这个例子中，`ComicBubble` 是一个自定义的形状，它在给定的矩形中绘制一个圆形。

- `InsettableShape`：这个协议定义了一个可以插入或扩展其边界的形状。例如，我们可以创建一个可以插入的漫画气泡形状：

```swift
struct InsettableComicBubble: InsettableShape {
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var bubble = self
        bubble.insetAmount += amount
        return bubble
    }
}
```

在这个例子中，`InsettableComicBubble` 是一个自定义的可以插入的形状，它在给定的矩形中绘制一个圆形，但是半径减去了插入量。`inset(by:)` 方法返回一个新的形状，其插入量增加了指定的量。
