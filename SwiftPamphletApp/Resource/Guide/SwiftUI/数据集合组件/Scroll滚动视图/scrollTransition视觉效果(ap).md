

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


