
AppIntentConfiguration 需要 AppIntentTimelineProvider，AppIntentTimelineProvider 需要实现 `snapshot`、`placeholder` 和 `timeline` 三个方法来确定小组件在展示和实际运行时间线时的视图和数据。

```swift
struct ArticleIntentProvider: AppIntentTimelineProvider {

    func snapshot(for configuration: ArticleIntent, in context: Context) async -> ArticleEntry {
        return .init(
            date: Date(),
            author: "snapshot"
        )
    }

    func placeholder(in context: Context) -> ArticleEntry {
        return .init(
            date: Date(),
            author: "某人"
        )
    }

    func timeline(for configuration: ArticleIntent, in context: Context) async -> Timeline<ArticleEntry> {
        return Timeline(
            entries: [
                .init(date: Date(),
                      author: configuration.author,
                      rate: await ArticleStore().rate())],
            policy: .never)
    }
}

struct ArticleEntry: TimelineEntry {
    let date: Date
    let author: String
    var rate: Int = 0
    //...
}
````
