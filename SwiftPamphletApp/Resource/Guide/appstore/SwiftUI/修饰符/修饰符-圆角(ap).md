

## cornerRadius

在修饰符中使用 cornerRadius 设置圆角的示例

```swift
struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("电影名称：星际穿越")
                .foregroundStyle(.white)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.secondary)
                        .stroke(Color.yellow, lineWidth: 3)
                    }
                
            Text("导演：克里斯托弗·诺兰")
        }
        .padding(20)
        .background(Color.indigo)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
```

以上代码中，我们创建了一个 `ContentView` 视图，其中包含了一个 `VStack`，其中包含了两个 `Text`。我们使用了 `foregroundStyle` 修饰符来设置第一个 `Text` 的前景色为白色，然后使用 `padding` 修饰符来设置内边距。接着，我们使用了 `background` 修饰符来设置第一个 `Text` 的背景颜色，然后使用 `RoundedRectangle` 来设置圆角和边框。最后，我们使用了 `clipShape` 修饰符来设置整个 `VStack` 的圆角。

## UnevenRoundedRectangle

iOS 17 开始，SwiftUI 引入 UnevenRoundedRectangle 视图，UnevenRoundedRectangle 可以为每个角指定不同的半径值，让开发者可以创建高度定制化的形状。

```swift
struct ContentView: View {
    @State private var animate = true
    var body: some View {
        Button(action: {
            // 在这里添加播放电影的代码
            withAnimation {
                animate.toggle()
            }
        }) {
            Text("播放电影")
                .font(.title)
        }
        .tint(.white)
        .frame(width: 200, height: 80)
        .background {
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: animate ? 30.0 : 60,
                bottomLeading: animate ? 20.0 : 10,
                bottomTrailing: animate ? 30.0 : 15,
                topTrailing: animate ? 20.0 : 40),
                      style: .continuous)
                .foregroundStyle(.red)
        }
    }
}
```

在这个例子中，我们创建了一个 `ContentView` 视图，其中包含了一个按钮，当点击按钮时，按钮的圆角会发生变化。通过使用 `UnevenRoundedRectangle` 视图，我们可以为每个角指定不同的半径值，从而创建高度定制化的形状。
