<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 函数 - Apple开发技术手册</title>
    <style>
        :root {
            --primary-color: #8B0000;
            --secondary-color: #F5F5DC;
            --accent-color: #654321;
            --text-color: #333333;
            --background-color: #FFFFFF;
            --block-bg-color: #F9F5F0;
            --code-bg-color: #F5F2EB;
            --border-color: #E0D5C5;
            --heading-font: 'Playfair Display', Georgia, serif;
            --body-font: 'Montserrat', 'Helvetica Neue', sans-serif;
            --max-width: 1200px;
            --section-spacing: 3rem;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-color: #C41E3A;
                --secondary-color: #413935;
                --accent-color: #D2B48C;
                --text-color: #E0D5C5;
                --background-color: #121212;
                --block-bg-color: #1E1E1E;
                --code-bg-color: #252525;
                --border-color: #413935;
            }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: var(--body-font);
            color: var(--text-color);
            background-color: var(--background-color);
            line-height: 1.6;
            padding: 0 20px;
        }

        .container {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: 40px 0;
        }

        header {
            text-align: center;
            margin-bottom: var(--section-spacing);
            padding-bottom: 2rem;
            border-bottom: 1px solid var(--border-color);
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: var(--heading-font);
            color: var(--primary-color);
            margin: 1.5rem 0 1rem;
            letter-spacing: 0.5px;
        }

        h1 {
            font-size: 2.8rem;
            margin-bottom: 1.2rem;
        }

        h2 {
            font-size: 2.2rem;
            margin-top: 2.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--border-color);
        }

        h3 {
            font-size: 1.8rem;
            margin-top: 2rem;
        }

        h4 {
            font-size: 1.4rem;
            color: var(--accent-color);
        }

        p {
            margin-bottom: 1.2rem;
        }

        a {
            color: var(--primary-color);
            text-decoration: none;
            border-bottom: 1px solid transparent;
            transition: border-color 0.3s ease;
        }

        a:hover {
            border-bottom-color: var(--primary-color);
        }

        code {
            font-family: 'Source Code Pro', monospace;
            background-color: var(--code-bg-color);
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 0.9rem;
        }

        pre {
            background-color: var(--code-bg-color);
            padding: 1.5rem;
            border-radius: 5px;
            overflow-x: auto;
            margin: 1.5rem 0;
            border-left: 4px solid var(--primary-color);
        }

        pre code {
            background-color: transparent;
            padding: 0;
            border-radius: 0;
            font-size: 0.9rem;
            display: block;
            line-height: 1.6;
        }

        .section {
            margin-bottom: var(--section-spacing);
        }

        .content-block {
            background-color: var(--block-bg-color);
            padding: 2rem;
            border-radius: 5px;
            margin: 2rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .note {
            background-color: rgba(139, 0, 0, 0.1);
            padding: 1.5rem;
            margin: 1.5rem 0;
            border-left: 4px solid var(--primary-color);
            border-radius: 3px;
        }

        .note-title {
            font-weight: bold;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .resources {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid var(--border-color);
        }

        .resource-group {
            margin-bottom: 2rem;
        }

        .resource-list {
            list-style-type: none;
            padding-left: 0;
        }

        .resource-list li {
            margin-bottom: 0.8rem;
            padding-left: 1.2rem;
            position: relative;
        }

        .resource-list li::before {
            content: "•";
            color: var(--primary-color);
            font-size: 1.2rem;
            position: absolute;
            left: 0;
        }

        .example-title {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: var(--accent-color);
        }

        .example-title::before {
            content: "▶︎";
            margin-right: 0.5rem;
            font-size: 0.8rem;
        }

        .function-diagram {
            max-width: 100%;
            margin: 2rem auto;
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
        }

        th, td {
            padding: 0.8rem 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: var(--block-bg-color);
            font-weight: 600;
            color: var(--primary-color);
        }

        tr:hover {
            background-color: rgba(245, 245, 220, 0.3);
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.2rem;
            }

            h2 {
                font-size: 1.8rem;
            }

            h3 {
                font-size: 1.5rem;
            }

            .content-block {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Swift 函数</h1>
            <p>函数是Swift中执行特定任务的自包含代码块，是Swift代码组织和复用的基础单元</p>
        </header>

        <main>
            <section class="section" id="introduction">
                <h2>函数简介</h2>
                <p>函数是Swift中最基本的构建块之一，它允许我们将特定目的的代码组织成可重用的单元。Swift中的函数具有灵活的参数功能、丰富的返回值选项，以及可作为一等公民在整个语言中使用的能力。</p>

                <div class="content-block">
                    <h3>函数的构成</h3>

                    <svg class="function-diagram" width="700" height="180" viewBox="0 0 700 180">
                        <style>
                            .diagram-text { font-family: monospace; font-size: 14px; }
                            .diagram-label { font-family: sans-serif; font-size: 12px; fill: #8B0000; }
                            .diagram-arrow { stroke: #654321; stroke-width: 1.5; fill: none; marker-end: url(#arrowhead); }
                            .diagram-box { stroke: #8B0000; stroke-width: 1.5; fill: rgba(245, 245, 220, 0.5); }
                        </style>
                        <defs>
                            <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                                <polygon points="0 0, 10 3.5, 0 7" fill="#654321" />
                            </marker>
                        </defs>
                        <!-- 函数声明背景 -->
                        <rect x="10" y="40" width="680" height="30" rx="5" class="diagram-box" fill-opacity="0.2" />
                        <!-- 函数关键字 -->
                        <text x="20" y="60" class="diagram-text">func</text>
                        <text x="20" y="80" class="diagram-label">函数关键字</text>
                        <path d="M20 65 L20 75" class="diagram-arrow" />
                        <!-- 函数名称 -->
                        <text x="60" y="60" class="diagram-text">greet</text>
                        <text x="60" y="80" class="diagram-label">函数名</text>
                        <path d="M60 65 L60 75" class="diagram-arrow" />
                        <!-- 参数列表 -->
                        <rect x="100" y="45" width="300" height="20" rx="5" class="diagram-box" />
                        <text x="110" y="60" class="diagram-text">person: String, day: String</text>
                        <text x="150" y="80" class="diagram-label">参数列表（参数名:参数类型）</text>
                        <path d="M150 65 L150 75" class="diagram-arrow" />
                        <!-- 返回箭头 -->
                        <text x="410" y="60" class="diagram-text">-></text>
                        <text x="410" y="80" class="diagram-label">返回箭头</text>
                        <path d="M410 65 L410 75" class="diagram-arrow" />
                        <!-- 返回类型 -->
                        <text x="440" y="60" class="diagram-text">String</text>
                        <text x="440" y="80" class="diagram-label">返回类型</text>
                        <path d="M440 65 L440 75" class="diagram-arrow" />
                        <!-- 函数体 -->
                        <rect x="30" y="100" width="640" height="30" rx="5" class="diagram-box" />
                        <text x="40" y="120" class="diagram-text">{ return "Hello, \(person)! Today is \(day)." }</text>
                        <text x="200" y="150" class="diagram-label">函数体（包含具体实现代码）</text>
                        <path d="M200 130 L200 140" class="diagram-arrow" />
                    </svg>
                </div>

                <p>Swift中的函数遵循一致的定义模式，如上图所示：</p>
                <ul>
                    <li>以<code>func</code>关键字开始</li>
                    <li>函数名表明函数的用途</li>
                    <li>参数列表定义了函数输入</li>
                    <li>返回箭头和类型声明了函数输出</li>
                    <li>函数体包含具体的实现代码</li>
                </ul>
            </section>

            <section class="section" id="function-declaration">
                <h2>函数声明与调用</h2>
                <p>Swift中的函数声明遵循简单明了的语法，让我们从最基本的函数声明和调用开始。</p>

                <h3>基本函数定义</h3>
                <div class="content-block">
                    <div class="example-title">示例：简单函数</div>
                    <pre><code>// 一个不接收参数也不返回值的简单函数
func sayHello() {
    print("Hello, Swift!")
}

// 函数调用
sayHello() // 输出: Hello, Swift!</code></pre>

                    <div class="example-title">示例：带参数的函数</div>
                    <pre><code>// 带一个参数的函数
func greet(person: String) {
    print("Hello, \(person)!")
}

// 调用带参数的函数
greet(person: "Tim Cook") // 输出: Hello, Tim Cook!</code></pre>

                    <div class="example-title">示例：带返回值的函数</div>
                    <pre><code>// 返回String类型值的函数
func createGreeting(for person: String) -> String {
    return "Welcome, \(person)!"
}

// 使用函数返回值
let greeting = createGreeting(for: "Craig Federighi")
print(greeting) // 输出: Welcome, Craig Federighi!</code></pre>
                </div>
            </section>

            <section class="section" id="parameters">
                <h2>函数参数</h2>
                <p>Swift提供了灵活的参数处理机制，让函数更加强大和易用。</p>

                <h3>参数标签和参数名</h3>
                <div class="content-block">
                    <p>Swift的函数参数有两个部分：参数标签(用于调用)和参数名(用于内部实现)。</p>
                    <pre><code>// 参数标签为from，参数名为hometown
func greet(from hometown: String) -> String {
    // 内部使用hometown
    return "I'm from \(hometown)"
}

// 调用时使用参数标签from
let message = greet(from: "Cupertino")
print(message) // 输出: I'm from Cupertino</code></pre>
                </div>

                <h3>省略参数标签</h3>
                <div class="content-block">
                    <p>使用下划线可以省略参数标签，使函数调用更简洁。</p>
                    <pre><code>func multiply(_ a: Int, _ b: Int) -> Int {
    return a * b
}

// 调用时无需使用参数标签
let result = multiply(5, 3)
print(result) // 输出: 15</code></pre>
                </div>

                <h3>默认参数值</h3>
                <div class="content-block">
                    <p>为参数提供默认值，在调用时可以选择性地省略这些参数。</p>
                    <pre><code>func greet(person: String, formally: Bool = false) -> String {
    if formally {
        return "How do you do, \(person)?"
    } else {
        return "Hey, \(person)!"
    }
}

print(greet(person: "Tim")) // 输出: Hey, Tim!
print(greet(person: "Tim", formally: true)) // 输出: How do you do, Tim?</code></pre>
                </div>

                <h3>可变参数</h3>
                <div class="content-block">
                    <p>可变参数允许传入不确定数量的输入，在参数类型后加上<code>...</code>即可。</p>
                    <pre><code>func calculateAverage(of numbers: Double...) -> Double {
    if numbers.isEmpty { return 0 }
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

let avg1 = calculateAverage(of: 5.0, 3.0, 9.5, 6.7)
print(avg1) // 输出: 6.05

let avg2 = calculateAverage(of: 2.5)
print(avg2) // 输出: 2.5

let avg3 = calculateAverage(of:)
print(avg3) // 输出: 0.0</code></pre>
                </div>

                <h3>输入输出参数 (inout)</h3>
                <div class="content-block">
                    <p>Swift默认的参数是常量，使用<code>inout</code>关键字可以让函数修改参数值并传出函数作用域。</p>
                    <pre><code>func swapTwoValues(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var x = 10
var y = 20
print("Before swap: x = \(x), y = \(y)") // 输出: Before swap: x = 10, y = 20
swapTwoValues(&x, &y) // 注意使用&符号
print("After swap: x = \(x), y = \(y)") // 输出: After swap: x = 20, y = 10</code></pre>

                    <div class="note">
                        <div class="note-title">⚠️ 注意事项</div>
                        <p>使用inout参数时：</p>
                        <ol>
                            <li>调用函数时需要在参数前加上&符号</li>
                            <li>不能传递常量或字面量，必须是变量</li>
                            <li>inout参数不能有默认值</li>
                            <li>inout参数不能是可变参数</li>
                        </ol>
                    </div>
                </div>
            </section>

            <section class="section" id="return-values">
                <h2>返回值</h2>

                <h3>基本返回值</h3>
                <div class="content-block">
                    <pre><code>func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

let sum = add(5, 3)
print(sum) // 输出: 8</code></pre>
                </div>

                <h3>隐式返回</h3>
                <div class="content-block">
                    <p>如果函数体只有一个单行表达式，可以省略<code>return</code>关键字。</p>
                    <pre><code>func multiply(_ a: Int, _ b: Int) -> Int {
    a * b // 隐式返回
}

print(multiply(4, 5)) // 输出: 20</code></pre>
                </div>

                <h3>多重返回值（元组）</h3>
                <div class="content-block">
                    <p>Swift可以通过元组返回多个值。</p>
                    <pre><code>func getMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var min = array[0]
    var max = array[0]

    for value in array {
        if value < min {
            min = value
        } else if value > max {
            max = value
        }
    }

    return (min, max)
}

if let bounds = getMinMax(array: [8, -6, 2, 109, 3, 71]) {
    print("最小值是 \(bounds.min)，最大值是 \(bounds.max)")
    // 输出: 最小值是 -6，最大值是 109
}

// 也可以通过索引访问
if let bounds = getMinMax(array: [8, -6, 2, 109, 3, 71]) {
    print("最小值是 \(bounds.0)，最大值是 \(bounds.1)")
    // 输出: 最小值是 -6，最大值是 109
}</code></pre>
                </div>

                <h3>可选返回类型</h3>
                <div class="content-block">
                    <p>函数可能在某些条件下无法返回有效值，可以使用可选类型。</p>
                    <pre><code>func findIndex(of value: Int, in array: [Int]) -> Int? {
    for (index, item) in array.enumerated() {
        if item == value {
            return index
        }
    }
    return nil
}

let numbers = [10, 20, 30, 40, 50]
if let index = findIndex(of: 30, in: numbers) {
    print("找到值30在索引\(index)处") // 输出: 找到值30在索引2处
} else {
    print("未找到值")
}

if let index = findIndex(of: 35, in: numbers) {
    print("找到值35在索引\(index)处")
} else {
    print("未找到值") // 输出: 未找到值
}</code></pre>
                </div>
            </section>

            <section class="section" id="function-types">
                <h2>函数类型</h2>
                <p>在Swift中，函数是一等公民，具有自己的类型，可以像其他类型一样被传递和使用。</p>

                <h3>函数类型表示法</h3>
                <div class="content-block">
                    <pre><code>// 函数类型: (Int, Int) -> Int
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

// 函数类型: (String) -> Void
func printHello(to person: String) {
    print("Hello, \(person)!")
}

// 将函数赋值给变量
let mathFunction: (Int, Int) -> Int = add
print(mathFunction(2, 3)) // 输出: 5

let greetFunction: (String) -> Void = printHello
greetFunction("World") // 输出: Hello, World!</code></pre>
                </div>

                <h3>函数类型作为参数</h3>
                <div class="content-block">
                    <pre><code>func performMathOperation(_ operation: (Int, Int) -> Int, on a: Int, and b: Int) -> Int {
    return operation(a, b)
}

func multiply(_ a: Int, _ b: Int) -> Int {
    return a * b
}

let result1 = performMathOperation(add, on: 10, and: 5)
print(result1) // 输出: 15

let result2 = performMathOperation(multiply, on: 10, and: 5)
print(result2) // 输出: 50</code></pre>
                </div>

                <h3>函数类型作为返回值</h3>
                <div class="content-block">
                    <pre><code>func chooseOperation(shouldMultiply: Bool) -> (Int, Int) -> Int {
    return shouldMultiply ? multiply : add
}

let operation = chooseOperation(shouldMultiply: true)
print(operation(4, 2)) // 输出: 8

let operation2 = chooseOperation(shouldMultiply: false)
print(operation2(4, 2)) // 输出: 6</code></pre>
                </div>
            </section>

            <section class="section" id="nested-functions">
                <h2>嵌套函数</h2>
                <p>Swift允许在函数内部定义函数，这些嵌套函数默认对外部隐藏，但可以被其包含函数使用或返回。</p>

                <div class="content-block">
                    <pre><code>func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    // 嵌套函数：向前一步
    func stepForward(input: Int) -> Int {
        return input + 1
    }

    // 嵌套函数：向后一步
    func stepBackward(input: Int) -> Int {
        return input - 1
    }

    // 根据参数返回相应的嵌套函数
    return backward ? stepBackward : stepForward
}

let moveToZero = chooseStepFunction(backward: 4 > 0)
var value = 4

// 反复调用函数直到达到0
while value != 0 {
    print("\(value)...")
    value = moveToZero(value)
}
print("零！")
// 输出:
// 4...
// 3...
// 2...
// 1...
// 零！</code></pre>
                </div>
            </section>

            <section class="section" id="closures">
                <h2>闭包</h2>
                <p>闭包是自包含的功能代码块，可以在代码中被传递和使用。Swift中的闭包类似于其他语言中的lambda或匿名函数。</p>

                <h3>闭包表达式语法</h3>
                <div class="content-block">
                    <svg class="function-diagram" width="700" height="180" viewBox="0 0 700 180">
                        <style>
                            .closure-box { stroke: #8B0000; stroke-width: 1.5; fill: rgba(245, 245, 220, 0.5); }
                            .closure-text { font-family: monospace; font-size: 14px; }
                            .closure-label { font-family: sans-serif; font-size: 12px; fill: #8B0000; }
                            .closure-arrow { stroke: #654321; stroke-width: 1.5; fill: none; marker-end: url(#arrowhead2); }
                        </style>
                        <defs>
                            <marker id="arrowhead2" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                                <polygon points="0 0, 10 3.5, 0 7" fill="#654321" />
                            </marker>
                        </defs>
                        <!-- 闭包整体背景 -->
                        <rect x="10" y="40" width="680" height="30" rx="5" class="closure-box" fill-opacity="0.2" />

                        <!-- 参数部分 -->
                        <rect x="40" y="45" width="150" height="20" rx="5" class="closure-box" />
                        <text x="50" y="60" class="closure-text">(a: Int, b: Int)</text>
                        <text x="65" y="95" class="closure-label">参数列表</text>
                        <path d="M65 65 L65 85" class="closure-arrow" />

                        <!-- in关键字 -->
                        <text x="210" y="60" class="closure-text">in</text>
                        <text x="210" y="95" class="closure-label">in关键字</text>
                        <path d="M210 65 L210 85" class="closure-arrow" />

                        <!-- 闭包体 -->
                        <rect x="240" y="45" width="400" height="20" rx="5" class="closure-box" />
                        <text x="250" y="60" class="closure-text">return a * b // 闭包体包含代码实现</text>
                        <text x="400" y="95" class="closure-label">闭包体</text>
                        <path d="M400 65 L400 85" class="closure-arrow" />

                        <!-- 闭包类型说明 -->
                        <text x="10" y="140" class="closure-label">闭包类型: (Int, Int) -> Int</text>
                    </svg>

                    <pre><code>// 完整闭包语法
let multiply = { (a: Int, b: Int) -> Int in
    return a * b
}

// 调用闭包
print(multiply(4, 5)) // 输出: 20

// 根据上下文推断类型
let add: (Int, Int) -> Int = { a, b in
    return a + b
}

// 隐式返回
let subtract: (Int, Int) -> Int = { a, b in a - b }

// 参数名称缩写
let square: (Int) -> Int = { $0 * $0 }

print(add(5, 3))      // 输出: 8
print(subtract(10, 4)) // 输出: 6
print(square(5))      // 输出: 25</code></pre>
                </div>

                <h3>尾随闭包</h3>
                <div class="content-block">
                    <p>当闭包是函数的最后一个参数时，可以使用尾随闭包语法，提高代码可读性。</p>
                    <pre><code>// 接受闭包作为参数的函数
func performOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

// 常规调用
let result1 = performOperation(5, 3, operation: { a, b in a + b })

// 使用尾随闭包
let result2 = performOperation(5, 3) { a, b in
    a + b
}

print(result1) // 输出: 8
print(result2) // 输出: 8

// 尾随闭包在数组方法中的应用
let numbers = [1, 5, 3, 8, 2, 10, 7]

let sortedNumbers = numbers.sorted { a, b in
    a < b
}
print(sortedNumbers) // 输出: [1, 2, 3, 5, 7, 8, 10]

// 使用参数名称缩写
let filteredNumbers = numbers.filter { $0 > 5 }
print(filteredNumbers) // 输出: [8, 10, 7]

let mappedNumbers = numbers.map { $0 * 2 }
print(mappedNumbers) // 输出: [2, 10, 6, 16, 4, 20, 14]</code></pre>
                </div>

                <h3>值捕获</h3>
                <div class="content-block">
                    <p>闭包可以捕获和存储其定义环境中的常量和变量。</p>
                    <pre><code>func makeIncrementer(incrementAmount: Int) -> () -> Int {
    var total = 0
    let incrementer: () -> Int = {
        // 闭包捕获了incrementAmount和total变量
        total += incrementAmount
        return total
    }
    return incrementer
}

let incrementByTwo = makeIncrementer(incrementAmount: 2)
print(incrementByTwo()) // 输出: 2
print(incrementByTwo()) // 输出: 4
print(incrementByTwo()) // 输出: 6

// 创建另一个独立的闭包实例
let incrementByTen = makeIncrementer(incrementAmount: 10)
print(incrementByTen()) // 输出: 10

// 原闭包继续累加自己的状态
print(incrementByTwo()) // 输出: 8</code></pre>
                </div>
            </section>

            <section class="section" id="escaping-closures">
                <h2>逃逸闭包与非逃逸闭包</h2>

                <div class="content-block">
                    <p>当闭包作为参数传递给函数，并且可能在函数返回后才被调用时，这个闭包就称为逃逸闭包。</p>

                    <svg class="function-diagram" width="700" height="280" viewBox="0 0 700 280">
                        <style>
                            .escape-box { fill: rgba(139, 0, 0, 0.1); stroke: #8B0000; stroke-width: 1.5; }
                            .escape-arrow { stroke: #654321; stroke-width: 2; fill: none; marker-end: url(#escapehead); }
                            .escape-text { font-family: sans-serif; font-size: 12px; }
                            .escape-title { font-family: sans-serif; font-size: 14px; font-weight: bold; }
                        </style>
                        <defs>
                            <marker id="escapehead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                                <polygon points="0 0, 10 3.5, 0 7" fill="#654321" />
                            </marker>
                        </defs>

                        <!-- 左边：非逃逸闭包 -->
                        <rect x="50" y="30" width="250" height="200" rx="10" class="escape-box" fill-opacity="0.2" />
                        <text x="100" y="55" class="escape-title">非逃逸闭包 (@escaping 不需要)</text>

                        <rect x="70" y="70" width="210" height="140" rx="5" class="escape-box" fill-opacity="0.5" />
                        <text x="130" y="90" class="escape-text">函数范围</text>

                        <rect x="90" y="110" width="80" height="40" rx="5" class="escape-box" />
                        <text x="105" y="135" class="escape-text">闭包参数</text>

                        <rect x="90" y="160" width="170" height="30" rx="5" class="escape-box" />
                        <text x="95" y="180" class="escape-text">函数内部使用闭包并返回</text>

                        <path d="M130 150 L130 160" class="escape-arrow" />

                        <!-- 右边：逃逸闭包 -->
                        <rect x="380" y="30" width="270" height="230" rx="10" class="escape-box" fill-opacity="0.2" />
                        <text x="430" y="55" class="escape-title">逃逸闭包 (需要 @escaping)</text>

                        <rect x="400" y="70" width="230" height="80" rx="5" class="escape-box" fill-opacity="0.5" />
                        <text x="470" y="90" class="escape-text">函数范围</text>

                        <rect x="420" y="110" width="80" height="30" rx="5" class="escape-box" />
                        <text x="425" y="130" class="escape-text">闭包存储</text>

                        <rect x="400" y="170" width="140" height="70" rx="5" class="escape-box" fill-opacity="0.5" />
                        <text x="440" y="195" class="escape-text">函数外部</text>
                        <text x="435" y="220" class="escape-text">使用闭包</text>

                        <rect x="560" y="170" width="70" height="70" rx="5" class="escape-box" fill-opacity="0.5" />
                        <text x="570" y="205" class="escape-text">异步调用</text>

                        <path d="M460 140 L460 170" class="escape-arrow" />
                        <path d="M500 110 L595 170" class="escape-arrow" />
                    </svg>

                    <h3>非逃逸闭包（默认）</h3>
                    <pre><code>// 默认情况下闭包是非逃逸的
func performClosure(closure: () -> Void) {
    print("函数开始执行")
    closure() // 在函数内部调用闭包
    print("函数执行完毕")
}

performClosure {
    print("这是非逃逸闭包")
}
// 输出:
// 函数开始执行
// 这是非逃逸闭包
// 函数执行完毕</code></pre>

                    <h3>逃逸闭包</h3>
                    <pre><code>// 定义一个存储闭包的数组
var completionHandlers: [() -> Void] = []

// 使用@escaping标记逃逸闭包
func addCompletionHandler(handler: @escaping () -> Void) {
    // 闭包被存储起来，在函数结束后可能被调用
    completionHandlers.append(handler)
}

// 添加几个闭包
addCompletionHandler {
    print("第一个完成处理器被调用")
}
addCompletionHandler {
    print("第二个完成处理器被调用")
}

print("添加了 \(completionHandlers.count) 个处理器")

// 在函数外部调用存储的闭包
completionHandlers.first?()
// 输出:
// 添加了 2 个处理器
// 第一个完成处理器被调用</code></pre>

                    <h3>逃逸闭包的典型应用</h3>
                    <pre><code>// 模拟一个网络请求函数
func fetchData(completion: @escaping (String) -> Void) {
    // 模拟异步操作
    DispatchQueue.global().async {
        // 模拟网络延迟
        Thread.sleep(forTimeInterval: 2)

        // 获取数据后，在主线程执行回调
        DispatchQueue.main.async {
            completion("获取到的数据")
        }
    }
    print("fetchData函数已返回，但异步操作仍在进行")
}

print("开始获取数据")
fetchData { data in
    print("数据回调: \(data)")
}
print("函数调用后继续执行其他任务")

// 输出顺序:
// 开始获取数据
// fetchData函数已返回，但异步操作仍在进行
// 函数调用后继续执行其他任务
// (2秒后)
// 数据回调: 获取到的数据</code></pre>

                    <div class="note">
                        <div class="note-title">⚠️ 重要提示</div>
                        <p>使用逃逸闭包需要注意内存管理问题，特别是在闭包中使用self时可能导致循环引用。在逃逸闭包中使用self时，应该考虑使用weak或unowned引用。</p>
                        <pre><code>class DataManager {
    var data = "Some data"

    func processData(completion: @escaping () -> Void) {
        // 推荐使用弱引用防止循环引用
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            print("处理数据: \(self.data)")
            completion()
        }
    }
}</code></pre>
                    </div>
                </div>
            </section>

            <section class="section" id="autoclosures">
                <h2>自动闭包</h2>
                <div class="content-block">
                    <p>自动闭包是一种特殊的闭包，它会自动将一个表达式包装为闭包。这在需要延迟求值的场景中非常有用。</p>

                    <pre><code>// 不使用自动闭包的常规函数
func logIfTrue(_ predicate: () -> Bool) {
    if predicate() {
        print("条件为真")
    }
}

// 调用时需要显式使用闭包语法
logIfTrue({ return 2 > 1 })

// 使用自动闭包的函数
func logIfTrueAuto(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("自动闭包条件为真")
    }
}

// 调用时可以直接传递表达式，系统自动将其包装为闭包
logIfTrueAuto(2 > 1)

// 自动闭包实际应用示例 - 短路求值
var customersInLine = ["Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count) // 输出: 4

// 创建一个从队列中取出第一个客户的闭包
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count) // 输出: 4 (闭包尚未执行)

// 执行闭包
print("Next customer: \(customerProvider())") // 输出: Next customer: Alex
print(customersInLine.count) // 输出: 3

// 使用自动闭包的函数
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

// 函数调用 - 表达式会自动转换为闭包
serve(customer: customersInLine.remove(at: 0)) // 输出: Now serving Ewa!
print(customersInLine.count) // 输出: 2</code></pre>

                    <div class="note">
                        <div class="note-title">💡 自动闭包使用提示</div>
                        <p>过度使用自动闭包会使代码难以理解，应当适度使用并在文档中注明。可以将@autoclosure和@escaping组合使用，允许自动闭包逃逸。</p>
                    </div>
                </div>
            </section>

            <section class="section" id="functional-programming">
                <h2>Swift中的函数式编程</h2>
                <div class="content-block">
                    <p>Swift语言支持函数式编程范式，允许我们使用高阶函数处理集合数据。</p>

                    <h3>常用高阶函数</h3>
                    <pre><code>let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// map: 转换集合中的每个元素
let doubled = numbers.map { $0 * 2 }
print(doubled) // 输出: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

// filter: 根据条件过滤集合
let evenNumbers = numbers.filter { $0 % 2 == 0 }
print(evenNumbers) // 输出: [2, 4, 6, 8, 10]

// reduce: 将集合合并成单个值
let sum = numbers.reduce(0) { $0 + $1 }
print(sum) // 输出: 55

let stringNumbers = numbers.reduce("") { "\($0)\($1)," }
print(stringNumbers) // 输出: 1,2,3,4,5,6,7,8,9,10,

// flatMap/compactMap: 展平嵌套集合或过滤nil值
let optionalNumbers: [Int?] = [1, nil, 3, nil, 5]
let nonNilNumbers = optionalNumbers.compactMap { $0 }
print(nonNilNumbers) // 输出: [1, 3, 5]

let nestedArrays = [[1, 2], [3, 4], [5, 6]]
let flattened = nestedArrays.flatMap { $0 }
print(flattened) // 输出: [1, 2, 3, 4, 5, 6]</code></pre>

                    <h3>函数式编程实践</h3>
                    <pre><code>// 定义一个Person结构体模拟数据
struct Person {
    let name: String
    let age: Int
}

// 创建一组数据
let people = [
    Person(name: "Alice", age: 25),
    Person(name: "Bob", age: 17),
    Person(name: "Charlie", age: 30),
    Person(name: "David", age: 16),
    Person(name: "Eve", age: 21)
]

// 需求：找出所有成年人的名字，按字母排序
let adultNames = people
    .filter { $0.age >= 18 }    // 过滤出成年人
    .map { $0.name }            // 提取名字
    .sorted()                   // 按字母排序

print(adultNames) // 输出: ["Alice", "Charlie", "Eve"]

// 需求：计算所有人的平均年龄
let totalAge = people.reduce(0) { $0 + $1.age }
let averageAge = Double(totalAge) / Double(people.count)
print("平均年龄: \(averageAge)") // 输出: 平均年龄: 21.8

// 函数组合：创建一个函数管道
func pipeline<T, U, V>(_ value: T, _ firstFunction: (T) -> U, _ secondFunction: (U) -> V) -> V {
    return secondFunction(firstFunction(value))
}

// 创建一些基础函数
func double(_ x: Int) -> Int { return x * 2 }
func addOne(_ x: Int) -> Int { return x + 1 }
func toString(_ x: Int) -> String { return "结果是 \(x)" }

// 使用函数组合
let result = pipeline(5, double, addOne)
print(result) // 输出: 11

let resultString = pipeline(5, { double($0) }, { toString($0) })
print(resultString) // 输出: 结果是 10</code></pre>
                </div>
            </section>

            <section class="section" id="best-practices">
                <h2>函数设计最佳实践</h2>
                <div class="content-block">
                    <h3>函数命名</h3>
                    <ul>
                        <li>使用动词开头的驼峰式命名法</li>
                        <li>名称应当清晰表达函数的行为</li>
                        <li>使用参数标签明确参数的角色</li>
                    </ul>

                    <pre><code>// 优秀的函数命名示例
func insert(_ element: Element, at index: Int)
func remove(at position: Index) -> Element
func distance(from start: Index, to end: Index) -> Int
func addObserver(_ observer: Observer, for keyPath: String)</code></pre>

                    <h3>单一职责原则</h3>
                    <p>函数应当只完成一个明确的任务。</p>

                    <pre><code>// 不推荐：一个函数做多件事
func processUserData(for userId: String) {
    // 获取用户数据
    // 验证用户权限
    // 更新用户数据
    // 发送通知
    // 记录日志
}

// 推荐：职责分离
func fetchUserData(for userId: String) -> User
func validateUserPermissions(for user: User) -> Bool
func updateUserData(_ user: User) -> Bool
func notifyDataUpdate(for user: User)
func logUserActivity(for userId: String, action: String)</code></pre>

                    <h3>参数设计</h3>
                    <p>控制参数数量，使用结构化数据作为参数。</p>

                    <pre><code>// 不推荐：过多参数
func createUser(firstName: String, lastName: String, email: String,
                age: Int, address: String, city: String, country: String,
                postalCode: String, phone: String) {
    // 实现...
}

// 推荐：使用结构体组织参数
struct UserData {
    let firstName: String
    let lastName: String
    let email: String
    let age: Int

    struct Address {
        let street: String
        let city: String
        let country: String
        let postalCode: String
    }

    let address: Address
    let phone: String
}

func createUser(with userData: UserData) {
    // 实现...
}</code></pre>

                    <h3>错误处理</h3>
                    <p>使用Swift的错误处理机制处理函数执行中可能出现的错误。</p>

                    <pre><code>// 定义可能的错误类型
enum DatabaseError: Error {
    case connectionFailed
    case queryFailed(String)
    case recordNotFound(id: String)
    case permissionDenied
}

// 使用throws声明可能抛出错误的函数
func fetchRecord(id: String) throws -> Record {
    guard isConnected else {
        throw DatabaseError.connectionFailed
    }

    guard hasPermission else {
        throw DatabaseError.permissionDenied
    }

    // 假设这是查询记录的代码
    if let record = findRecord(id: id) {
        return record
    } else {
        throw DatabaseError.recordNotFound(id: id)
    }
}

// 调用可能抛出错误的函数
do {
    let record = try fetchRecord(id: "12345")
    print("获取记录成功: \(record)")
} catch DatabaseError.connectionFailed {
    print("连接数据库失败")
} catch DatabaseError.permissionDenied {
    print("没有权限访问该记录")
} catch DatabaseError.recordNotFound(let id) {
    print("记录 \(id) 不存在")
} catch {
    print("发生未知错误: \(error)")
}</code></pre>
                </div>
            </section>

            <section class="section resources" id="resources">
                <h2>参考资源</h2>

                <div class="resource-group">
                    <h3>官方文档</h3>
                    <ul class="resource-list">
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Functions.html" target="_blank">Swift官方文档 - 函数</a></li>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Closures.html" target="_blank">Swift官方文档 - 闭包</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/using-closures" target="_blank">Apple开发者文档 - 使用闭包</a></li>
                    </ul>
                </div>

                <div class="resource-group">
                    <h3>书籍推荐</h3>
                    <ul class="resource-list">
                        <li>《Swift编程语言》 - Apple官方</li>
                        <li>《Swift进阶》 - 王巍(onevcat)</li>
                        <li>《函数式Swift》 - Chris Eidhof, Florian Kugler, Wouter Swierstra</li>
                        <li>《Pro Swift》 - Paul Hudson</li>
                    </ul>
                </div>

                <div class="resource-group">
                    <h3>视频教程</h3>
                    <ul class="resource-list">
                        <li><a href="https://developer.apple.com/videos/play/wwdc2019/415/" target="_blank">WWDC2019 - Modern Swift API Design</a></li>
                        <li><a href="https://www.youtube.com/watch?v=CxpQ1Y-YMpY" target="_blank">Stanford CS193p - 函数式编程在Swift中的应用</a></li>
                        <li><a href="https://www.raywenderlich.com/9222-swift-functional-programming-fundamentals" target="_blank">RayWenderlich - Swift函数式编程基础</a></li>
                    </ul>
                </div>

                <div class="resource-group">
                    <h3>优秀博客与文章</h3>
                    <ul class="resource-list">
                        <li><a href="https://www.swiftbysundell.com/articles/functions-as-first-class-types-in-swift/" target="_blank">Swift by Sundell - Functions as first class types</a></li>
                        <li><a href="https://www.hackingwithswift.com/articles/126/whats-the-difference-between-escaping-and-non-escaping-closures" target="_blank">Hacking with Swift - 逃逸和非逃逸闭包的区别</a></li>
                        <li><a href="https://onevcat.com/2015/01/swift-pointers/" target="_blank">OneV's Den - Swift中的指针</a></li>
                        <li><a href="https://swift.gg/2016/12/08/swift-pattern-matching-in-detail/" target="_blank">SwiftGG - Swift模式匹配详解</a></li>
                    </ul>
                </div>

                <div class="resource-group">
                    <h3>相关开源项目</h3>
                    <ul class="resource-list">
                        <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift - 响应式编程框架</a></li>
                        <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Swift Composable Architecture - 函数式架构</a></li>
                        <li><a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms - Swift标准库算法扩展</a></li>
                        <li><a href="https://github.com/pointfreeco/swift-snapshot-testing" target="_blank">Swift Snapshot Testing - 函数式测试工具</a></li>
                    </ul>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
