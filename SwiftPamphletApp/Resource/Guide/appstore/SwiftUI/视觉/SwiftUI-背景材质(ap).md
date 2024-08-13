
背景材质使用例子

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Image("evermore")
            Text("电影标题")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
    }
}
```

材质厚度从低到高：

- .ultraThinMaterial
- .thinMaterial
- .regularMaterial
- .bar
- .thickMaterial
- .ultraThickMaterial

下面例子可以直观看到效果

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.indigo.gradient)
            VStack {
                Text("材质").font(.largeTitle).padding()
                    .background(.ultraThinMaterial)
                Text("材质").font(.largeTitle).padding()
                    .background(.thinMaterial)
                Text("材质").font(.largeTitle).padding()
                    .background(.regularMaterial)
                Text("材质").font(.largeTitle).padding()
                    .background(.bar)
                Text("材质").font(.largeTitle).padding()
                    .background(.thickMaterial)
                Text("材质").font(.largeTitle).padding()
                    .background(.ultraThickMaterial)
            }
        }
    }
}
```

可以通过 opacity 和 brightness 来达成一些和背景融合的效果

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.indigo.gradient)
            VStack {
                Text("融合效果").font(.largeTitle).padding()
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.black)
                            .opacity(0.25)
                            .brightness(-0.4)
                    }
            }
        }
    }
}
```

