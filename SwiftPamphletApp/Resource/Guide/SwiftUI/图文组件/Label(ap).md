![](https://ming1016.github.io/qdimg/240505/label-ap01.png)

```swift
struct PlayLabelView: View {
    var body: some View {
        VStack(spacing: 10) {
            Label("一个 Label", systemImage: "bolt.circle")
            
            Label("只显示 icon", systemImage: "heart.fill")
                .labelStyle(.iconOnly)
                .foregroundColor(.red)
            
            // 自建 Label
            Label {
                Text("自建 Label")
                    .foregroundColor(.orange)
                    .bold()
                    .font(.largeTitle)
                    .shadow(color: .black, radius: 1, x: 0, y: 2)
            } icon: {
                Image("p3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .shadow(color: .black, radius: 1, x: 0, y: 2)
            }

            
            // 自定义 LabelStyle
            Label("有边框的 Label", systemImage: "b.square.fill")
                .labelStyle(.border)
            
            Label("仅标题有边框", systemImage: "text.bubble")
                .labelStyle(.borderOnlyTitle)
            
            // 扩展的 Label
            Label("扩展的 Label", originalSystemImage: "cloud.sun.bolt.fill")
            
        } // end VStack
    } // end body
}

// 对 Label 做扩展
extension Label where Title == Text, Icon == Image {
    init(_ title: LocalizedStringKey, originalSystemImage systemImageString: String) {
        self.init {
            Text(title)
        } icon: {
            Image(systemName: systemImageString)
                .renderingMode(.original) // 让 SFSymbol 显示本身的颜色
        }

    }
}

// 添加自定义 LabelStyle，用来加上边框
struct BorderLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.purple, lineWidth: 4))
            .shadow(color: .black, radius: 4, x: 0, y: 5)
            .labelStyle(.automatic) // 样式擦除器，防止样式被 .iconOnly、.titleOnly 这样的 LabelStyle 擦除了样式。
                        
    }
}
extension LabelStyle where Self == BorderLabelStyle {
    internal static var border: BorderLabelStyle {
        BorderLabelStyle()
    }
}

// 只给标题加边框
struct BorderOnlyTitleLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(.pink, lineWidth: 4))
                .shadow(color: .black, radius: 1, x: 0, y: 1)
                .labelStyle(.automatic)
        }
    }
}
extension LabelStyle where Self == BorderOnlyTitleLabelStyle {
    internal static var borderOnlyTitle: BorderOnlyTitleLabelStyle {
        BorderOnlyTitleLabelStyle()
    }
}
```
