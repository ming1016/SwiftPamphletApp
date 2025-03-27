<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 字符串详解</title>
    <style>
        :root {
            --background-color: #5c94fc;
            --text-color: #242424;
            --code-bg: #f3c677;
            --header-color: #bb5522;
            --accent-color: #2ecc71;
            --border-color: #8b5d3a;
            --link-color: #2244bb;
            --cloud-color: #ffffff;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #2a4480;
                --text-color: #f0f0f0;
                --code-bg: #976c2d;
                --header-color: #ff8855;
                --accent-color: #3bdb85;
                --border-color: #b48b6c;
                --link-color: #88aaff;
                --cloud-color: #cccccc;
            }
        }
        
        * {
            box-sizing: border-box;
            image-rendering: pixelated;
        }
        
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            font-family: 'Courier New', monospace;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-image: 
                radial-gradient(var(--cloud-color) 30%, transparent 30%),
                radial-gradient(var(--cloud-color) 40%, transparent 40%);
            background-position: 0 0, 50px 50px;
            background-size: 200px 200px, 150px 150px;
            background-attachment: fixed;
        }
        
        .pixel-border {
            border: 4px solid var(--border-color);
            border-style: solid;
            image-rendering: pixelated;
            box-shadow: 4px 4px 0 rgba(0, 0, 0, 0.3);
        }
        
        .container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(255, 255, 240, 0.9);
            border-radius: 0px;
            position: relative;
        }
        
        @media (prefers-color-scheme: dark) {
            .container {
                background-color: rgba(40, 44, 52, 0.9);
            }
        }
        
        h1, h2, h3, h4 {
            color: var(--header-color);
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.2);
        }
        
        h1 {
            font-size: 2.5rem;
            text-align: center;
            margin-top: 0;
            padding: 10px;
            border-bottom: 4px solid var(--accent-color);
        }
        
        h2 {
            font-size: 1.8rem;
            border-left: 8px solid var(--accent-color);
            padding-left: 15px;
            margin-top: 40px;
        }
        
        h3 {
            font-size: 1.4rem;
            border-bottom: 2px dashed var(--accent-color);
            padding-bottom: 5px;
        }
        
        pre {
            background-color: var(--code-bg);
            padding: 15px;
            border-radius: 0;
            overflow-x: auto;
            margin: 20px 0;
        }
        
        code {
            font-family: 'Courier New', monospace;
            color: var(--text-color);
            background-color: var(--code-bg);
            padding: 2px 4px;
            border-radius: 0;
        }
        
        pre code {
            padding: 0;
            background-color: transparent;
        }
        
        a {
            color: var(--link-color);
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px solid transparent;
            transition: border-bottom 0.3s;
        }
        
        a:hover {
            border-bottom: 2px solid var(--link-color);
        }
        
        .example {
            border-left: 4px solid var(--accent-color);
            padding-left: 15px;
            margin: 20px 0;
        }
        
        .note {
            background-color: rgba(46, 204, 113, 0.2);
            border-left: 4px solid var(--accent-color);
            padding: 10px 15px;
            margin: 20px 0;
        }
        
        .resource-section {
            margin-top: 40px;
            padding: 15px;
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        .pixel-button {
            display: inline-block;
            padding: 8px 16px;
            background-color: var(--accent-color);
            color: white;
            border: none;
            cursor: pointer;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            text-transform: uppercase;
            box-shadow: 4px 4px 0 rgba(0, 0, 0, 0.3);
            margin: 10px 0;
            transition: transform 0.1s, box-shadow 0.1s;
        }
        
        .pixel-button:hover {
            transform: translate(2px, 2px);
            box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.3);
        }
        
        /* 表格样式 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        
        th, td {
            border: 2px solid var(--border-color);
            padding: 8px;
            text-align: left;
        }
        
        th {
            background-color: var(--accent-color);
            color: white;
        }
        
        tr:nth-child(even) {
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        /* 响应式布局 */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
                margin: 10px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            h2 {
                font-size: 1.5rem;
            }
            
            h3 {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container pixel-border">
        <h1>Swift 字符串详解</h1>
        
        <h2>1. 字符串基础</h2>
        
        <p>Swift 的字符串是一种强大的文本表示类型，它提供了丰富的 API 来处理文本数据。Swift 中的字符串是由 Unicode 字符组成的，它使用了高效的内存表示方式，可以快速处理各种语言的文本。</p>
        
        <svg width="100%" height="180" viewBox="0 0 600 180">
            <rect x="50" y="40" width="500" height="60" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <rect x="55" y="45" width="490" height="50" rx="3" fill="#f3c677" stroke="black" stroke-width="1"/>
            <text x="300" y="75" text-anchor="middle" font-family="Courier New" font-weight="bold" font-size="24">Swift String</text>
            <path d="M300,100 L300,130 L280,130 L300,150 L320,130 L300,130" fill="#8b5d3a" stroke="black" stroke-width="1"/>
            <text x="200" y="170" text-anchor="middle" font-family="Courier New" font-size="16">Unicode 字符集合</text>
            <text x="400" y="170" text-anchor="middle" font-family="Courier New" font-size="16">值类型（Copy-on-Write）</text>
        </svg>
        
        <h3>1.1 字符串的创建</h3>
        
        <p>在 Swift 中创建字符串的多种方式：</p>
        
        <pre><code>// 1. 使用字符串字面量
let greeting = "你好，Swift!"

// 2. 空字符串的创建
let emptyString = ""
let anotherEmptyString = String()

// 3. 使用字符数组创建
let characters: [Character] = ["S", "w", "i", "f", "t"]
let stringFromChars = String(characters)  // "Swift"

// 4. 重复字符创建字符串
let repeated = String(repeating: "A", count: 5)  // "AAAAA"</code></pre>
        
        <div class="note">
            <p>Swift 字符串是<strong>值类型</strong>，这意味着当它被传递给函数或赋值给新变量时，它会被复制。这种行为由于 Copy-on-Write 优化而变得高效。</p>
        </div>
        
        <h3>1.2 字符串的可变性</h3>
        
        <pre><code>// 不可变字符串
let constantString = "这是一个常量字符串"
// constantString += "无法修改"  // 编译错误！

// 可变字符串
var variableString = "这是一个变量字符串"
variableString += "，可以修改"  // 正确</code></pre>
        
        <h2>2. 字符串操作</h2>
        
        <h3>2.1 字符串连接</h3>
        
        <svg width="100%" height="120" viewBox="0 0 600 120">
            <rect x="50" y="20" width="200" height="40" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <text x="150" y="45" text-anchor="middle" font-family="Courier New" font-size="16">"Hello"</text>
            
            <rect x="350" y="20" width="200" height="40" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <text x="450" y="45" text-anchor="middle" font-family="Courier New" font-size="16">"World"</text>
            
            <text x="300" y="45" text-anchor="middle" font-family="Courier New" font-weight="bold" font-size="24">+</text>
            
            <path d="M300,70 L300,80 L270,80 L300,100 L330,80 L300,80" fill="#8b5d3a" stroke="black" stroke-width="1"/>
            
            <rect x="200" y="100" width="200" height="40" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <text x="300" y="125" text-anchor="middle" font-family="Courier New" font-size="16">"HelloWorld"</text>
        </svg>
        
        <pre><code>// 1. 使用 + 运算符连接
let string1 = "Hello"
let string2 = "World"
let combined = string1 + " " + string2  // "Hello World"

// 2. 使用字符串插值
let name = "Swift"
let message = "Hello, \(name)!"  // "Hello, Swift!"

// 3. 使用 append 方法
var greeting = "Hello"
greeting.append(", ")
greeting.append("Swift!")  // "Hello, Swift!"

// 4. 使用字符串插值进行复杂表达式
let a = 5
let b = 10
let result = "\(a) + \(b) = \(a + b)"  // "5 + 10 = 15"</code></pre>
        
        <h3>2.2 字符串访问与修改</h3>
        
        <pre><code>// 获取字符串的第一个字符
let greeting = "Hello, Swift!"
let firstChar = greeting.first  // 返回可选类型 Character?，值为 "H"

// 获取最后一个字符
let lastChar = greeting.last  // 返回可选类型 Character?，值为 "!"

// 字符串的遍历
for character in greeting {
    print(character)
}

// 使用字符串索引访问字符
let index = greeting.startIndex
let firstCharacter = greeting[index]  // "H"

// 访问指定位置的字符
let position = greeting.index(greeting.startIndex, offsetBy: 7)  // 偏移量为7的位置
let seventhChar = greeting[position]  // "S"

// 安全地访问指定位置字符
let safePosition = greeting.index(greeting.startIndex, offsetBy: 7, limitedBy: greeting.endIndex)
if let safePos = safePosition {
    let char = greeting[safePos]  // "S"
}

// 插入字符
var mutableGreeting = "Hello"
mutableGreeting.insert("!", at: mutableGreeting.endIndex)  // "Hello!"

// 插入字符串
mutableGreeting.insert(contentsOf: " Swift", at: mutableGreeting.index(before: mutableGreeting.endIndex))  // "Hello Swift!"

// 删除字符
var welcome = "Hello Swift!"
welcome.remove(at: welcome.index(before: welcome.endIndex))  // 删除最后一个字符 "!"
print(welcome)  // "Hello Swift"

// 删除子范围
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)  // 删除 " Swift"
print(welcome)  // "Hello"</code></pre>

        <h3>2.3 子字符串</h3>
        
        <svg width="100%" height="100" viewBox="0 0 600 100">
            <rect x="50" y="20" width="500" height="40" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <text x="300" y="45" text-anchor="middle" font-family="Courier New" font-size="16">"Hello, Swift!"</text>
            
            <rect x="100" y="70" width="300" height="30" rx="5" fill="#2ecc71" stroke="black" stroke-width="1" fill-opacity="0.6"/>
            <text x="250" y="90" text-anchor="middle" font-family="Courier New" font-size="14">Substring: "Hello, Swi"</text>
        </svg>
        
        <pre><code>let greeting = "Hello, Swift!"

