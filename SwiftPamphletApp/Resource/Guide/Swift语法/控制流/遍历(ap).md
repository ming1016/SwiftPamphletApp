<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift控制流：遍历</title>
    <style>
        :root {
            --background-color: #c4e6d0;
            --text-color: #444;
            --code-background: #f0f8f4;
            --link-color: #5a8f71;
            --heading-color: #3c6e51;
            --border-color: #8bbd9e;
            --accent-color: #ff7d45;
            --secondary-color: #9bb8a9;
            --box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            --font-pixel: 'Courier New', monospace;
            --pixel-border: 2px solid var(--border-color);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #1e332a;
                --text-color: #d2e7dd;
                --code-background: #2c443c;
                --link-color: #8ccaa8;
                --heading-color: #a0ddbb;
                --border-color: #4d7b65;
                --accent-color: #ff9e6b;
                --secondary-color: #4e6b5d;
                --box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
            }
        }

        body {
            background-color: var(--background-color);
            color: var(--text-color);
            font-family: var(--font-pixel);
            line-height: 1.6;
            margin: 0;
            padding: 0;
            image-rendering: pixelated;
        }

        .container {
            max-width: 960px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            text-align: center;
            padding: 20px;
            margin-bottom: 30px;
            border-bottom: var(--pixel-border);
            position: relative;
        }

        header::after {
            content: "";
            display: block;
            height: 4px;
            background: repeating-linear-gradient(
                to right,
                var(--accent-color),
                var(--accent-color) 8px,
                transparent 8px,
                transparent 16px
            );
            margin-top: 10px;
        }

        h1, h2, h3, h4 {
            color: var(--heading-color);
            margin-top: 30px;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        h1 {
            font-size: 2.5em;
            text-shadow: 2px 2px 0 var(--secondary-color);
        }

        h2 {
            font-size: 1.8em;
            border-bottom: 4px solid var(--accent-color);
            padding-bottom: 8px;
            display: inline-block;
        }

        h3 {
            font-size: 1.4em;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 2px dashed var(--link-color);
            transition: all 0.3s;
        }

        a:hover {
            color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .code-container {
            margin: 20px 0;
            border: var(--pixel-border);
            border-left: 8px solid var(--accent-color);
            box-shadow: var(--box-shadow);
        }

        pre {
            background-color: var(--code-background);
            padding: 15px;
            overflow-x: auto;
            margin: 0;
        }

        code {
            font-family: 'Courier New', monospace;
            color: var(--accent-color);
        }

        .note {
            background-color: var(--secondary-color);
            padding: 15px;
            border-left: 8px solid var(--accent-color);
            margin: 20px 0;
            box-shadow: var(--box-shadow);
        }

        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 40px;
        }

        .resource-card {
            border: var(--pixel-border);
            padding: 15px;
            background-color: var(--code-background);
            box-shadow: var(--box-shadow);
            transition: transform 0.3s;
        }

        .resource-card:hover {
            transform: translateY(-5px);
        }

        .resource-type {
            font-size: 0.8em;
            color: var(--accent-color);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        figure {
            text-align: center;
            margin: 30px 0;
        }

        figure svg {
            max-width: 100%;
            height: auto;
        }

        figcaption {
            color: var(--secondary-color);
            font-style: italic;
            margin-top: 10px;
        }

        .pixelated {
            image-rendering: pixelated;
            image-rendering: -moz-crisp-edges;
            image-rendering: crisp-edges;
        }

        .example-section {
            margin: 30px 0;
            padding: 20px;
            border: var(--pixel-border);
            background-color: var(--code-background);
            box-shadow: var(--box-shadow);
        }

        @media screen and (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            h1 {
                font-size: 2em;
            }
            
            .resources {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Swift控制流：遍历</h1>
            <p>探索Swift中强大而灵活的遍历方式</p>
        </header>

        <section>
            <h2>概述</h2>
            <p>Swift提供了丰富的遍历方式，可以遍历集合、序列和其他可迭代的数据结构。本章将详细讲解Swift中的各种遍历方法，以及它们的用法和适用场景。</p>
            
            <figure>
                <svg width="500" height="200" viewBox="0 0 500 200" xmlns="http://www.w3.org/2000/svg" class="pixelated">
                    <rect x="20" y="20" width="460" height="160" fill="var(--code-background)" stroke="var(--border-color)" stroke-width="4"/>
                    <rect x="40" y="50" width="60" height="60" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <rect x="120" y="50" width="60" height="60" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <rect x="200" y="50" width="60" height="60" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <rect x="280" y="50" width="60" height="60" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <rect x="360" y="50" width="60" height="60" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <path d="M40 130 L100 130 L120 150 L180 150 L200 130 L260 130 L280 150 L340 150 L360 130 L420 130" stroke="var(--link-color)" stroke-width="4" fill="transparent"/>
                    <text x="250" y="180" text-anchor="middle" fill="var(--text-color)">遍历集合元素</text>
                </svg>
                <figcaption>Swift中的遍历示意图</figcaption>
            </figure>
        </section>

        <section>
            <h2>for-in 循环</h2>
            <p>for-in 循环是Swift中最常用的遍历方式，可用于遍历数组、字典、集合、范围、字符串等。</p>

            <div class="example-section">
                <h3>数组遍历</h3>
                <div class="code-container">
                    <pre><code>// 遍历数组
let fruits = ["苹果", "香蕉", "橙子", "葡萄"]

// 基本遍历
for fruit in fruits {
    print("我喜欢吃\(fruit)")
}

// 带索引遍历
for (index, fruit) in fruits.enumerated() {
    print("\(index + 1). \(fruit)")
}</code></pre>
                </div>
            </div>

            <div class="example-section">
                <h3>字典遍历</h3>
                <div class="code-container">
                    <pre><code>// 遍历字典
let heights = ["小明": 175, "小红": 165, "小刚": 180]

// 同时获取键和值
for (name, height) in heights {
    print("\(name)的身高是\(height)厘米")
}

// 只遍历键
for name in heights.keys {
    print(name)
}

// 只遍历值
for height in heights.values {
    print(height)</code></pre>
                </div>
            </div>

            <div class="example-section">
                <h3>范围遍历</h3>
                <div class="code-container">
                    <pre><code>// 遍历范围
// 闭区间范围 1到5，包含5
for i in 1...5 {
    print("数字: \(i)")
}

// 半开区间范围 1到4，不包含5
for i in 1..<5 {
    print("数字: \(i)")
}

// 带步长的范围 (Swift 5.1+)
for i in stride(from: 0, to: 10, by: 2) {
    print("偶数: \(i)") // 输出 0, 2, 4, 6, 8
}

// 逆序遍历
for i in (1...5).reversed() {
    print("倒数: \(i)") // 输出 5, 4, 3, 2, 1
}</code></pre>
                </div>
            </div>

            <div class="example-section">
                <h3>字符串遍历</h3>
                <div class="code-container">
                    <pre><code>// 遍历字符串中的字符
let greeting = "你好，Swift!"
for character in greeting {
    print(character)
}</code></pre>
                </div>
            </div>
        </section>

        <section>
            <h2>forEach 方法</h2>
            <p>forEach是Swift标准库中的一个高阶函数，它提供了另一种遍历集合的方式。</p>

            <figure>
                <svg width="500" height="200" viewBox="0 0 500 200" xmlns="http://www.w3.org/2000/svg" class="pixelated">
                    <rect x="50" y="50" width="400" height="100" fill="var(--code-background)" stroke="var(--border-color)" stroke-width="4"/>
                    <text x="250" y="90" text-anchor="middle" fill="var(--heading-color)" font-size="16">for-in vs forEach</text>
                    <text x="150" y="120" text-anchor="middle" fill="var(--text-color)" font-size="12">允许使用break/continue</text>
                    <text x="350" y="120" text-anchor="middle" fill="var(--text-color)" font-size="12">闭包形式，不能中断循环</text>
                    <path d="M250 100 L250 140" stroke="var(--border-color)" stroke-width="2"/>
                </svg>
                <figcaption>for-in 与 forEach 对比</figcaption>
            </figure>

            <div class="example-section">
                <h3>forEach基本用法</h3>
                <div class="code-container">
                    <pre><code>// 使用forEach遍历数组
let numbers = [1, 2, 3, 4, 5]

numbers.forEach { number in
    print("数字是: \(number)")
}

// 使用简写参数名
numbers.forEach {
    print("数字是: \($0)")
}</code></pre>
                </div>
            </div>

            <div class="note">
                <p><strong>注意：</strong> forEach 与 for-in 的主要区别：</p>
                <ul>
                    <li>forEach 使用闭包语法</li>
                    <li>forEach 不能使用 break 或 continue 来控制循环流程</li>
                    <li>forEach 不能使用 return 跳出整个循环，只能跳出当前闭包迭代</li>
                </ul>
            </div>

            <div class="example-section">
                <h3>forEach与for-in对比示例</h3>
                <div class="code-container">
                    <pre><code>// for-in 可以使用break和continue
for number in numbers {
    if number == 3 {
        break // 遇到3就停止循环
    }
    print("for-in: \(number)")
}

// forEach 无法使用break和continue
numbers.forEach { number in
    // 下面这行会导致编译错误
    // if number == 3 { break }
    
    print("forEach: \(number)")
    
    // 只能跳过当前闭包迭代，不能跳出整个循环
    if number == 3 {
        return
    }
    
    print("处理数字: \(number)")
}</code></pre>
                </div>
            </div>
        </section>

        <section>
            <h2>while 循环</h2>
            <p>while 循环在满足条件时重复执行代码块。它在进入循环前先判断条件。</p>

            <div class="example-section">
                <h3>while基本用法</h3>
                <div class="code-container">
                    <pre><code>// 基本while循环
var counter = 0
while counter < 5 {
    print("当前计数: \(counter)")
    counter += 1
}

// 使用while循环读取数据直到满足条件
func processData() {
    var data = fetchNextDataItem()
    while data != nil {
        // 处理数据
        process(data!)
        data = fetchNextDataItem()
    }
}

// 模拟函数
func fetchNextDataItem() -> String? {
    // 实现获取数据的逻辑
    return nil
}

func process(_ data: String) {
    // 实现处理数据的逻辑
}</code></pre>
                </div>
            </div>
        </section>

        <section>
            <h2>repeat-while 循环</h2>
            <p>repeat-while 循环（其他语言中称为 do-while）先执行一次代码块，然后再判断条件。它至少会执行一次。</p>

            <div class="example-section">
                <h3>repeat-while基本用法</h3>
                <div class="code-container">
                    <pre><code>// 基本repeat-while循环
var counter = 0
repeat {
    print("当前计数: \(counter)")
    counter += 1
} while counter < 5

// 即使条件一开始就不满足，也会执行一次
var num = 10
repeat {
    print("这句话会被打印，尽管条件不满足")
    num += 1
} while num < 10</code></pre>
                </div>
            </div>

            <figure>
                <svg width="500" height="300" viewBox="0 0 500 300" xmlns="http://www.w3.org/2000/svg" class="pixelated">
                    <rect x="10" y="10" width="230" height="280" fill="var(--code-background)" stroke="var(--border-color)" stroke-width="4"/>
                    <text x="125" y="40" text-anchor="middle" fill="var(--heading-color)">while循环</text>
                    <circle cx="125" cy="70" r="25" fill="var(--secondary-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <text x="125" y="75" text-anchor="middle" fill="var(--text-color)" font-size="12">条件判断</text>
                    <rect x="85" y="120" width="80" height="40" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <text x="125" y="145" text-anchor="middle" fill="var(--code-background)" font-size="12">执行代码</text>
                    <path d="M125 95 L125 120" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrow)"/>
                    <path d="M125 160 L125 180 L50 180 L50 70 L100 70" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrow)"/>
                    <path d="M150 70 L200 70 L200 190 L125 190" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrow)"/>
                    <text x="160" y="60" fill="var(--text-color)" font-size="10">条件为假</text>
                    <text x="70" y="165" fill="var(--text-color)" font-size="10">条件为真</text>
                    
                    <rect x="260" y="10" width="230" height="280" fill="var(--code-background)" stroke="var(--border-color)" stroke-width="4"/>
                    <text x="375" y="40" text-anchor="middle" fill="var(--heading-color)">repeat-while循环</text>
                    <rect x="335" y="70" width="80" height="40" fill="var(--accent-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <text x="375" y="95" text-anchor="middle" fill="var(--code-background)" font-size="12">执行代码</text>
                    <circle cx="375" cy="150" r="25" fill="var(--secondary-color)" stroke="var(--border-color)" stroke-width="2"/>
                    <text x="375" y="155" text-anchor="middle" fill="var(--text-color)" font-size="12">条件判断</text>
                    <path d="M375 110 L375 125" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrow)"/>
                    <path d="M375 175 L375 195 L300 195 L300 70 L335 70" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrow)"/>
                    <path d="M400 150 L450 150 L450 200 L375 200" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrow)"/>
                    <text x="410" y="140" fill="var(--text-color)" font-size="10">条件为假</text>
                    <text x="320" y="180" fill="var(--text-color)" font-size="10">条件为真</text>
                    
                    <defs>
                        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
                            <path d="M0,0 L0,6 L9,3 z" fill="var(--text-color)" />
                        </marker>
                    </defs>
                </svg>
                <figcaption>while 和 repeat-while 循环流程对比</figcaption>
            </figure>
        </section>

        <section>
            <h2>序列和迭代器</h2>
            <p>Swift的Sequence和IteratorProtocol协议是遍历功能的基础。了解它们可以帮助你创建自定义可遍历类型。</p>

            <div class="example-section">
                <h3>自定义迭代器示例</h3>
                <div class="code-container">
                    <pre><code>// 创建一个斐波那契数列迭代器
