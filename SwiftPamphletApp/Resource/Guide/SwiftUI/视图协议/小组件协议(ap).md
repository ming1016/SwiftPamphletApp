

小组件包括

- `Widget`
- `WidgetBundle`
- `WidgetConfiguration`

在 iOS 和 macOS 中，小组件协议允许我们创建和配置小部件，这些小部件可以在主屏幕或者通知中心显示应用程序的信息。以下是这些协议的介绍和示例：

- `Widget`：这个协议定义了一个小部件的基本接口。例如，我们可以创建一个显示漫画书标题的小部件：

```swift
struct ComicWidget: Widget {
    private let kind: String = "ComicWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ComicWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Comic Widget")
        .description("This is a comic widget.")
    }
}
```

- `WidgetBundle`：这个协议允许我们将多个小部件组合在一起。例如，我们可以创建一个包含多个漫画小部件的小部件包：

```swift
@main
struct ComicWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ComicWidget()
        AnotherComicWidget()
    }
}
```

- `WidgetConfiguration`：这个协议定义了一个小部件的配置。在上面的 `ComicWidget` 示例中，我们使用了 `StaticConfiguration`，它是 `WidgetConfiguration` 的一个具体实现，用于创建静态小部件。

注意：在这些示例中，`Provider` 和 `ComicWidgetEntryView` 需要你自己定义。`Provider` 是一个遵循 `TimelineProvider` 协议的类型，它负责提供小部件的时间线数据。`ComicWidgetEntryView` 是一个视图，用于显示小部件的内容。
