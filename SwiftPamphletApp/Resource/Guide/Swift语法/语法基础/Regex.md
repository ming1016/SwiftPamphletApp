标准库多了个 `Regex<Output>` 类型，Regex 语法与 Perl、Python、Ruby、Java、NSRegularExpression 和许多其他语言兼容。可以用 `let regex = try! Regex("a[bc]+")` 或 `let regex = /a[bc]+/` 写法来使用。[SE-0350 Regex Type and Overview](https://github.com/apple/swift-evolution/blob/main/proposals/0350-regex-type-overview.md) 引入 Regex 类型。[SE-0351 Regex builder DSL](https://github.com/apple/swift-evolution/blob/main/proposals/0351-regex-builder.md) 使用 result builder 来构建正则表达式的 DSL。[SE-0354 Regex Literals](https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md) 简化的正则表达式。[SE-0357 Regex-powered string processing algorithms](https://github.com/apple/swift-evolution/blob/main/proposals/0357-regex-string-processing-algorithms.md) 提案里有基于正则表达式的新字符串处理算法。

[RegexBuilder 文档](https://developer.apple.com/documentation/RegexBuilder)

session [Meet Swift Regex](https://developer.apple.com/videos/play/wwdc2022-110357) 、[Swift Regex: Beyond the basics](https://developer.apple.com/videos/play/wwdc2022-110358)

Regex 示例代码如下：
```swift
let s1 = "I am not a good painter"
print(s1.ranges(of: /good/))
do {
    let regGood = try Regex("[a-z]ood")
    print(s1.replacing(regGood, with: "bad"))
} catch {
    print(error)
}
print(s1.trimmingPrefix(/i am /.ignoresCase()))

let reg1 = /(.+?) read (\d+) books./
let reg2 = /(?<name>.+?) read (?<books>\d+) books./
let s2 = "Jack read 3 books."
do {
    if let r1 = try reg1.wholeMatch(in: s2) {
        print(r1.1)
        print(r1.2)
    }
    if let r2 = try reg2.wholeMatch(in: s2) {
        print("name:" + r2.name)
        print("books:" + r2.books)
    }
} catch {
    print(error)
}
```

使用 regex builders 的官方示例：
```swift
// Text to parse:
// CREDIT  03/02/2022  Payroll from employer     $200.23
// CREDIT  03/03/2022  Suspect A           $2,000,000.00
// DEBIT   03/03/2022  Ted's Pet Rock Sanctuary    $2,000,000.00
// DEBIT   03/05/2022  Doug's Dugout Dogs      $33.27

import RegexBuilder
let fieldSeparator = /\s{2,}|\t/
let transactionMatcher = Regex {
  /CREDIT|DEBIT/
  fieldSeparator
  One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt)) // 👈🏻 we define which data locale/timezone we want to use
  fieldSeparator
  OneOrMore {
    NegativeLookahead { fieldSeparator } // 👈🏻 we stop as soon as we see one field separator
    CharacterClass.any
  }
  fieldSeparator
  One(.localizedCurrency(code: "USD").locale(Locale(identifier: "en_US")))
}
```

在正则表达式中捕获数据，使用 Capture：
```swift
let fieldSeparator = /\s{2,}|\t/
let transactionMatcher = Regex {
  Capture { /CREDIT|DEBIT/ } // 👈🏻
  fieldSeparator

  Capture { One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt)) } // 👈🏻
  fieldSeparator

  Capture { // 👈🏻
    OneOrMore {
      NegativeLookahead { fieldSeparator }
      CharacterClass.any
    }
  }
  fieldSeparator
  Capture { One(.localizedCurrency(code: "USD").locale(Locale(identifier: "en_US"))) } // 👈🏻
}
// transactionMatcher: Regex<(Substring, Substring, Date, Substring, Decimal)>
```