// 使用字符串索引创建子字符串
let indexStart = greeting.startIndex
let indexEnd = greeting.index(greeting.startIndex, offsetBy: 5)
let substring = greeting[indexStart..<indexEnd]  // "Hello"

// 子字符串转换为字符串
let newString = String(substring)  // 将子字符串转换为独立的字符串

// 前缀和后缀
let hasPrefix = greeting.hasPrefix("Hello")  // true
let hasSuffix = greeting.hasSuffix("Swift!")  // true

// 使用范围截取子字符串
let range = greeting.index(greeting.startIndex, offsetBy: 7)..<greeting.endIndex
let subString = greeting[range]  // "Swift!"

// 截取到指定字符
if let commaIndex = greeting.firstIndex(of: ",") {
    let beforeComma = greeting[..<commaIndex]  // "Hello"
    let afterComma = greeting[greeting.index(after: commaIndex)...]  // " Swift!"
    
    // 转换为字符串以便长期存储
    let beforeString = String(beforeComma)
    let afterString = String(afterComma)
}</code></pre>

        <div class="note">
            <p><strong>注意</strong>：子字符串（Substring）和字符串（String）共享底层存储，因此子字符串只是原始字符串的一个视图。当你需要长期存储子字符串时，应将其转换为新的字符串。</p>
        </div>
        
        <h3>2.4 字符串比较</h3>
        
        <pre><code>// 字符串相等性比较
