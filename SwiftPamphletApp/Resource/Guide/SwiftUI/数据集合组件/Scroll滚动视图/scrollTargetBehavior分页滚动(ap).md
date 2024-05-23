
## 按可视尺寸分页

`.scrollTargetBehavior(.paging)` 可以让 ScrollView 滚动，滚动一页的范围是 ScrollView 的可视尺寸。
 
```swift
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0...20, id: \.self) { i in
                    colorView()
                        .frame(width: 300, height: 200)
                }
            }
        }
        .scrollTargetBehavior(.paging)
    }
    
    @ViewBuilder
    func colorView() -> some View {
        [Color.red, Color.yellow, Color.blue, Color.mint, Color.indigo, Color.green].randomElement()
    }
}
```

## 按容器元素对齐分页

使用 `.scrollTargetBehavior(.viewAligned)` 配合 scrollTargetLayout。示例代码如下：

```swift
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0...20, id: \.self) { i in
                    colorView()
                        .frame(width: 300, height: 200)
                }
            }
            .scrollTargetLayout(isEnabled: true)
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    @ViewBuilder
    func colorView() -> some View {
        [Color.red, Color.yellow, Color.blue, Color.mint, Color.indigo, Color.green].randomElement()
    }
}
```

## containerRelativeFrame 控制划动单元显示范围

containerRelativeFrame 可以控制划动单元显示范围，可以控制单个内容一页，也可以控制多个内容一页。

以下是 containerRelativeFrame 的使用示例：

```swift
struct ContentView: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10.0) {
                ForEach(0...20, id: \.self) { _ in
                    Image("evermore")
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal, count: 4, span: 3, spacing: 8)
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .safeAreaPadding(.horizontal, 20.0)
    }
}
```

以上代码中，我们使用 containerRelativeFrame 修饰符，将每个 Image 视图的宽度设置为容器宽度的 3/4。我们还设置了每个 Image 视图之间的间距为 8 点。