struct FibonacciIterator: IteratorProtocol {
    var state = (0, 1)
    
    // next方法是IteratorProtocol协议的要求
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

// 创建斐波那契序列
struct FibonacciSequence: Sequence {
    // makeIterator方法是Sequence协议的要求
    func makeIterator() -> FibonacciIterator {
        return FibonacciIterator()
    }
}

// 使用自定义序列
let fibonacci = FibonacciSequence()
var count = 0

// 使用for-in遍历自定义序列
for number in fibonacci {
    if count == 10 { break }
    print("斐波那契数列第\(count+1)个数: \(number)")
    count += 1
}</code></pre>
                </div>
            </div>

            <div class="note">
                <p><strong>Sequence协议与IteratorProtocol的关系：</strong></p>
                <ul>
                    <li>Sequence协议需要提供makeIterator()方法，返回一个符合IteratorProtocol的迭代器</li>
                    <li>IteratorProtocol需要提供next()方法，每次调用返回序列中的下一个元素，或在序列结束时返回nil</li>
                    <li>for-in循环是对这些协议的语法糖，使遍历更易于使用</li>
                </ul>
            </div>
        </section>

        <section>
            <h2>标签语句与转移控制</h2>
            <p>Swift提供了标签语句和控制转移语句，可以更精确地控制循环流程。</p>

