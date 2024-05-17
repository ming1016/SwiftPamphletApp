

`Stepper` 控件允许用户通过点击按钮来增加或减少数值。

```swift
struct ContentView: View {
    @State private var count: Int = 2
    var body: some View {
        Stepper(value: $count, in: 2...20, step: 2) {
            Text("共\(count)")
        } onEditingChanged: { b in
            print(b)
        } // end Stepper
    }
}
```

在 `ContentView` 中，我们定义了一个状态变量 `count`，并将其初始化为 2。然后，我们创建了一个 `Stepper` 视图，并将其绑定到 `count` 状态变量。

`Stepper` 视图的值范围为 2 到 20，步进值为 2，这意味着每次点击按钮，`count` 的值会增加或减少 2。我们还添加了一个标签，显示当前的 `count` 值。

我们还添加了 `onEditingChanged` 回调，当 `Stepper` 的值改变时，会打印出一个布尔值，表示 `Stepper` 是否正在被编辑。
