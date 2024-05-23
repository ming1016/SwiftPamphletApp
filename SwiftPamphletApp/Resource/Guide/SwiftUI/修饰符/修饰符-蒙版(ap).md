
SwiftUI 中有一些修饰符可以用来做蒙版，比如 `.clipped()`、`.clipShape()` 和 `.mask()`。

## `.clipped()`

`.clipped()` 修饰符用于将视图的内容裁剪到其布局区域。如果视图的内容超出了其布局区域，那么超出的部分将不会被显示。

例如，你可能有一个大的图片视图，但你只想在一个小的矩形区域内显示这个图片。你可以使用 `.clipped()` 修饰符来实现这个效果：

```swift
struct ContentView: View {
    var body: some View {
        Image("evermore")
            .frame(width: 100, height: 100)
            .clipped()
    }
}
```

在这个例子中，`Image` 视图的内容将被裁剪到一个宽度和高度都为 100 的矩形区域内。如果图片的大小超过了这个区域，那么超出的部分将不会被显示。

需要注意的是 `.clipped()` 只是视觉上的裁切，如果要限制可点击区域，需要使用 `.contentShape()` 修饰符。

## `.clipShape()`

`.clipShape()` 修饰符用于将视图裁剪为指定的形状。你可以使用任何 `Shape` 类型的对象来裁剪视图，比如 `Circle`、`Rectangle`、`RoundedRectangle` 等。

例如，你可以使用 `.clipShape()` 修饰符将一个 `Image` 视图裁剪为星形：

```swift
struct SomeShape: Shape {
    func path(in rect: CGRect) -> Path {
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let points = 5
            let adjustment = CGFloat.pi / 2
            var path = Path()

            for i in 0..<points {
                let angle = adjustment + CGFloat(Double.pi * 2) / CGFloat(points) * CGFloat(i)
                let point = CGPoint(x: center.x + cos(angle) * radius, y: center.y + sin(angle) * radius)
                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
            return path
        }
}

struct ContentView: View {
    var body: some View {
        Image("evermore")
            .resizable()
            .frame(width: 200, height: 200)
            .clipShape(SomeShape())
    }
}
```

在这个例子中，我们创建了一个 `Star` 结构体，它实现了 `Shape` 协议，用于绘制一个星形。然后，我们使用 `.clipShape()` 修饰符将一个 `Image` 视图裁剪为这个星形。

## `.mask()`

`.mask()` 修饰符用于将一个视图作为蒙版应用到另一个视图上。蒙版视图的不透明部分将会显示出来，而透明部分将会被隐藏。

```swift
struct ContentView: View {
    @State private var animationProgress = 0.0

    var body: some View {

        Image("evermore")
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .mask {
                Text("Taylor Swift")
                    .font(.largeTitle)
                    .bold()
            }
    }
}
```

在这个例子中，我们创建了一个 `ContentView` 视图，其中包含了一个 `Image` 视图。我们使用 `.mask()` 修饰符将一个 `Text` 视图作为蒙版应用到 `Image` 视图上。这样，`Image` 视图的内容将被 `Text` 视图的不透明部分遮挡，而透明部分将会被隐藏。

