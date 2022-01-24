添加和读取剪贴板的方法如下：
```swift
// 读取剪贴板内容
let s = NSPasteboard.general.string(forType: .string)
guard let s = s else {
    return
}
print(s)

// 设置剪贴板内容
let p = NSPasteboard.general
p.declareTypes([.string], owner: nil)
p.setString(s, forType: .string)
```