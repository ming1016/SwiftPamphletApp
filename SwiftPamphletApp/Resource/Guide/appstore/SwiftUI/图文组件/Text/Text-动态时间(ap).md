
逻辑更新时，不会触发 `body` 的重绘，只对使用了 Text Date 插值的 `Text`。 

倒计时

```swift
Text(Date().addingTimeInterval(60), style: .offset)
```

指定多长时间

```swift
// 多久后
let aimDate = Calendar.current.date(byAdding: DateComponents(minute: 10), to: Date())!

```

指定一个具体时间

```swift
// 具体时间
let aimDate = Calendar.current(DateComponents(year: 2024, month: 6, day: 11, hour: 20, minute: 10))!
```

Text 视图

```swift
// 多种表现样式
Text(aimDate, style: .relative)
Text(aimDate, style: .offset)
Text(aimDate, style: .timer)
Text(aimDate, style: .date)
Text(aimDate, style: .time)
```

两个时间间隔

```swift
let beginDate = Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 11, hour: 20, minute: 10))!
let endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 15, hour: 20, minute: 10))!

Text(beginDate ... endDate)
```
