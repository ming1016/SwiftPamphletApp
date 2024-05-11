
## 显示区域

iOS 17 新增显示区域配置，有四种

- homeScreen
- lockScreen
- standBy
- iPhoneWidgetsOnMac

设置小组件不在哪个区域显示某尺寸。

```swift
struct SomeWidget: Widget {
    ...
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            ... { entry in
            ...
        }
        // 在 StandBy 中取消显示 systemSmall 尺寸
        .disfavoredLocations([.standBy], for: [.systemSmall])
    }
}
```

## 取消内容边距

使用 `.contentMarginsDisabled()` 取消内容边距。

```swift
struct SomeWidget: Widget {
    ...
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            ... { entry in
            ...
        }
        // 使 Content margin 失效
        .contentMarginsDisabled()
    }
}
```

每个平台内容边距大小不同，环境变量 `\.widgetContentMargins` 可以读取内容边距的大小。

## 取消背景删除

在 StandBy 和 LockScreen 的某些情况，小组件的背景是会被自动删除的。

使用 `containerBackgroundRemovable()` 修饰符可以取消背景删除。

```swift
struct SomeWidget: Widget {
    ...
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            ... { entry in
            ...
        }
        // 取消背景删除
        .containerBackgroundRemovable(false)
        // 让自己的背景可以全覆盖
        .contentMarginsDisabled()
    }
}
```

## 后台网络处理

```swift
.onBackgroundURLSessionEvents { (identifier, completion) in
    //...
}
```