            <div class="example-section">
                <h3>控制转移语句</h3>
                <div class="code-container">
                    <pre><code>// break语句 - 立即结束整个循环的执行
for i in 1...10 {
    if i > 5 {
        print("大于5，跳出循环")
        break
    }
    print("当前数字: \(i)")
}

// continue语句 - 跳过当前迭代，进入下一次迭代
for i in 1...10 {
    if i % 2 == 0 {
        continue // 跳过偶数
    }
    print("奇数: \(i)")
}</code></pre>
                </div>
            </div>

            <div class="example-section">
                <h3>标签语句</h3>
                <div class="code-container">
                    <pre><code>// 使用标签控制嵌套循环
outerLoop: for i in 1...3 {
    for j in 1...3 {
        if i == 2 && j == 2 {
            print("跳出外层循环")
            break outerLoop // 跳出标记为outerLoop的循环
        }
        print("i = \(i), j = \(j)")
    }
}

// 使用标签和continue
rowLoop: for row in 1...3 {
    for column in 1...3 {
        if row == 1 && column == 1 {
            continue rowLoop // 跳过第一行的剩余列
        }
        print("(\(row), \(column))")
    }
}</code></pre>
                </div>
            </div>
        </section>

        <section>
            <h2>高级遍历技巧</h2>

