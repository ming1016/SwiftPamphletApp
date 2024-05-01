用法：
```swift
let ri = Int.random(in: 0..<10)
print(ri) // 0到10随机数
let a = [0, 1, 2, 3, 4, 5]
print(a.randomElement() ?? 0) // 数组中随机取个数
print(a.shuffled()) // 随机打乱数组顺序
```
