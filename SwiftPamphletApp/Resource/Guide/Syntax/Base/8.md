函数可以作为另一个函数的参数，也可以作为另一个函数的返回。函数是特殊的闭包，在类、结构体和枚举中是方法。

```swift
// 为参数设置默认值
func f1(p: String = "p") -> String {
    "p is \(p)"
}

// 函数作为参数
func f2(fn: (String) -> String, p: String) -> String {
    return fn(p)
}

print(f2(fn:f1, p: "d")) // p is d

// 函数作为返回值
func f3(p: String) -> (String) -> String {
    return f1
}

print(f3(p: "yes")("no")) // p is no
```

函数可以返回多个值，函数是可以嵌套的，也就是函数里内可以定义函数，函数内定义的函数可以访问自己作用域外函数内的变量。inout 表示的是输入输出参数，函数可以在函数内改变输入输出参数。defer 标识的代码块会在函数返回之前执行。

函数在 Swift 5.4 时开始有了使用多个变量参数的能力，使用方法如下：

```swift
func f4(s: String..., i: Int...) {
    print(s)
    print(i)
}

f4(s: "one", "two", "three", i: 1, 2, 3)
/// ["one", "two", "three"]
/// [1, 2, 3]
```

嵌套函数可以重载，嵌套函数可以在声明函数之前调用他。

```swift
func f5() {
    nf5()
    func nf5() {
        print("this is nested function")
    }
}
f5() // this is nested function
```