let string1 = "Hello"
let string2 = "Hello"
let string3 = "hello"

print(string1 == string2)  // true
print(string1 == string3)  // false
print(string1.lowercased() == string3.lowercased())  // true

// 使用 compare 方法
let result = string1.compare(string3, options: .caseInsensitive)
if result == .orderedSame {
    print("字符串相等（忽略大小写）")
}

// 前缀和后缀检查
let hasPrefix = string1.hasPrefix("He")  // true
let hasSuffix = string1.hasSuffix("lo")  // true

// 包含检查
let contains = string1.contains("ell")  // true</code></pre>
        
        <h2>3. 字符串格式化</h2>
        
        <h3>3.1 字符串插值</h3>
        
        <pre><code>// 基本字符串插值
let name = "Swift"
let age = 8
let message = "\(name) 已经 \(age) 岁了"

// 格式化数字
let pi = 3.14159
let formattedPi = String(format: "π 约等于 %.2f", pi)  // "π 约等于 3.14"

// 使用 NumberFormatter 进行高级格式化
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal
numberFormatter.maximumFractionDigits = 2
let number = 1234.5678
if let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
    print(formattedNumber)  // 根据区域设置格式化，例如 "1,234.57"
}

// 日期格式化
let now = Date()
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .long
dateFormatter.timeStyle = .short
let formattedDate = dateFormatter.string(from: now)  // "2023年6月15日 下午3:30"</code></pre>

        <h3>3.2 格式化对齐</h3>
        
        <pre><code>// 文本对齐和填充
