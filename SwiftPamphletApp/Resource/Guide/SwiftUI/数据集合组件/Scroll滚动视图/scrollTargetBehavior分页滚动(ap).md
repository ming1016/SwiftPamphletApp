
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




