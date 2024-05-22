

`.popover` 是一个用于显示弹出视图的修饰符。以下是一个使用 `.popover` 的例子

```swift
import SwiftUI

struct ContentView: View {
    @State private var showPopover = false

    var body: some View {
        Button("显示漫画详情") {
            showPopover = true
        }
        .popover(isPresented: $showPopover,
                 attachmentAnchor: .point(.bottom),
                 arrowEdge: .bottom
        ) {
            VStack {
                Text("漫画标题")
                    .font(.title)
                Text("漫画详情")
                    .font(.body)
                Button("关闭") {
                    showPopover = false
                }
                .padding()
            }
            .padding()
            .presentationCompactAdaptation(.popover)
        }
    }
}
```

代码中 `PresentationAdaptation` 的可选值：

- `automatic`：默认适配方式
- `none`：不进行尺寸等级适应
- `popover`：优先使用弹出视图
- `sheet`：优先使用工作表，适用于调整大小类（如 iPhone 默认）
- `fullScreenCover`：优先使用全屏覆盖视图


