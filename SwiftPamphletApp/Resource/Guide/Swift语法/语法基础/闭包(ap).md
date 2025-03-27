<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift闭包详解 | Apple开发技术手册</title>
    <style>
        :root {
            --primary-color: #E01F26;
            --background-color: #F5F2EA;
            --text-color: #222222;
            --code-bg: #f4f4f4;
            --heading-color: #000000;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --primary-color: #FF3B42;
                --background-color: #222222;
                --text-color: #F5F2EA;
                --code-bg: #333333;
                --heading-color: #FFFFFF;
            }
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            position: relative;
            padding: 40px 0;
            margin-bottom: 40px;
            border-bottom: 5px solid var(--primary-color);
        }
        
        h1 {
            font-size: 3.5rem;
            font-weight: 900;
            text-transform: uppercase;
            color: var(--heading-color);
            margin-bottom: 20px;
            letter-spacing: -1px;
            line-height: 1;
            position: relative;
            z-index: 1;
        }
        
        h1 span {
            color: var(--primary-color);
        }
        
        h2 {
            font-size: 2.5rem;
            font-weight: 800;
            text-transform: uppercase;
            color: var(--heading-color);
            margin-top: 50px;
            margin-bottom: 25px;
            position: relative;
        }
        
        h2::after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 5px;
            background-color: var(--primary-color);
        }
        
        h3 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--heading-color);
            margin-top: 40px;
            margin-bottom: 20px;
        }
        
        p {
            margin-bottom: 20px;
            font-size: 1.1rem;
        }
        
        .badge {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            font-weight: bold;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-right: 10px;
            margin-bottom: 10px;
        }
        
        pre {
            background-color: var(--code-bg);
            border-left: 4px solid var(--primary-color);
            padding: 15px;
            margin: 20px 0;
            overflow-x: auto;
            border-radius: 5px;
        }
        
        code {
            font-family: 'Menlo', 'Monaco', 'Courier New', monospace;
            font-size: 14px;
        }
        
        .example {
            background-color: rgba(224, 31, 38, 0.05);
            border-radius: 8px;
            padding: 20px;
            margin: 30px 0;
            position: relative;
        }
        
        .example::before {
            content: "示例";
            position: absolute;
            top: -12px;
            left: 20px;
            background-color: var(--primary-color);
            color: white;
            padding: 3px 15px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: bold;
        }
        
        .note {
            background-color: rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            padding: 20px;
            margin: 30px 0;
            border-left: 5px solid #666;
        }
        
        .resources {
            margin-top: 50px;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.05);
            border-radius: 8px;
        }
        
        .resource-list {
            list-style-type: none;
        }
        
        .resource-list li {
            margin-bottom: 15px;
        }
        
        a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
        }
        
        a:hover {
            text-decoration: underline;
        }
        
        .diagram {
            margin: 30px auto;
            display: block;
            max-width: 100%;
        }
        
        .circle-badge {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            text-align: center;
            position: absolute;
            top: 20px;
            right: 20px;
            transform: rotate(15deg);
            font-size: 0.9rem;
            z-index: 2;
        }
        
        @media (max-width: 768px) {
            h1 {
                font-size: 2.5rem;
            }
            
            h2 {
                font-size: 2rem;
            }
            
            .circle-badge {
                width: 80px;
                height: 80px;
                font-size: 0.7rem;
            }
        }
    </style>
</head>

