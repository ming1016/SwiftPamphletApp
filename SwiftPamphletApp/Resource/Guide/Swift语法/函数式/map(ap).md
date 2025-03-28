<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift函数式编程 - Map 函数详解</title>
    <style>
        :root {
            --text-color: #333;
            --background-color: #f8f4e9;
            --code-background: #f0e9d8;
            --accent-color: #e85a2c;
            --secondary-color: #75b7b7;
            --link-color: #d05a2c;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #e0dfd5;
                --background-color: #2a2a2a;
                --code-background: #3a3a3a;
                --accent-color: #ff7446;
                --secondary-color: #8dcfcf;
                --link-color: #ff9370;
            }
        }
        
        body {
            font-family: "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
            line-height: 1.7;
            color: var(--text-color);
            background-color: var(--background-color);
            background-image: url("data:image/svg+xml,%3Csvg width='100%25' height='100%25' xmlns='http://www.w3.org/2000/svg'%3E%3Cdefs%3E%3Cpattern id='pattern' width='100' height='100' patternUnits='userSpaceOnUse'%3E%3Crect width='100' height='100' fill='%23f8f4e9' opacity='0.3'/%3E%3Cpath d='M0 0L100 100M100 0L0 100' stroke='%23d9d2c0' stroke-width='1' opacity='0.2'/%3E%3C/pattern%3E%3C/defs%3E%3Crect width='100%25' height='100%25' fill='url(%23pattern)'/%3E%3C/svg%3E");
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--background-color);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            position: relative;
            overflow: hidden;
        }
        
        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 10px;
            background: linear-gradient(90deg, var(--accent-color), var(--secondary-color));
        }
        
        .ribbon {
            position: absolute;
            top: 40px;
            right: -50px;
            transform: rotate(45deg);
            background-color: var(--secondary-color);
            padding: 5px 50px;
            color: white;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            z-index: 100;
        }
        
        header {
            text-align: center;
            margin-bottom: 3rem;
            padding-bottom: 1rem;
            border-bottom: 2px dashed var(--secondary-color);
            position: relative;
        }
        
        h1 {
            color: var(--accent-color);
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        
        h2 {
            color: var(--accent-color);
            border-bottom: 1px solid var(--secondary-color);
            padding-bottom: 0.5rem;
            margin-top: 2.5rem;
        }
        
        h3 {
            color: var(--secondary-color);
            margin-top: 2rem;
        }
        
        p {
            margin-bottom: 1.5rem;
        }
        
        code {
            font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
            background-color: var(--code-background);
            padding: 2px 5px;
            border-radius: 3px;
        }
        
        pre {
            background-color: var(--code-background);
            padding: 1rem;
            border-radius: 5px;
            overflow-x: auto;
            position: relative;
            border-left: 4px solid var(--accent-color);
        }
        
        pre code {
            background-color: transparent;
            padding: 0;
            white-space: pre-wrap;
        }
        
        .code-title {
            position: absolute;
            top: 0;
            right: 0;
            background-color: var(--accent-color);
            color: white;
            padding: 2px 10px;
            font-size: 0.8rem;
            border-bottom-left-radius: 5px;
        }
        
        .note {
            background-color: var(--secondary-color);
            color: white;
            padding: 1rem;
            border-radius: 5px;
            margin: 1.5rem 0;
            position: relative;
        }
        
        .note::before {
            content: "📝 注意";
            font-weight: bold;
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .resources {
            background-color: rgba(var(--secondary-color-rgb), 0.1);
            padding: 1.5rem;
            border-radius: 5px;
            margin-top: 2rem;
            border: 1px dashed var(--secondary-color);
        }
        
        .resources h3 {
            margin-top: 0;
        }
        
        .resources ul {
            padding-left: 1.5rem;
        }
        
        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dashed var(--link-color);
            transition: all 0.3s ease;
        }
        
        a:hover {
            color: var(--accent-color);
            border-bottom-style: solid;
        }
        
        .illustration {
            text-align: center;
            margin: 2rem 0;
        }
        
        .illustration svg {
            max-width: 100%;
            height: auto;
        }
        
        .example-wrapper {
            margin: 2rem 0;
            padding: 1.5rem;
            border-radius: 8px;
            background-color: rgba(var(--accent-color-rgb), 0.05);
            border: 1px solid rgba(var(--accent-color-rgb), 0.2);
        }
        
        .example-title {
            font-weight: bold;
            color: var(--accent-color);
            margin-bottom: 0.5rem;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
        }
        
        th, td {
            padding: 0.75rem;
            text-align: left;
            border: 1px solid var(--secondary-color);
        }
        
        th {
            background-color: var(--secondary-color);
            color: white;
        }
        
        tr:nth-child(even) {
            background-color: rgba(var(--secondary-color-rgb), 0.1);
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
                margin: 1rem;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .ribbon {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="ribbon">Swift 函数式编程</div>
        <header>
            <h1>Swift 函数式编程：Map 详解</h1>
            <p>变换集合，优雅高效</p>
        </header>
        
        <section>
            <h2>什么是 Map 函数？</h2>
            <p>Map 是函数式编程中最基础、最常用的高阶函数之一。它接受一个函数作为参数，将这个函数应用于集合中的每一个元素，并返回一个包含所有转换后元素的新集合。本质上，map 是一种将集合从一种形式转换为另一种形式的操作，而不会改变原始集合。</p>
            
            <div class="illustration">
                <svg width="600" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
                    <!-- 输入数组 -->
                    <rect x="50" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="75" y="105" font-size="16" text-anchor="middle" fill="white">1</text>
                    
                    <rect x="110" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="135" y="105" font-size="16" text-anchor="middle" fill="white">2</text>
                    
                    <rect x="170" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="195" y="105" font-size="16" text-anchor="middle" fill="white">3</text>
                    
                    <!-- 映射函数 -->
                    <rect x="260" y="70" width="80" height="60" rx="10" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="300" y="105" font-size="16" text-anchor="middle" fill="white">x => x*2</text>
                    
                    <!-- 输出数组 -->
                    <rect x="380" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="405" y="105" font-size="16" text-anchor="middle" fill="white">2</text>
                    
                    <rect x="440" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="465" y="105" font-size="16" text-anchor="middle" fill="white">4</text>
                    
                    <rect x="500" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="525" y="105" font-size="16" text-anchor="middle" fill="white">6</text>
                    
                    <!-- 箭头 -->
                    <path d="M 230 100 L 250 100" stroke="#333" stroke-width="2" fill="none"/>
                    <polygon points="250,100 240,95 240,105" fill="#333"/>
                    
                    <path d="M 350 100 L 370 100" stroke="#333" stroke-width="2" fill="none"/>
                    <polygon points="370,100 360,95 360,105" fill="#333"/>
                    
                    <!-- 标签 -->
                    <text x="135" y="50" font-size="14" text-anchor="middle">原始数组</text>
                    <text x="300" y="50" font-size="14" text-anchor="middle">映射函数</text>
                    <text x="465" y="50" font-size="14" text-anchor="middle">结果数组</text>
                    
                    <text x="300" y="160" font-size="16" text-anchor="middle" font-style="italic">map 将函数应用于每个元素并返回新集合</text>
                </svg>
            </div>
        </section>
        
        <section>
            <h2>Swift 中的 Map 函数</h2>
            <p>在 Swift 中，map 是 Sequence 协议的扩展方法，这意味着所有遵循 Sequence 协议的类型（如 Array、Set、Dictionary 等）都可以使用 map 函数。</p>
            
            <h3>基本语法</h3>
            <pre><code>func map&lt;T&gt;(_ transform: (Element) throws -> T) rethrows -> [T]</code></pre>
            <p>其中:</p>
            <ul>
                <li><code>transform</code>: 用于转换每个元素的闭包</li>
                <li><code>Element</code>: 序列中元素的类型</li>
                <li><code>T</code>: 转换后元素的类型</li>
                <li>返回值: 包含转换后元素的数组</li>
            </ul>
        </section>
        
        <section>
            <h2>基础示例</h2>
            <div class="example-wrapper">
                <div class="example-title">示例 1: 数值转换</div>
                <pre><code>// 数字翻倍
let numbers = [1, 2, 3, 4, 5]
let doubled = numbers.map { $0 * 2 }
print(doubled) // 输出: [2, 4, 6, 8, 10]

// 单行箭头函数语法
let squared = numbers.map { num in num * num }
print(squared) // 输出: [1, 4, 9, 16, 25]</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">示例 2: 字符串处理</div>
                <pre><code>// 字符串转大写
let names = ["alice", "bob", "charlie"]
let uppercased = names.map { $0.uppercased() }
print(uppercased) // 输出: ["ALICE", "BOB", "CHARLIE"]

// 提取首字母
let firstLetters = names.map { $0.prefix(1).uppercased() }
print(firstLetters) // 输出: ["A", "B", "C"]</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">示例 3: 类型转换</div>
                <pre><code>// 字符串转整数
let stringNumbers = ["1", "2", "3", "4"]
let integers = stringNumbers.map { Int($0) } // [Optional(1), Optional(2), Optional(3), Optional(4)]

// 处理可选值
let safeIntegers = stringNumbers.map { Int($0) ?? 0 } 
print(safeIntegers) // 输出: [1, 2, 3, 4]</code></pre>
            </div>
        </section>
        
        <section>
            <h2>进阶用法</h2>
            
            <h3>在不同集合类型上使用 map</h3>
            <div class="example-wrapper">
                <div class="example-title">在字典上使用 map</div>
                <pre><code>// 字典的 map 操作会对每个键值对进行转换
let scores = ["Alice": 85, "Bob": 92, "Charlie": 78]

// map 处理整个键值对
let formattedScores = scores.map { (key, value) -> String in
    return "\(key): \(value)分"
}
print(formattedScores) // 输出: ["Alice: 85分", "Bob: 92分", "Charlie: 78分"]

// 只获取及格的学生
let passingStudents = scores.filter { $0.value >= 80 }
                           .map { $0.key }
print(passingStudents) // 输出: ["Alice", "Bob"]</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">在可选值上使用 map</div>
                <pre><code>// 可选值的 map 会在值存在时进行转换，否则保持为 nil
let optionalName: String? = "Swift"

// 使用 map 转换可选值内的内容
let nameLength = optionalName.map { $0.count }
print(nameLength) // 输出: Optional(5)

// 链式使用 map
let uppercasedLength = optionalName
    .map { $0.uppercased() }
    .map { $0.count }
print(uppercasedLength) // 输出: Optional(5)

// 当可选值为 nil 时
let emptyName: String? = nil
let emptyNameLength = emptyName.map { $0.count }
print(emptyNameLength) // 输出: nil</code></pre>
            </div>
            
            <h3>处理复杂对象</h3>
            <div class="example-wrapper">
                <div class="example-title">转换自定义对象数组</div>
                <pre><code>// 定义一个简单的用户模型
struct User {
    let id: Int
    let name: String
    let email: String
}

// 创建一些用户对象
let users = [
    User(id: 1, name: "Alice", email: "alice@example.com"),
    User(id: 2, name: "Bob", email: "bob@example.com"),
    User(id: 3, name: "Charlie", email: "charlie@example.com")
]

// 转换为简单的名称数组
let userNames = users.map { $0.name }
print(userNames) // 输出: ["Alice", "Bob", "Charlie"]

// 转换为字典数组
let userDicts = users.map { user -> [String: Any] in
    return ["id": user.id, "name": user.name]
}
print(userDicts) // 输出: [["name": "Alice", "id": 1], ["name": "Bob", "id": 2], ["name": "Charlie", "id": 3]]</code></pre>
            </div>
            
            <h3>结合其他函数式操作</h3>
            <div class="example-wrapper">
                <div class="example-title">map 与 filter、reduce 组合使用</div>
                <pre><code>let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 使用 map 和 filter 计算偶数的平方
let evenSquares = numbers
    .filter { $0 % 2 == 0 }  // 筛选偶数: [2, 4, 6, 8, 10]
    .map { $0 * $0 }         // 求平方: [4, 16, 36, 64, 100]
print(evenSquares) // 输出: [4, 16, 36, 64, 100]

// 使用 map 和 reduce 计算所有数字平方的总和
let sumOfSquares = numbers
    .map { $0 * $0 }        // 求平方: [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
    .reduce(0, +)           // 求和: 385
print(sumOfSquares) // 输出: 385</code></pre>
            </div>
        </section>
        
        <section>
            <h2>compactMap: 处理可选值</h2>
            <p>compactMap 是 map 的变体，它在应用转换函数后会过滤掉结果中的 nil 值。</p>
            
            <div class="illustration">
                <svg width="600" height="210" viewBox="0 0 600 210" xmlns="http://www.w3.org/2000/svg">
                    <!-- 输入数组 -->
                    <rect x="20" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="45" y="105" font-size="16" text-anchor="middle" fill="white">"1"</text>
                    
                    <rect x="80" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="105" y="105" font-size="16" text-anchor="middle" fill="white">"2"</text>
                    
                    <rect x="140" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="165" y="105" font-size="16" text-anchor="middle" fill="white">"三"</text>
                    
                    <rect x="200" y="80" width="50" height="40" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="225" y="105" font-size="16" text-anchor="middle" fill="white">"4"</text>
                    
                    <!-- 映射函数 -->
                    <rect x="290" y="70" width="80" height="60" rx="10" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="330" y="105" font-size="16" text-anchor="middle" fill="white">Int($0)</text>
                    
                    <!-- 中间结果 -->
                    <rect x="410" y="60" width="50" height="40" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="435" y="85" font-size="16" text-anchor="middle" fill="white">1</text>
                    
                    <rect x="470" y="60" width="50" height="40" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="495" y="85" font-size="16" text-anchor="middle" fill="white">2</text>
                    
                    <rect x="530" y="60" width="50" height="40" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2" stroke-dasharray="4"/>
                    <text x="555" y="85" font-size="16" text-anchor="middle" fill="#e85a2c">nil</text>
                    
                    <rect x="410" y="110" width="50" height="40" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="435" y="135" font-size="16" text-anchor="middle" fill="white">4</text>
                    
                    <!-- 箭头1 -->
                    <path d="M 260 100 L 280 100" stroke="#333" stroke-width="2" fill="none"/>
                    <polygon points="280,100 270,95 270,105" fill="#333"/>
                    
                    <!-- 箭头2 -->
                    <path d="M 380 100 L 400 100" stroke="#333" stroke-width="2" fill="none"/>
                    <polygon points="400,100 390,95 390,105" fill="#333"/>
                    
                    <!-- 结果过滤 -->
                    <path d="M 430 160 L 460 180 L 490 160" stroke="#333" stroke-width="2" fill="none"/>
                    <path d="M 555 160 L 555 180" stroke="#e85a2c" stroke-width="2" stroke-dasharray="4" fill="none"/>
                    <text x="555" y="170" font-size="20" text-anchor="middle" fill="#e85a2c">✕</text>
                    
                    <!-- 最终结果 -->
                    <rect x="410" y="180" width="170" height="30" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="495" y="200" font-size="16" text-anchor="middle" fill="white">[1, 2, 4]</text>
                    
                    <!-- 标签 -->
                    <text x="135" y="40" font-size="14" text-anchor="middle">原始字符串数组</text>
                    <text x="330" y="40" font-size="14" text-anchor="middle">转换函数</text>
                    <text x="495" y="40" font-size="14" text-anchor="middle">转换后结果（带 nil）</text>
                    <text x="495" y="160" font-size="13" text-anchor="middle">过滤掉 nil 值</text>
                </svg>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">compactMap 基本用法</div>
                <pre><code>// 将字符串转换为数字，忽略无法转换的值
let strings = ["1", "2", "three", "4", "5"]

// 使用常规 map
let numbersWithNil = strings.map { Int($0) }
print(numbersWithNil) // 输出: [Optional(1), Optional(2), nil, Optional(4), Optional(5)]

// 使用 compactMap 自动过滤 nil
let numbers = strings.compactMap { Int($0) }
print(numbers) // 输出: [1, 2, 4, 5]</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">处理嵌套数组</div>
                <pre><code>// 提取多个 URL 字符串中的有效 URL
let urlStrings = [
    "https://apple.com", 
    "invalid-url", 
    "https://swift.org", 
    "file://"
]

let urls = urlStrings.compactMap { URL(string: $0) }
print(urls) // 输出: 包含两个有效的 URL 对象数组</code></pre>
            </div>
        </section>
        
        <section>
            <h2>flatMap: 处理嵌套集合</h2>
            <p>flatMap 是另一个 map 的变体，它处理嵌套集合并将结果"展平"成单层集合。</p>
            
            <div class="illustration">
                <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                    <!-- 输入嵌套数组 -->
                    <rect x="30" y="50" width="200" height="150" rx="10" fill="transparent" stroke="#333" stroke-width="2" stroke-dasharray="5,5"/>
                    
                    <rect x="50" y="80" width="50" height="30" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="75" y="100" font-size="14" text-anchor="middle" fill="white">1</text>
                    
                    <rect x="110" y="80" width="50" height="30" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="135" y="100" font-size="14" text-anchor="middle" fill="white">2</text>
                    
                    <rect x="50" y="130" width="50" height="30" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="75" y="150" font-size="14" text-anchor="middle" fill="white">3</text>
                    
                    <rect x="110" y="130" width="50" height="30" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="135" y="150" font-size="14" text-anchor="middle" fill="white">4</text>
                    
                    <rect x="170" y="130" width="50" height="30" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="195" y="150" font-size="14" text-anchor="middle" fill="white">5</text>
                    
                    <!-- flatMap 箭头 -->
                    <path d="M 260 125 L 330 125" stroke="#333" stroke-width="2" fill="none"/>
                    <text x="295" y="115" font-size="14" text-anchor="middle">flatMap</text>
                    <polygon points="330,125 320,120 320,130" fill="#333"/>
                    
                    <!-- 结果数组 -->
                    <rect x="350" y="90" width="230" height="60" rx="10" fill="transparent" stroke="#333" stroke-width="2"/>
                    
                    <rect x="360" y="105" width="40" height="30" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="380" y="125" font-size="14" text-anchor="middle" fill="white">1</text>
                    
                    <rect x="410" y="105" width="40" height="30" rx="5" fill="#e85a2c" stroke="#333" stroke-width="2"/>
                    <text x="430" y="125" font-size="14" text-anchor="middle" fill="white">2</text>
                    
                    <rect x="460" y="105" width="40" height="30" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="480" y="125" font-size="14" text-anchor="middle" fill="white">3</text>
                    
                    <rect x="510" y="105" width="40" height="30" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="530" y="125" font-size="14" text-anchor="middle" fill="white">4</text>
                    
                    <rect x="560" y="105" width="40" height="30" rx="5" fill="#75b7b7" stroke="#333" stroke-width="2"/>
                    <text x="580" y="125" font-size="14" text-anchor="middle" fill="white">5</text>
                    
                    <!-- 标签 -->
                    <text x="130" y="40" font-size="14" text-anchor="middle">嵌套数组 [[1,2], [3,4,5]]</text>
                    <text x="465" y="70" font-size="14" text-anchor="middle">展平后数组 [1,2,3,4,5]</text>
                    <text x="300" y="185" font-size="16" text-anchor="middle" font-style="italic">flatMap 将嵌套集合展平为单一层级</text>
                </svg>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">flatMap 基本用法</div>
                <pre><code>// 展平嵌套数组
let nestedArray = [[1, 2, 3], [4, 5], [6]]
let flattened = nestedArray.flatMap { $0 }
print(flattened) // 输出: [1, 2, 3, 4, 5, 6]

// 和 map 组合使用
let sentences = ["Hello world", "Swift is awesome"]
let words = sentences.flatMap { $0.split(separator: " ") }
print(words) // 输出: ["Hello", "world", "Swift", "is", "awesome"]</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">实际应用示例</div>
                <pre><code>// 扁平化处理多个数据源
let teamA = ["Alice", "Bob"]
let teamB = ["Charlie", "Dave"]
let teamC = ["Eve"]

let allTeams = [teamA, teamB, teamC]

// 获取所有成员
let allMembers = allTeams.flatMap { $0 }
print(allMembers) // 输出: ["Alice", "Bob", "Charlie", "Dave", "Eve"]

// 结合 map 和 flatMap
struct Team {
    let name: String
    let members: [String]
}

let teams = [
    Team(name: "Engineering", members: ["Alice", "Bob"]),
    Team(name: "Design", members: ["Charlie", "Dave"]),
    Team(name: "Marketing", members: ["Eve"])
]

// 获取所有团队成员
let allPeople = teams.flatMap { $0.members }
print(allPeople) // 输出: ["Alice", "Bob", "Charlie", "Dave", "Eve"]</code></pre>
            </div>
        </section>
        
        <section>
            <h2>性能考虑</h2>
            <p>虽然 map 函数使代码简洁易读，但在某些情况下需要考虑性能影响:</p>
            
            <div class="note">
                <p>对于大型集合，map 会创建一个全新的集合来存储结果，这可能比传统的 for 循环消耗更多内存。</p>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">内存使用比较</div>
                <pre><code>// 使用 map（创建新数组）
func doubleWithMap(_ array: [Int]) -> [Int] {
    return array.map { $0 * 2 }
}

// 使用传统 for 循环（创建新数组）
func doubleWithForLoop(_ array: [Int]) -> [Int] {
    var result = [Int]()
    result.reserveCapacity(array.count) // 预分配内存以提高性能
    
    for number in array {
        result.append(number * 2)
    }
    
    return result
}

// 使用 in-place 修改（仅当可变集合且不需保留原始数据时适用）
func doubleInPlace(_ array: inout [Int]) {
    for i in 0..<array.count {
        array[i] *= 2
    }
}</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">链式操作的性能优化</div>
                <pre><code>// 链式使用多个 map 会创建多个中间集合
let numbers = [1, 2, 3, 4, 5]

// 低效: 创建两个中间数组
let result1 = numbers.map { $0 * 2 }.map { $0 + 1 }

// 更高效: 仅创建一个新数组
let result2 = numbers.map { ($0 * 2) + 1 }</code></pre>
            </div>
            
            <p>在实际应用中，大多数情况下 map 的性能足够好，其带来的代码可读性和维护性优势通常超过了性能损失。只有在处理非常大的数据集或性能关键型应用时，才需要特别关注这些优化。</p>
        </section>
        
        <section>
            <h2>最佳实践</h2>
            <ul>
                <li><strong>保持简洁</strong>: map 闭包应该简短且专注于一个转换操作。</li>
                <li><strong>类型选择</strong>: 根据需求选择 map, compactMap 或 flatMap。</li>
                <li><strong>链式使用</strong>: 合理组合 map 与其他高阶函数，但避免过多链式操作。</li>
                <li><strong>命名明确</strong>: 使用有意义的变量名来表示转换的目的。</li>
                <li><strong>注意性能</strong>: 在处理大数据集时，考虑使用惰性集合或替代方法。</li>
            </ul>
            
            <div class="example-wrapper">
                <div class="example-title">推荐做法示例</div>
                <pre><code>// ✅ 良好实践
// 简洁清晰的变量名和转换
let userIds = users.map { $0.id }

// 避免嵌套，使用正确的函数
let validEmails = users
    .compactMap { $0.email.isEmpty ? nil : $0.email }

// 使用类型注解提高可读性
let userModels = jsonData.map { data -> UserModel in
    return UserModel(from: data)
}</code></pre>
            </div>
            
            <div class="example-wrapper">
                <div class="example-title">避免的做法</div>
                <pre><code>// ❌ 不推荐
// 过于复杂的闭包
let processed = data.map { item in
    let a = process1(item)
    if a > 10 {
        return process2(a)
    } else {
        return process3(a)
    }
}

// 过多的链式调用
let result = array
    .map { $0.uppercased() }
    .map { $0.trimmingCharacters(in: .whitespaces) }
    .map { "\($0)!" }
    
// 更好的方式:
let betterResult = array.map { 
    $0.uppercased().trimmingCharacters(in: .whitespaces) + "!"
}</code></pre>
            </div>
        </section>
        
        <section class="resources">
            <h2>参考资源</h2>
            
            <h3>官方文档</h3>
            <ul>
                <li><a href="https://developer.apple.com/documentation/swift/array/3017522-map" target="_blank">Swift 官方文档: Array.map</a></li>
                <li><a href="https://developer.apple.com/documentation/swift/array/3126923-compactmap" target="_blank">Swift 官方文档: Array.compactMap</a></li>
                <li><a href="https://developer.apple.com/documentation/swift/array/2905332-flatmap" target="_blank">Swift 官方文档: Array.flatMap</a></li>
            </ul>
            
            <h3>优秀博客文章</h3>
            <ul>
                <li><a href="https://www.swiftbysundell.com/articles/map-flatmap-and-compactmap-explained/" target="_blank">Swift by Sundell: Map, FlatMap 和 CompactMap 详解</a></li>
                <li><a href="https://www.hackingwithswift.com/articles/205/whats-the-difference-between-map-flatmap-and-compactmap" target="_blank">Hacking with Swift: map, flatMap 和 compactMap 的区别</a></li>
                <li><a href="https://www.objc.io/blog/2014/12/08/functional-snippet-5-map/" target="_blank">objc.io: 函数式编程之 map</a></li>
            </ul>
            
            <h3>推荐书籍</h3>
            <ul>
                <li>《Functional Swift》by Chris Eidhof, Florian Kugler, and Wouter Swierstra</li>
                <li>《Swift in Depth》by Tjeerd in 't Veen（特别推荐第8章关于函数式编程的内容）</li>
                <li>《Advanced Swift》by Chris Eidhof, Ole Begemann, and Airspeed Velocity</li>
            </ul>
            
            <h3>视频教程</h3>
            <ul>
                <li><a href="https://www.pointfree.co/episodes/ep1-functions" target="_blank">Point-Free: 函数式编程基础</a></li>
                <li><a href="https://www.raywenderlich.com/3925-functional-programming-with-swift" target="_blank">Ray Wenderlich: Swift 函数式编程</a></li>
            </ul>
            
            <h3>相关开源项目</h3>
            <ul>
                <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 响应式编程框架，广泛使用函数式概念</li>
                <li><a href="https://github.com/pointfreeco/swift-overture" target="_blank">Overture</a> - 函数式编程工具库</li>
                <li><a href="https://github.com/typelift/Swiftz" target="_blank">Swiftz</a> - 函数式编程库</li>
            </ul>
        </section>
    </div>
    
    <script>
        // 暗黑模式切换增强
        const isDarkMode = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
        
        // 为SVG图形动态添加暗黑模式支持
        if (isDarkMode) {
            document.querySelectorAll('svg').forEach(svg => {
                const styles = document.createElementNS("http://www.w3.org/2000/svg", "style");
                styles.textContent = `
                    text { fill: #e0dfd5 }
                    path[stroke="#333"] { stroke: #ccc }
                    polygon[fill="#333"] { fill: #ccc }
                    rect[stroke="#333"] { stroke: #ccc }
                `;
                svg.appendChild(styles);
            });
        }
    </script>
</body>
</html>