            <div class="example-section">
                <h3>过滤和变换</h3>
                <div class="code-container">
                    <pre><code>// 使用filter过滤集合
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let evens = numbers.filter { $0 % 2 == 0 }
print("偶数: \(evens)")

// 使用map变换集合
let squares = numbers.map { $0 * $0 }
print("平方: \(squares)")

// 链式操作
let evenSquares = numbers.filter { $0 % 2 == 0 }.map { $0 * $0 }
print("偶数的平方: \(evenSquares)")</code></pre>
                </div>
            </div>

            <div class="example-section">
                <h3>惰性遍历</h3>
                <div class="code-container">
                    <pre><code>// 使用lazy进行惰性求值
let largeNumbers = Array(1...1000000)
let lazySquares = largeNumbers.lazy.map { number -> Int in
    print("计算\(number)的平方")
    return number * number
}

print("准备获取第五个元素")
let fifthSquare = lazySquares[4] // 只会计算前5个元素的平方
print("第五个元素是: \(fifthSquare)")</code></pre>
                </div>
            </div>

            <div class="example-section">
                <h3>zip组合遍历</h3>
                <div class="code-container">
                    <pre><code>// 使用zip同时遍历两个集合
let names = ["小明", "小红", "小刚"]
let scores = [95, 87, 92]

for (name, score) in zip(names, scores) {
    print("\(name)的分数是\(score)分")
}

// 当两个集合长度不同时，只遍历到较短集合的长度
let moreScores = [95, 87, 92, 88, 76]
for (name, score) in zip(names, moreScores) {
    // 只会遍历3个元素
    print("\(name)的分数是\(score)分")
}</code></pre>
                </div>
            </div>
        </section>