<body>
    <header>
        <div class="circle-badge">SWIFT<br>CLOSURE</div>
        <h1>SWIFT <span>闭包</span><br>CLOSURE</h1>
        <p>强大而灵活的Swift函数式编程核心</p>
    </header>

    <section id="introduction">
        <h2>闭包概述</h2>
        <p>闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift的闭包类似于C和Objective-C中的blocks或其他语言中的匿名函数。</p>
        
        <svg class="diagram" width="100%" height="220" viewBox="0 0 800 220">
            <defs>
                <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="0" refY="3.5" orient="auto">
                    <polygon points="0 0, 10 3.5, 0 7" fill="#E01F26" />
                </marker>
            </defs>
            <rect x="50" y="50" width="700" height="120" rx="15" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="30" text-anchor="middle" font-size="20" font-weight="bold">闭包的本质</text>
            <rect x="80" y="80" width="200" height="60" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="180" y="115" text-anchor="middle" font-size="16">函数代码块</text>
            <rect x="340" y="80" width="200" height="60" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="440" y="115" text-anchor="middle" font-size="16">捕获环境中的值</text>
            <rect x="600" y="80" width="120" height="60" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="660" y="115" text-anchor="middle" font-size="16">可传递</text>
            <line x1="280" y1="110" x2="330" y2="110" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
            <line x1="540" y1="110" x2="590" y2="110" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
        </svg>

        <p>闭包采取以下三种形式之一：</p>
        <ul>
            <li>全局函数：有名字但不捕获任何值的闭包</li>
            <li>嵌套函数：有名字且能从其包含函数捕获值的闭包</li>
            <li>闭包表达式：无名闭包，使用轻量级语法，可从上下文中捕获值</li>
        </ul>
    </section>

    <section id="closure-syntax">
        <h2>闭包语法</h2>
        <p>Swift的闭包表达式语法有一种干净、清晰的风格，通过优化鼓励在简短闭包中进行整洁的语法。</p>

        <svg class="diagram" width="100%" height="320" viewBox="0 0 800 320">
            <rect x="50" y="40" width="700" height="240" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="25" text-anchor="middle" font-size="18" font-weight="bold">闭包语法结构</text>
            <rect x="100" y="70" width="600" height="50" rx="5" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="400" y="100" text-anchor="middle" font-size="16">{ (参数) -> 返回类型 in 表达式 }</text>
            <line x1="100" y1="150" x2="700" y2="150" stroke="#333" stroke-dasharray="5,5" />
            <rect x="100" y="170" width="600" height="85" rx="5" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="400" y="195" text-anchor="middle" font-size="14">左花括号 { 开始</text>
            <text x="400" y="225" text-anchor="middle" font-size="14">参数和返回类型声明，后跟 in 关键字</text>
            <text x="400" y="255" text-anchor="middle" font-size="14">右花括号 } 结束</text>
        </svg>

        <div class="example">
            <p>一个完整的闭包表达式示例：</p>
            <pre><code>// 使用函数
let sortedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 < s2
})

// 等效的函数版本
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}
let sortedNames2 = names.sorted(by: backward)</code></pre>
        </div>
    </section>

    <section id="closure-simplification">
        <h2>闭包表达式简化</h2>
        <p>Swift提供了多种方式来简化闭包表达式语法，使代码更简洁。</p>

        <h3>1. 根据上下文推断类型</h3>
        <div class="example">
            <pre><code>// 原始版本
let sortedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 < s2
})

// 简化版本 - 从上下文推断参数和返回类型
let sortedNames = names.sorted(by: { s1, s2 in return s1 < s2 })</code></pre>
        </div>

        <h3>2. 单表达式闭包的隐式返回</h3>
        <div class="example">
            <pre><code>// 移除return关键字
let sortedNames = names.sorted(by: { s1, s2 in s1 < s2 })</code></pre>
        </div>

        <h3>3. 参数名称缩写</h3>
        <div class="example">
            <pre><code>// 使用$0, $1等自动命名的参数
let sortedNames = names.sorted(by: { $0 < $1 })</code></pre>
        </div>

        <h3>4. 运算符方法</h3>
        <div class="example">
            <pre><code>// 使用String类型的<运算符
