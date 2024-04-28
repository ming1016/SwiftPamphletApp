变量是可变的，使用 var 修饰，常量是不可变的，使用 let 修饰。类、结构体和枚举里的变量是属性。

```swift
var v1:String = "hi" // 标注类型
var v2 = "类型推导"
let l1 = "标题" // 常量

class a {
    let p1 = 3
    var p2: Int {
        p1 * 3
    }
}
```

属性没有 set 可以省略 get，如果有 set 需加 get。变量设置前通过 willSet 访问到，变量设置后通过 didSet 访问。
