
HUD 是 Heads-Up Display 的缩写，翻译为中文是"平视显示器"。在编程中，HUD 通常指的是一种特殊的视图或窗口，它会浮动在应用程序的主界面之上，用于显示某些重要的、临时的信息，比如加载状态、提示信息等。

在 SwiftUI 中，创建一个自定义的 HUD 可以通过创建一个新的 View 来实现。以下是一个简单的 HUD 示例：

```swift
struct HUDView: View {
    var body: some View {
        ZStack {
            VStack {
                ProgressView()
                Text("加载中...")
                    .padding(.top, 20)
            }
            .foregroundColor(.white)
            .frame(width: 120, height: 120)
            .background(Color.indigo)
            .cornerRadius(16)
        }
    }
}

struct ContentView: View {
    @State private var showHUD = false

    var body: some View {
        VStack {
            Button("显示 HUD") {
                showHUD = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showHUD = false
                }
            }
        }
        .overlay(showHUD ? HUDView() : nil)
    }
}
```

在这个例子中，我们创建了一个 `HUDView` 视图，它包含一个 `ProgressView` 和一个 `Text`。我们还创建了一个 `ContentView` 视图，其中包含一个按钮，当点击按钮时，会显示 `HUDView`。通过 `DispatchQueue.main.asyncAfter` 方法，我们在 2 秒后隐藏 `HUDView`。