let sortedNames = names.sorted(by: <)</code></pre>
        </div>

        <svg class="diagram" width="100%" height="300" viewBox="0 0 800 300">
            <rect x="50" y="20" width="700" height="260" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="50" text-anchor="middle" font-size="18" font-weight="bold">闭包简化演变</text>
            
            <line x1="100" y1="80" x2="700" y2="80" stroke="#333" stroke-width="1" />
            <text x="150" y="100" font-size="14">完整形式</text>
            <text x="450" y="100" text-anchor="middle" font-size="12">{ (s1: String, s2: String) -> Bool in return s1 < s2 }</text>
            
            <line x1="400" y1="120" x2="400" y2="130" stroke="#E01F26" stroke-width="2" marker-end="url(#arrowhead)" />
            
            <line x1="100" y1="140" x2="700" y2="140" stroke="#333" stroke-width="1" />
            <text x="150" y="160" font-size="14">类型推断</text>
            <text x="450" y="160" text-anchor="middle" font-size="12">{ s1, s2 in return s1 < s2 }</text>
            
            <line x1="400" y1="180" x2="400" y2="190" stroke="#E01F26" stroke-width="2" marker-end="url(#arrowhead)" />
            
            <line x1="100" y1="200" x2="700" y2="200" stroke="#333" stroke-width="1" />
            <text x="150" y="220" font-size="14">隐式返回</text>
            <text x="450" y="220" text-anchor="middle" font-size="12">{ s1, s2 in s1 < s2 }</text>
            
            <line x1="400" y1="240" x2="400" y2="250" stroke="#E01F26" stroke-width="2" marker-end="url(#arrowhead)" />
            
            <line x1="100" y1="260" x2="700" y2="260" stroke="#333" stroke-width="1" />
            <text x="150" y="280" font-size="14">简写参数名</text>
            <text x="450" y="280" text-anchor="middle" font-size="12">{ $0 < $1 }</text>
        </svg>
    </section>

    <section id="trailing-closures">
        <h2>尾随闭包</h2>
        <p>当闭包是函数的最后一个参数时，可以使用尾随闭包语法，将闭包表达式写在函数调用括号之后。</p>

        <div class="example">
            <pre><code>// 标准写法
let sortedNames = names.sorted(by: { $0 < $1 })

// 尾随闭包语法
let sortedNames = names.sorted() { $0 < $1 }

// 当闭包是唯一参数时，还可以省略括号
let sortedNames = names.sorted { $0 < $1 }</code></pre>
        </div>

        <div class="note">
            <p>尾随闭包在闭包表达式很长的情况下特别有用，使代码更加清晰易读。</p>
        </div>

        <div class="example">
            <p>多个尾随闭包（Swift 5.3+）：</p>
            <pre><code>// 使用多个尾随闭包的UIView动画示例
UIView.animate(withDuration: 0.3) {
    // 第一个闭包：动画
    view.alpha = 0
} completion: { finished in
    // 第二个闭包：完成回调
    view.removeFromSuperview()
}</code></pre>
        </div>
    </section>

    <section id="capturing-values">
        <h2>值捕获</h2>
        <p>闭包可以从定义它的上下文中"捕获"常量和变量，即使定义这些常量和变量的作用域已不存在，闭包仍然可以在其函数体内引用和修改这些值。</p>

        <svg class="diagram" width="100%" height="280" viewBox="0 0 800 280">
            <rect x="100" y="30" width="600" height="220" rx="15" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="20" text-anchor="middle" font-size="18" font-weight="bold">闭包值捕获原理</text>
            
            <rect x="150" y="60" width="500" height="60" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="90" text-anchor="middle" font-size="16">外部函数作用域</text>
            <text x="400" y="110" text-anchor="middle" font-size="14">var counter = 0</text>
            
            <rect x="200" y="150" width="400" height="70" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="400" y="175" text-anchor="middle" font-size="16">闭包</text>
            <text x="400" y="200" text-anchor="middle" font-size="14">{ counter += 1 }</text>
            
            <path d="M400,120 L400,150" stroke="#333" stroke-width="2" stroke-dasharray="5,5" />
            <text x="420" y="135" font-size="14">捕获引用</text>
        </svg>

        <div class="example">
            <p>闭包捕获和修改值的示例：</p>
            <pre><code>func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        // incrementer()函数捕获了runningTotal和amount
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

// 创建一个递增器
let incrementByTen = makeIncrementer(forIncrement: 10)

// 调用递增器多次
print(incrementByTen()) // 输出: 10
print(incrementByTen()) // 输出: 20
print(incrementByTen()) // 输出: 30

// 创建另一个独立的递增器
let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven()) // 输出: 7

