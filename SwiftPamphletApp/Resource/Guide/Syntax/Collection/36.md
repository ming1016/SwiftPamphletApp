数组是有序集合

```swift
var a0: [Int] = [1, 10]
a0.append(2)
a0.remove(at: 0)
print(a0) // [10, 2]

let a1 = ["one", "two", "three"]
let a2 = ["three", "four"]

// 找两个集合的不同
let dif = a1.difference(from: a2) // swift的 diffing 算法在这 http://www.xmailserver.org/diff2.pdf swift实现在  swift/stdlib/public/core/Diffing.swift
for c in dif {
    switch c {
    case .remove(let o, let e, let a):
        print("offset:\(o), element:\(e), associatedWith:\(String(describing: a))")
    case .insert(let o, let e, let a):
        print("offset:\(o), element:\(e), associatedWith:\(String(describing: a))")
    }
}
/*
 remove offset:1, element:four, associatedWith:nil
 insert offset:0, element:one, associatedWith:nil
 insert offset:1, element:two, associatedWith:nil
 */
let a3 = a2.applying(dif) ?? [] // 可以用于添加删除动画
print(a3) // ["one", "two", "three"]
```

dif 有第三个 case 值 .insert(let offset, let element, let associatedWith) 可以跟踪成对的变化，用于高级动画。

从数组中随机取一个元素
```swift
print(a0.randomElement() ?? 0)
```

数组排序

```swift
// 排序
struct S1 {
    let n: Int
    var b = true
}

let a4 = [
    S1(n: 1),
    S1(n: 10),
    S1(n: 3),
    S1(n: 2)
]
let a5 = a4.sorted { i1, i2 in
    i1.n < i2.n
}
for n in a5 {
    print(n)
}
/// S1(n: 1)
/// S1(n: 2)
/// S1(n: 3)
/// S1(n: 10)

let a6 = [1,10,4,7,2]
print(a6.sorted(by: >)) // [10, 7, 4, 2, 1]
```

可以加到数组扩展中，通过扩展约束能够指定特定元素类型的排序，代码如下：

```swift
extension Array where Element == Int {
    // 升序
    func intSortedASC() -> [Int] {
        return self.sorted(by: <)
    }
    // 降序
    func intSortedDESC() -> [Int] {
        return self.sorted(by: <)
    }
}

print(a6.intSortedASC()) // 使用扩展增加自定义排序能力
```

在数组中检索满足条件的元素，代码如下：

```swift
// 第一个满足条件了就返回
let a7 = a4.first {
    $0.n == 10
}
print(a7?.n ?? 0)

// 是否都满足了条件
print(a4.allSatisfy { $0.n == 1 }) // false
print(a4.allSatisfy(\.b)) // true

// 找出最大的那个
print(a4.max(by: { e1, e2 in
    e1.n < e2.n
}) ?? S1(n: 0))
// S1(n: 10, b: true)

// 看看是否包含某个元素
print(a4.contains(where: {
    $0.n == 7
}))
// false
```

一些切割数组的方法。

```swift
// 切片
// 取前3个，并不是直接复制，对于大的数组有性能优势。
print(a6[..<3]) // [1, 10, 4] 需要做越界检查
print(a6.prefix(30)) // [1, 10, 4, 7, 2] 不需要做越界检查，也是切片，性能一样

// 去掉前3个
print(a6.dropFirst(3)) // [7, 2]
```

prefix(while:) 和 drop(while:) 方法，顺序遍历执行闭包里的逻辑判断，满足条件就返回，遇到不匹配就会停止遍历。prefix 返回满足条件的元素集合，drop 返回停止遍历之后那些元素集合。

```swift
let a8 = [8, 9, 20, 1, 35, 3]
let a9 = a8.prefix {
    $0 < 30
}
print(a9) // [8, 9, 20, 1]
let a10 = a8.drop {
    $0 < 30
}
print(a10) // [35, 3]
```

比 filter 更高效的删除元素的方法 removeAll

```swift
// 删除所有不满足条件的元素
var a11 = [1, 3, 5, 12, 25]
a11.removeAll { $0 < 10 }
print(a11) // [4, 3, 1, 3, 3] 随机

// 创建未初始化的数组
let a12 = (0...4).map { _ in
    Int.random(in: 0...5)
}
print(a12) // [0, 3, 3, 2, 5] 随机
```

#if 用于后缀表达式

```swift
// #if 用于后缀表达式
let a13 = a11
#if os(iOS)
    .count
#else
    .reduce(0, +)
#endif
print(a13) //37
```