let number = 42
let paddedNumber = String(format: "%05d", number)  // "00042"

let text = "Swift"
let paddedText = String(format: "%-10s", text)  // "Swift      " (左对齐，总长度10)
let rightAligned = String(format: "%10s", text)  // "     Swift" (右对齐，总长度10)

// 使用 Foundation 的格式化选项
import Foundation

let value = 12345.6789
let currencyFormatter = NumberFormatter()
currencyFormatter.numberStyle = .currency
currencyFormatter.locale = Locale(identifier: "zh_CN")
if let formatted = currencyFormatter.string(from: NSNumber(value: value)) {
    print(formatted)  // "¥12,345.68"
}</code></pre>
        
        <h2>4. Unicode 和字符串国际化</h2>
        
        <h3>4.1 Unicode 基础</h3>
        
        <svg width="100%" height="200" viewBox="0 0 600 200">
            <rect x="50" y="20" width="500" height="160" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <text x="300" y="50" text-anchor="middle" font-family="Courier New" font-weight="bold" font-size="20">Unicode 在 Swift 中的表示</text>
            
            <rect x="100" y="70" width="400" height="40" rx="5" fill="#f3c677" stroke="black" stroke-width="1"/>
            <text x="300" y="95" text-anchor="middle" font-family="Courier New" font-size="16">"Hello" = ['H','e','l','l','o']</text>
            
            <rect x="100" y="120" width="400" height="40" rx="5" fill="#f3c677" stroke="black" stroke-width="1"/>
            <text x="300" y="145" text-anchor="middle" font-family="Courier New" font-size="16">"👨‍👩‍👧‍👦" = 单个 Unicode 标量序列</text>
        </svg>
        
        <pre><code>// Unicode 标量
let dollarSign = "\u{24}"        // $
let blackHeart = "\u{2665}"      // ♥
let sparklingHeart = "\u{1F496}" // 💖

// 复合字符序列
let acuteE = "\u{65}\u{301}"     // é

// 计算字符数量
let complexEmoji = "👨‍👩‍👧‍👦"
print(complexEmoji.count)         // 1 (单个家庭表情符号)
print(complexEmoji.unicodeScalars.count)  // 7 (由多个Unicode标量组成)

// 遍历 Unicode 标量
for scalar in complexEmoji.unicodeScalars {
    print("\(scalar.value) ")  // 打印每个标量的数值
}

// 字符串规范化
let decomposed = "\u{e9}"        // é (单个 Unicode 标量)
let composed = "\u{65}\u{301}"   // e + ´ (两个 Unicode 标量组合)

