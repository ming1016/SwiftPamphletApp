
Environment 协议包括：

- `EnvironmentKey`
- `EnvironmentalModifier`

在 SwiftUI 中，`Environment` 是一个属性包装器，它允许我们从视图层次结构的环境中获取值。这些值可以是系统设置，如用户界面样式，或者是我们自定义的环境值。

例如，我们可以创建一个视图，它使用 `@Environment` 属性包装器来获取当前的用户界面样式，并根据这个样式来显示不同的漫画：

```swift
struct ComicView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if colorScheme == .dark {
            Text("显示暗黑模式的漫画")
        } else {
            Text("显示普通模式的漫画")
        }
    }
}
```

在这个例子中，`ComicView` 是一个自定义的视图，它使用 `@Environment` 属性包装器来获取当前的用户界面样式。如果样式是暗黑模式，它显示一条表示暗黑模式的漫画的文本；否则，它显示一条表示普通模式的漫画的文本。

注意：`\.colorScheme` 是一个 `EnvironmentKey`，它表示用户界面样式的环境值。我们可以使用 `@Environment` 属性包装器来获取这个值。

另外，`EnvironmentalModifier` 是一个协议，它定义了一个可以修改环境值的修饰符。例如，我们可以创建一个修饰符，它将用户界面样式设置为暗黑模式：

```swift
struct DarkModeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content.environment(\.colorScheme, .dark)
    }
}
```

然后，我们可以使用这个修饰符来修改我们的 `ComicView`：

```swift
ComicView()
    .modifier(DarkModeModifier())
```

在这个例子中，`DarkModeModifier` 是一个自定义的修饰符，它使用 `@Environment` 属性包装器来获取当前的用户界面样式，然后使用 `.environment()` 修饰符将样式设置为暗黑模式。
