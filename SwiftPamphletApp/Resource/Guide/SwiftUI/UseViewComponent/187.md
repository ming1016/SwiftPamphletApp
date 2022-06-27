Transferable 协议使数据可以用于剪切板、拖放和 Share Sheet。

可以在自己应用程序之间或你的应用和其他应用之间发送或接受可传输项目。

支持 SwiftUI 来使用。

官方文档 [Core Transferable](https://developer.apple.com/documentation/CoreTransferable)

session [Meet Transferable](https://developer.apple.com/videos/play/wwdc2022-10062)

新增一个专门用来接受 Transferable 的按钮视图 PasteButton，使用示例如下：
```swift
struct PPasteButton: View {
    @State private var s = "戴铭"
    var body: some View {
        TextField("输入", text: $s)
            .textFieldStyle(.roundedBorder)
        PasteButton(payloadType: String.self) { str in
            guard let first = str.first else { return }
            s = first
        }
    }
}
```