print(decomposed == composed)    // true (Swift 自动规范化)</code></pre>
        
        <div class="note">
            <p>Swift 的字符串全面支持 Unicode，任何字符无论是英文字母、中文汉字、日文假名，还是表情符号，在 Swift 中都被视为等长的字符。这种设计使得 Swift 能够很好地处理全球各种文字和符号。</p>
        </div>
        
        <h3>4.2 文本本地化</h3>
        
        <pre><code>// 使用 NSLocalizedString 进行文本本地化
import Foundation

let greeting = NSLocalizedString(
    "Hello, world!",
    comment: "A greeting message"
)

// 带参数的本地化字符串
let format = NSLocalizedString(
    "Hello, %@!",
    comment: "A personalized greeting. The parameter is the person's name."
)
let personalizedGreeting = String(format: format, "Swift")</code></pre>
        
        <h2>5. 字符串性能优化</h2>
        
        <p>Swift 字符串的内部实现使用了一种高效的存储方式，它可以根据字符串内容自动选择最佳的内存布局。</p>
        
        <svg width="100%" height="180" viewBox="0 0 600 180">
            <rect x="50" y="20" width="500" height="140" rx="5" fill="#8b5d3a" stroke="black" stroke-width="2"/>
            <text x="300" y="50" text-anchor="middle" font-family="Courier New" font-weight="bold" font-size="18">Swift 字符串性能优化</text>
            
            <rect x="100" y="70" width="180" height="70" rx="5" fill="#2ecc71" stroke="black" stroke-width="1"/>
            <text x="190" y="100" text-anchor="middle" font-family="Courier New" font-size="14">Copy-on-Write</text>
            <text x="190" y="120" text-anchor="middle" font-family="Courier New" font-size="12">避免不必要的复制</text>
            
            <rect x="320" y="70" width="180" height="70" rx="5" fill="#2ecc71" stroke="black" stroke-width="1"/>
            <text x="410" y="100" text-anchor="middle" font-family="Courier New" font-size="14">String.Index</text>
            <text x="410" y="120" text-anchor="middle" font-family="Courier New" font-size="12">高效的Unicode处理</text>
        </svg>
        
        <pre><code>// 高效率的字符串操作

// 1. 使用容量预留减少重新分配
var greeting = ""
greeting.reserveCapacity(20)  // 预留空间，减少重新分配
for i in 1...10 {
    greeting.append("\(i), ")
}

// 2. 重用字符串索引
let message = "Hello, Swift!"
let startIndex = message.startIndex
let endIndex = message.endIndex

// 计算一次索引后重复使用
let fifthIndex = message.index(startIndex, offsetBy: 5)
let sixthIndex = message.index(after: fifthIndex)

// 3. 使用 contentsOf 一次添加多个字符，而不是多次调用 append
var text = "Hello"
text.append(contentsOf: ", World!")  // 比多次 append 单个字符更高效

// 4. 使用字符串字面量减少运行时开销
let staticText = "这是一个字符串字面量"  // 编译时已知，运行时开销小

// 5. 对于重复操作，考虑使用 NSMutableString
import Foundation
let nsString = NSMutableString(string: "Swift ")
for _ in 1...1000 {
    nsString.append("!")  // NSMutableString 针对重复操作进行了优化
}
let finalString = String(nsString)</code></pre>
        
        <h2>6. 实用技巧</h2>
        
        <h3>6.1 字符串分割与连接</h3>
        
        <pre><code>// 字符串分割
let csv = "apple,banana,orange,grape"
let fruits = csv.split(separator: ",")  // ["apple", "banana", "orange", "grape"]

// 指定最大分割数量
let limited = csv.split(separator: ",", maxSplits: 2)  // ["apple", "banana", "orange,grape"]

// 保留空元素
let data = "a,,b,c"
let elements = data.split(separator: ",", omittingEmptySubsequences: false)  // ["a", "", "b", "c"]

// 字符串数组连接
let words = ["Swift", "is", "awesome"]
let sentence = words.joined(separator: " ")  // "Swift is awesome"</code></pre>

        <h3>6.2 字符串搜索与替换</h3>
        
        <pre><code>// 基本搜索
