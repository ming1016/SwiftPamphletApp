
在 TimelineProvider 中的 timeline 方法中加入请求逻辑

```swift
func timeline(for configuration: RunIntent, in context: Context) -> Void) async -> Timeline<ArticleEntry> {
    guard let article = try? await ArticleFetch.fetchNewestArticle() else {
        return
    }
    let entry = ArticleEntry(date: Date(), article: article)
    
    // 下次在 30 分钟后再请求
    let afterDate = Calendar.current.date(byAdding: DateComponents(minute: 30), to: Date())!
    return Timeline(entries: [entry], policy: .after(afterDate))
}
```


