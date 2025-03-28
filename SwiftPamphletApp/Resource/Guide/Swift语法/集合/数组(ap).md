<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift数组详解 - Apple开发技术手册</title>
    <style>
        :root {
            --background-color: #f5f5f5;
            --text-color: #333;
            --code-background: #f0f0f0;
            --header-background: linear-gradient(to bottom, #444, #222);
            --card-background: #fff;
            --border-color: #ddd;
            --accent-color: #0070c9;
            --secondary-color: #ff9500;
            --shadow-color: rgba(0, 0, 0, 0.1);
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #222;
                --text-color: #eee;
                --code-background: #333;
                --header-background: linear-gradient(to bottom, #000, #222);
                --card-background: #333;
                --border-color: #444;
                --accent-color: #0a84ff;
                --secondary-color: #ff9f0a;
                --shadow-color: rgba(0, 0, 0, 0.3);
            }
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background: var(--background-color) url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" opacity="0.05"><rect width="100" height="100" fill="none" stroke="currentColor" stroke-width="0.5"/></svg>');
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        header {
            background: var(--header-background);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            box-shadow: 0 3px 10px var(--shadow-color);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        header .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        h1, h2, h3, h4 {
            margin-top: 1.5em;
            margin-bottom: 0.5em;
            font-weight: 600;
        }
        
        h1 {
            font-size: 2.5em;
            text-align: center;
        }
        
        h2 {
            font-size: 2em;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 10px;
            color: var(--accent-color);
        }
        
        h3 {
            font-size: 1.5em;
            color: var(--secondary-color);
        }
        
        .card {
            background: var(--card-background);
            border-radius: 10px;
            box-shadow: 0 4px 6px var(--shadow-color), 0 0 0 1px var(--border-color);
            padding: 25px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }
        
        .card::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-color), var(--secondary-color));
        }
        
        pre {
            background: var(--code-background);
            border-radius: 5px;
            padding: 15px;
            overflow-x: auto;
            border: 1px solid var(--border-color);
            margin: 20px 0;
        }
        
        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9em;
        }
        
        p code {
            background: var(--code-background);
            padding: 2px 5px;
            border-radius: 3px;
            border: 1px solid var(--border-color);
        }
        
        .note {
            background-color: rgba(var(--accent-color-rgb), 0.1);
            border-left: 4px solid var(--accent-color);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }
        
        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .resource-card {
            background: var(--card-background);
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 4px var(--shadow-color), 0 0 0 1px var(--border-color);
        }
        
        .resource-card h4 {
            margin-top: 0;
            color: var(--accent-color);
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 8px;
        }
        
        a {
            color: var(--accent-color);
            text-decoration: none;
        }
        
        a:hover {
            text-decoration: underline;
        }
        
        .figure {
            margin: 30px 0;
            text-align: center;
        }
        
        .figure figcaption {
            margin-top: 10px;
            font-style: italic;
            color: var(--text-color);
            opacity: 0.8;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .resources {
                grid-template-columns: 1fr;
            }
            
            h1 {
                font-size: 2em;
            }
            
            h2 {
                font-size: 1.7em;
            }
            
            .card {
                padding: 15px;
            }
        }
        
        footer {
            background: var(--header-background);
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>Swift数组详解</h1>
            <p>Apple开发技术手册</p>
        </div>
    </header>
    
    <div class="container">
        <div class="card">
            <h2>Swift数组概述</h2>
            <p>数组（Array）是Swift中最基础也是最常用的集合类型之一，它按照有序的方式存储相同类型的元素。Swift数组具有类型安全性，这意味着Swift数组只能存储一种明确的数据类型。</p>
            
            <div class="figure">
                <svg width="600" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .box { fill: var(--card-background); stroke: var(--accent-color); stroke-width: 2; }
                        .index { font-size: 12px; fill: var(--text-color); }
                        .value { font-size: 14px; fill: var(--text-color); font-weight: bold; }
                        .arrow { fill: none; stroke: var(--secondary-color); stroke-width: 2; }
                        .label { font-size: 14px; fill: var(--text-color); }
                    </style>
                    <rect x="50" y="80" width="500" height="60" rx="5" class="box" />
                    
                    <!-- 数组元素 -->
                    <rect x="50" y="80" width="100" height="60" rx="0" class="box" />
                    <text x="100" y="70" text-anchor="middle" class="index">index 0</text>
                    <text x="100" y="120" text-anchor="middle" class="value">"Apple"</text>
                    
                    <rect x="150" y="80" width="100" height="60" rx="0" class="box" />
                    <text x="200" y="70" text-anchor="middle" class="index">index 1</text>
                    <text x="200" y="120" text-anchor="middle" class="value">"Orange"</text>
                    
                    <rect x="250" y="80" width="100" height="60" rx="0" class="box" />
                    <text x="300" y="70" text-anchor="middle" class="index">index 2</text>
                    <text x="300" y="120" text-anchor="middle" class="value">"Banana"</text>
                    
                    <rect x="350" y="80" width="100" height="60" rx="0" class="box" />
                    <text x="400" y="70" text-anchor="middle" class="index">index 3</text>
                    <text x="400" y="120" text-anchor="middle" class="value">"Grape"</text>
                    
                    <rect x="450" y="80" width="100" height="60" rx="0" class="box" />
                    <text x="500" y="70" text-anchor="middle" class="index">index 4</text>
                    <text x="500" y="120" text-anchor="middle" class="value">"Kiwi"</text>
                    
                    <!-- 数组标签 -->
                    <text x="300" y="180" text-anchor="middle" class="label">let fruits: [String] = ["Apple", "Orange", "Banana", "Grape", "Kiwi"]</text>
                </svg>
                <figcaption>图1: Swift数组的基本结构</figcaption>
            </div>
        </div>
        
        <div class="card">
            <h2>数组的声明与初始化</h2>
            <p>Swift提供了多种方式来声明和初始化数组：</p>
            
            <h3>1. 使用数组字面量</h3>
            <pre><code>// 使用数组字面量创建数组
let fruits = ["Apple", "Orange", "Banana"] // 类型推断为 [String]

// 显式声明类型
let numbers: [Int] = [1, 2, 3, 4, 5]</code></pre>
            
            <h3>2. 使用Array构造器</h3>
            <pre><code>// 创建空数组
var emptyArray = [String]()
var anotherEmptyArray: [Int] = []

// 创建带有默认值的数组
var fiveZeros = Array(repeating: 0, count: 5) // [0, 0, 0, 0, 0]

// 使用范围创建数组
let oneToFive = Array(1...5) // [1, 2, 3, 4, 5]</code></pre>
            
            <h3>3. 类型注解和类型推断</h3>
            <pre><code>// 类型注解
let intArray: Array&lt;Int> = [1, 2, 3]
let stringArray: [String] = ["a", "b", "c"]

// 类型推断
let inferredArray = [1, 2, 3] // 推断为 [Int]</code></pre>
            
            <div class="figure">
                <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .box { fill: var(--card-background); stroke: var(--accent-color); stroke-width: 2; }
                        .arrow { fill: none; stroke: var(--secondary-color); stroke-width: 2; marker-end: url(#arrowhead); }
                        .label { font-size: 14px; fill: var(--text-color); }
                        .code { font-family: monospace; font-size: 13px; fill: var(--text-color); }
                    </style>
                    
                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="var(--secondary-color)" />
                        </marker>
                    </defs>
                    
                    <rect x="100" y="40" width="400" height="60" rx="5" class="box" />
                    <text x="300" y="30" text-anchor="middle" class="label">数组字面量初始化</text>
                    <text x="300" y="75" text-anchor="middle" class="code">let fruits = ["Apple", "Orange", "Banana"]</text>
                    
                    <rect x="100" y="130" width="400" height="60" rx="5" class="box" />
                    <text x="300" y="120" text-anchor="middle" class="label">空数组初始化</text>
                    <text x="300" y="165" text-anchor="middle" class="code">var emptyArray = [String]()</text>
                    
                    <rect x="100" y="220" width="400" height="60" rx="5" class="box" />
                    <text x="300" y="210" text-anchor="middle" class="label">重复值初始化</text>
                    <text x="300" y="255" text-anchor="middle" class="code">var fiveZeros = Array(repeating: 0, count: 5)</text>
                </svg>
                <figcaption>图2: Swift数组的不同初始化方式</figcaption>
            </div>
        </div>
        
        <div class="card">
            <h2>数组的基本操作</h2>
            
            <h3>1. 访问和修改数组</h3>
            <pre><code>var fruits = ["Apple", "Orange", "Banana", "Grape"]

// 使用下标访问元素
let firstFruit = fruits[0] // "Apple"

// 修改元素
fruits[1] = "Pineapple" // 数组变为 ["Apple", "Pineapple", "Banana", "Grape"]

// 获取数组长度
let count = fruits.count // 4

// 检查数组是否为空
let isEmpty = fruits.isEmpty // false

// 获取第一个和最后一个元素
let first = fruits.first // Optional("Apple")
let last = fruits.last   // Optional("Grape")</code></pre>
            
            <h3>2. 添加元素</h3>
            <pre><code>var fruits = ["Apple", "Orange"]

// 在数组末尾添加元素
fruits.append("Banana") // ["Apple", "Orange", "Banana"]

// 在指定位置插入元素
fruits.insert("Kiwi", at: 1) // ["Apple", "Kiwi", "Orange", "Banana"]

// 添加另一个数组的内容
fruits += ["Grape", "Mango"] // ["Apple", "Kiwi", "Orange", "Banana", "Grape", "Mango"]</code></pre>
            
            <h3>3. 删除元素</h3>
            <pre><code>var fruits = ["Apple", "Orange", "Banana", "Grape", "Kiwi"]

// 移除指定位置的元素
let orange = fruits.remove(at: 1) // 返回 "Orange"，数组变为 ["Apple", "Banana", "Grape", "Kiwi"]

// 移除第一个元素
let firstFruit = fruits.removeFirst() // 返回 "Apple"，数组变为 ["Banana", "Grape", "Kiwi"]

// 移除最后一个元素
let lastFruit = fruits.removeLast() // 返回 "Kiwi"，数组变为 ["Banana", "Grape"]

// 移除所有元素
fruits.removeAll() // 数组变为 []</code></pre>
            
            <h3>4. 查找元素</h3>
            <pre><code>let fruits = ["Apple", "Orange", "Banana", "Grape", "Orange"]

// 检查数组是否包含某个元素
let hasOrange = fruits.contains("Orange") // true

// 查找元素的索引
if let index = fruits.firstIndex(of: "Banana") {
    print("Banana位于索引 \(index)") // 输出: Banana位于索引 2
}

// 查找满足条件的元素索引
if let index = fruits.firstIndex(where: { $0.count > 5 }) {
    print("第一个长度大于5的水果是 \(fruits[index])") // 输出: 第一个长度大于5的水果是 Orange
}</code></pre>
            
            <div class="figure">
                <svg width="600" height="350" viewBox="0 0 600 350" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .box { fill: var(--card-background); stroke: var(--accent-color); stroke-width: 2; }
                        .box-highlight { fill: rgba(255, 149, 0, 0.2); stroke: var(--secondary-color); stroke-width: 2; }
                        .arrow { fill: none; stroke: var(--secondary-color); stroke-width: 2; marker-end: url(#arrowhead); }
                        .label { font-size: 14px; fill: var(--text-color); }
                        .code { font-family: monospace; font-size: 13px; fill: var(--text-color); }
                        .method { font-weight: bold; font-size: 16px; fill: var(--text-color); }
                    </style>
                    
                    <!-- 原始数组 -->
                    <text x="300" y="30" text-anchor="middle" class="label">原始数组: var fruits = ["Apple", "Orange", "Banana", "Grape"]</text>
                    <rect x="50" y="50" width="500" height="50" rx="5" class="box" />
                    <line x1="175" y1="50" x2="175" y2="100" stroke="var(--text-color)" stroke-width="1" />
                    <line x1="300" y1="50" x2="300" y2="100" stroke="var(--text-color)" stroke-width="1" />
                    <line x1="425" y1="50" x2="425" y2="100" stroke="var(--text-color)" stroke-width="1" />
                    <text x="112.5" y="80" text-anchor="middle" class="code">"Apple"</text>
                    <text x="237.5" y="80" text-anchor="middle" class="code">"Orange"</text>
                    <text x="362.5" y="80" text-anchor="middle" class="code">"Banana"</text>
                    <text x="487.5" y="80" text-anchor="middle" class="code">"Grape"</text>
                    <text x="50" y="115" text-anchor="start" class="code">Index: 0</text>
                    <text x="175" y="115" text-anchor="start" class="code">Index: 1</text>
                    <text x="300" y="115" text-anchor="start" class="code">Index: 2</text>
                    <text x="425" y="115" text-anchor="start" class="code">Index: 3</text>
                    
                    <!-- 添加元素 -->
                    <text x="150" y="165" text-anchor="middle" class="method">append()</text>
                    <rect x="50" y="180" width="500" height="50" rx="5" class="box" />
                    <rect x="550" y="180" width="0" height="50" rx="5" class="box-highlight" />
                    <line x1="175" y1="180" x2="175" y2="230" stroke="var(--text-color)" stroke-width="1" />
                    <line x1="300" y1="180" x2="300" y2="230" stroke="var(--text-color)" stroke-width="1" />
                    <line x1="425" y1="180" x2="425" y2="230" stroke="var(--text-color)" stroke-width="1" />
                    <text x="112.5" y="210" text-anchor="middle" class="code">"Apple"</text>
                    <text x="237.5" y="210" text-anchor="middle" class="code">"Orange"</text>
                    <text x="362.5" y="210" text-anchor="middle" class="code">"Banana"</text>
                    <text x="487.5" y="210" text-anchor="middle" class="code">"Grape"</text>
                    <text x="575" y="210" text-anchor="middle" class="code">"Kiwi"</text>
                    <path d="M550,205 C565,205 565,205 575,205" class="arrow" />
                    
                    <!-- 删除元素 -->
                    <text x="150" y="265" text-anchor="middle" class="method">remove(at: 1)</text>
                    <rect x="50" y="280" width="500" height="50" rx="5" class="box" />
                    <rect x="175" y="280" width="125" height="50" rx="0" class="box-highlight" />
                    <line x1="175" y1="280" x2="175" y2="330" stroke="var(--text-color)" stroke-width="1" />
                    <line x1="300" y1="280" x2="300" y2="330" stroke="var(--text-color)" stroke-width="1" />
                    <line x1="425" y1="280" x2="425" y2="330" stroke="var(--text-color)" stroke-width="1" />
                    <text x="112.5" y="310" text-anchor="middle" class="code">"Apple"</text>
                    <text x="237.5" y="310" text-anchor="middle" class="code">"Banana"</text>
                    <text x="362.5" y="310" text-anchor="middle" class="code">"Grape"</text>
                    <text x="487.5" y="310" text-anchor="middle" class="code">""</text>
                </svg>
                <figcaption>图3: 数组的基本操作示意图</figcaption>
            </div>
        </div>
        
        <div class="card">
            <h2>数组的高级操作</h2>
            
            <h3>1. 数组遍历</h3>
            <pre><code>let fruits = ["Apple", "Orange", "Banana", "Grape"]

// for-in 循环遍历
for fruit in fruits {
    print(fruit)
}

// 带索引的遍历
for (index, fruit) in fruits.enumerated() {
    print("\(index): \(fruit)")
}

// forEach方法
fruits.forEach { fruit in
    print(fruit)
}</code></pre>
            
            <h3>2. 数组转换</h3>
            <pre><code>let numbers = [1, 2, 3, 4, 5]

// 使用map转换数组元素
let squares = numbers.map { $0 * $0 } // [1, 4, 9, 16, 25]

// 使用filter过滤元素
let evenNumbers = numbers.filter { $0 % 2 == 0 } // [2, 4]

// 使用reduce合并元素
let sum = numbers.reduce(0, +) // 15 (0 + 1 + 2 + 3 + 4 + 5)
let product = numbers.reduce(1, *) // 120 (1 * 1 * 2 * 3 * 4 * 5)

// 链式操作
let sumOfSquaresOfEvenNumbers = numbers
    .filter { $0 % 2 == 0 }     // [2, 4]
    .map { $0 * $0 }            // [4, 16]
    .reduce(0, +)               // 20</code></pre>
            
            <h3>3. 数组排序</h3>
            <pre><code>var fruits = ["Orange", "Apple", "Banana", "Grape"]

// 使用sort()对数组进行排序（修改原数组）
fruits.sort() // ["Apple", "Banana", "Grape", "Orange"]

// 使用sorted()获得排序后的新数组（不修改原数组）
let sortedFruits = fruits.sorted() // 返回排序后的新数组

// 自定义排序规则
fruits.sort { $0.count > $1.count } // 按字符串长度降序排列

// 使用sorted(by:)自定义排序
let sortedByLength = fruits.sorted { $0.count < $1.count } // 按字符串长度升序排列</code></pre>
            
            <h3>4. 数组切片</h3>
            <pre><code>let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 获取数组切片
let firstThree = numbers[0..<3] // [1, 2, 3]
let lastThree = numbers[(numbers.count - 3)...] // [8, 9, 10]

// 注意：切片是数组的视图，不是新数组
// 如果需要创建新数组，可以使用Array初始化器
let newArray = Array(firstThree) // [1, 2, 3]</code></pre>
            
            <div class="figure">
                <svg width="600" height="350" viewBox="0 0 600 350" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .box { fill: var(--card-background); stroke: var(--accent-color); stroke-width: 2; }
                        .result { fill: rgba(10, 132, 255, 0.2); stroke: var(--accent-color); stroke-width: 2; }
                        .arrow { fill: none; stroke: var(--secondary-color); stroke-width: 2; marker-end: url(#arrowhead); }
                        .operation { font-weight: bold; font-size: 16px; fill: var(--accent-color); }
                        .code { font-family: monospace; font-size: 13px; fill: var(--text-color); }
                    </style>
                    
                    <!-- 源数组 -->
                    <text x="300" y="30" text-anchor="middle" class="code">let numbers = [1, 2, 3, 4, 5]</text>
                    <rect x="100" y="50" width="400" height="40" rx="5" class="box" />
                    <text x="140" y="75" text-anchor="middle" class="code">1</text>
                    <text x="220" y="75" text-anchor="middle" class="code">2</text>
                    <text x="300" y="75" text-anchor="middle" class="code">3</text>
                    <text x="380" y="75" text-anchor="middle" class="code">4</text>
                    <text x="460" y="75" text-anchor="middle" class="code">5</text>
                    
                    <!-- Map操作 -->
                    <text x="50" y="120" text-anchor="start" class="operation">map { $0 * $0 }</text>
                    <path d="M300,90 L300,130" class="arrow" />
                    <rect x="100" y="140" width="400" height="40" rx="5" class="result" />
                    <text x="140" y="165" text-anchor="middle" class="code">1</text>
                    <text x="220" y="165" text-anchor="middle" class="code">4</text>
                    <text x="300" y="165" text-anchor="middle" class="code">9</text>
                    <text x="380" y="165" text-anchor="middle" class="code">16</text>
                    <text x="460" y="165" text-anchor="middle" class="code">25</text>
                    
                    <!-- Filter操作 -->
                    <text x="50" y="210" text-anchor="start" class="operation">filter { $0 % 2 == 0 }</text>
                    <path d="M300,90 L300,220" class="arrow" />
                    <rect x="180" y="230" width="240" height="40" rx="5" class="result" />
                    <text x="220" y="255" text-anchor="middle" class="code">2</text>
                    <text x="380" y="255" text-anchor="middle" class="code">4</text>
                    
                    <!-- Reduce操作 -->
                    <text x="50" y="300" text-anchor="start" class="operation">reduce(0, +)</text>
                    <path d="M300,90 L300,310" class="arrow" />
                    <rect x="275" y="320" width="50" height="40" rx="5" class="result" />
                    <text x="300" y="345" text-anchor="middle" class="code">15</text>
                </svg>
                <figcaption>图4: 数组的高级操作示意图</figcaption>
            </div>
        </div>
        
        <div class="card">
            <h2>数组性能考虑</h2>
            <p>在使用Swift数组时，需要了解一些性能方面的注意事项：</p>
            
            <h3>1. 数组内存分配</h3>
            <p>Swift数组在内存中是连续存储的，当数组需要增长但没有足够空间时，会触发重新分配，这可能导致性能开销。</p>
            <pre><code>// 如果知道需要的容量，可以预先分配
var numbers = [Int]()
numbers.reserveCapacity(1000) // 预先分配1000个元素的空间</code></pre>
            
            <h3>2. 值类型与写时复制</h3>
            <p>Swift数组是值类型，采用了写时复制（Copy-on-Write）机制，在实际需要修改时才会进行复制，这有助于提高性能。</p>
            <pre><code>var array1 = [1, 2, 3]
var array2 = array1 // 此时没有进行复制，array1和array2共享存储

// 只有当其中一个数组被修改时，才会复制底层存储
array2.append(4) // 此时会复制底层存储</code></pre>
            
            <h3>3. 大O表示法中的数组操作复杂度</h3>
            <pre><code>// O(1) - 常数时间操作
let firstElement = array[0] // 通过索引访问
let count = array.count   // 获取长度
array.append(10)          // 在末尾添加元素（均摊复杂度）

// O(n) - 线性时间操作
array.insert(5, at: 0)    // 在开头插入元素
array.remove(at: 0)       // 删除元素
array.contains(10)        // 查找元素</code></pre>
            
            <div class="figure">
                <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .chart { fill: none; stroke: var(--accent-color); stroke-width: 2; }
                        .chart-bg { fill: var(--card-background); stroke: var(--border-color); stroke-width: 1; }
                        .line1 { fill: none; stroke: var(--accent-color); stroke-width: 2; }
                        .line2 { fill: none; stroke: var(--secondary-color); stroke-width: 2; }
                        .axis { stroke: var(--text-color); stroke-width: 1; }
                        .label { font-size: 12px; fill: var(--text-color); }
                        .title { font-size: 14px; font-weight: bold; fill: var(--text-color); }
                    </style>
                    
                    <!-- 背景和坐标轴 -->
                    <rect x="50" y="50" width="500" height="200" class="chart-bg" />
                    <line x1="50" y1="250" x2="550" y2="250" class="axis" />
                    <line x1="50" y1="50" x2="50" y2="250" class="axis" />
                    
                    <!-- 坐标轴标签 -->
                    <text x="300" y="280" text-anchor="middle" class="title">数组大小 (n)</text>
                    <text x="20" y="150" text-anchor="middle" transform="rotate(-90, 20, 150)" class="title">操作时间</text>
                    
                    <!-- 常数时间操作 O(1) -->
                    <path d="M50,250 L550,250" class="line1" />
                    <text x="570" y="250" class="label">O(1)</text>
                    
                    <!-- 线性时间操作 O(n) -->
                    <path d="M50,250 L550,50" class="line2" />
                    <text x="570" y="50" class="label">O(n)</text>
                    
                    <!-- 图例 -->
                    <text x="300" y="30" text-anchor="middle" class="title">数组操作复杂度</text>
                    <line x1="100" y1="300" x2="130" y2="300" class="line1" />
                    <text x="135" y="304" class="label">常数时间操作 (访问、添加末尾)</text>
                    <line x1="350" y1="300" x2="380" y2="300" class="line2" />
                    <text x="385" y="304" class="label">线性时间操作 (插入、删除、搜索)</text>
                </svg>
                <figcaption>图5: 数组操作的时间复杂度</figcaption>
            </div>
        </div>
        
        <div class="card">
            <h2>实际应用示例</h2>
            <p>下面是一些Swift数组在实际开发中的常见应用场景：</p>
            
            <h3>1. 待办事项管理</h3>
            <pre><code>struct Task {
    let id: UUID
    var title: String
    var isCompleted: Bool
}

class TodoListManager {
    private var tasks: [Task] = []
    
    func addTask(title: String) {
        let task = Task(id: UUID(), title: title, isCompleted: false)
        tasks.append(task)
    }
    
    func completeTask(at index: Int) {
        guard index < tasks.count else { return }
        var task = tasks[index]
        task.isCompleted = true
        tasks[index] = task
    }
    
    func removeTask(at index: Int) {
        guard index < tasks.count else { return }
        tasks.remove(at: index)
    }
    
    func getAllTasks() -> [Task] {
        return tasks
    }
    
    func getCompletedTasks() -> [Task] {
        return tasks.filter { $0.isCompleted }
    }
    
    func getPendingTasks() -> [Task] {
        return tasks.filter { !$0.isCompleted }
    }
}

// 使用示例
let todoManager = TodoListManager()
todoManager.addTask(title: "完成Swift学习")
todoManager.addTask(title: "编写应用程序")
todoManager.completeTask(at: 0)
let completed = todoManager.getCompletedTasks() // 包含"完成Swift学习"
let pending = todoManager.getPendingTasks() // 包含"编写应用程序"</code></pre>
            
            <h3>2. 图片轮播器</h3>
            <pre><code>import UIKit

class ImageCarouselView: UIView {
    private var images: [UIImage] = []
    private var currentIndex = 0
    private let imageView = UIImageView()
    
    init(frame: CGRect, images: [UIImage]) {
        self.images = images
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        if !images.isEmpty {
            imageView.image = images[currentIndex]
        }
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        showNextImage()
    }
    
    func showNextImage() {
        guard !images.isEmpty else { return }
        
        currentIndex = (currentIndex + 1) % images.count
        
        UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.imageView.image = self.images[self.currentIndex]
        }, completion: nil)
    }
    
    func showPreviousImage() {
        guard !images.isEmpty else { return }
        
        currentIndex = (currentIndex - 1 + images.count) % images.count
        
        UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.imageView.image = self.images[self.currentIndex]
        }, completion: nil)
    }
    
    func addImage(_ image: UIImage) {
        images.append(image)
        if images.count == 1 {
            imageView.image = image
        }
    }
    
    func removeImage(at index: Int) {
        guard index >= 0, index < images.count else { return }
        
        images.remove(at: index)
        
        if images.isEmpty {
            imageView.image = nil
            currentIndex = 0
        } else {
            currentIndex = min(currentIndex, images.count - 1)
            imageView.image = images[currentIndex]
        }
    }
}</code></pre>
        </div>
        
        <div class="card">
            <h2>参考资料</h2>
            
            <div class="resources">
                <div class="resource-card">
                    <h4>官方文档</h4>
                    <ul>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html" target="_blank">Swift官方文档 - 集合类型</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/array" target="_blank">Apple开发者文档 - Array</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/sequence" target="_blank">Apple开发者文档 - Sequence</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>优秀博客文章</h4>
                    <ul>
                        <li><a href="https://www.hackingwithswift.com/articles/76/how-to-use-the-array-type-in-swift" target="_blank">Hacking with Swift - 如何在Swift中使用数组</a></li>
                        <li><a href="https://www.swiftbysundell.com/articles/the-power-of-map-filter-and-reduce-in-swift/" target="_blank">Swift by Sundell - Swift中map、filter和reduce的强大功能</a></li>
                        <li><a href="https://www.objc.io/blog/2018/12/18/atomic-variables/" target="_blank">objc.io - Swift中的写时复制</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>推荐书籍</h4>
                    <ul>
                        <li>《Swift编程权威指南》(The Swift Programming Language) - Apple官方Swift编程指南</li>
                        <li>《Swift进阶》(Advanced Swift) - Chris Eidhof, Ole Begemann, and Airspeed Velocity著</li>
                        <li>《Functional Swift》- Chris Eidhof, Florian Kugler, and Wouter Swierstra著</li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>视频教程</h4>
                    <ul>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2018/223/" target="_blank">WWDC18 - Swift中的集合类型</a></li>
                        <li><a href="https://www.raywenderlich.com/3530-collection-types-in-swift" target="_blank">Ray Wenderlich - Swift中的集合类型</a></li>
                        <li><a href="https://www.udemy.com/course/ios-13-app-development-bootcamp/" target="_blank">Udemy - iOS App开发训练营</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>相关开源项目</h4>
                    <ul>
                        <li><a href="https://github.com/airspeedswift/swift-algorithm-club" target="_blank">Swift Algorithm Club</a> - 使用Swift实现的算法和数据结构</li>
                        <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 响应式编程框架，大量使用数组操作</li>
                        <li><a href="https://github.com/danielgindi/Charts" target="_blank">Charts</a> - 一个强大的图表库，展示了数组的高级应用</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
