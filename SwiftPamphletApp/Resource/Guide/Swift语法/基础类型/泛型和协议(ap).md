<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 泛型与协议</title>
    <style>
        :root {
            --text-color: #333;
            --bg-color: #f5f5f7;
            --code-bg: #f1f1f1;
            --link-color: #0070c9;
            --heading-color: #000;
            --border-color: #d1d1d1;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #f5f5f7;
                --bg-color: #121212;
                --code-bg: #1e1e1e;
                --link-color: #4dabf7;
                --heading-color: #ffffff;
                --border-color: #444;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background: var(--bg-color);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25'%3E%3Cdefs%3E%3ClinearGradient id='a' x1='0' x2='0' y1='0' y2='1'%3E%3Cstop offset='0' stop-color='%23041b3e'/%3E%3Cstop offset='1' stop-color='%23050a18'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cpattern id='b' width='24' height='24' patternUnits='userSpaceOnUse'%3E%3Ccircle fill='%23ffffff' cx='12' cy='12' r='0.5'/%3E%3C/pattern%3E%3Crect width='100%25' height='100%25' fill='url(%23a)'/%3E%3Crect width='100%25' height='100%25' fill='url(%23b)' fill-opacity='0.05'/%3E%3C/svg%3E");
            background-attachment: fixed;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.85);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        @media (prefers-color-scheme: dark) {
            .container {
                background-color: rgba(30, 30, 30, 0.9);
            }
        }

        header {
            text-align: center;
            padding: 40px 20px;
            position: relative;
            background: linear-gradient(to bottom, rgba(4, 27, 62, 0.9), rgba(5, 10, 24, 0.9));
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25'%3E%3Cpattern id='stars' width='100' height='100' patternUnits='userSpaceOnUse'%3E%3Ccircle fill='%23ffffff' cx='10' cy='10' r='1'/%3E%3Ccircle fill='%23ffffff' cx='50' cy='30' r='0.5'/%3E%3Ccircle fill='%23ffffff' cx='70' cy='70' r='0.8'/%3E%3Ccircle fill='%23ffffff' cx='90' cy='20' r='0.7'/%3E%3Ccircle fill='%23ffffff' cx='30' cy='80' r='0.6'/%3E%3C/pattern%3E%3Crect width='100%25' height='100%25' fill='url(%23stars)'/%3E%3C/svg%3E");
            opacity: 0.4;
        }

        .header-content {
            position: relative;
            z-index: 2;
        }

        h1 {
            font-family: 'Comic Sans MS', cursive, sans-serif;
            font-size: 3.5rem;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            margin-bottom: 10px;
            letter-spacing: 1px;
            transform: rotate(-1deg);
        }

        h2 {
            color: var(--heading-color);
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.3em;
            margin-top: 1.5em;
            font-size: 1.8rem;
        }

        h3 {
            color: var(--heading-color);
            margin-top: 1.2em;
            font-size: 1.4rem;
        }

        .character {
            max-width: 200px;
            margin: 20px auto;
        }

        pre {
            background-color: var(--code-bg);
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            border-left: 4px solid #FF6B6B;
            margin: 20px 0;
        }

        code {
            font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, Courier, monospace;
            font-size: 0.9em;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--link-color);
        }

        a:hover {
            border-bottom: 1px solid var(--link-color);
        }

        .note {
            background-color: rgba(255, 239, 213, 0.4);
            padding: 15px;
            border-left: 4px solid #FFD700;
            margin: 20px 0;
            border-radius: 5px;
        }

        @media (prefers-color-scheme: dark) {
            .note {
                background-color: rgba(255, 239, 213, 0.1);
            }
        }

        .section {
            margin-bottom: 40px;
        }

        .example {
            background-color: rgba(144, 238, 144, 0.1);
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            border-left: 4px solid #4CAF50;
        }

        .resources {
            background-color: rgba(173, 216, 230, 0.1);
            padding: 20px;
            border-radius: 5px;
            margin: 30px 0;
            border: 1px solid var(--border-color);
        }

        .resources ul {
            list-style-type: none;
            padding-left: 10px;
        }

        .resources li {
            margin-bottom: 8px;
            padding-left: 20px;
            position: relative;
        }

        .resources li::before {
            content: "•";
            position: absolute;
            left: 0;
            color: var(--link-color);
        }

        .footer {
            text-align: center;
            font-size: 0.9em;
            padding: 20px;
            opacity: 0.8;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
                margin: 10px;
            }

            h1 {
                font-size: 2.5rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            pre {
                padding: 10px;
            }
        }

        .concept-diagram {
            max-width: 100%;
            margin: 20px auto;
            display: block;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 10px;
            border-radius: 5px;
        }

        @media (prefers-color-scheme: dark) {
            .concept-diagram {
                background-color: rgba(40, 40, 40, 0.9);
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: rgba(0, 0, 0, 0.1);
        }

        tr:hover {
            background-color: rgba(0, 0, 0, 0.05);
        }

        @media (prefers-color-scheme: dark) {
            tr:hover {
                background-color: rgba(255, 255, 255, 0.05);
            }
            th {
                background-color: rgba(255, 255, 255, 0.1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="header-content">
                <h1>Swift 泛型与协议</h1>
                <svg class="character" width="200" height="200" viewBox="0 0 200 200">
                    <!-- 卡通人物形象 -->
                    <circle cx="100" cy="80" r="35" fill="#FFD700" stroke="#FF4500" stroke-width="2"/>
                    <circle cx="85" cy="70" r="5" fill="#000"/>
                    <circle cx="115" cy="70" r="5" fill="#000"/>
                    <path d="M90 90 Q100 100 110 90" stroke="#000" stroke-width="2" fill="none"/>
                    <rect x="70" y="115" width="60" height="50" fill="#FFD700" rx="10" ry="10" stroke="#FF4500" stroke-width="2"/>
                    <circle cx="40" cy="50" r="15" fill="#4dabf7" stroke="#0070c9" stroke-width="1"/>
                    <circle cx="160" cy="50" r="20" fill="#4CAF50" stroke="#2E7D32" stroke-width="1"/>
                    <circle cx="30" cy="120" r="18" fill="#FF6B6B" stroke="#C62828" stroke-width="1"/>
                    <circle cx="170" cy="130" r="12" fill="#9C27B0" stroke="#6A1B9A" stroke-width="1"/>
                    <line x1="40" y1="50" x2="70" y2="80" stroke="#ffffff" stroke-width="1" stroke-opacity="0.7"/>
                    <line x1="160" y1="50" x2="130" y2="80" stroke="#ffffff" stroke-width="1" stroke-opacity="0.7"/>
                    <line x1="30" y1="120" x2="70" y2="130" stroke="#ffffff" stroke-width="1" stroke-opacity="0.7"/>
                    <line x1="170" y1="130" x2="130" y2="130" stroke="#ffffff" stroke-width="1" stroke-opacity="0.7"/>
                </svg>
                <p style="color: white; font-size: 1.2rem; font-weight: 300;">打开Swift的抽象世界，探索泛型与协议的强大力量</p>
            </div>
        </header>

        <div class="section">
            <h2>目录</h2>
            <ul>
                <li><a href="#introduction">前言</a></li>
                <li><a href="#generics">泛型 (Generics)</a></li>
                <li><a href="#protocols">协议 (Protocols)</a></li>
                <li><a href="#protocol-extensions">协议扩展 (Protocol Extensions)</a></li>
                <li><a href="#pat">面向协议编程 (Protocol-Oriented Programming)</a></li>
                <li><a href="#advanced">泛型与协议的高级特性</a></li>
                <li><a href="#resources">参考资源</a></li>
            </ul>
        </div>

        <div id="introduction" class="section">
            <h2>前言</h2>
            <p>泛型和协议是Swift中两个强大且紧密相关的特性，它们共同构成了Swift类型系统的基石，也是Swift"面向协议编程"理念的核心。理解并掌握泛型和协议，是成为优秀Swift开发者的必要条件。</p>

            <svg class="concept-diagram" width="600" height="300" viewBox="0 0 600 300">
                <defs>
                    <linearGradient id="bg-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" style="stop-color:rgba(65,105,225,0.3)"/>
                        <stop offset="100%" style="stop-color:rgba(138,43,226,0.3)"/>
                    </linearGradient>
                </defs>
                <rect x="0" y="0" width="600" height="300" rx="10" ry="10" fill="url(#bg-gradient)" />

                <!-- 左侧：泛型 -->
                <rect x="50" y="50" width="200" height="200" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#4dabf7" stroke-width="2" />
                <text x="150" y="90" text-anchor="middle" font-weight="bold" font-size="16">泛型 (Generics)</text>
                <text x="150" y="120" text-anchor="middle" font-size="12">代码重用</text>
                <text x="150" y="145" text-anchor="middle" font-size="12">类型安全</text>
                <text x="150" y="170" text-anchor="middle" font-size="12">抽象化</text>
                <text x="150" y="195" text-anchor="middle" font-size="12">算法实现</text>
                <text x="150" y="220" text-anchor="middle" font-size="12">集合类型</text>

                <!-- 右侧：协议 -->
                <rect x="350" y="50" width="200" height="200" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="450" y="90" text-anchor="middle" font-weight="bold" font-size="16">协议 (Protocols)</text>
                <text x="450" y="120" text-anchor="middle" font-size="12">接口定义</text>
                <text x="450" y="145" text-anchor="middle" font-size="12">多态性</text>
                <text x="450" y="170" text-anchor="middle" font-size="12">组合复用</text>
                <text x="450" y="195" text-anchor="middle" font-size="12">API设计</text>
                <text x="450" y="220" text-anchor="middle" font-size="12">面向协议编程</text>

                <!-- 连接线 -->
                <path d="M250 150 C275 150, 325 150, 350 150" stroke="#9370DB" stroke-width="3" fill="none" />
                <circle cx="300" cy="150" r="25" fill="rgba(255,255,255,0.8)" stroke="#9370DB" stroke-width="2" />
                <text x="300" y="155" text-anchor="middle" font-size="12" font-weight="bold">结合</text>
            </svg>
        </div>

        <div id="generics" class="section">
            <h2>泛型 (Generics)</h2>

            <p>泛型是Swift中极其重要的特性，允许你编写灵活、可复用的函数和类型，这些函数和类型可以处理任何类型，同时还保证类型安全。</p>

            <h3>泛型的基本概念</h3>

            <svg class="concept-diagram" width="600" height="250" viewBox="0 0 600 250">
                <rect x="0" y="0" width="600" height="250" rx="10" ry="10" fill="rgba(65,105,225,0.1)" />

                <rect x="100" y="30" width="400" height="50" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#4dabf7" stroke-width="2" />
                <text x="300" y="60" text-anchor="middle" font-weight="bold">泛型函数/类型声明处使用占位符类型</text>

                <path d="M300 80 L300 120" stroke="#333" stroke-width="2" marker-end="url(#arrow)" />

                <rect x="100" y="120" width="400" height="50" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#4dabf7" stroke-width="2" />
                <text x="300" y="150" text-anchor="middle" font-weight="bold">使用时指定具体类型</text>

                <path d="M300 170 L300 210" stroke="#333" stroke-width="2" marker-end="url(#arrow)" />

                <rect x="100" y="210" width="400" height="30" rx="5" ry="5" fill="rgba(144,238,144,0.3)" stroke="#4CAF50" stroke-width="2" />
                <text x="300" y="230" text-anchor="middle" font-weight="bold">编译器确保类型安全</text>

                <defs>
                    <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
                        <path d="M0,0 L0,6 L9,3 z" fill="#333" />
                    </marker>
                </defs>
            </svg>

            <h3>泛型函数</h3>

            <div class="example">
                <p>以下是一个简单的泛型函数示例，用于交换两个同类型的值：</p>

                <pre><code>// 泛型函数示例
func swapValues<T>(_ a: inout T, _ b: inout T) {
    // 临时变量存储a的值
    let temporaryA = a
    // 将b的值赋给a
    a = b
    // 将临时变量(原a的值)赋给b
    b = temporaryA
}

// 使用泛型函数交换整数
var number1 = 10
var number2 = 20
print("交换前: \(number1), \(number2)")
swapValues(&number1, &number2)
print("交换后: \(number1), \(number2)")

// 使用泛型函数交换字符串
var string1 = "Hello"
var string2 = "World"
print("交换前: \(string1), \(string2)")
swapValues(&string1, &string2)
print("交换后: \(string1), \(string2)")</code></pre>

                <p>这个泛型函数使用类型参数<code>T</code>表示任意类型，允许我们用同一个函数交换不同类型的值对，同时保持类型安全。</p>
            </div>

            <h3>泛型类型</h3>

            <div class="example">
                <p>创建一个泛型栈数据结构：</p>

                <pre><code>// 泛型栈结构
struct Stack<Element> {
    // 私有数组存储元素
    private var items = [Element]()

    // 检查栈是否为空
    var isEmpty: Bool {
        return items.isEmpty
    }

    // 返回栈中元素数量
    var count: Int {
        return items.count
    }

    // 向栈中添加元素
    mutating func push(_ item: Element) {
        items.append(item)
    }

    // 从栈中弹出元素
    mutating func pop() -> Element? {
        return items.popLast()
    }

    // 查看栈顶元素但不移除
    func peek() -> Element? {
        return items.last
    }
}

// 使用整数栈
var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
intStack.push(3)

if let topItem = intStack.pop() {
    print("弹出的元素是: \(topItem)")  // 输出: 弹出的元素是: 3
}

// 使用字符串栈
var stringStack = Stack<String>()
stringStack.push("Apple")
stringStack.push("Banana")
stringStack.push("Cherry")

while let item = stringStack.pop() {
    print("弹出: \(item)")
}</code></pre>

                <p>这个泛型栈结构可以存储任何类型的元素，我们分别创建了一个整数栈和一个字符串栈。</p>
            </div>

            <h3>类型约束</h3>

            <div class="example">
                <p>有时我们需要限制泛型可以使用的类型范围，这时可以使用类型约束：</p>

                <pre><code>// 使用类型约束的泛型函数
// 要求T必须遵循Comparable协议
func findLargest<T: Comparable>(_ items: [T]) -> T? {
    // 如果数组为空，返回nil
    guard !items.isEmpty else { return nil }

    // 初始化最大值为第一个元素
    var largest = items[0]

    // 遍历数组查找最大值
    for item in items {
        if item > largest {  // 这里要求T必须遵循Comparable协议
            largest = item
        }
    }

    return largest
}

// 使用整数数组
let numbers = [10, 3, 7, 19, 5]
if let largestNumber = findLargest(numbers) {
    print("最大的数字是: \(largestNumber)")  // 输出: 最大的数字是: 19
}

// 使用字符串数组
let fruits = ["Apple", "Banana", "Orange", "Watermelon"]
if let largestFruit = findLargest(fruits) {
    print("字母顺序最后的水果是: \(largestFruit)")  // 输出: 字母顺序最后的水果是: Watermelon
}</code></pre>

                <p>在这个例子中，我们限制泛型类型<code>T</code>必须遵循<code>Comparable</code>协议，这样才能使用大于运算符<code>></code>进行比较。</p>
            </div>

            <h3>关联类型</h3>

            <div class="example">
                <p>协议中的关联类型是泛型的一种应用：</p>

                <pre><code>// 使用关联类型的协议
protocol Container {
    // 关联类型，表示容器中的元素类型
    associatedtype Item

    // 向容器中添加新元素
    mutating func add(_ item: Item)

    // 获取容器中的元素数量
    var count: Int { get }

    // 通过索引访问容器元素
    subscript(i: Int) -> Item { get }
}

// 实现Container协议的泛型结构
struct GenericArray<T>: Container {
    // 内部数组存储元素
    var items = [T]()

    // Container协议的关联类型实现
    typealias Item = T

    // 添加元素的方法实现
    mutating func add(_ item: T) {
        items.append(item)
    }

    // 获取元素数量的属性实现
    var count: Int {
        return items.count
    }

    // 下标访问方法实现
    subscript(i: Int) -> T {
        return items[i]
    }
}

// 创建并使用整数数组
var intArray = GenericArray<Int>()
intArray.add(1)
intArray.add(2)
intArray.add(3)
print("数组包含 \(intArray.count) 个元素")
print("第一个元素是: \(intArray[0])")

// 创建并使用字符串数组
var stringArray = GenericArray<String>()
stringArray.add("Hello")
stringArray.add("Swift")
for i in 0..<stringArray.count {
    print("元素 \(i): \(stringArray[i])")
}</code></pre>

                <p>这个例子展示了如何在协议中使用关联类型，以及如何通过泛型结构来实现这个协议。</p>
            </div>
        </div>

        <div id="protocols" class="section">
            <h2>协议 (Protocols)</h2>

            <p>协议定义了适合特定任务或功能的方法、属性以及其他要求的蓝图。类、结构体或枚举都可以遵循协议，并提供这些要求的具体实现。</p>

            <svg class="concept-diagram" width="600" height="300" viewBox="0 0 600 300">
                <rect x="0" y="0" width="600" height="300" rx="10" ry="10" fill="rgba(65,105,225,0.1)" />

                <!-- 协议 -->
                <rect x="200" y="30" width="200" height="60" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="300" y="65" text-anchor="middle" font-weight="bold" font-size="16">协议(Protocol)</text>
                <text x="300" y="85" text-anchor="middle" font-size="12">定义接口要求</text>

                <!-- 连接线 -->
                <line x1="300" y1="90" x2="300" y2="120" stroke="#333" stroke-width="2" stroke-dasharray="5,5" />

                <!-- 实现类型 -->
                <rect x="50" y="120" width="150" height="50" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="125" y="145" text-anchor="middle" font-size="14">类(Class)</text>
                <line x1="125" y1="120" x2="300" y2="90" stroke="#333" stroke-width="1" />

                <rect x="225" y="120" width="150" height="50" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#FB8C00" stroke-width="2" />
                <text x="300" y="145" text-anchor="middle" font-size="14">结构体(Struct)</text>
                <line x1="300" y1="120" x2="300" y2="90" stroke="#333" stroke-width="1" />

                <rect x="400" y="120" width="150" height="50" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#7CB342" stroke-width="2" />
                <text x="475" y="145" text-anchor="middle" font-size="14">枚举(Enum)</text>
                <line x1="475" y1="120" x2="300" y2="90" stroke="#333" stroke-width="1" />

                <!-- 协议组合 -->
                <rect x="100" y="220" width="400" height="50" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#9C27B0" stroke-width="2" />
                <text x="300" y="245" text-anchor="middle" font-size="14" font-weight="bold">协议组合(Protocol Composition)</text>
                <text x="300" y="260" text-anchor="middle" font-size="12">使用 & 组合多个协议</text>

                <path d="M125 170 C125 200, 200 220, 300 220" stroke="#333" stroke-width="1" fill="none" />
                <path d="M300 170 C300 200, 300 220, 300 220" stroke="#333" stroke-width="1" fill="none" />
                <path d="M475 170 C475 200, 400 220, 300 220" stroke="#333" stroke-width="1" fill="none" />
            </svg>

            <h3>协议基础</h3>

            <div class="example">
                <p>基本协议定义和实现：</p>

                <pre><code>// 定义一个表示媒体项目的协议
protocol MediaItem {
    // 要求：必须有一个只读的名称属性
    var name: String { get }

    // 要求：必须有一个只读的创建年份属性
    var year: Int { get }

    // 要求：必须实现一个显示信息的方法
    func displayInfo()
}

// 实现协议的电影类
class Movie: MediaItem {
    var name: String
    var year: Int
    var director: String

    init(name: String, year: Int, director: String) {
        self.name = name
        self.year = year
        self.director = director
    }

    func displayInfo() {
        print("电影《\(name)》(\(year)) - 导演: \(director)")
    }
}

// 实现协议的音乐类
struct Song: MediaItem {
    var name: String
    var year: Int
    var artist: String

    func displayInfo() {
        print("歌曲《\(name)》(\(year)) - 艺术家: \(artist)")
    }
}

// 使用遵循协议的对象
let movie = Movie(name: "星际穿越", year: 2014, director: "克里斯托弗·诺兰")
let song = Song(name: "Shape of You", year: 2017, artist: "Ed Sheeran")

// 创建一个协议类型的数组
let mediaItems: [MediaItem] = [movie, song]

// 遍历并显示信息
for item in mediaItems {
    item.displayInfo()
}</code></pre>

                <p>这个例子展示了如何定义协议以及如何通过类和结构体来实现协议。注意我们可以将不同类型但都遵循同一协议的对象存储在一个协议类型的数组中。</p>
            </div>

            <h3>协议属性要求</h3>

            <div class="example">
                <p>协议可以要求遵循类型提供特定名称和类型的实例属性或类型属性：</p>

                <pre><code>// 定义一个协议，包含多种属性要求
protocol Vehicle {
    // 要求：可读写的实例属性
    var numberOfWheels: Int { get set }

    // 要求：只读实例属性
    var description: String { get }

    // 要求：类型属性（静态属性）
    static var typeName: String { get }
}

// 结构体实现Vehicle协议
struct Bicycle: Vehicle {
    // 实现可读写属性
    var numberOfWheels: Int = 2

    // 实现计算属性
    var description: String {
        return "自行车有\(numberOfWheels)个轮子"
    }

    // 实现静态属性
    static var typeName: String {
        return "自行车"
    }
}

// 类实现Vehicle协议
class Car: Vehicle {
    // 实现可读写属性
    var numberOfWheels: Int = 4

    // 实现存储属性作为只读属性
    private(set) var description: String

    // 实现类型属性
    static var typeName: String {
        return "汽车"
    }

    init(description: String) {
        self.description = description
    }
}

// 使用遵循协议的类型
let bicycle = Bicycle()
print(bicycle.description)  // 输出: 自行车有2个轮子
print(Bicycle.typeName)     // 输出: 自行车

let car = Car(description: "豪华轿车")
print(car.description)      // 输出: 豪华轿车
print(Car.typeName)         // 输出: 汽车</code></pre>

                <p>这个例子展示了协议中不同类型的属性要求，以及如何在结构体和类中实现这些要求。</p>
            </div>

            <h3>协议方法要求</h3>

            <div class="example">
                <p>协议可以要求特定实例方法和类型方法的实现：</p>

                <pre><code>// 定义一个绘图元素协议
protocol Drawable {
    // 要求实例方法
    func draw()

    // 要求可变方法(会修改self)
    mutating func resize(scale: Float)

    // 要求静态方法
    static func createDefault() -> Self
}

// 结构体实现协议
struct Square: Drawable {
    var sideLength: Double

    // 实现实例方法
    func draw() {
        print("绘制边长为\(sideLength)的正方形")
    }

    // 实现可变方法
    mutating func resize(scale: Float) {
        sideLength *= Double(scale)
        print("调整大小后边长为: \(sideLength)")
    }

    // 实现静态方法
    static func createDefault() -> Square {
        return Square(sideLength: 10.0)
    }
}

// 类实现协议
class Circle: Drawable {
    var radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    // 实现实例方法
    func draw() {
        print("绘制半径为\(radius)的圆")
    }

    // 实现可变方法(类不需要mutating关键字)
    func resize(scale: Float) {
        radius *= Double(scale)
        print("调整大小后半径为: \(radius)")
    }

    // 实现类型方法
    static func createDefault() -> Circle {
        return Circle(radius: 5.0)
    }
}

// 使用遵循协议的类型
var square = Square.createDefault()
square.draw()
square.resize(scale: 2.0)

let circle = Circle.createDefault()
circle.draw()
circle.resize(scale: 1.5)</code></pre>

                <p>这个例子展示了协议中实例方法和类型方法的要求。注意对于结构体和枚举，如果方法会修改自身，需要使用<code>mutating</code>关键字标记。</p>
            </div>

            <h3>协议作为类型</h3>

            <div class="example">
                <p>协议可以像其他类型一样使用：</p>

                <pre><code>// 定义一个支付方式协议
protocol PaymentMethod {
    var name: String { get }
    func processPayment(amount: Double) -> Bool
}

// 实现不同的支付方式
struct CreditCard: PaymentMethod {
    var name: String
    var cardNumber: String
    var expiryDate: String
    var cvv: String

    func processPayment(amount: Double) -> Bool {
        // 模拟信用卡支付处理
        print("使用信用卡支付 ¥\(amount)")
        return true
    }
}

struct ApplePay: PaymentMethod {
    var name: String
    var deviceId: String

    func processPayment(amount: Double) -> Bool {
        // 模拟Apple Pay支付处理
        print("使用Apple Pay支付 ¥\(amount)")
        return true
    }
}

// 使用协议类型接收不同的支付方式
func checkout(totalAmount: Double, using paymentMethod: PaymentMethod) {
    print("结账总金额: ¥\(totalAmount)")
    print("支付方式: \(paymentMethod.name)")

    if paymentMethod.processPayment(amount: totalAmount) {
        print("支付成功!")
    } else {
        print("支付失败，请尝试其他支付方式")
    }
}

// 创建不同的支付方式实例
let myCard = CreditCard(name: "Visa信用卡", cardNumber: "4111 1111 1111 1111",
                        expiryDate: "12/24", cvv: "123")
let myApplePay = ApplePay(name: "Apple Pay", deviceId: "iPhone13-ABCDE")

// 使用不同支付方式结账
checkout(totalAmount: 299.99, using: myCard)
print("---")
checkout(totalAmount: 99.99, using: myApplePay)</code></pre>

                <p>在这个例子中，协议<code>PaymentMethod</code>用作参数类型，允许函数处理任何遵循该协议的对象。</p>
            </div>

            <h3>协议组合</h3>

            <div class="example">
                <p>可以要求一个类型同时遵循多个协议：</p>

                <pre><code>// 定义几个简单的协议
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

protocol Employable {
    var jobTitle: String { get }
}

// 使用协议组合
func greetEmployee(person: Named & Aged & Employable) {
    print("你好，\(person.name)!")
    print("我们了解到你\(person.age)岁，是一名\(person.jobTitle)")
}

// 定义遵循多个协议的结构体
struct Employee: Named, Aged, Employable {
    var name: String
    var age: Int
    var jobTitle: String
}

// 使用协议组合
let john = Employee(name: "张三", age: 35, jobTitle: "iOS开发工程师")
greetEmployee(person: john)</code></pre>

                <p>使用<code>&</code>符号可以组合多个协议，要求传入的对象同时遵循所有这些协议。</p>
            </div>

            <h3>协议继承</h3>

            <div class="example">
                <p>协议可以继承一个或多个其他协议，并添加更多要求：</p>

                <pre><code>// 基础协议
protocol Animal {
    var species: String { get }
    func makeSound()
}

// 继承Animal协议的Pet协议
protocol Pet: Animal {
    var name: String { get }
    var owner: String { get }
}

// 实现Pet协议的结构体
struct Dog: Pet {
    var species: String {
        return "犬科"
    }

    var name: String
    var owner: String
    var breed: String

    func makeSound() {
        print("\(name)汪汪叫!")
    }
}

// 使用遵循继承协议的类型
let myDog = Dog(name: "旺财", owner: "张三", breed: "金毛")
myDog.makeSound()
print("\(myDog.name)属于\(myDog.species)，它的主人是\(myDog.owner)")</code></pre>

                <p>这个例子展示了如何创建协议继承层次结构，其中<code>Pet</code>协议继承自<code>Animal</code>协议，并添加了额外的要求。</p>
            </div>

            <h3>类专属协议</h3>

            <div class="example">
                <p>可以限制协议只能被类类型遵循：</p>

                <pre><code>// 类专属协议
protocol ClassOnlyProtocol: AnyObject {
    func someMethod()
}

// 类可以实现类专属协议
class SomeClass: ClassOnlyProtocol {
    func someMethod() {
        print("类实现的方法")
    }
}

// 错误示例：结构体不能实现类专属协议
// struct SomeStruct: ClassOnlyProtocol { // 编译错误
//     func someMethod() {
//         print("结构体实现的方法")
//     }
// }

// 类专属协议的实际用例：弱引用代理模式
protocol WeakDelegate: AnyObject {
    func didUpdate(data: String)
}

class DataSource {
    // 使用弱引用避免循环引用
    weak var delegate: WeakDelegate?

    func fetchData() {
        // 模拟获取数据
        let newData = "新数据 - \(Date())"
        // 通知代理
        delegate?.didUpdate(data: newData)
    }
}

class DataPresenter: WeakDelegate {
    let dataSource: DataSource

    init() {
        dataSource = DataSource()
        dataSource.delegate = self
    }

    func didUpdate(data: String) {
        print("收到更新: \(data)")
    }

    func requestData() {
        print("请求数据...")
        dataSource.fetchData()
    }
}

// 使用弱引用代理模式
let presenter = DataPresenter()
presenter.requestData()</code></pre>

                <p>通过添加<code>AnyObject</code>继承，可以将协议限制为只能被类类型遵循，这在需要使用弱引用的场景（如代理模式）中特别有用。</p>
            </div>
        </div>

        <div id="protocol-extensions" class="section">
            <h2>协议扩展 (Protocol Extensions)</h2>

            <p>协议扩展允许我们为协议提供默认实现，这是Swift中一个非常强大的特性。</p>

            <svg class="concept-diagram" width="600" height="250" viewBox="0 0 600 250">
                <rect x="0" y="0" width="600" height="250" rx="10" ry="10" fill="rgba(65,105,225,0.1)" />

                <!-- 协议 -->
                <rect x="50" y="50" width="200" height="60" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="150" y="85" text-anchor="middle" font-weight="bold" font-size="16">协议定义要求</text>

                <!-- 协议扩展 -->
                <rect x="350" y="50" width="200" height="60" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#9C27B0" stroke-width="2" />
                <text x="450" y="85" text-anchor="middle" font-weight="bold" font-size="16">协议扩展提供实现</text>

                <!-- 遵循类型 -->
                <rect x="200" y="160" width="200" height="60" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="300" y="195" text-anchor="middle" font-weight="bold" font-size="16">遵循类型</text>

                <!-- 箭头 -->
                <path d="M250 80 L350 80" stroke="#333" stroke-width="2" marker-end="url(#arrow2)" />
                <path d="M150 110 C150 140, 200 160, 250 160" stroke="#333" stroke-width="2" marker-end="url(#arrow2)" />
                <path d="M450 110 C450 140, 400 160, 350 160" stroke="#333" stroke-width="2" marker-end="url(#arrow2)" />

                <defs>
                    <marker id="arrow2" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
                        <path d="M0,0 L0,6 L9,3 z" fill="#333" />
                    </marker>
                </defs>
            </svg>

            <h3>提供默认实现</h3>

            <div class="example">
                <p>协议扩展可以为协议要求提供默认实现：</p>

                <pre><code>// 定义一个协议
protocol TextRepresentable {
    var textDescription: String { get }
    func asHTML() -> String
}

// 为协议添加扩展，提供默认实现
extension TextRepresentable {
    // 为asHTML方法提供默认实现
    func asHTML() -> String {
        return "&lt;p&gt;\(textDescription)&lt;/p&gt;"
    }
}

// 实现协议的结构体，仅实现必要的要求
struct Article: TextRepresentable {
    var title: String
    var content: String

    // 仅需实现textDescription属性
    var textDescription: String {
        return "\(title)：\(content)"
    }

    // asHTML方法使用协议扩展中的默认实现
}

// 实现协议的结构体，并重写默认实现
struct Quote: TextRepresentable {
    var text: String
    var author: String

    var textDescription: String {
        return ""\(text)" —— \(author)"
    }

    // 重写默认的asHTML实现
    func asHTML() -> String {
        return "&lt;blockquote&gt;\(text)&lt;cite&gt;\(author)&lt;/cite&gt;&lt;/blockquote&gt;"
    }
}

// 使用协议类型
let article = Article(title: "Swift编程语言", content: "Swift是一门强大而直观的编程语言。")
let quote = Quote(text: "简洁是复杂的终极形式。", author: "达芬奇")

let items: [TextRepresentable] = [article, quote]

for item in items {
    print(item.textDescription)
    print(item.asHTML())
    print("---")
}</code></pre>

                <p>这个例子展示了如何通过协议扩展为<code>asHTML()</code>方法提供默认实现，实现协议的类型可以选择使用默认实现或者提供自己的实现。</p>
            </div>

            <h3>扩展现有协议</h3>

            <div class="example">
                <p>为Swift标准库中的协议添加功能：</p>

                <pre><code>// 扩展Collection协议添加新功能
extension Collection {
    // 添加一个计算属性，返回第一个、中间和最后一个元素
    var summarized: [Element] {
        guard !isEmpty else { return [] }

        var result: [Element] = []

        // 添加第一个元素
        result.append(self[startIndex])

        // 如果集合大于2个元素，添加中间元素
        if count > 2 {
            let middleIndex = index(startIndex, offsetBy: count / 2)
            result.append(self[middleIndex])
        }

        // 如果集合至少有2个元素，添加最后一个元素
        if count > 1 {
            result.append(self[index(before: endIndex)])
        }

        return result
    }

    // 添加一个方法，返回所有符合条件的元素
    func elements(where predicate: (Element) -> Bool) -> [Element] {
        return filter(predicate)
    }
}

// 使用扩展的功能
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print("汇总: \(numbers.summarized)")  // 输出: 汇总: [1, 5, 10]

let evenNumbers = numbers.elements { $0 % 2 == 0 }
print("偶数: \(evenNumbers)")  // 输出: 偶数: [2, 4, 6, 8, 10]

// 字符串也是Collection
let greeting = "Hello, Swift!"
print("字符串汇总: \(greeting.summarized)")  // 输出字符串的第一个、中间和最后一个字符

// 自定义字典也能使用这些扩展方法
let scores = ["Alice": 85, "Bob": 92, "Charlie": 78, "David": 95]
let summary = scores.summarized
print("分数汇总:")
for pair in summary {
    print("\(pair.key): \(pair.value)")
}</code></pre>

                <p>这个例子展示了如何通过协议扩展为标准库中的<code>Collection</code>协议添加新功能，所有遵循该协议的类型（如数组、字典、字符串等）都可以使用这些新功能。</p>
            </div>

            <h3>有条件的协议扩展</h3>

            <div class="example">
                <p>可以只为满足特定条件的类型提供协议扩展：</p>

                <pre><code>// 为遵循Equatable的Collection添加功能
extension Collection where Element: Equatable {
    // 检查是否包含指定的元素序列
    func containsSequence(_ sequence: [Element]) -> Bool {
        // 如果序列为空或长度大于集合本身，肯定不包含
        guard !sequence.isEmpty, sequence.count <= self.count else {
            return false
        }

        // 转换为数组进行比较（如果原本就是数组，可能有更高效的实现）
        let selfArray = Array(self)

        // 尝试查找序列
        for i in 0...selfArray.count - sequence.count {
            var found = true

            for j in 0..<sequence.count {
                if selfArray[i + j] != sequence[j] {
                    found = false
                    break
                }
            }

            if found {
                return true
            }
        }

        return false
    }
}

// 为数字集合扩展功能
extension Collection where Element: Numeric {
    // 计算所有元素的和
    var sum: Element {
        return reduce(.zero, +)
    }

    // 计算所有元素的平均值
    var average: Double {
        guard !isEmpty else { return 0 }
        let sum = self.sum
        return Double("\(sum)") ?? 0 / Double(count)
    }
}

// 使用有条件的扩展
let numbers = [1, 2, 3, 4, 5]
print("数组和: \(numbers.sum)")  // 输出: 数组和: 15
print("数组平均值: \(numbers.average)")  // 输出: 数组平均值: 3.0

let subsequence = [3, 4]
print("包含子序列 [3, 4]: \(numbers.containsSequence(subsequence))")  // 输出: true

let notSubsequence = [5, 6]
print("包含子序列 [5, 6]: \(numbers.containsSequence(notSubsequence))")  // 输出: false

// 自定义Point类型
struct Point: Numeric {
    var x: Double
    var y: Double

    // Numeric协议要求
    init?<T>(exactly source: T) where T : BinaryInteger {
        guard let value = Double(exactly: source) else { return nil }
        self.x = value
        self.y = value
    }

    static var zero: Point { return Point(x: 0, y: 0) }

    static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func += (lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }

    static func - (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func -= (lhs: inout Point, rhs: Point) {
        lhs = lhs - rhs
    }

    static func * (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    static func *= (lhs: inout Point, rhs: Point) {
        lhs = lhs * rhs
    }
}

// 使用自定义Numeric类型的集合
let points = [Point(x: 1, y: 2), Point(x: 3, y: 4), Point(x: 5, y: 6)]
let sumPoint = points.sum  // 可以直接使用sum方法
print("点的和: (\(sumPoint.x), \(sumPoint.y))")  // 输出: 点的和: (9.0, 12.0)</code></pre>

                <p>这个例子展示了如何创建有条件的协议扩展，只为满足特定条件的类型提供额外功能。</p>
            </div>
        </div>

        <div id="pat" class="section">
            <h2>面向协议编程 (Protocol-Oriented Programming)</h2>

            <p>面向协议编程是Swift的核心设计理念之一，它鼓励通过协议和协议扩展来组织代码，而不是传统的类继承。</p>

            <svg class="concept-diagram" width="600" height="350" viewBox="0 0 600 350">
                <rect x="0" y="0" width="600" height="350" rx="10" ry="10" fill="rgba(65,105,225,0.1)" />

                <!-- 面向对象 vs 面向协议 -->
                <rect x="50" y="30" width="200" height="60" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="150" y="65" text-anchor="middle" font-weight="bold" font-size="16">面向对象编程</text>
                <text x="150" y="85" text-anchor="middle" font-size="12">基于类和继承</text>

                <rect x="350" y="30" width="200" height="60" rx="10" ry="10" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="450" y="65" text-anchor="middle" font-weight="bold" font-size="16">面向协议编程</text>
                <text x="450" y="85" text-anchor="middle" font-size="12">基于协议和组合</text>

                <!-- OOP层次结构 -->
                <rect x="100" y="130" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="150" y="155" text-anchor="middle" font-size="14">基类</text>

                <path d="M150 170 L100 210" stroke="#1E88E5" stroke-width="2" marker-end="url(#arrow3)" />
                <path d="M150 170 L150 210" stroke="#1E88E5" stroke-width="2" marker-end="url(#arrow3)" />
                <path d="M150 170 L200 210" stroke="#1E88E5" stroke-width="2" marker-end="url(#arrow3)" />

                <rect x="50" y="210" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="100" y="235" text-anchor="middle" font-size="14">子类A</text>

                <rect x="100" y="270" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="150" y="295" text-anchor="middle" font-size="14">子类B</text>

                <rect x="150" y="210" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#1E88E5" stroke-width="2" />
                <text x="200" y="235" text-anchor="middle" font-size="14">子类C</text>

                <!-- POP结构 -->
                <rect x="400" y="130" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="450" y="155" text-anchor="middle" font-size="14">协议A</text>

                <rect x="350" y="190" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="400" y="215" text-anchor="middle" font-size="14">协议B</text>

                <rect x="450" y="190" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#4CAF50" stroke-width="2" />
                <text x="500" y="215" text-anchor="middle" font-size="14">协议C</text>

                <rect x="400" y="250" width="100" height="40" rx="5" ry="5" fill="rgba(255,255,255,0.8)" stroke="#FB8C00" stroke-width="2" />
                <text x="450" y="275" text-anchor="middle" font-size="14">实现类型</text>

                <path d="M400 210 L425 250" stroke="#4CAF50" stroke-width="2" marker-end="url(#arrow3)" />
                <path d="M500 210 L475 250" stroke="#4CAF50" stroke-width="2" marker-end="url(#arrow3)" />
                <path d="M450 170 L450 190" stroke="#4CAF50" stroke-width="2" marker-end="url(#arrow3)" />

                <defs>
                    <marker id="arrow3" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
                        <path d="M0,0 L0,6 L9,3 z" fill="#333" />
                    </marker>
                </defs>
            </svg>

            <h3>面向协议编程实践</h3>

            <div class="example">
                <p>以下是一个面向协议编程的案例，展示了如何使用协议和协议扩展替代类继承：</p>

                <pre><code>// 传统面向对象方法
class Animal {
    var name: String

    init(name: String) {
        self.name = name
    }

    func makeSound() {
        print("动物发出声音")
    }

    func sleep() {
        print("\(name)正在睡觉")
    }
}

class Dog: Animal {
    override func makeSound() {
        print("\(name)汪汪叫")
    }

    func fetch() {
        print("\(name)正在捡回物品")
    }
}

class Bird: Animal {
    override func makeSound() {
        print("\(name)叽叽喳喳")
    }

    func fly() {
        print("\(name)正在飞翔")
    }
}

// 面向协议的重构方法
protocol Nameable {
    var name: String { get }
}

protocol SoundProducing {
    func makeSound()
}

protocol Sleeper {
    func sleep()
}

extension Sleeper where Self: Nameable {
    func sleep() {
        print("\(name)正在睡觉")
    }
}

protocol Fetcher {
    func fetch()
}

extension Fetcher where Self: Nameable {
    func fetch() {
        print("\(name)正在捡回物品")
    }
}

protocol Flyer {
    func fly()
}

extension Flyer where Self: Nameable {
    func fly() {
        print("\(name)正在飞翔")
    }
}

struct DogPOP: Nameable, SoundProducing, Sleeper, Fetcher {
    var name: String

    func makeSound() {
        print("\(name)汪汪叫")
    }
}

struct BirdPOP: Nameable, SoundProducing, Sleeper, Flyer {
    var name: String

    func makeSound() {
        print("\(name)叽叽喳喳")
    }
}

// 使用面向协议的代码
let dogPOP = DogPOP(name: "小黑")
dogPOP.makeSound()  // 输出: 小黑汪汪叫
dogPOP.sleep()      // 输出: 小黑正在睡觉
dogPOP.fetch()      // 输出: 小黑正在捡回物品

let birdPOP = BirdPOP(name: "小红")
birdPOP.makeSound() // 输出: 小红叽叽喳喳
birdPOP.sleep()     // 输出: 小红正在睡觉
birdPOP.fly()       // 输出: 小红正在飞翔

// 面向协议编程的优势：代码组合
struct FlyingDog: Nameable, SoundProducing, Sleeper, Fetcher, Flyer {
    var name: String

    func makeSound() {
        print("\(name)汪汪叫，同时拍打翅膀")
    }
}

let flyingDog = FlyingDog(name: "超能狗")
flyingDog.makeSound()  // 输出: 超能狗汪汪叫，同时拍打翅膀
flyingDog.fetch()      // 输出: 超能狗正在捡回物品
flyingDog.fly()        // 输出: 超能狗正在飞翔</code></pre>

                <p>这个例子对比了传统面向对象编程和面向协议编程的方法。面向协议编程通过组合多个协议来实现功能，而不是通过继承，提供了更大的灵活性。</p>
            </div>

            <div class="note">
                <p><strong>面向协议编程的优势：</strong></p>
                <ul>
                    <li>更灵活的代码组合，避免了类继承的层次结构限制</li>
                    <li>通过协议扩展提供默认行为，减少代码重复</li>
                    <li>值类型(结构体、枚举)也能享受到代码共享的好处</li>
                    <li>更容易进行单元测试和模拟</li>
                    <li>更清晰的接口设计和职责分离</li>
                </ul>
            </div>
        </div>

        <div id="advanced" class="section">
            <h2>泛型与协议的结合</h2>

            <p>泛型和协议结合使用是Swift中最强大的特性之一，它们一起可以构建灵活且类型安全的抽象。</p>

            <h3>泛型协议</h3>

            <div class="example">
                <p>使用关联类型创建泛型协议：</p>

                <pre><code>// 定义带有关联类型的协议
protocol Stack {
    // 定义关联类型Element，表示栈中的元素类型
    associatedtype Element

    // 检查栈是否为空
    var isEmpty: Bool { get }

    // 返回栈中元素数量
    var count: Int { get }

    // 向栈中添加元素
    mutating func push(_ element: Element)

    // 从栈中弹出元素
    mutating func pop() -> Element?

    // 查看栈顶元素但不移除
    func peek() -> Element?
}

// 为Stack协议提供扩展实现
extension Stack {
    // 添加一个方法，将另一个栈的元素合并到当前栈
    mutating func merge<S: Stack>(with otherStack: S) where S.Element == Element {
        // 创建临时数组存储另一个栈的元素
        var elements: [Element] = []
        var tempStack = otherStack

        // 弹出另一个栈的所有元素
        while let element = tempStack.pop() {
            elements.append(element)
        }

        // 从后向前遍历数组，保持元素的栈顺序
        for element in elements.reversed() {
            push(element)
        }
    }

    // 添加一个映射方法，返回一个新的栈，其中元素经过变换
    func map<T>(_ transform: (Element) -> T) -> ArrayStack<T> {
        var mappedStack = ArrayStack<T>()
        var elements: [Element] = []
        var tempStack = self

        while let element = tempStack.pop() {
            elements.append(element)
        }

        for element in elements.reversed() {
            mappedStack.push(transform(element))
        }

        return mappedStack
    }
}

// 使用数组实现Stack协议
struct ArrayStack<T>: Stack {
    typealias Element = T

    private var items = [T]()

    var isEmpty: Bool {
        return items.isEmpty
    }

    var count: Int {
        return items.count
    }

    mutating func push(_ element: T) {
        items.append(element)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    func peek() -> T? {
        return items.last
    }
}

// 使用链表实现Stack协议
struct LinkedListStack<T>: Stack {
    class Node {
        var value: T
        var next: Node?

        init(value: T, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }

    typealias Element = T

    private var head: Node?
    private var _count: Int = 0

    var isEmpty: Bool {
        return head == nil
    }

    var count: Int {
        return _count
    }

    mutating func push(_ element: T) {
        head = Node(value: element, next: head)
        _count += 1
    }

    mutating func pop() -> T? {
        guard let head = head else { return nil }

        let value = head.value
        self.head = head.next
        _count -= 1

        return value
    }

    func peek() -> T? {
        return head?.value
    }
}

// 使用不同的栈实现
var arrayIntStack = ArrayStack<Int>()
arrayIntStack.push(1)
arrayIntStack.push(2)
arrayIntStack.push(3)
print("数组栈元素数量: \(arrayIntStack.count)")

var linkedIntStack = LinkedListStack<Int>()
linkedIntStack.push(10)
linkedIntStack.push(20)
print("链表栈元素数量: \(linkedIntStack.count)")

// 合并两个栈
arrayIntStack.merge(with: linkedIntStack)
print("合并后数组栈元素数量: \(arrayIntStack.count)")

// 使用map转换栈元素
let stringStack = arrayIntStack.map { "数字\($0)" }
while let item = stringStack.pop() {
    print(item)  // 输出形如: 数字20, 数字10, 数字3, 数字2, 数字1
}</code></pre>

                <p>这个例子展示了如何使用关联类型创建泛型协议，以及如何通过协议扩展为所有遵循该协议的类型添加功能。</p>
            </div>

            <h3>泛型类型约束与协议</h3>

            <div class="example">
                <p>结合协议和泛型约束创建更灵活的API：</p>

                <pre><code>// 一个接口协议
protocol LoggerProtocol {
    func log(_ message: String)
}

// 一个简单的控制台日志实现
struct ConsoleLogger: LoggerProtocol {
    func log(_ message: String) {
        print("[控制台] \(message)")
    }
}

// 一个文件日志实现
struct FileLogger: LoggerProtocol {
    let filePath: String

    func log(_ message: String) {
        // 在实际应用中，这里会写入文件
        print("[文件:\(filePath)] \(message)")
    }
}

// 定义一个可缓存类型的协议
protocol Cacheable {
    // 返回唯一标识符
    var cacheKey: String { get }

    // 返回缓存的过期时间（秒）
    var expirationInterval: TimeInterval { get }
}

// 通用的网络客户端
class NetworkClient<Logger: LoggerProtocol> {
    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    // 通用请求方法
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        logger.log("请求URL: \(url)")

        // 模拟网络请求
        DispatchQueue.global().async {
            // 实际中这里会进行真正的网络请求
            self.logger.log("请求完成")

            // 模拟成功结果
            // 这里示例用JSON字符串模拟
            let jsonString = """
            {"name": "Swift", "version": 5.5}
            """

            if let data = jsonString.data(using: .utf8) {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)

                    DispatchQueue.main.async {
                        self.logger.log("请求成功解析")
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.logger.log("解析失败: \(error)")
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    // 添加缓存功能的请求方法
    func cachedRequest<T: Decodable & Cacheable>(
        url: URL,
        forceRefresh: Bool = false,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        // 检查是否有缓存
        func checkCache(_ item: T) -> Bool {
            logger.log("检查缓存: \(item.cacheKey)")
            // 实际应用中会检查缓存是否存在且未过期
            return false && !forceRefresh
        }

        // 这里应该检查缓存
        // 如果有缓存，且未过期，且不强制刷新，直接返回缓存结果

        // 否则进行网络请求
        logger.log("无缓存或需要刷新，执行网络请求")
        request(url: url) { (result: Result<T, Error>) in
            switch result {
            case .success(let value):
                // 保存到缓存
                self.logger.log("保存到缓存: \(value.cacheKey), 过期时间: \(value.expirationInterval)秒")
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// 定义一个API响应类型
struct LanguageInfo: Decodable, Cacheable {
    let name: String
    let version: Double

    var cacheKey: String {
        return "language_\(name)"
    }

    var expirationInterval: TimeInterval {
        return 3600 // 1小时
    }
}

// 使用示例
let consoleLogger = ConsoleLogger()
let networkClient = NetworkClient(logger: consoleLogger)

// 创建URL
let url = URL(string: "https://api.example.com/languages/swift")!

// 发送请求
networkClient.cachedRequest(url: url) { (result: Result<LanguageInfo, Error>) in
    switch result {
    case .success(let info):
        print("成功: \(info.name) 版本 \(info.version)")
    case .failure(let error):
        print("失败: \(error)")
    }
}</code></pre>

                <p>这个例子展示了如何结合泛型参数、协议类型约束和协议继承来创建灵活且可扩展的API设计。</p>
            </div>
        </div>

        <div id="advanced" class="section">
            <h2>泛型与协议的高级特性</h2>

            <h3>不透明类型 (Opaque Types)</h3>

            <div class="example">
                <p>Swift 5.1引入了不透明类型，使用<code>some</code>关键字表示：</p>

                <pre><code>// 定义一个绘图元素协议
protocol Shape {
    func draw() -> String
}

// 实现Shape协议的结构体
struct Circle: Shape {
    var radius: Double

    func draw() -> String {
        return "绘制半径为\(radius)的圆"
    }
}

struct Square: Shape {
    var sideLength: Double

    func draw() -> String {
        return "绘制边长为\(sideLength)的正方形"
    }
}

// 组合形状
struct LayeredShape: Shape {
    var shapes: [Shape]

    func draw() -> String {
        return shapes.map { $0.draw() }.joined(separator: "\n")
    }
}

// 使用不透明类型返回一个具体的Shape
func createShape(isCircle: Bool) -> some Shape {
    if isCircle {
        return Circle(radius: 10.0)
    } else {
        return Square(sideLength: 10.0)
    }
}

// 使用不透明类型
let shape1 = createShape(isCircle: true)
print(shape1.draw())  // 输出: 绘制半径为10.0的圆

let shape2 = createShape(isCircle: false)
print(shape2.draw())  // 输出: 绘制边长为10.0的正方形

// 不能返回不同类型
// func createMixedShape(isCircle: Bool) -> some Shape {
//     if isCircle {
//         return Circle(radius: 10.0)
//     } else {
//         // 错误: 函数声明了返回不透明类型'some Shape'，但函数主体返回了不同类型的值
//         return LayeredShape(shapes: [Circle(radius: 5.0), Square(sideLength: 5.0)])
//     }
// }

// 使用泛型返回任意Shape
func createAnyShape<T: Shape>() -> T {
    // 这里会报错，因为我们需要实例化一个具体的T类型对象
    // 需要有更多上下文信息来确定具体类型
    // 在实际代码中，T的具体类型通常由调用者决定
    fatalError("必须由子类实现")
}</code></pre>

                <p>不透明类型使函数可以返回遵循特定协议的类型，而不暴露具体类型信息。与普通协议类型不同，不透明类型保证每次返回相同的具体类型。</p>
            </div>

            <h3>泛型下标和泛型类型构造</h3>

            <div class="example">
                <p>泛型可用于定义下标和构造方法：</p>

                <pre><code>// 定义数据存储协议
protocol DataStore {
    // 泛型下标：通过键获取值
    subscript<T>(key: String) -> T? { get set }
}

// UserDefaults实现数据存储协议
extension UserDefaults: DataStore {
    subscript<T>(key: String) -> T? {
        get {
            return object(forKey: key) as? T
        }
        set {
            if let newValue = newValue {
                set(newValue, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}

// 字典实现数据存储协议
class DictionaryStore: DataStore {
    private var storage: [String: Any] = [:]

    subscript<T>(key: String) -> T? {
        get {
            return storage[key] as? T
        }
        set {
            storage[key] = newValue
        }
    }
}

// 使用数据存储
let dictStore = DictionaryStore()

// 存储不同类型的值
dictStore["intValue"] = 42
dictStore["stringValue"] = "Hello"
dictStore["boolValue"] = true

// 取回特定类型的值
let intValue: Int? = dictStore["intValue"]
let stringValue: String? = dictStore["stringValue"]
let boolValue: Bool? = dictStore["boolValue"]

print("Int值: \(intValue ?? 0)")
print("String值: \(stringValue ?? "")")
print("Bool值: \(boolValue ?? false)")

// 使用UserDefaults作为数据存储
let defaults = UserDefaults.standard
defaults["appLaunchCount"] = 10
let launchCount: Int? = defaults["appLaunchCount"]
print("App启动次数: \(launchCount ?? 0)")

// 泛型构造器
class GenericFactory<T> {
    // 存储创建T实例的闭包
    private let createInstance: () -> T

    // 构造器接收创建实例的闭包
    init(create: @escaping () -> T) {
        self.createInstance = create
    }

    // 生成新实例
    func createNew() -> T {
        return createInstance()
    }
}

// 构造字符串工厂
let stringFactory = GenericFactory { "新字符串" }
print(stringFactory.createNew())

// 构造日期工厂
let dateFactory = GenericFactory { Date() }
print("当前时间: \(dateFactory.createNew())")</code></pre>

                <p>这个例子展示了如何使用泛型下标和泛型构造方法，创建更灵活的API。</p>
            </div>

            <h3>条件一致性 (Conditional Conformance)</h3>

            <div class="example">
                <p>可以让类型在特定条件下遵循协议：</p>

                <pre><code>// 定义一个协议用于获取元素计数
protocol CountableCollection {
    var elementCount: Int { get }
}

// 为数组添加条件一致性：当元素是可计数的时，整个数组也是可计数的
extension Array: CountableCollection where Element: CountableCollection {
    var elementCount: Int {
        return reduce(0) { $0 + $1.elementCount }
    }
}

// 定义一个简单的可计数结构体
struct Item: CountableCollection {
    var name: String
    var subItems: [Item]

    var elementCount: Int {
        return 1 + subItems.elementCount // 自己算1，加上子项计数
    }
}

// 使用条件一致性
let item1 = Item(name: "文件夹1", subItems: [])
let item2 = Item(name: "文件夹2", subItems: [
    Item(name: "文件1", subItems: []),
    Item(name: "文件2", subItems: [])
])

let items = [item1, item2]
print("总元素计数: \(items.elementCount)")  // 输出: 总元素计数: 4

// 另一个条件一致性的例子
protocol TextPresentable {
    var textDescription: String { get }
}

extension Array: TextPresentable where Element: TextPresentable {
    var textDescription: String {
        return map { $0.textDescription }.joined(separator: ", ")
    }
}

// 实现TextPresentable协议
extension Item: TextPresentable {
    var textDescription: String {
        return name
    }
}

// 使用
print("项目描述: \(items.textDescription)")  // 输出类似: 项目描述: 文件夹1, 文件夹2</code></pre>

                <p>条件一致性允许类型在其元素或关联类型满足特定条件时遵循协议，这提供了更大的灵活性。</p>
            </div>

            <h3>existential类型和类型擦除</h3>

            <div class="example">
                <p>处理异构集合和类型擦除：</p>

                <pre><code>// 定义协议
protocol Drawable {
    func draw()
}

// 实现协议的结构体
struct Line: Drawable {
    func draw() {
        print("绘制直线")
    }
}

struct Circle: Drawable {
    func draw() {
        print("绘制圆形")
    }
}

// 使用existential类型
let drawables: [Drawable] = [Line(), Circle()]
for drawable in drawables {
    drawable.draw()
}

// 类型擦除包装器
struct AnyDrawable: Drawable {
    private let _draw: () -> Void

    init<D: Drawable>(_ drawable: D) {
        _draw = drawable.draw
    }

    func draw() {
        _draw()
    }
}

// 使用类型擦除
let erasedDrawables: [AnyDrawable] = [
    AnyDrawable(Line()),
    AnyDrawable(Circle())
]

for drawable in erasedDrawables {
    drawable.draw()
}

// 更复杂的类型擦除器
class AnyIterator<Element>: IteratorProtocol {
    private let _next: () -> Element?

    init<I: IteratorProtocol>(_ iterator: I) where I.Element == Element {
        var iteratorCopy = iterator
        _next = { iteratorCopy.next() }
    }

    func next() -> Element? {
        return _next()
    }
}

class AnySequence<Element>: Sequence {
    private let _makeIterator: () -> AnyIterator<Element>

    init<S: Sequence>(_ sequence: S) where S.Element == Element {
        _makeIterator = { AnyIterator(sequence.makeIterator()) }
    }

    func makeIterator() -> AnyIterator<Element> {
        return _makeIterator()
    }
}

// 使用自定义序列
struct CountdownSequence: Sequence {
    let start: Int

    func makeIterator() -> CountdownIterator {
        return CountdownIterator(current: start)
    }
}

struct CountdownIterator: IteratorProtocol {
    var current: Int

    mutating func next() -> Int? {
        if current <= 0 {
            return nil
        }
        defer { current -= 1 }
        return current
    }
}

// 擦除类型
let countdown = CountdownSequence(start: 3)
let erasedSequence = AnySequence(countdown)

// 使用擦除后的序列
for number in erasedSequence {
    print(number)  // 输出: 3, 2, 1
}</code></pre>

                <p>类型擦除技术可以隐藏具体类型的实现细节，提供统一的接口，同时保持类型安全。</p>
            </div>
        </div>

        <div id="resources" class="section resources">
            <h2>参考资源</h2>

            <h3>官方文档</h3>
            <ul>
                <li><a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics" target="_blank">Swift官方文档 - 泛型</a></li>
                <li><a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols" target="_blank">Swift官方文档 - 协议</a></li>
                <li><a href="https://developer.apple.com/documentation/swift/opaque-types" target="_blank">Apple开发者文档 - 不透明类型</a></li>
                <li><a href="https://developer.apple.com/videos/play/wwdc2015/408/" target="_blank">WWDC 2015 - 面向协议编程</a></li>
                <li><a href="https://developer.apple.com/videos/play/wwdc2016/416/" target="_blank">WWDC 2016 - 理解Swift性能</a></li>
            </ul>

            <h3>优秀博客文章</h3>
            <ul>
                <li><a href="https://www.hackingwithswift.com/plus/intermediate-swift/understanding-generics-and-protocols" target="_blank">Hacking with Swift - 理解泛型和协议</a></li>
                <li><a href="https://www.swiftbysundell.com/articles/protocols-generics/" target="_blank">Swift by Sundell - 泛型和协议</a></li>
                <li><a href="https://www.swiftbysundell.com/articles/using-protocol-extensions-to-create-unified-apis/" target="_blank">Swift by Sundell - 使用协议扩展创建统一的API</a></li>
                <li><a href="https://www.objc.io/issues/13-architecture/protocol-oriented-programming/" target="_blank">objc.io - 面向协议编程</a></li>
                <li><a href="https://medium.com/@johnsundell/the-power-of-type-inference-in-swift-b5bd779877d1" target="_blank">Medium - Swift中类型推断的威力</a></li>
            </ul>

            <h3>相关书籍</h3>
            <ul>
                <li><a href="https://www.amazon.com/Swift-Programming-Ranch-Guide-Guides/dp/0135264200" target="_blank">Swift编程：Big Nerd Ranch指南</a></li>
                <li><a href="https://www.amazon.com/Advanced-Swift-Airspeed-Velocity/dp/1492054704" target="_blank">Advanced Swift</a></li>
                <li><a href="https://www.objc.io/books/optimizing-collections/" target="_blank">Optimizing Collections - 深入Swift集合类型</a></li>
                <li><a href="https://www.objc.io/books/thinking-in-swiftui/" target="_blank">Thinking in SwiftUI - SwiftUI中的泛型与协议</a></li>
                <li><a href="https://www.raywenderlich.com/books/swift-apprentice" target="_blank">Swift Apprentice - Ray Wenderlich</a></li>
            </ul>

            <h3>开源项目</h3>
            <ul>
                <li><a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms</a> - Apple官方Swift算法库，展示了优秀的泛型和协议使用</li>
                <li><a href="https://github.com/apple/swift-collections" target="_blank">Swift Collections</a> - Apple官方高性能集合类型，使用泛型和协议构建</li>
                <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 反应式编程框架，大量使用泛型和协议</li>
                <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a> - 网络请求库，展示了优秀的协议设计</li>
                <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">The Composable Architecture</a> - 基于协议和泛型的应用架构</li>
            </ul>

            <h3>视频教程</h3>
            <ul>
                <li><a href="https://www.youtube.com/watch?v=QCxkaTj7QJs" target="_blank">Swift泛型入门到高级</a></li>
                <li><a href="https://talk.objc.io/collections/protocol-oriented-programming" target="_blank">objc.io Talks - 面向协议编程</a></li>
                <li><a href="https://www.pluralsight.com/courses/protocol-oriented-programming-swift" target="_blank">Pluralsight - Swift中的面向协议编程</a></li>
                <li><a href="https://www.raywenderlich.com/6742901-protocol-oriented-programming-tutorial-in-swift-5-1-getting-started" target="_blank">Ray Wenderlich - 面向协议编程教程</a></li>
                <li><a href="https://youtu.be/5kXTAtgMkwA" target="_blank">Sean Allen - Swift泛型深入解析</a></li>
            </ul>
        </div>
    </div>
</body>
</html>
