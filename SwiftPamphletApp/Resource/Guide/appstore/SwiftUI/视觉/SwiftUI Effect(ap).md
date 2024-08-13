![](https://ming1016.github.io/qdimg/240505/swiftuieffect-ap01.jpeg)

```swift
struct PlayEffect: View {
    @State private var isHover = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .black, .pink], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // 材质
                Text("材质效果")
                    .font(.system(size:30))
                    .padding(isHover ? 40 : 30)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .onHover { b in
                        withAnimation {
                            isHover = b
                        }
                    }
                
                // 模糊
                Text("模糊效果")
                    .font(.system(size: 30))
                    .padding(30)
                    .background {
                        Color.black.blur(radius: 8, opaque: false)
                    }
                
                // 选择
                Text("3D 旋转")
                    .font(.largeTitle)
                    .rotation3DEffect(Angle(degrees: 45), axis: (x: 0, y: 20, z: 0))
                    .scaleEffect(1.5)
                    .blendMode(.hardLight)
                    .blur(radius: 3)
                
            }
                
        }
    }
}
```

材质厚度从低到高有：

* .regularMaterial
* .thinMaterial
* .ultraThinMaterial
* .thickMaterial
* .ultraThickMaterial

Gradient 和 Shadow 的 2022 的更新

下面是个简单示例：
```swift
struct PGradientAndShadow: View {
    var body: some View {
        Image(systemName: "bird")
            .frame(width: 150, height: 150)
            .background(in: Rectangle())
            .backgroundStyle(.cyan.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1, y: 3.0)))
            .font(.system(size: 60))
    }
}
```

Paul Hudson 使用 Core Motion 做了一个阴影随设备倾斜而变化的效果，非常棒，[How to use inner shadows to simulate depth with SwiftUI and Core Motion](https://www.hackingwithswift.com/articles/253/how-to-use-inner-shadows-to-simulate-depth-with-swiftui-and-core-motion) 。


