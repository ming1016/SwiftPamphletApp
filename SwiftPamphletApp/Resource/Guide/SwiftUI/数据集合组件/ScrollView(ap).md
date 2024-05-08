
## 新增 modifier

```swift
ScrollView {
    ForEach(0..<300) { i in
        Text("\(i)")
            .id(i)
    }
}
.scrollDisabled(false) // 设置是否可滚动
.scrollDismissesKeyboard(.interactively) // 关闭键盘
.scrollIndicators(.visible) // 设置滚动指示器是否可见
```

## ScrollViewReader

ScrollView 使用 scrollTo 可以直接滚动到指定的位置。ScrollView 还可以透出偏移量，利用偏移量可以定义自己的动态视图，比如向下向上滚动视图时有不同效果，到顶部显示标题视图等。

示例代码如下：

```swift
struct PlayScrollView: View {
    @State private var scrollOffset: CGFloat = .zero
    
    var infoView: some View {
        GeometryReader { g in
            Text("移动了 \(Double(scrollOffset).formatted(.number.precision(.fractionLength(1)).rounded()))")
                .padding()
        }
    }
    
    var body: some View {
        // 标准用法
        ScrollViewReader { s in
            ScrollView {
                ForEach(0..<300) { i in
                    Text("\(i)")
                        .id(i)
                }
            }
            Button("跳到150") {
                withAnimation {
                    s.scrollTo(150, anchor: .top)
                }
            } // end Button
        } // end ScrollViewReader
        
        // 自定义的 ScrollView 透出 offset 供使用
        ZStack {
            PCScrollView {
                ForEach(0..<100) { i in
                    Text("\(i)")
                }
            } whenMoved: { d in
                scrollOffset = d
            }
            infoView
            
        } // end ZStack
    } // end body
}

// MARK: - 自定义 ScrollView
struct PCScrollView<C: View>: View {
    let c: () -> C
    let whenMoved: (CGFloat) -> Void
    
    init(@ViewBuilder c: @escaping () -> C, whenMoved: @escaping (CGFloat) -> Void) {
        self.c = c
        self.whenMoved = whenMoved
    }
    
    var offsetReader: some View {
        GeometryReader { g in
            Color.clear
                .preference(key: OffsetPreferenceKey.self, value: g.frame(in: .named("frameLayer")).minY)
        }
        .frame(height:0)
    }
    
    var body: some View {
        ScrollView {
            offsetReader
            c()
                .padding(.top, -8)
        }
        .coordinateSpace(name: "frameLayer")
        .onPreferenceChange(OffsetPreferenceKey.self, perform: whenMoved)
    } // end body
}

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
```

## 滚动到顶部

在 SwiftUI 中，目前没有直接的方法可以让 List 滚动到顶部。但你可以使用 ScrollViewReader 和 scrollTo 方法来实现滚动到顶部的功能。以下是一个例子：

```swift
struct ContentView: View {
    let items = Array(1...100) // 你的数据
    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView {
                    ForEach(items, id: \.self) { item in
                        Text("Item \(item)")
                    }
                    .id(items.first) // 给第一个元素设置 id
                }
                Button("滚动到顶部") {
                    withAnimation {
                        scrollView.scrollTo(items.first, anchor: .top) // 滚动到第一个元素
                    }
                }
            }
        }
    }
}
```
