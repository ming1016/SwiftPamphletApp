

## `.formatted`

```swift
print(888.formatted(.currency(code: "RMB")))
print(99999.formatted())
print(0.3.formatted(.percent))
print(3.14.formatted(.number.precision(.fractionLength(1))))
```

## NumberFormatter 描述数字

```swift
// 数字
let f3 = NumberFormatter()
f3.locale = Locale(identifier: "zh_Hans_CN")
f3.numberStyle = .currency
print(f3.string(from: 123456) ?? "") // ¥123,456.00
f3.numberStyle = .percent
print(f3.string(from: 123456) ?? "") // 12,345,600%

let n1 = 1.23456
let n1Str = n1.formatted(.number.precision(.fractionLength(3)).rounded())
print(n1Str) // 1.235
```

ByteCountFormatter 描述数据大小
```swift
let formatter = ByteCountFormatter()
formatter.countStyle = .file

text = formatter.string(fromByteCount: 1_000_000_000) // 1GB
```
