控制台打印值

```swift
print("hi")
let i = 14
print(i)
print("9月\(i)是小柠檬的生日")

for i in 1...3{
    print(i)
}
// output:
// 1
// 2
// 3

// 使用terminator使循环打印更整洁
for i in 1...3 {
    print("\(i) ", terminator: "")
}
// output:
// 1 2 3
```