let text = "Swift is a powerful language"
if let range = text.range(of: "powerful") {
    print("找到了单词!")
    let substring = text[range]  // "powerful"
}

// 不区分大小写搜索
if let range = text.range(of: "SWIFT", options: .caseInsensitive) {
    print("找到了不区分大小写的匹配!")
}

// 从末尾开始搜索
if let range = text.range(of: "a", options: .backwards) {
    print("从后向前找到了第一个'a'")
}

// 替换子字符串
var message = "Hello, world!"
if let range = message.range(of: "world") {
    message.replaceSubrange(range, with: "Swift")  // "Hello, Swift!"
}

// 替换所有出现的子字符串（使用Foundation）
import Foundation
let newMessage = message.replacingOccurrences(of: "l", with: "L")  // "HeLLo, Swift!"

// 使用正则表达式替换（使用Foundation）
let pattern = "\\b[A-Z]\\w+"  // 匹配以大写字母开头的单词
if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
    let modifiedString = regex.stringByReplacingMatches(
        in: "Hello Swift World",
        options: [],
        range: NSRange(location: 0, length: 17),
        withTemplate: "CODE"
    )  // "Hello CODE CODE"
}</code></pre>

        <h3>6.3 多行字符串</h3>
        
        <pre><code>// Swift 支持使用三个双引号的多行字符串字面量
let multilineString = """
这是一个多行字符串。
它可以跨越多行，
并保留格式。
    这行前面的空格会被保留。
"""

// 使用反斜杠连接行，避免换行符
let joinedLines = """
这行末尾有一个反斜杠 \
所以它会与下一行连接成一行
"""  // "这行末尾有一个反斜杠 所以它会与下一行连接成一行"

// 在多行字符串中使用引号
let quotedText = """
他说："多行字符串很方便！"
我回答："是的，"并且补充说："特别是处理 JSON 和 HTML！"
"""</code></pre>

        <h2>参考资源</h2>
        
        <div class="resource-section">
            <h3>官方文档</h3>
            <ul>
                <li><a href="https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html" target="_blank">Swift 官方文档 - 字符串与字符</a></li>
                <li><a href="https://developer.apple.com/documentation/swift/string" target="_blank">Apple Developer - String API 参考</a></li>
            </ul>
            
            <h3>推荐博客</h3>
            <ul>
                <li><a href="https://nshipster.com/swift-strings/" target="_blank">NSHipster - Swift 字符串详解</a></li>
                <li><a href="https://www.objc.io/issues/9-strings/string-localization/" target="_blank">objc.io - 字符串本地化</a></li>
                <li><a href="https://www.swiftbysundell.com/articles/string-parsing-in-swift/" target="_blank">Swift by Sundell - Swift 中的字符串解析</a></li>
            </ul>
            
            <h3>相关书籍</h3>
            <ul>
                <li>《Swift 进阶》 (Advanced Swift) - Chris Eidhof, Ole Begemann, Airspeed Velocity</li>
                <li>《Swift 编程权威指南》- 苹果官方 Swift 编程指南</li>
                <li>《Mastering Swift 5》- Jon Hoffman</li>
            </ul>
            
            <h3>开源项目</h3>
            <ul>
                <li><a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms</a> - 包含了许多字符串处理算法</li>
                <li><a href="https://github.com/apple/swift-markdown" target="_blank">Swift Markdown</a> - Swift 的 Markdown 解析库</li>
                <li><a href="https://github.com/malcommac/SwiftRichString" target="_blank">SwiftRichString</a> - 强大的字符串样式和属性字符串库</li>
            </ul>
            
            <h3>视频教程</h3>
            <ul>
                <li><a href="https://www.raywenderlich.com/3075-swift-strings" target="_blank">Ray Wenderlich - Swift 字符串详解</a></li>
                <li><a href="https://developer.apple.com/videos/play/wwdc2018/223/" target="_blank">WWDC 2018 - Swift 中的字符串</a></li>
            </ul>
        </div>
    </div>
</body>
</html>
