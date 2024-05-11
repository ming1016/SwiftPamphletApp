
## 通过 Text 视图更新

倒计时

```swift

let futureDate = Calendar.current.date(byAdding: components, to: Date())!

// 日期会在 Text 视图中动态变化

```

```swift
struct CountdownWidgetView: View {
    
    var body: some View {
        Text(futureDate(), style: .timer)
    }
    
    private func futureDate() -> Date {
        let components = DateComponents(second: 10)
        let futureDate = Calendar.current.date(byAdding: components, to: Date())!
        return futureDate
    }
}
```

## Timeline Provider 更新

在 timeline 方法中实现，entries 包含了不同更新的数据。

```swift
func timeline(for configuration: ArticleIntent, in context: Context) async -> Timeline<ArticleEntry> {
    return Timeline(
        entries: [
            .init(date: Date(),
                  author: configuration.author,
                  rate: await ArticleStore().rate())],
        policy: .never)
}
```

## 更新策略

3 种类型的刷新策略：
- `atEnd`：上个刷新完成直接进入下个刷新，但是进入下一个刷新的时间由系统决定。
- `after(Date)`：指定进入下个刷新的时间，但是具体时间还是由系统说了算，因此可以理解为是指定的是最早进入下个刷新的时间。
- `never`：不会进入下个刷新，除非显式调用 `reloadTimelines(ofKind:)`

举例，指定下个刷新周期至少是上个周期结束10秒后：

```swift
let lastUpdateDate = entries.last!.date
let nextUpdateDate = Calendar.current.date(byAdding: DateComponents(second: 10), to: lastUpdate)!

let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
```

## Relevance 优先级

App 自定义刷新 Timeline 的优先级，使用 Relevance。先在 TimelineEntry 里定义：

```swift
struct ArticleEntry: TimelineEntry {
    let date: Date
    ...
    let relevance: TimelineEntryRelevance?
}
```

在 timeline 方法中根据必要刷新程序，定义不同 relevance 的值。

## App 主动刷新

```swift
// 刷新单个小组件
WidgetCenter.shared.reloadTimelines(ofKind: "CountryWidget")

// 刷新所有小组件
WidgetCenter.shared.reloadAllTimelines()
```

## 刷新小组件的最佳实践

调试时刷新率不会有限制，生产环境每天最多40到70次，相当于每15到60分钟刷新一次。

