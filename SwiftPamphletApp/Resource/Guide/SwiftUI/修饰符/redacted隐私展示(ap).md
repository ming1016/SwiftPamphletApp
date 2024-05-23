
## `.privacySensitive`

使用 .privacySensitive 修饰符，可以在锁屏时隐藏隐私信息，例如电话号码、电子邮件地址等。这样可以保护用户的隐私信息，避免在锁屏时泄露用户的隐私信息。

## `.redacted()`

`.redacted()` 是一个修饰符，用于将视图的内容替换为占位符。这在加载数据时显示占位符，或者在隐私敏感的情况下隐藏数据特别有用。

假设我们有一个显示电影海报的视图，当海报图片正在加载时，我们可以使用 `.redacted()` 修饰符来显示占位符：

```swift
struct MoviePosterView: View {
    @State private var isLoading = true
    var body: some View {
        Image("movie_poster")
            .resizable()
            .scaledToFit()
            .redacted(reason: isLoading ? .placeholder : [])
    }
}
```

在这个例子中，当 `isLoading` 为 `true` 时，图片视图的内容将被替换为占位符。当海报图片加载完成，你可以将 `isLoading` 设置为 `false`，这将移除占位符并显示实际的图片。

你也可以使用 `.redacted()` 修饰符来隐藏隐私敏感的数据。例如，你可能有一个显示电影演员的视图，但在某些情况下，你希望隐藏这个信息：

```swift
struct MovieActorView: View {
    @State private var isPrivacyMode = true
    var body: some View {
        Text("Movie Actor")
            .redacted(reason: isPrivacyMode ? .placeholder : [])
    }
}
```

在这个例子中，当 `isPrivacyMode` 为 `true` 时，文本视图的内容将被替换为占位符，从而隐藏电影演员的名字。当隐私模式关闭，你可以将 `isPrivacyMode` 设置为 `false`，这将移除占位符并显示电影演员的名字。
