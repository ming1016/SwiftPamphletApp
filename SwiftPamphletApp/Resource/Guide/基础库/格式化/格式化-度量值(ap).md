

MeasurementFormatter

使用 Swift Foundation Formatter API
```swift
Measurement<UnitMass>(value: 1, unit: .kilograms)
    .formatted(.measurement(width: .abbreviated))
```

标准库里的物理量，在这个文档里有详细列出，包括角度、平方米等。
```swift
// 参考：https://developer.apple.com/documentation/foundation/nsdimension
let m1 = Measurement(value: 1, unit: UnitLength.kilometers)
let m2 = m1.converted(to: .meters) // 千米转米
print(m2) // 1000.0 m
// 度量值转为本地化的值
let mf = MeasurementFormatter()
mf.locale = Locale(identifier: "zh_Hans_CN")
print(mf.string(from: m1)) // 1公里
```

一些物理公式供参考：
```
面积 = 长度 × 长度
体积 = 长度 × 长度 × 长度 = 面积 × 长度

速度=长度/时间
加速度=速度/时间

力 = 质量 × 加速度
扭矩 = 力 × 长度
压力 = 力 / 面积

密度=质量 / 体积
能量 = 功率 × 时间
电阻 = 电压 / 电流
```


描述多个事物
```swift
// 描述多个事物
let s1 = ListFormatter.localizedString(byJoining: ["冬天","春天","夏天","秋天"])
print(s1)
```

使用 Foundation Formatter API
```swift
["足球", "篮球"].formatted(.list(type: .and))
```
