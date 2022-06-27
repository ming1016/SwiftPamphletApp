ShareLink 视图可以让你轻松共享数据。示例代码如下：
```swift
struct PShareLink: View {
    let url = URL(string: "https://ming1016.github.io/")!
    var body: some View {
        ShareLink(item: url, message: Text("戴铭的博客"))
        ShareLink("戴铭的博客", item: url)
        ShareLink(item: url) {
            Label("戴铭的博客", systemImage: "swift")
        }
    }
}
```

