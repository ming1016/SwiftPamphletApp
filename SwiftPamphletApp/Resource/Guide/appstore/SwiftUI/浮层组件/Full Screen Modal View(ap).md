
`fullScreenCover` 是一个非常有用的修饰符，它可以让你全屏显示一个视图。以下是一个使用 `fullScreenCover` 的例子

```swift
import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Text("显示电影详情")
        }
        .fullScreenCover(isPresented: $isPresented) {
            MovieDetailView()
        }
    }
}

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("电影标题")
                .font(.largeTitle)
            Text("电影详情")
                .font(.body)
            Button(action: {
                // Dismiss the view
                dismiss()
            }) {
                Text("关闭")
            }
        }
    }
}
```

在这个例子中，我们创建了一个 `ContentView` 视图，其中包含一个按钮。当用户点击这个按钮时，我们将 `isPresented` 设置为 `true`，这将触发 `fullScreenCover` 并显示 `MovieDetailView` 视图。在 `MovieDetailView` 视图中，我们显示电影的标题和详情，以及一个可以关闭视图的按钮。

