![](https://user-images.githubusercontent.com/251980/155062538-108a79b4-3e5c-417b-867a-3f7e58316664.png)

```swift
struct PlayButtonView: View {
    var asyncAction: () async -> Void = {
        do {
            try await Task.sleep(nanoseconds: 300_000_000)
        } catch {}
    }
    @State private var isFollowed: Bool = false
    var body: some View {
        VStack {
            // 常用方式
            Button {
                print("Clicked")
            } label: {
                Image(systemName: "ladybug.fill")
                Text("Report Bug")
            }

            // 图标
            Button(systemIconName: "ladybug.fill") {
                print("bug")
            }
            .buttonStyle(.plain) // 无背景
            .simultaneousGesture(LongPressGesture().onEnded({ _ in
                print("长按") // macOS 暂不支持
            }))
            .simultaneousGesture(TapGesture().onEnded({ _ in
                print("短按") // macOS 暂不支持
            }))
            
            
            // iOS 15 修改器的使用。role 在 macOS 上暂不支持
            Button("要删除了", role: .destructive) {
                print("删除")
            }
            .tint(.purple)
            .controlSize(.large) // .regular 是默认大小
            .buttonStyle(.borderedProminent) // borderedProminent 可显示 tint 的设置。还有 bordered、plain 和 borderless 可选。
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .accentColor(.pink)
            .buttonBorderShape(.automatic) // 会依据 controlSize 调整边框样式
            .background(.ultraThinMaterial, in: Capsule()) // 添加材质就像在视图和背景间加了个透明层达到模糊的效果。效果由高到底分别是.ultraThinMaterial、.thinMaterial、.regularMaterial、.thickMaterial、.ultraThickMaterial。
            
            // 风格化
            Button(action: {
                //
            }, label: {
                Text("风格化").font(.largeTitle)
            })
            .buttonStyle(PStarmingButtonStyle())
            
            
            // 自定义 Button
            PCustomButton("点一下触发") {
                print("Clicked!")
            }
            
            // 自定义 ButtonStyle
            Button {
                print("Double Clicked!")
            } label: {
                Text("点两下触发")
            }
            .buttonStyle(PCustomPrimitiveButtonStyle())

            // 将 Text 视图加上另一个 Text 视图中，类型仍还是 Text。
            PCustomButton(Text("点我 ").underline() + Text("别犹豫").font(.title) + Text("🤫悄悄说声，有惊喜").font(.footnote).foregroundColor(.secondary)) {
                print("多 Text 组合标题按钮点击！")
            }
            
            // 异步按钮
            ButtonAsync {
                await asyncAction()
                isFollowed = true
            } label: {
                if isFollowed == true {
                    Text("已关注")
                } else {
                    Text("关注")
                }
            }
            .font(.largeTitle)
            .disabled(isFollowed)
            .buttonStyle(PCustomButtonStyle(backgroundColor: isFollowed == true ? .gray : .pink))
        }
        .padding()
        .background(Color.skeumorphismBG)
        
    }
}

// MARK: - 异步操作的按钮
struct ButtonAsync<Label: View>: View {
    var doAsync: () async -> Void
    @ViewBuilder var label: () -> Label
    @State private var isRunning = false // 避免连续点击造成重复执行事件
    
    var body: some View {
        Button {
            isRunning = true
            Task {
                await doAsync()
                isRunning = false
            }
        } label: {
            label().opacity(isRunning == true ? 0 : 1)
            if isRunning == true {
                ProgressView()
            }
        }
        .disabled(isRunning)

    }
}

// MARK: - 扩展 Button
// 使用 SFSymbol 做图标
extension Button where Label == Image {
    init(systemIconName: String, done: @escaping () -> Void) {
        self.init(action: done) {
            Image(systemName: systemIconName)
                .renderingMode(.original)
        }
    }
}

// MARK: - 自定义 Button
struct PCustomButton: View {
    let desTextView: Text
    let act: () -> Void
    
    init(_ des: LocalizedStringKey, act: @escaping () -> Void) {
        self.desTextView = Text(des)
        self.act = act
    }
    
    var body: some View {
        Button {
            act()
        } label: {
            desTextView.bold()
        }
        .buttonStyle(.starming)
    }
}

extension PCustomButton {
    init(_ desTextView: Text, act: @escaping () -> Void) {
        self.desTextView = desTextView
        self.act = act
    }
}

// 点语法使用自定义样式
extension ButtonStyle where Self == PCustomButtonStyle {
    static var starming: PCustomButtonStyle {
        PCustomButtonStyle(cornerRadius: 15)
    }
}


// MARK: - ButtonStyle
struct PCustomButtonStyle: ButtonStyle {
    var cornerRadius:Double = 10
    var backgroundColor: Color = .pink
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(backgroundColor)
                .shadow(color: configuration.isPressed ? .white : .black, radius: 1, x: 0, y: 1)
        )
        .opacity(configuration.isPressed ? 0.5 : 1)
        .scaleEffect(configuration.isPressed ? 0.99 : 1)
        
    }
}

// MARK: - PrimitiveButtonStyle
struct PCustomPrimitiveButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 双击触发
        configuration.label
            .onTapGesture(count: 2) {
                configuration.trigger()
            }
        // 手势识别
        Button(configuration)
            .gesture(
                LongPressGesture()
                    .onEnded({ _ in
                        configuration.trigger()
                    })
            )
    }
}

// MARK: - 风格化
struct PStarmingButtonStyle: ButtonStyle {
    var backgroundColor = Color.skeumorphismBG
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .padding(20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .shadow(color: .white, radius: configuration.isPressed ? 7 : 10, x: configuration.isPressed ? -5 : -10, y: configuration.isPressed ? -5 : -10)
                    .shadow(color: .black, radius: configuration.isPressed ? 7 : 10, x: configuration.isPressed ? 5 : 10, y: configuration.isPressed ? 5 : 10)
                    .blendMode(.overlay)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(backgroundColor)
            }
        )
        .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

extension Color {
    static let skeumorphismBG = Color(hex: "f0f0f3")
}

extension Color {
    init(hex: String) {
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
```

`.buttonStyle` 可组合，示例如下：
```swift
struct PButtonStyleComposition: View {
    @State private var isT = false
    var body: some View {
        Section("标签") {
            VStack(alignment: .leading) {
                HStack {
                    Toggle("Swift", isOn: $isT)
                    Toggle("SwiftUI", isOn: $isT)
                }
                HStack {
                    Toggle("Swift Chart", isOn: $isT)
                    Toggle("Navigation API", isOn: $isT)
                }
            }
            .toggleStyle(.button)
            .buttonStyle(.bordered)
        }
    }
}
```

Tap Location 可以获取点击的位置，示例代码如下：
```swift
Rectangle()
    .fill(.green)
    .frame(width: 50, height: 50)
    .onTapGesture(coordinateSpace: .global) { location in
        print("Tap in \(location)")
    }
```

其中 coordinateSpace 指定为 `.global` 表示位置是相对屏幕左上角，默认是相对当前视图的左上角的位置。
