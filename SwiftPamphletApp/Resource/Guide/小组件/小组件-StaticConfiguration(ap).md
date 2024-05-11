
在 Xcode 中，File -> New -> Target，选择 Widget Extension

```swift
import WidgetKit
import SwiftUI

// Timeline Entry
struct ArticleEntry: TimelineEntry {
    let date: Date
    let title: String
}

// Widget View
struct ArticleWidgetView : View {
    let entry: ArticleEntry

    var body: some View {
        Text(entry.title)
    }
}

// Timeline Provider
struct ArticleTimelineProvider: TimelineProvider {
    typealias Entry = ArticleEntry
    
    func placeholder(in context: Context) -> Entry {
        // 占位大小，内容不会显示
        return ArticleEntry(date: Date(), title: "Placeholder")
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = ArticleEntry(date: Date(), title: "Snapshot")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = ArticleEntry(date: Date(), title: "Timeline")
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// Widget Configuration
@main
struct ArticleWidget: Widget {
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.starming.articleWidget",
            provider: ArticleTimelineProvider()
        ) { entry in
            ArticleWidgetView(entry: entry)
        }
        .configurationDisplayName("Article Widget")
        .description("这是一个 Article Widget.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
        ])
    }
}
```
