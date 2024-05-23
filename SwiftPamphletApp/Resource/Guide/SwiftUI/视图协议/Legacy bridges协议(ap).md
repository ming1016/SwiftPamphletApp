
Legacy bridges 协议包括：

- `UIViewControllerRepresentable` (iOS)
- `UIViewRepresentable` (iOS)
- `NSViewControllerRepresentable` (macOS)
- `NSViewRepresentable` (macOS)
- `WKInterfaceObjectRepresentable` (watchOS)

Legacy bridges 协议允许我们在 SwiftUI 视图中使用 UIKit（iOS）、AppKit（macOS）或 WatchKit（watchOS）的视图和视图控制器。这些协议包括：

- `UIViewControllerRepresentable`：这个协议允许我们在 SwiftUI 视图中使用 UIKit 的视图控制器。例如，我们可以创建一个表示漫画的 `UIViewController`，然后在 SwiftUI 视图中显示它：

```swift
struct ComicViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // 更新视图控制器
    }
}
```

- `UIViewRepresentable`：这个协议允许我们在 SwiftUI 视图中使用 UIKit 的视图。例如，我们可以创建一个表示漫画的 `UIView`，然后在 SwiftUI 视图中显示它：

```swift
struct ComicView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // 更新视图
    }
}
```

- `NSViewControllerRepresentable` 和 `NSViewRepresentable`：这些协议允许我们在 SwiftUI 视图中使用 AppKit 的视图和视图控制器。它们的使用方式与 `UIViewControllerRepresentable` 和 `UIViewRepresentable` 类似，但是它们是用于 macOS 的。

- `WKInterfaceObjectRepresentable`：这个协议允许我们在 SwiftUI 视图中使用 WatchKit 的界面对象。例如，我们可以创建一个表示漫画的 `WKInterfaceLabel`，然后在 SwiftUI 视图中显示它：

```swift
struct ComicLabel: WKInterfaceObjectRepresentable {
    func makeWKInterfaceObject(context: Context) -> WKInterfaceLabel {
        let label = WKInterfaceLabel()
        label.setText("漫画")
        return label
    }

    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceLabel, context: Context) {
        // 更新界面对象
    }
}
```

在这些例子中，我们创建了表示漫画的视图和视图控制器，然后使用 Legacy bridges 协议在 SwiftUI 视图中显示它们。
