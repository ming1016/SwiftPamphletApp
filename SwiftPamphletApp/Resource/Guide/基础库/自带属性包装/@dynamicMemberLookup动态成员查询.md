@dynamicCallable 动态可调用类型。通过实现 dynamicallyCall 方法来定义变参的处理。

```swift
@dynamicCallable
struct D {
    // 带参数说明
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Int {
        let firstArg = args.first?.value ?? 0
        return firstArg * 2
    }
    
    // 无参数说明
    func dynamicallyCall(withArguments args: [String]) -> String {
        var firstArg = ""
        if args.count > 0 {
            firstArg = args[0]
        }
        return "show \(firstArg)"
    }
}

let d = D()
let i = d(numberIs: 2)
print(i) // 4
let s = d("hi")
print(s) // show hi
```
