Date 的基本用法如下：
```swift
let now = Date()

// Date 转 时间戳
let interval = now.timeIntervalSince1970 // 时间戳
let df = DateFormatter()
df.dateFormat = "yyyy 年 MM 月 dd 日 HH:mm:ss"
print("时间戳：\(Int(interval))") // 时间戳：1642399901
print("格式化的时间：" + df.string(from: now)) // 格式化的时间：2022 年 01 月 17 日 14:11:41
df.dateStyle = .short
print("short 样式时间：" + df.string(from: now)) // short 样式时间：2022/1/17
df.locale = Locale(identifier: "zh_Hans_CN")
df.dateStyle = .full
print("full 样式时间：" + df.string(from: now)) // full 样式时间：2022年1月17日 星期一

// 时间戳转 Date
let date = Date(timeIntervalSince1970: interval)
print(date) // 2022-01-17 06:11:41 +0000
```


复杂的时间操作，比如说 GitHub 接口使用的是 ISO 标准，RSS 输出的是 RSS 标准字符串，不同标准对应不同时区的时间计算处理，可以使用开源库  [SwiftDate](https://github.com/malcommac/SwiftDate)  来完成。示例代码如下：

```swift
import SwiftDate

// 使用 SwiftDate 库
let cn = Region(zone: Zones.asiaShanghai, locale: Locales.chineseChina)
SwiftDate.defaultRegion = cn
print("2008-02-14 23:12:14".toDate()?.year ?? "") // 2008

let d1 = "2022-01-17T23:20:35".toISODate(region: cn)
guard let d1 = d1 else {
    return
}
print(d1.minute) // 20
let d2 = d1 + 1.minutes
print(d2.minute)

// 两个 DateInRegion 相差时间 interval
let i1 = DateInRegion(Date(), region: cn) - d1
let s1 = i1.toString {
    $0.maximumUnitCount = 4
    $0.allowedUnits = [.day, .hour, .minute]
    $0.collapsesLargestUnit = true
    $0.unitsStyle = .abbreviated
    $0.locale = Locales.chineseChina
}
print(s1) // 9小时45分钟
```
