```swift
let s1 = """
one1,
two2,
three3.
"""
let sn1 = Scanner(string: s1)
while !sn1.isAtEnd {
    if let r1 = sn1.scanUpToCharacters(from: .newlines) {
        print(r1 as String)
    }
}
/// one1,
/// two2,
/// three3.

// 找出数字
let sn2 = Scanner(string: s1)
sn2.charactersToBeSkipped = CharacterSet.decimalDigits.inverted // 不是数字的就跳过
var p: Int = 0
while !sn2.isAtEnd {
    if sn2.scanInt(&p) {
        print(p)
    }
}
/// 1
/// 2
/// 3
```

上面的代码还不是那么 Swifty，可以通过用AnySequence和AnyIterator来包装下，将序列中的元素推迟到实际需要时再来处理，这样性能也会更好些。具体实现可以参看《 [String parsing in Swift](https://www.swiftbysundell.com/articles/string-parsing-in-swift/) 》这篇文章。