// 原来的递增器仍然保持自己的状态
print(incrementByTen()) // 输出: 40</code></pre>
        </div>
    </section>

    <section id="reference-type">
        <h2>闭包是引用类型</h2>
        <p>闭包是引用类型。当你将一个闭包赋值给两个不同的常量或变量，它们都会引用同一个闭包。</p>

        <div class="example">
            <pre><code>// 创建一个递增器
let incrementByTen = makeIncrementer(forIncrement: 10)
print(incrementByTen()) // 输出: 10

// 将闭包赋值给另一个常量
let anotherIncrementByTen = incrementByTen
print(anotherIncrementByTen()) // 输出: 20

// 两个常量引用同一个闭包实例
print(incrementByTen()) // 输出: 30</code></pre>
        </div>

        <svg class="diagram" width="100%" height="200" viewBox="0 0 800 200">
            <rect x="120" y="40" width="200" height="60" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="220" y="75" text-anchor="middle" font-size="16">incrementByTen</text>
            
            <rect x="480" y="40" width="200" height="60" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="580" y="75" text-anchor="middle" font-size="16">anotherIncrementByTen</text>
            
            <rect x="300" y="120" width="200" height="60" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="400" y="155" text-anchor="middle" font-size="16">闭包实例</text>
            
            <line x1="220" y1="100" x2="350" y2="120" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
            <line x1="580" y1="100" x2="450" y2="120" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
        </svg>
    </section>

    <section id="escaping-closures">
        <h2>逃逸闭包</h2>
        <p>当闭包作为参数传递给函数，但在函数返回后才被调用，我们称该闭包从函数中"逃逸"。使用@escaping标记这种闭包。</p>

        <svg class="diagram" width="100%" height="300" viewBox="0 0 800 300">
            <rect x="100" y="30" width="600" height="250" rx="15" fill="none" stroke="#333" stroke-width="2" />
            <rect x="150" y="60" width="500" height="80" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="90" text-anchor="middle" font-size="16">函数作用域</text>
            <text x="400" y="120" text-anchor="middle" font-size="14">func example(closure: @escaping () -> Void) { ... }</text>
            
            <rect x="200" y="180" width="180" height="70" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="290" y="215" text-anchor="middle" font-size="14">存储闭包</text>
            
            <rect x="420" y="180" width="180" height="70" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="510" y="215" text-anchor="middle" font-size="14">异步执行闭包</text>
            
            <path d="M400,140 L290,180" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
            <path d="M400,140 L510,180" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
            <text x="400" y="170" text-anchor="middle" font-size="14">闭包逃逸</text>
        </svg>

        <div class="example">
            <p>逃逸闭包示例：</p>
            <pre><code>// 存储闭包的数组
var completionHandlers: [() -> Void] = []

// 接受逃逸闭包的函数
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    // 闭包被添加到函数外部定义的数组中
    completionHandlers.append(completionHandler)
}

// 调用函数并传入闭包
someFunctionWithEscapingClosure {
    print("这是一个逃逸闭包，它将在函数返回后执行")
}

// 稍后执行存储的闭包
completionHandlers.first?() // 输出: 这是一个逃逸闭包，它将在函数返回后执行</code></pre>
        </div>

        <div class="note">
            <p>逃逸闭包中引用self需要特别注意：</p>
            <ul>
                <li>在类的方法中，逃逸闭包需要显式使用self</li>
                <li>需要考虑内存管理和循环引用问题</li>
            </ul>
        </div>

        <div class="example">
            <p>在类中使用逃逸闭包：</p>
            <pre><code>class SomeClass {
    var x = 10
    
    func doSomething() {
        someFunctionWithEscapingClosure { [weak self] in
            // 使用weak self避免循环引用
            guard let self = self else { return }
            print(self.x)
        }
    }
}</code></pre>
        </div>
    </section>

    <section id="autoclosures">
        <h2>自动闭包</h2>
        <p>自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，被调用时会返回被包装在其中的表达式的值。</p>

        <div class="example">
            <p>自动闭包示例：</p>
            <pre><code>// 不使用自动闭包的函数
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

// 调用时需要显式创建闭包
serve(customer: { "Alex" })

// 使用自动闭包的函数
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

