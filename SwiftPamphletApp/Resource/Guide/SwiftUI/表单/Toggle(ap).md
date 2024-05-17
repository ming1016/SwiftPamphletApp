![](https://ming1016.github.io/qdimg/240505/toggle-ap01.png)



## 示例

使用示例如下

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

## 样式

Toggle 可以设置 toggleStyle，可以自定义样式。

下表是不同平台支持的样式

- DefaultToggleStyle：iOS 表现的是 Switch，macOS 是 Checkbox
- SwitchToggleStyle：iOS 和 macOS 都支持
- CheckboxToggleStyle：只支持 macOS

## 纯图像的 Toggle

```swift
struct ContentView: View {
    @State private var isMuted = false

    var body: some View {
        Toggle(isOn: $isMuted) {
            Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.fill")
                .font(.system(size: 50))
        }
        .tint(.red)
        .toggleStyle(.button)
        .clipShape(Circle())
    }
}
```

## 自定义 ToggleStyle

做一个自定义的切换按钮 OfflineModeToggleStyle。这个切换按钮允许用户控制是否开启离线模式。代码如下：

```swift
struct ContentView: View {
    @State private var isOfflineMode = false

    var body: some View {
        Toggle(isOn: $isOfflineMode) {
            Text("Offline Mode")
        }
        .toggleStyle(OfflineModeToggleStyle(systemImage: isOfflineMode ? "wifi.slash" : "wifi", activeColor: .blue))
    }
}

struct OfflineModeToggleStyle: ToggleStyle {
    var systemImage: String
    var activeColor: Color

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? activeColor : Color(.systemGray5))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(2)
                        .overlay {
                            Image(systemName: systemImage)
                                .foregroundColor(configuration.isOn ? activeColor : Color(.systemGray5))
                        }
                        .offset(x: configuration.isOn ? 8 : -8)
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
```

以上代码中，我们定义了一个 OfflineModeToggleStyle，它接受两个参数：systemImage 和 activeColor。systemImage 是一个字符串，表示图像的系统名称。activeColor 是一个颜色，表示激活状态的颜色。

## 动画化的 Toggle

以下是一个自定义的切换按钮 MuteToggleStyle。这个切换按钮允许用户控制是否开启静音模式。

```swift
struct ContentView: View {
    @State private var isMuted = false

    var body: some View {
        VStack {
            Toggle(isOn: $isMuted) {
                Text("Mute Mode")
                    .foregroundColor(isMuted ? .white : .black)
            }
            .toggleStyle(MuteToggleStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MuteToggleStyle: ToggleStyle {
    var onImage = "speaker.slash.fill"
    var offImage = "speaker.2.fill"

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? Color(.systemGray6) : .yellow)
                .overlay {
                    Image(systemName: configuration.isOn ? onImage : offImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding(5)
                        .rotationEffect(.degrees(configuration.isOn ? 0 : 180))
                        .offset(x: configuration.isOn ? 10 : -10)
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

extension ToggleStyle where Self == MuteToggleStyle {
    static var mute: MuteToggleStyle { .init() }
}
```

以上代码中，我们定义了一个 MuteToggleStyle，它接受两个参数：onImage 和 offImage。onImage 是一个字符串，表示激活状态的图像的系统名称。offImage 是一个字符串，表示非激活状态的图像的系统名称。

## 两个标签的 Toggle

以下是一个自定义的切换按钮，它有两个标签。这个切换按钮允许用户控制是否开启静音模式。

```swift
Toggle(isOn: $mute) {
  Text("静音")
  Text("这将关闭所有声音")
}
```

