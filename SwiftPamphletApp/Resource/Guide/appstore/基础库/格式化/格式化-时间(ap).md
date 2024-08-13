
## 格式化时间成字符串

格式化日期的示例。这些方法都是在 `Date` 类型上调用的，它们返回一个格式化的字符串，表示当前日期和时间。

```swift
Date.now.formatted()
```
这行代码返回一个默认格式的日期和时间字符串。

```swift
Date.now.formatted(.relative(presentation: .named))
```
这行代码返回一个相对于现在的时间字符串，例如 "5 分钟前" 或 "明天"。

```swift
Date.now.formatted(date: .abbreviated, time: .omitted)
```
这行代码返回一个简写的日期字符串，不包含时间。

```swift
Date.now.formatted(.dateTime.day(.twoDigits).month(.abbreviated).year(.twoDigits))
```
这行代码返回一个自定义格式的日期和时间字符串，包含两位数的日、简写的月和两位数的年。

```swift
Date.now.formatted(.iso8601)
```
这行代码返回一个 ISO 8601 格式的日期和时间字符串。

代码示例：

```swift
struct Movie {
    let title: String
    let screeningDates: [Date]
}

let movie = Movie(title: "电影标题", screeningDates: [Date.now, Date.now.advanced(by: 60*60*24)])

for date in movie.screeningDates {
    print("\(movie.title) 的放映时间是 \(date.formatted(date: .abbreviated, time: .shortened))")
}
```

这段代码会打印出电影的标题和每个放映时间，时间是以简写的日期和短格式的时间显示的。


## 相对时间差

描述两个日期之间的相对时间差。这个类可以生成如 "昨天"、"5 分钟前" 这样的字符串。

```swift
let d1 = Date().timeIntervalSince1970 - 60 * 60 * 24
```
这行代码创建了一个 `Date` 对象，表示当前时间减去 24 小时（即一天前的时间）。

```swift
let f1 = RelativeDateTimeFormatter()
f1.dateTimeStyle = .named
f1.formattingContext = .beginningOfSentence
f1.locale = Locale(identifier: "zh_Hans_CN")
let str = f1.localizedString(for: Date(timeIntervalSince1970: d1), relativeTo: Date())
print(str) // 昨天
```
这些代码创建了一个 `RelativeDateTimeFormatter` 对象，并设置了其样式和语言环境。然后，它使用这个格式化器来生成一个表示 `d1` 和当前时间相对时间差的字符串。

```swift
let str2 = Date.now.addingTimeInterval(-(60 * 60 * 24))
    .formatted(.relative(presentation: .named))
print(str2) // yesterday
```
这行代码做的事情和前面的代码类似，但是它使用了 Swift 5.5 引入的新的 `Date` 格式化 API。这个 API 更简洁，更易于使用。

我们可能会有一个电影放映时间的列表，我们可以使用这些方法来描述每个放映时间距离现在有多久。例如：

```swift
struct Movie {
    let title: String
    let screeningDates: [Date]
}

let movie = Movie(title: "电影标题", screeningDates: [Date.now, Date.now.advanced(by: 60*60*24)])

for date in movie.screeningDates {
    let relativeTime = date.formatted(.relative(presentation: .named))
    print("\(movie.title) 的放映时间是 \(relativeTime)")
}
```

这段代码会打印出电影的标题和每个放映时间距离现在的相对时间。


## 剩余时间

描述一个时间间隔。这个类可以生成如 "大约 5 分钟" 这样的字符串。

电影的剩余播放时间，我们可以使用这个方法来描述这个时间。例如：

```swift
struct Movie {
    let title: String
    let remainingTime: TimeInterval
}

let movie = Movie(title: "电影标题", remainingTime: 300.0)

let formatter = DateComponentsFormatter()
formatter.unitsStyle = .full
formatter.includesApproximationPhrase = true
formatter.includesTimeRemainingPhrase = true
let text = formatter.string(from: movie.remainingTime) ?? ""

print("\(movie.title) 的剩余播放时间是 \(text)")
```

这段代码会打印出电影的标题和剩余播放时间。


## DateIntervalFormatter

一个电影的放映时间段，我们可以使用这个方法来描述这个时间段。例如：

```swift
struct Movie {
    let title: String
    let screeningInterval: (start: Date, end: Date)
}

let movie = Movie(title: "电影标题", screeningInterval: (start: Date(), end: Date(timeInterval: 86400, since: Date())))

let formatter = DateIntervalFormatter()
formatter.dateStyle = .short
formatter.timeStyle = .none
let text = formatter.string(from: movie.screeningInterval.start, to: movie.screeningInterval.end)

print("\(movie.title) 的放映时间段是 \(text)")
```

这段代码会打印出电影的标题和放映时间段。