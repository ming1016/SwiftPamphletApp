

要创建自定义按钮样式，我们需要创建一个新类型，该类型遵循 `ButtonStyle` 协议。

该协议都要求实现一个名为 `makeBody(configuration:)` 的方法。传递给此方法的配置参数包含了我们正在为其设置样式的按钮的相关信息。

我们可以通过 `configuration.label` 获取表示按钮标签的视图，并将我们的样式应用于该标签。

```swift
struct ContentView: View {
    @State private var isPrivacyMode = true
    var body: some View {
        Button(action: {
            print("按钮被点击!")
        }) {
            Text("点击我")
        }
        .buttonStyle(ComicButtonStyle())
    }
}

struct ComicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .font(.title).bold()
        .background {
            Capsule()
                .stroke(configuration.isPressed ? .red : .blue, lineWidth: 2)
        }
        .opacity(configuration.isPressed ? 0.6 : 1)
    }
}
```
