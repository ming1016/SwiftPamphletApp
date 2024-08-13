
## 基本元素样式

通过 `.font(.title)` 设置字体大小。

`.stroke(Color.blue)` 设置描边。举个例子：

```swift
struct ContentView: View {

    var body: some View {
        Rectangle()
            .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: [30]))
            .padding(30)
    }
}
```

`StrokeStyle(lineWidth: 10, lineCap: .round, dash: [30])` 定义了描边的样式，其中 `lineWidth: 10` 表示线宽为 10，`lineCap: .round` 表示线帽样式为圆形，`dash: [30]` 表示虚线模式，数组中的数字表示虚线和间隙的交替长度。

## frame

`.frame(width: 200, height:100, alignment: .topLeading)`

- `width: 200` 表示视图的宽度为 200 点。
- `height: 100` 表示视图的高度为 100 点。
- `alignment: .topLeading` 表示视图的内容应该在视图的左上角对齐。`.topLeading` 是 SwiftUI 中的一个对齐方式，表示左上角对齐。

## Stack

多个视图通过 Stack 视图进行对齐排列。这些 Stack 视图主要是：
 
 - ZStack：Z轴排列
 - VStack：垂直排列
 - HStack：横向排列
 
 ## 间隔
 
 视图之间的间隔可以用 Space()，它可以在各种布局视图中使用。
 
 