// 调用时可以直接传入字符串表达式，Swift会自动将其包装为闭包
serve(customer: "Alex") // 输出: Now serving Alex!</code></pre>
        </div>

        <div class="note">
            <p>自动闭包可以延迟求值，表达式不会立即评估，而是在闭包被调用时才会计算。</p>
        </div>

        <div class="example">
            <p>延迟求值示例：</p>
            <pre><code>var customersInLine = ["Alex", "Brook", "Chris", "Dave"]
print(customersInLine.count) // 输出: 4

// 创建一个自动闭包
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count) // 输出: 4，数组尚未改变

// 调用闭包
print("Now serving \(customerProvider())!") // 输出: Now serving Alex!
print(customersInLine.count) // 输出: 3，现在数组已经改变</code></pre>
        </div>
    </section>
    
    <section id="memory-management">
        <h2>闭包与内存管理</h2>
        <p>闭包可能导致强引用循环，尤其是当类实例的属性存储了闭包，而该闭包又捕获了这个实例。</p>

        <svg class="diagram" width="100%" height="250" viewBox="0 0 800 250">
            <rect x="200" y="50" width="150" height="80" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="275" y="90" text-anchor="middle" font-size="16">类实例</text>
            
            <rect x="450" y="50" width="150" height="80" rx="10" fill="none" stroke="#E01F26" stroke-width="2" />
            <text x="525" y="90" text-anchor="middle" font-size="16">闭包</text>
            
            <path d="M350,70 L450,70" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
            <text x="400" y="60" text-anchor="middle" font-size="12">持有</text>
            
            <path d="M450,110 L350,110" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)" />
            <text x="400" y="130" text-anchor="middle" font-size="12">捕获</text>
            
            <rect x="150" y="170" width="500" height="60" rx="10" fill="none" stroke="#333" stroke-width="2" />
            <text x="400" y="200" text-anchor="middle" font-size="16">解决方案：弱引用 [weak self] 或无主引用 [unowned self]</text>
        </svg>

        <div class="example">
            <p>解决循环引用的示例：</p>
            <pre><code>class HTMLElement {
    let name: String
    let text: String?
    
    // 这个闭包引用了self，可能导致循环引用
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "&lt;\(self.name)&gt;\(text)&lt;/\(self.name)&gt;"
        } else {
            return "&lt;\(self.name) /&gt;"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

// 解决方案：使用捕获列表
class HTMLElement {
    let name: String
    let text: String?
    
    // 使用捕获列表避免循环引用
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "&lt;\(self.name)&gt;\(text)&lt;/\(self.name)&gt;"
        } else {
            return "&lt;\(self.name) /&gt;"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}</code></pre>
        </div>

        <div class="note">
            <p><strong>[weak self]</strong> vs <strong>[unowned self]</strong>：</p>
            <ul>
                <li><strong>weak</strong>：当引用可能为nil时使用。self变为可选型</li>
                <li><strong>unowned</strong>：当确定引用一定存在时使用。访问已释放的实例会导致运行时错误</li>
            </ul>
        </div>
    </section>

    <section id="practical-examples">
        <h2>实际应用示例</h2>
        
        <h3>1. 数组操作</h3>
        <div class="example">
            <pre><code>// 使用filter、map和reduce
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 筛选偶数
let evenNumbers = numbers.filter { $0 % 2 == 0 }
// 输出: [2, 4, 6, 8, 10]

// 将每个数字平方
let squaredNumbers = numbers.map { $0 * $0 }
// 输出: [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

// 计算所有数字的和
let sum = numbers.reduce(0) { $0 + $1 }
// 输出: 55

// 链式调用：筛选偶数，然后平方，最后求和
let sumOfSquaredEvens = numbers.filter { $0 % 2 == 0 }
                                .map { $0 * $0 }
                                .reduce(0) { $0 + $1 }
// 输出: 220</code></pre>
        </div>
        
        <h3>2. 异步编程</h3>
        <div class="example">
            <pre><code>// 使用闭包进行网络请求
func fetchData(completion: @escaping (Data?, Error?) -> Void) {
    let url = URL(string: "https://api.example.com/data")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        completion(data, error)
    }
    task.resume()
}

