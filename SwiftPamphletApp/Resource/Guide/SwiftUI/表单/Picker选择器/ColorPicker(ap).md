

`ColorPicker` 是一个允许用户选择颜色的视图。以下是一个 `ColorPicker` 的使用示例：

```swift
import SwiftUI

struct ContentView: View {
    @State private var selectedColor = Color.white

    var body: some View {
        VStack {
            ColorPicker("选择一个颜色", selection: $selectedColor)
            Text("你选择的颜色")
                .foregroundColor(selectedColor)
        }
    }
}
```

在这个示例中，我们创建了一个 `ColorPicker` 视图，用户可以通过这个视图选择一个颜色。我们使用 `@State` 属性包装器来创建一个可以绑定到 `ColorPicker` 的 `selectedColor` 状态。当用户选择一个新的颜色时，`selectedColor` 状态会自动更新，`Text` 视图的前景色也会相应地更新。

