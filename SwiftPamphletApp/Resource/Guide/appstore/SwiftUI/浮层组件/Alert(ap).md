
`.alert` 是一个用于显示警告对话框的修饰符。以下是一个使用 `.alert` 的例子

```swift
struct ContentView: View {
    @State private var showAlert = false
    @State private var authCode = ""

    var body: some View {
        Button("删除漫画") {
            showAlert = true
        }
        .alert("确定要删除这部漫画吗？", isPresented: $showAlert) {
            Button("删除", role: .destructive) {
                print("漫画已删除")
            }
            Button("取消", role: .cancel) {
                print("取消删除")
            }
            TextField("enter", text: $authCode)
        } message: {
            Text("请输入验证码？")
        }
    }
}
```