// 调用
fetchData { (data, error) in
    if let error = error {
        print("Error: \(error.localizedDescription)")
        return
    }
    
    if let data = data {
        // 处理数据
        print("Received \(data.count) bytes")
    }
}</code></pre>
        </div>
        
        <h3>3. 自定义排序</h3>
        <div class="example">
            <pre><code>// 对结构体进行自定义排序
struct Person {
    let name: String
    let age: Int
}

let people = [
    Person(name: "Alice", age: 25),
    Person(name: "Bob", age: 20),
    Person(name: "Charlie", age: 30)
]

// 按年龄排序
let sortedByAge = people.sorted { $0.age < $1.age }

// 按名字排序
let sortedByName = people.sorted { $0.name < $1.name }</code></pre>
        </div>
        
        <h3>4. 延迟执行</h3>
        <div class="example">
            <pre><code>// DispatchQueue延迟执行
DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    print("2秒后执行的代码")
}</code></pre>
        </div>
    </section>

    <section id="performance-optimization">
        <h2>闭包性能优化</h2>
        
        <div class="note">
            <h3>性能优化要点：</h3>
            <ol>
                <li>避免在闭包中捕获大对象或不必要的引用</li>
                <li>使用值捕获而非引用捕获（当适用时）</li>
                <li>注意内存泄漏和循环引用</li>
                <li>复杂闭包考虑使用内联函数代替</li>
            </ol>
        </div>
        
        <div class="example">
            <p>捕获列表性能优化：</p>
            <pre><code>class DataProcessor {
    var largeData: [Int] = Array(1...10000)
    
    func process(completion: @escaping () -> Void) {
        // 不好的做法 - 捕获整个self
        DispatchQueue.global().async {
            _ = self.largeData.map { $0 * 2 }
            completion()
        }
        
        // 好的做法 - 只捕获需要的属性
        let data = largeData
        DispatchQueue.global().async {
            _ = data.map { $0 * 2 }
            completion()
        }
    }
}</code></pre>
        </div>
    </section>

    <section id="resources" class="resources">
        <h2>参考资源</h2>
        
        <h3>官方文档</h3>
        <ul class="resource-list">
            <li><a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/" target="_blank">Swift 官方文档 - 闭包</a></li>
            <li><a href="https://developer.apple.com/documentation/swift/array/3017522-filter" target="_blank">Apple Developer - 高阶函数文档</a></li>
        </ul>
        
        <h3>相关书籍</h3>
        <ul class="resource-list">
            <li>《Swift 进阶》- 王巍(onevcat)</li>
            <li>《函数式Swift》- Chris Eidhof, Florian Kugler, 王巍</li>
            <li>《Swift Programming: The Big Nerd Ranch Guide》- Matthew Mathias, John Gallagher</li>
        </ul>
        
        <h3>优秀博客文章</h3>
        <ul class="resource-list">
            <li><a href="https://www.swiftbysundell.com/articles/swifts-closure-capturing-mechanics/" target="_blank">Swift by Sundell - Swift's closure capturing mechanics</a></li>
            <li><a href="https://www.objc.io/issues/16-swift/swift-functions/" target="_blank">objc.io - Swift函数式编程</a></li>
            <li><a href="https://www.hackingwithswift.com/articles/179/capture-lists-in-swift-whats-the-difference-between-weak-strong-and-unowned-references" target="_blank">Hacking with Swift - Capture lists: What's the difference between weak, strong, and unowned references?</a></li>
        </ul>
        
        <h3>相关开源项目</h3>
        <ul class="resource-list">
            <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift - 响应式编程框架</a></li>
            <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Swift Composable Architecture - 函数式架构</a></li>
            <li><a href="https://github.com/mxcl/PromiseKit" target="_blank">PromiseKit - Promise实现库</a></li>
        </ul>
        
        <h3>相关视频</h3>
        <ul class="resource-list">
            <li><a href="https://developer.apple.com/videos/play/wwdc2019/415/" target="_blank">WWDC 2019 - Modern Swift API Design</a></li>
            <li><a href="https://www.youtube.com/watch?v=PNSdU_EbUhA" target="_blank">Swift中的函数式编程 - Sean Allen</a></li>
        </ul>
    </section>
</body>
</html>