        <section>
            <h2>性能考量与最佳实践</h2>
            
            <div class="note">
                <h3>性能提示</h3>
                <ul>
                    <li>对于大数据集，使用 for-in 循环通常比 forEach 更高效</li>
                    <li>使用 lazy 集合可以避免不必要的计算</li>
                    <li>尽可能避免在循环中创建临时对象</li>
                    <li>考虑使用 stride() 而不是创建中间数组来遍历范围</li>
                    <li>对于频繁迭代的代码，考虑使用unsafe指针以提高性能（仅适用于高级场景）</li>
                </ul>
            </div>

            <div class="example-section">
                <h3>最佳实践示例</h3>
                <div class="code-container">
                    <pre><code>// 低效方式: 在循环中创建临时数组
func inefficientSum(_ maxValue: Int) -> Int {
    var sum = 0
    for i in Array(1...maxValue) { // 创建临时数组
        sum += i
    }
    return sum
}

// 高效方式: 直接使用范围
func efficientSum(_ maxValue: Int) -> Int {
    var sum = 0
    for i in 1...maxValue {
        sum += i
    }
    return sum
}

// 更高效的方式: 使用数学公式
func mostEfficientSum(_ maxValue: Int) -> Int {
    return maxValue * (maxValue + 1) / 2
}</code></pre>
                </div>
            </div>
        </section>

        <section>
            <h2>资源链接</h2>
            <div class="resources">
                <div class="resource-card">
                    <div class="resource-type">官方文档</div>
                    <h4>Swift控制流文档</h4>
                    <p>Apple官方Swift控制流文档，详细介绍了Swift中的各种循环和控制流结构。</p>
                    <a href="https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html" target="_blank">查看文档</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-type">官方文档</div>
                    <h4>Collection协议文档</h4>
                    <p>Swift官方关于Collection协议的文档，介绍了可遍历集合的基本原理。</p>
                    <a href="https://developer.apple.com/documentation/swift/collection" target="_blank">查看文档</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-type">博客</div>
                    <h4>Swift by Sundell</h4>
                    <p>关于Swift集合和序列的高级操作的深入文章。</p>
                    <a href="https://www.swiftbysundell.com/articles/the-power-of-the-swift-standard-library/" target="_blank">阅读文章</a>
                </div>
                
                <div class="resource-card">
                    <div class="resource-type">博客</div>
                    <h4>Hacking with Swift</h4>
                    <p>Paul Hudson的Swift控制流教程，包含大量实用示例。</p>
                    <a href="https://www.hackingwithswift.com/articles/147/swift-loops-explained-for-while-repeat" target="_blank">阅读教程</a>
                </div>

                <div class="resource-card">
                    <div class="resource-type">书籍</div>
                    <h4>Swift编程权威指南</h4>
                    <p>全面介绍Swift语言的权威书籍，包含详尽的控制流章节。</p>
                    <a href="https://www.amazon.com/Swift-Programming-Ranch-Guide-Guides/dp/0134610679" target="_blank">查看书籍</a>
                </div>

                <div class="resource-card">
                    <div class="resource-type">视频</div>
                    <h4>WWDC视频</h4>
                    <p>Apple WWDC关于Swift集合和高效算法的演讲。</p>
                    <a href="https://developer.apple.com/videos/play/wwdc2018/223/" target="_blank">观看视频</a>
                </div>

                <div class="resource-card">
                    <div class="resource-type">开源项目</div>
                    <h4>Swift Algorithm Club</h4>
                    <p>使用Swift实现的常见算法和数据结构，包含多种遍历方法。</p>
                    <a href="https://github.com/raywenderlich/swift-algorithm-club" target="_blank">访问项目</a>
                </div>

                <div class="resource-card">
                    <div class="resource-type">开源项目</div>
                    <h4>SwifterSwift</h4>
                    <p>Swift扩展集合，提供了许多方便的集合操作扩展。</p>
                    <a href="https://github.com/SwifterSwift/SwifterSwift" target="_blank">访问项目</a>
                </div>
            </div>
        </section>
    </div>

    <script>
        // 如需添加交互功能可在此处添加JavaScript代码
    </script>
</body>
</html>
