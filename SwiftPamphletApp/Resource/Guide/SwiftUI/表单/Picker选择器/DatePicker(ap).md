

## 基本使用

```swift
struct ContentView: View {
    @State private var releaseDate: Date = Date()

    var body: some View {
        VStack(spacing: 30) {
            DatePicker("选择电影发布日期", selection: $releaseDate, displayedComponents: .date)
            Text("选择的发布日期: \(releaseDate, formatter: DateFormatter.dateMedium)")
        }
        .padding()
    }
}
```


## 选择多个日期

在 iOS 16 中，您现在可以允许用户选择多个日期，MultiDatePicker 视图会显示一个日历，用户可以选择多个日期，可以设置选择范围。示例如下：
```swift
struct PMultiDatePicker: View {
    @Environment(\.calendar) var cal
    @State var dates: Set<DateComponents> = []
    var body: some View {
        MultiDatePicker("选择个日子", selection: $dates, in: Date.now...)
        Text(s)
    }
    var s: String {
        dates.compactMap { c in
            cal.date(from:c)?.formatted(date: .long, time: .omitted)
        }
        .formatted()
    }
}
```

## 指定日期范围

指定日期的范围，例如只能选择当前日期之后的日期，示例如下：

```swift
DatePicker(
    "选择日期",
    selection: $selectedDate,
    in: Date()...,
    displayedComponents: [.date]
)
.datePickerStyle(WheelDatePickerStyle())
.labelsHidden()
```

在这个示例中：

- `selection: $selectedDate` 表示选定的日期和时间。
- `in: Date()...` 表示可选日期的范围。在这个例子中，用户只能选择当前日期之后的日期。你也可以使用 `...Date()` 来限制用户只能选择当前日期之前的日期，或者使用 `Date().addingTimeInterval(86400*7)` 来限制用户只能选择从当前日期开始的接下来一周内的日期。
- `displayedComponents: [.date]` 表示 `DatePicker` 应该显示哪些组件。在这个例子中，我们只显示日期组件。你也可以使用 `.hourAndMinute` 来显示小时和分钟组件，或者同时显示日期和时间组件。
- `.datePickerStyle(WheelDatePickerStyle())` 表示 `DatePicker` 的样式。在这个例子中，我们使用滚轮样式。你也可以使用 `GraphicalDatePickerStyle()` 来应用图形样式。
- `.labelsHidden()` 表示隐藏 `DatePicker` 的标签。

