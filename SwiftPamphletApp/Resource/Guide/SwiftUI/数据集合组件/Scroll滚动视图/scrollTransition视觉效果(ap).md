

iOS 17 新推出 `.scrollTransition`，用于处理滚动时的动画。

`.transition` 用于视图插入和移除视图树时的动画。

`.scrollTransition` 会和滚动联合起来进行平滑的过渡动画处理。`.scrollTransition` 可以修改很多属性，比如大小，可见性还有旋转等。

`.scrollTransition` 可以针对不同阶段进行处理，目前有三个阶段：

- `topLeading`: 视图进入 ScrollView 可见区域
- `identity`: 在可见区域中
- `bottomTrailing`: 视图离开 ScrollView 可见区域

```swift
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0...20, id: \.self) { i in
                    colorView()
                        .frame(width: 300, height: 200)
                        .scrollTransition { content, phase in 
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.4)
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    func colorView() -> some View {
        [Color.red, Color.yellow, Color.blue, Color.mint, Color.indigo, Color.green].randomElement()
    }
}
```

使用阶段的值

```swift
.scrollTransition(.animated(.bouncy)) { content, phase in
    content
        .scaleEffect(phase.isIdentity ? 1 : phase.value)
}
```

比如在 ScrollView 中使用 `.scrollTransition` 时，可以使用 `topLeading` 和 `bottomTrailing` 两个阶段。下面的示例代码中，我们使用 `.scrollTransition` 为每个专辑封面添加了动画效果。

```swift
struct ContentView: View {
    enum ImageNames: String, CaseIterable {
        case speaknow, midnights, red, fearless, evermore, folklore, lover
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(ImageNames.allCases, id: \.self) { album in
                    albumImage(album: album)
                        .padding(.horizontal, 16)
                        .scrollTransition(
                            topLeading: .animated(.smooth),
                            bottomTrailing: .animated(.smooth),
                            axis: .vertical,
                            transition: { content, phase in
                                content
                                    .scaleEffect(1.0 - (abs(phase.value) * 0.05))
                                    .blur(radius: 2 * abs(phase.value))
                            })
                }
            }
        }
    }

    func albumImage(album: ImageNames) -> some View {
        Image(album.rawValue)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                Text(album.rawValue.capitalized)
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3, x: 0, y: 0),
                alignment: .bottom
            )
    }
}
```

以上代码中，我们使用了 `.scrollTransition` 为每个专辑封面添加了动画效果。在 `topLeading` 阶段，我们使用了 `.animated(.smooth)` 动画效果，使专辑封面在进入可见区域时平滑放大。在 `bottomTrailing` 阶段，我们使用了 `.animated(.smooth)` 动画效果，使专辑封面在离开可见区域时平滑缩小。

不同阶段的产生效果设置

```swift
.scrollTransition(
    topLeading: .animated,
    bottomTrailing: .interactive
) { content, phase in
    content.rotationEffect(.radians(phase.value))
}
```

`.rotation3DEffect` 也是支持的。

```swift
.scrollTransition(.interactive) { content, phase in
    content
        .rotation3DEffect(
            Angle.degrees(phase.isIdentity ? 0: 120),
            axis: (x: 0.9, y: 0.0, z: 0.1))
        .offset(x: phase.value * -300)
}
```


