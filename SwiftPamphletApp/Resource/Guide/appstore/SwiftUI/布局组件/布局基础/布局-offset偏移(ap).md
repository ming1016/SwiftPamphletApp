


```swift
struct OffsetDemo: View {
    @State var offset: CGFloat = 0
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .offset(y: offset)
            Slider(value: $offset, in: -100...100)
                .padding()
        }
    }
}
```

我们创建了一个 `Text` 视图和一个 `Slider`。`Text` 视图使用了 `.offset(y: offset)` 修饰符，这意味着它的 y 偏移量会根据 `offset` 的值改变。`Slider` 则用于改变 `offset` 的值。当你移动滑块时，`Text` 视图的位置也会相应地上下移动。
