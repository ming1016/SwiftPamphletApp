

## shadow

卡片阴影效果

```swift
.shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0, y: 0)
```

## `.shadow(.drop(radius:` 前景阴影

```swift
struct ContentView: View {
    var body: some View {
        Image(systemName: "film")
            .frame(width: 200, height: 200)
            .background(Color.mint)
            .foregroundStyle(Color.white.shadow(.drop(radius: 1, y: 2.0)))
            .font(.system(size: 80))
            .overlay {
                VStack {
                    Spacer()
                    Text("电影")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white.shadow(.drop(radius: 1, y: 2.0)))
                        .padding()
                }
            }
    }
}
```

以上代码中，我们使用了 `shadow(.drop(radius: y:))` 修饰符为图像和文本添加了阴影效果。这个修饰符接受两个参数：`radius` 和 `y`。`radius` 参数控制阴影的模糊半径，`y` 参数控制阴影的偏移量。


## 多重阴影，发光效果

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
            Image(systemName: "film")
                .frame(width: 200, height: 200)
                .background(Color.mint)
                .foregroundStyle(Color.white.shadow(.drop(radius: 2, y: 4.0)))
                .shadow(color: .white.opacity(0.3), radius: 100)
                .shadow(color: .white.opacity(0.5), radius: 80)
                .shadow(color: .white.opacity(0.6), radius: 30)
                .shadow(color: .white.opacity(0.7), radius: 10)
                .font(.system(size: 80))
                .overlay {
                    VStack {
                        Spacer()
                        Text("电影")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white.shadow(.drop(radius: 2, y: 4.0)))
                            .padding()
                    }
                }
        }
    }
}
```

