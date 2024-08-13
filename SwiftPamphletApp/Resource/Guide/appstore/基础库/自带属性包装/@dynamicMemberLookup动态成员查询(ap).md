
@dynamicMemberLookup 指示访问属性时调用一个已实现的处理动态查找的下标方法 subscript(dynamicMemeber:)，通过指定属性字符串名返回值。使用方法如下：

```swift
@dynamicMemberLookup
struct D {
    // 找字符串
    subscript(dynamicMember m: String) -> String {
        let p = ["one": "first", "two": "second"]
        return p[m, default: ""]
    }
    // 找整型
    subscript(dynamicMember m: String) -> Int {
        let p = ["one": 1, "two": 2]
        return p[m, default: 0]
    }
    // 找闭包
    subscript(dynamicMember m: String) -> (_ s: String) -> Void {
        return {
            print("show \($0)")
        }
    }
    // 静态数组成员
    var p = ["This is a member"]
    // 动态数组成员
    subscript(dynamicMember m: String) -> [String] {
        return ["This is a dynamic member"]
    }
}

let d = D()
let s1: String = d.one
print(s1) // first
let i1: Int = d.one
print(i1) // 1
d.show("something") // show something
print(d.p) // ["This is a member"]
let dynamicP:[String] = d.dp
print(dynamicP) // ["This is a dynamic member"]
```

类使用 @dynamicMemberLookup，继承的类也会自动加上 @dynamicMemberLookup。协议上定义 @dynamicMemberLookup，通过扩展可以默认实现 subscript(dynamicMember:) 方法。



