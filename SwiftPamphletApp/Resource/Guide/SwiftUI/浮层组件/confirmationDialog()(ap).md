
在 SwiftUI 中，`confirmationDialog()` 是一个用于显示确认对话框的修饰符。支持 iOS 15 或更高版本，也适用于 macOS。以下是一个使用 `confirmationDialog()` 的例子

```swift
import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false

    var body: some View {
        Button("删除漫画") {
            showingConfirmation = true
        }
        .confirmationDialog("确定要删除这部漫画吗？", 
                            isPresented: $showingConfirmation,
                            titleVisibility: .hidden
        ) {
            Button("删除", role: .destructive) {
                print("漫画已删除")
            }
            .keyboardShortcut(.defaultAction) // 确保始终会在顶部
            Button("取消", role: .cancel) {
                print("取消删除")
            }
        } message: {
            Text("删除操作无法恢复，你确定继续删除么？")
        }
    }
}
```

使用 `.dialogSuppressionToggle(isSuppressed: $isSuppressed)` 能够在 macOS 上添加一个复选框，允许用户选择不再显示确认对话框。


