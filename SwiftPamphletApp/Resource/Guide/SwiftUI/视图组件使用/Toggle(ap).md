![](https://user-images.githubusercontent.com/251980/156289124-bde3c73e-2a81-4043-8682-ae55a820f1aa.png)

Toggle 可以设置 toggleStyle，可以自定义样式。使用示例如下

```swift
struct PlayToggleView: View {
    @State private var isEnable = false
    var body: some View {
        // 普通样式
        Toggle(isOn: $isEnable) {
            Text("\(isEnable ? "开了" : "关了")")
        }
        .padding()
        
        // 按钮样式
        Toggle(isOn: $isEnable) {
            Label("\(isEnable ? "打开了" : "关闭了")", systemImage: "cloud.moon")
        }
        .padding()
        .tint(.pink)
        .controlSize(.large)
        .toggleStyle(.button)
        
        // Switch 样式
        Toggle(isOn: $isEnable) {
            Text("\(isEnable ? "开了" : "关了")")
        }
        .toggleStyle(SwitchToggleStyle(tint: .orange))
        .padding()
        
        // 自定义样式
        Toggle(isOn: $isEnable) {
            Text(isEnable ? "录音中" : "已静音")
        }
        .toggleStyle(PCToggleStyle())
        
    }
}

// MARK: - 自定义样式
struct PCToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "mic.square.fill" : "mic.slash.circle.fill")
                .renderingMode(.original)
                .resizable()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
```
