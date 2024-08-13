

## 演进

在 iOS 13 中，苹果引入了 SF Symbols，这是一套专门为 Apple 设备设计的符号图标，可以在应用程序中使用。这些符号图标是矢量图形，可以在不同的大小和颜色下保持清晰度。

WWDC 21 符号数量达到 3000 个，包括 500 个全新的符号，以及 1000 个符号的变体。推出了 SF Symbols 3，支持更多的变体和颜色。可以自定义符号。

WWDC 22 推出了 SF Symbols 4，数量达到 4000 个，支持更多的变体和颜色。有自动渲染模式，还有可变颜色。

WWDC 23 推出了 SF Symbols 5，数量达到 5000 个。符号有7种动画，可以定制动画。可以用 Symbol Components 来创建自定义符号。

## 变量值

SF Symbol 支持变量值，可以通过设置 variableValue 来填充不同部分，比如 wifi 图标，不同值会亮不同部分，`Image(systemName: "wifi", variableValue: 0.5)` 。

下面是一个使用变量值的示例代码：

```swift
struct ContentView: View {
    @State private var variableValue: Double = 0.5

    var body: some View {
        VStack {
            Slider(value: $variableValue, in: 0...1, step: 0.01)
            Image(systemName: "speaker.wave.3.fill", variableValue: variableValue)
                .symbolRenderingMode(.palette)
                .symbolVariant(.fill)
                .foregroundColor(.blue)
                .imageScale(.large)
        }
        .padding()
    }
}
```

## 大小

`.imageScale` 可以改变 SF Symbol 的大小，可以设置为 `.small`、`.medium`、`.large`。

```swift
struct ContentView: View {
    var body: some View {
        Image(systemName: "wifi")
            .imageScale(.large)
    }
}
```

还可以通过 `.font(.system(size:` 和 `.fontWeight(.semibold)` 来设置大小和粗细。

## 文本插值

文本插值支持 SF Symbol，可以在文本中插入 SF Symbol。

```swift
Text("这是一辆双层 \(Image(systemName: "bus.doubledecker"))")
```

## symbolRenderingMode 渲染模式

symbolRenderingMode 可以设置 SF Symbol 的渲染模式，可以设置为 `.multicolor`、`.palette`、`.monochrome`、`.hierarchical`。

- `.multicolor`：多色模式。这种模式下，SF Symbols 将使用预定义的多种颜色来显示。这是默认的渲染模式。
- `.palette`：调色板模式。这种模式下，SF Symbols 将使用你指定的颜色来显示。你可以为每个部分指定不同的颜色。
- `.monochrome`：单色模式。这种模式下，SF Symbols 将使用单一颜色来显示。这个颜色是你在代码中指定的颜色。
- `.hierarchical`：层次模式。这种模式下，SF Symbols 将使用一种颜色，但是不同的部分会有不同的透明度。这可以创建出一种层次感。

以下是一个使用 `.multicolor` 渲染模式的示例代码：

```swift
struct ContentView: View {
    var body: some View {
        Image(systemName: "figure.walk.motion.trianglebadge.exclamationmark")
            .symbolRenderingMode(.multicolor)
    }
}
```

## symbolVariant 变体

symbolVariant 可以设置 SF Symbol 的变体，可以设置为 `.none`、`.circle`、`.square`、`.rectangle`、`.fill`、`.slash`。

当然，以下是 SF Symbols 的各种变体的详细介绍：

- `none`：没有任何特殊变体的 SF Symbol。
- `circle`：在一个圆形背景中的。例如，`circle` 变体的 "person" symbol 就是一个人像在一个圆形背景中。
- `square`：在一个正方形背景中的。例如，`square` 变体的 "person" symbol 就是一个人像在一个正方形背景中。
- `rectangle`：在一个矩形背景中的。例如，`rectangle` 变体的 "person" symbol 就是一个人像在一个矩形背景中。
- `fill`：填充的，也就是说，它的内部是有颜色的，而不是空心的。例如，`fill` 变体的 "heart" symbol 就是一个填充的心形。
- `slash`：一条斜线穿过。例如，`slash` 变体的 "bell" symbol 就是一个有斜线穿过的铃铛，表示静音。

```swift
struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Label("Default", systemImage: "person")
            Label("Circle", systemImage: "circle")
                .symbolVariant(.circle)
            Label("Circle Fill", systemImage: "circle.fill")
                .symbolVariant(.circle.fill)
            Label("Square", systemImage: "square")
                .symbolVariant(.square)
            Label("Square Fill", systemImage: "square.fill")
                .symbolVariant(.square.fill)
            Label("Rectangle", systemImage: "rectangle")
                .symbolVariant(.rectangle)
            Label("Rectangle Fill", systemImage: "rectangle.fill")
                .symbolVariant(.rectangle.fill)
            Label("Fill", systemImage: "heart")
                .symbolVariant(.fill)
            Label("Slash", systemImage: "bell")
                .symbolVariant(.slash)
            Label("Slash Fill", systemImage: "bell.fill")
                .symbolVariant(.slash.fill)
        }
    }
}

```

## 动画

 SF Symbols 的动画一共有 7 种，分别是：Appear, Disappear, Bounce, Scale, Variable Color, Pulse, Replace。

```swift
struct ContentView: View {
    @State private var isAnimating = false
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            Button("Toggle Animation") {
                withAnimation {
                    self.isAnimating.toggle()
                }
            }
            Stepper("Count: \(count)", value: $count, in: 0...100)
            
            Image(systemName: "moon.stars")
                .symbolEffect(.disappear, isActive: isAnimating)
            
            Image(systemName: "sun.max.fill")
                .symbolEffect(
                    .variableColor,
                    isActive: isAnimating
                )
            Image(systemName: "wifi")
                .symbolEffect(.bounce, value: count)
            Image(systemName: "wifi")
                .symbolEffect(.pulse, value: count)
            Image(systemName: "wifi")
                .symbolEffect(.variableColor, value: count)
            Image(systemName: "wifi")
                .symbolEffect(.variableColor, isActive: isAnimating)
            Image(systemName: "wifi")
                .symbolEffect(.scale.up, isActive: isAnimating)
            Image(systemName: "wifi")
                .symbolEffect(.scale.down, isActive: isAnimating)
            Image(systemName: "wifi")
                .symbolEffect(.pulse, isActive: isAnimating)
        }
        .imageScale(.large)
        .padding()
    }
}
```

