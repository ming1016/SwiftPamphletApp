
## 不同的大小设置不同视图

```swift
struct ArticleWidgetView: View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var family

  @ViewBuilder
  var body: some View {
    switch family {
    case .systemSmall:
        SomeViewSmall()
    default:
      SomeViewDefault()
    }
  }
}
```

## 锁屏小组件

让小组件支持锁屏

```swift
struct ArticleWidget: Widget {

    var body: some WidgetConfiguration {
        StaticConfiguration(
            ...
        ) { entry in
            ...
        }
        ...
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,

            // 添加支持到 Lock Screen widgets
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline,
        ])
    }
}
```

## 不同类型 widgetFamily 实现不同视图

```swift
struct ArticleWidgetView : View {
   
    let entry: ViewSizeEntry
    // 获取 widget family 值
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .accessoryRectangular:
            RectangularWidgetView()
        case .accessoryCircular:
            CircularWidgetView()
        case .accessoryInline:
            InlineWidgetView()
        default:
            ArticleWidgetView(entry: entry)
        }
    }
}
```

## 不同渲染模式实现不同视图

小组件有三种不同的渲染模式：

- Full-color：主屏用
- Vibrant：用于待机模式和锁屏
- The accented：用于手表

```swift
struct ArticleWidgetView: View {
    let entry: Entry
    
    @Environment(\.widgetRenderingMode) private var renderingMode
    
    var body: some View {
        switch renderingMode {
        case .accented:
            AccentedWidgetView(entry: entry)
        case .fullColor:
            FullColorWidgetView(entry: entry)
        case .vibrant:
            VibrantWidgetView(entry: entry)
        default:
            DefaultView()
        }
    }
}
```

## 视图交互

使用 AppIntent

```swift
struct ArticleWidgetView : View {
    var entry: IntentProvider.Entry

    var body: some View {
        VStack(spacing: 20) {
            ...

            Button(intent: RunIntent(rate: entry.rate), label: {
                ...
            })
        }
    }
}
```
