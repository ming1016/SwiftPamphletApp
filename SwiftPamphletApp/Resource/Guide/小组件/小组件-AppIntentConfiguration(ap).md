

iOS 17 开始可以使用 AppIntentConfiguration 来配置小组件

```swift
import SwiftUI
import WidgetKit
import AppIntents

struct ArticleWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: "com.starming.articleWidget",
            intent: ArticleIntent.self,
            provider: ArticleIntentProvider()
        ) { entry in
            ArticleWidgetView(entry: entry)
        }
        .configurationDisplayName("Article Widget")
        .description("这是一个 Article Widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct ArticleWidgetView: View {
    var entry: IntentProvider.Entry
    var body: some View {
        Text(entry.author)
    }
}

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

// 放在主应用中和小组件交互
struct ArticleIntent: WidgetConfigurationIntent {
    
    static var title: LocalizedStringResource  = "文章"
    var author: String = "某某某"

    func perform() async throws -> some IntentResult {
        //...
        return .result()
    }
}

class ArticleStore {
    //... SwiftData 相关配置
    @MainActor
    func rate() async -> Int {
        //... 获取
        return 5
    }
}
```
