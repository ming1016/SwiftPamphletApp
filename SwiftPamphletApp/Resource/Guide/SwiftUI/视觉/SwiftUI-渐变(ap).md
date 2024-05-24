
## `.gradient`

在 SwiftUI 中，你可以使用 `.gradient` 修饰符为任何 `Color` 添加渐变效果。例如，你可以使用 `.gradient` 修饰符为 `Text` 添加渐变效果，如下所示：

Color 后直接加 `.gradient` 可以实现渐变效果，如下所示：
```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.gradient)
            Text("渐变色")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.indigo.gradient)
        }
    }
}
```

## Gradient

你可以使用 `Gradient` 类型来创建自定义渐变，如下所示：

```swift
struct ContentView: View {
    let gradientColors: [Color] = [
        .mint, .yellow
    ]

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.gradient)
            Text("渐变色")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Gradient(colors: gradientColors))
        }
    }
}
```

## LinearGradient

你可以使用 `LinearGradient` 类型创建线性渐变，如下所示：

```swift
Rectangle()
    .fill(LinearGradient(colors: [.white, .black], startPoint: .leading, endPoint: .trailing))
```

## RadialGradient

你可以使用 `RadialGradient` 类型创建径向渐变，如下所示：

```swift
struct ContentView: View {
    var body: some View {
        Rectangle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [.black, .gray, .white]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 200
                )
            )
            .frame(width: 400, height: 600)
            .cornerRadius(20)
    }
}
```

我们创建了一个矩形，并使用 `RadialGradient` 填充它。渐变从黑色开始，经过深灰色和浅灰色，最后到白色，从中心开始，到半径为 200 的圆结束。我们还设置了矩形的宽度和高度分别为 400 和 600，以及圆角半径为 20。

## AngularGradient

`AngularGradient` 类型创建一个角度渐变，如下所示：

```swift
struct ContentView: View {
    var body: some View {
        Rectangle()
            .fill(
                AngularGradient(
                    gradient: Gradient(colors: [.black, .gray, .white, .black]),
                    center: .center
                )
            )
            .frame(width: 400, height: 600)
            .cornerRadius(20)
    }
}
```
