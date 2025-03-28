<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift函数式编程 - Reduce</title>
    <style>
        :root {
            --background-color: #f3f3f3;
            --text-color: #121212;
            --accent-color-1: #ffcc00;
            --accent-color-2: #ff99cc;
            --code-background: #e0e0e0;
            --card-background: #ffffff;
            --border-color: #333333;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #222222;
                --text-color: #f0f0f0;
                --accent-color-1: #ffdd33;
                --accent-color-2: #ff99cc;
                --code-background: #333333;
                --card-background: #2c2c2c;
                --border-color: #ffffff;
            }
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            padding: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 900;
            transform: rotate(-2deg);
            margin: 20px 0;
            display: inline-block;
            padding: 15px 30px;
            background-color: var(--accent-color-1);
            color: #000;
            border: 3px solid #000;
            box-shadow: 5px 5px 0 #000;
        }

        h2 {
            font-size: 2rem;
            font-weight: 800;
            margin: 30px 0 20px;
            transform: rotate(-1deg);
            border-bottom: 4px solid var(--accent-color-2);
            display: inline-block;
            padding-right: 30px;
        }

        h3 {
            font-size: 1.5rem;
            margin: 25px 0 15px;
            font-weight: 700;
        }

        p {
            margin-bottom: 20px;
            font-size: 1.1rem;
        }

        .card {
            background: var(--card-background);
            border: 2px solid var(--border-color);
            border-radius: 8px;
            padding: 25px;
            margin: 30px 0;
            box-shadow: 5px 5px 0 var(--border-color);
            position: relative;
        }

        .card::before {
            content: "";
            position: absolute;
            top: -10px;
            left: 20px;
            width: 40px;
            height: 40px;
            background: var(--accent-color-1);
            border-radius: 50%;
            z-index: -1;
        }

        pre {
            background: var(--code-background);
            padding: 20px;
            border-radius: 5px;
            overflow-x: auto;
            margin: 20px 0;
            border-left: 5px solid var(--accent-color-1);
            font-size: 0.95rem;
            position: relative;
        }

        code {
            font-family: 'Menlo', monospace;
        }

        .comment {
            color: #708090;
        }

        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .resource-card {
            background: var(--card-background);
            border: 2px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            transition: transform 0.2s;
        }

        .resource-card:hover {
            transform: translateY(-5px);
        }

        a {
            color: var(--accent-color-1);
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px dashed var(--accent-color-1);
            transition: all 0.2s;
        }

        a:hover {
            color: var(--accent-color-2);
            border-bottom-color: var(--accent-color-2);
        }

        .diagram {
            margin: 30px 0;
            text-align: center;
        }

        .example-heading {
            background: var(--accent-color-1);
            color: black;
            display: inline-block;
            padding: 5px 15px;
            transform: rotate(-1deg);
            margin-bottom: 15px;
        }

        .note {
            border-left: 5px solid var(--accent-color-2);
            padding-left: 20px;
            font-style: italic;
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            h1 {
                font-size: 2.5rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            .resources {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift 函数式编程：Reduce</h1>
        <p>化繁为简，从集合到单一值的转换艺术</p>
    </header>

    <div class="card">
        <h2>Reduce 概念介绍</h2>
        <p>在Swift函数式编程中，<code>reduce</code>是一种强大的高阶函数，它将集合中的所有元素合并成单个值。无论是计算总和、拼接字符串，还是构建复杂数据结构，<code>reduce</code>都能以简洁优雅的方式实现。</p>
        
        <div class="diagram">
            <svg width="700" height="220" xmlns="http://www.w3.org/2000/svg">
                <style>
                    @media (prefers-color-scheme: dark) {
                        .box { fill: #2c2c2c; stroke: white; }
                        .text { fill: white; }
                        .arrow { stroke: white; }
                        .result { fill: #2c2c2c; stroke: #ffcc00; }
                        .result-text { fill: #ffcc00; }
                        .initial { fill: #2c2c2c; stroke: #ff99cc; }
                        .initial-text { fill: #ff99cc; }
                    }
                    @media (prefers-color-scheme: light) {
                        .box { fill: white; stroke: black; }
                        .text { fill: black; }
                        .arrow { stroke: black; }
                        .result { fill: white; stroke: #cc7700; }
                        .result-text { fill: #cc7700; }
                        .initial { fill: white; stroke: #cc6699; }
                        .initial-text { fill: #cc6699; }
                    }
                </style>
                
                <!-- 初始值 -->
                <rect x="20" y="90" width="80" height="40" rx="5" class="initial" stroke-width="2"/>
                <text x="60" y="115" text-anchor="middle" class="initial-text">初始值</text>
                
                <!-- 箭头 -->
                <line x1="105" y1="110" x2="140" y2="110" class="arrow" stroke-width="2" stroke-linecap="round"/>
                
                <!-- 数组元素 -->
                <rect x="150" y="40" width="60" height="40" rx="5" class="box" stroke-width="2"/>
                <text x="180" y="65" text-anchor="middle" class="text">元素1</text>
                
                <rect x="150" y="90" width="60" height="40" rx="5" class="box" stroke-width="2"/>
                <text x="180" y="115" text-anchor="middle" class="text">元素2</text>
                
                <rect x="150" y="140" width="60" height="40" rx="5" class="box" stroke-width="2"/>
                <text x="180" y="165" text-anchor="middle" class="text">元素3</text>
                
                <!-- 箭头 -->
                <line x1="215" y1="110" x2="250" y2="110" class="arrow" stroke-width="2" stroke-linecap="round"/>
                
                <!-- Reduce函数 -->
                <rect x="260" y="70" width="160" height="80" rx="10" stroke-width="2" fill="var(--accent-color-1)" stroke="black"/>
                <text x="340" y="115" text-anchor="middle" font-weight="bold" fill="black">Reduce 函数</text>
                
                <!-- 箭头 -->
                <line x1="425" y1="110" x2="470" y2="110" class="arrow" stroke-width="2" stroke-linecap="round"/>
                
                <!-- 结果 -->
                <rect x="480" y="70" width="120" height="80" rx="10" class="result" stroke-width="3"/>
                <text x="540" y="115" text-anchor="middle" class="result-text" font-size="16" font-weight="bold">单一结果</text>
                
                <!-- 说明文字 -->
                <text x="340" y="30" text-anchor="middle" class="text" font-size="14">Reduce流程示意图</text>
                <text x="180" y="200" text-anchor="middle" class="text" font-size="12">[集合元素]</text>
                <text x="340" y="180" text-anchor="middle" class="text" font-size="12">将前一次结果与当前元素结合</text>
            </svg>
        </div>
    </div>

    <div class="card">
        <h2>Reduce 语法基础</h2>
        <p>Swift中的<code>reduce</code>方法有两种形式：</p>
        
        <h3>1. 基础形式</h3>
        <pre><code>func reduce&lt;Result&gt;(_ initialResult: Result, 
              _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result</code></pre>
        
        <h3>2. 链式形式</h3>
        <pre><code>func reduce&lt;Result&gt;(into initialResult: Result, 
              _ updateAccumulatingResult: (inout Result, Element) throws -> Void) rethrows -> Result</code></pre>
        
        <div class="note">
            <p>两种形式的主要区别在于：基础形式在每次迭代中创建新的累加值，而链式形式则通过修改原有累加值（通过<code>inout</code>参数）来构建结果。在处理大型集合或复杂对象时，链式形式通常性能更好。</p>
        </div>
    </div>

    <div class="card">
        <h2>实战示例</h2>
        
        <h3>示例1：计算数组元素总和</h3>
        <div class="example-heading">数值求和</div>
        <pre><code>// 使用基础形式计算总和
let numbers = [1, 2, 3, 4, 5]
let sum = numbers.reduce(0, { partialResult, element in
    return partialResult + element
})
// 或使用更简洁的写法
let sum2 = numbers.reduce(0, +)

print(sum)  // 输出: 15</code></pre>

        <h3>示例2：字符串连接</h3>
        <div class="example-heading">拼接字符串</div>
        <pre><code>// 将字符串数组连接成单个字符串
let words = ["Swift", "is", "powerful"]

// 基础形式
let sentence1 = words.reduce("", { result, word in
    return result.isEmpty ? word : result + " " + word
})

// 链式形式
let sentence2 = words.reduce(into: "", { result, word in
    if result.isEmpty {
        result = word
    } else {
        result += " " + word
    }
})

print(sentence1)  // 输出: "Swift is powerful"</code></pre>

        <h3>示例3：数组分组</h3>
        <div class="example-heading">按条件分组</div>
        <pre><code>// 将数字按奇偶性分组
let mixedNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

// 使用链式reduce创建字典
let grouped = mixedNumbers.reduce(into: [String: [Int]]()) { result, number in
    // 根据奇偶性决定键名
    let key = number % 2 == 0 ? "even" : "odd"
    
    // 向对应组添加数字
    if result[key] != nil {
        result[key]!.append(number)
    } else {
        result[key] = [number]
    }
}

print(grouped)  // 输出: ["odd": [1, 3, 5, 7, 9], "even": [2, 4, 6, 8]]</code></pre>

        <h3>示例4：复杂对象转换</h3>
        <div class="example-heading">对象转换</div>
        <pre><code>// 模拟电商系统中的订单和商品
struct Product {
    let id: String
    let name: String
    let price: Double
}

struct Order {
    let orderNumber: String
    let items: [Product]
    
    // 计算订单总价
    func totalPrice() -> Double {
        return items.reduce(0) { total, product in
            return total + product.price
        }
    }
    
    // 获取所有商品名称
    func allProductNames() -> String {
        return items.reduce("") { names, product in
            if names.isEmpty {
                return product.name
            } else {
                return names + ", " + product.name
            }
        }
    }
}

// 创建示例订单
let products = [
    Product(id: "p1", name: "Swift编程书籍", price: 59.0),
    Product(id: "p2", name: "编程笔记本", price: 29.0),
    Product(id: "p3", name: "定制键盘", price: 199.0)
]

let order = Order(orderNumber: "ORD12345", items: products)

print("订单总价: \(order.totalPrice())")  // 输出: 订单总价: 287.0
print("订购商品: \(order.allProductNames())")  // 输出: 订购商品: Swift编程书籍, 编程笔记本, 定制键盘</code></pre>

        <h3>示例5：性能对比</h3>
        <div class="example-heading">基础形式 vs 链式形式</div>
        <pre><code>import Foundation

// 创建大型测试数组
let largeArray = Array(1...100000)

// 测量基础形式性能
let startTime1 = CFAbsoluteTimeGetCurrent()
let result1 = largeArray.reduce([Int]()) { partialResult, element in
    var newResult = partialResult
    newResult.append(element * 2)
    return newResult
}
let endTime1 = CFAbsoluteTimeGetCurrent()

// 测量链式形式性能
let startTime2 = CFAbsoluteTimeGetCurrent()
let result2 = largeArray.reduce(into: [Int]()) { partialResult, element in
    partialResult.append(element * 2)
}
let endTime2 = CFAbsoluteTimeGetCurrent()

print("基础形式耗时: \(endTime1 - startTime1)秒")
print("链式形式耗时: \(endTime2 - startTime2)秒")
// 链式形式通常会快几倍，因为避免了每次迭代创建新数组的开销</code></pre>
    </div>

    <div class="card">
        <h2>Reduce 应用场景</h2>
        
        <h3>1. 数值计算</h3>
        <ul>
            <li>求和、平均值、最大/最小值</li>
            <li>累乘、阶乘计算</li>
            <li>自定义数学运算</li>
        </ul>
        
        <h3>2. 集合转换</h3>
        <ul>
            <li>数组转字典</li>
            <li>分组和分类</li>
            <li>扁平化嵌套结构</li>
        </ul>
        
        <h3>3. 文本处理</h3>
        <ul>
            <li>字符串拼接</li>
            <li>单词统计</li>
            <li>文本格式转换</li>
        </ul>
        
        <h3>4. 数据分析</h3>
        <ul>
            <li>数据统计和汇总</li>
            <li>构建报表数据</li>
            <li>数据过滤和转换</li>
        </ul>
    </div>

    <div class="card">
        <h2>高级技巧</h2>
        
        <h3>与其他高阶函数组合</h3>
        <pre><code>// 组合map和reduce：计算偶数平方和
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let sumOfEvenSquares = numbers
    .filter { $0 % 2 == 0 }  // 过滤出偶数
    .map { $0 * $0 }         // 计算平方
    .reduce(0, +)            // 求和

print(sumOfEvenSquares)  // 输出: 220 (2² + 4² + 6² + 8² + 10²)</code></pre>
        
        <h3>递归结构处理</h3>
        <pre><code>// 处理树状结构
// 定义节点结构
class TreeNode {
    let value: Int
    let children: [TreeNode]
    
    init(value: Int, children: [TreeNode] = []) {
        self.value = value
        self.children = children
    }
    
    // 使用reduce递归计算树的节点总数
    func countNodes() -> Int {
        // 1(当前节点) + 所有子节点的节点数总和
        return 1 + children.reduce(0) { count, child in
            return count + child.countNodes()
        }
    }
    
    // 收集树中所有节点值
    func allValues() -> [Int] {
        return [value] + children.reduce([Int]()) { values, child in
            return values + child.allValues()
        }
    }
}

// 构建示例树
let tree = TreeNode(
    value: 1,
    children: [
        TreeNode(value: 2),
        TreeNode(
            value: 3,
            children: [
                TreeNode(value: 5),
                TreeNode(value: 6)
            ]
        ),
        TreeNode(value: 4)
    ]
)

print("节点总数: \(tree.countNodes())")  // 输出: 6
print("所有节点值: \(tree.allValues())")  // 输出: [1, 2, 3, 5, 6, 4]</code></pre>
    </div>

    <div class="card">
        <h2>reduce vs forEach vs for循环</h2>
        
        <div class="diagram">
            <svg width="700" height="300" xmlns="http://www.w3.org/2000/svg">
                <style>
                    @media (prefers-color-scheme: dark) {
                        .comp-box { fill: #2c2c2c; stroke: white; }
                        .comp-title { fill: white; }
                        .comp-text { fill: #dddddd; }
                    }
                    @media (prefers-color-scheme: light) {
                        .comp-box { fill: white; stroke: black; }
                        .comp-title { fill: black; }
                        .comp-text { fill: #333333; }
                    }
                </style>
                
                <!-- reduce框 -->
                <rect x="20" y="20" width="200" height="260" rx="10" class="comp-box" stroke-width="2"/>
                <rect x="20" y="20" width="200" height="40" rx="10" fill="var(--accent-color-1)" stroke="black" stroke-width="2"/>
                <text x="120" y="45" text-anchor="middle" font-weight="bold" fill="black">reduce</text>
                
                <text x="35" y="80" class="comp-text" font-size="14">优点:</text>
                <text x="45" y="100" class="comp-text" font-size="12">• 声明式、更简洁</text>
                <text x="45" y="120" class="comp-text" font-size="12">• 返回单一值</text>
                <text x="45" y="140" class="comp-text" font-size="12">• 链式调用友好</text>
                <text x="45" y="160" class="comp-text" font-size="12">• 无副作用(基础形式)</text>
                
                <text x="35" y="190" class="comp-text" font-size="14">缺点:</text>
                <text x="45" y="210" class="comp-text" font-size="12">• 学习曲线较陡</text>
                <text x="45" y="230" class="comp-text" font-size="12">• 调试相对困难</text>
                <text x="45" y="250" class="comp-text" font-size="12">• 复杂情况可读性降低</text>
                
                <!-- forEach框 -->
                <rect x="240" y="20" width="200" height="260" rx="10" class="comp-box" stroke-width="2"/>
                <rect x="240" y="20" width="200" height="40" rx="10" fill="var(--accent-color-1)" stroke="black" stroke-width="2"/>
                <text x="340" y="45" text-anchor="middle" font-weight="bold" fill="black">forEach</text>
                
                <text x="255" y="80" class="comp-text" font-size="14">优点:</text>
                <text x="265" y="100" class="comp-text" font-size="12">• 简洁的语法</text>
                <text x="265" y="120" class="comp-text" font-size="12">• 适合执行副作用</text>
                <text x="265" y="140" class="comp-text" font-size="12">• 入门门槛低</text>
                <text x="265" y="160" class="comp-text" font-size="12">• 代码易读</text>
                
                <text x="255" y="190" class="comp-text" font-size="14">缺点:</text>
                <text x="265" y="210" class="comp-text" font-size="12">• 无法中断循环</text>
                <text x="265" y="230" class="comp-text" font-size="12">• 无返回值</text>
                <text x="265" y="250" class="comp-text" font-size="12">• 不支持索引访问</text>
                
                <!-- for循环框 -->
                <rect x="460" y="20" width="200" height="260" rx="10" class="comp-box" stroke-width="2"/>
                <rect x="460" y="20" width="200" height="40" rx="10" fill="var(--accent-color-1)" stroke="black" stroke-width="2"/>
                <text x="560" y="45" text-anchor="middle" font-weight="bold" fill="black">for循环</text>
                
                <text x="475" y="80" class="comp-text" font-size="14">优点:</text>
                <text x="485" y="100" class="comp-text" font-size="12">• 完全控制循环流程</text>
                <text x="485" y="120" class="comp-text" font-size="12">• 可使用break/continue</text>
                <text x="485" y="140" class="comp-text" font-size="12">• 支持索引操作</text>
                <text x="485" y="160" class="comp-text" font-size="12">• 直观易理解</text>
                
                <text x="475" y="190" class="comp-text" font-size="14">缺点:</text>
                <text x="485" y="210" class="comp-text" font-size="12">• 代码较冗长</text>
                <text x="485" y="230" class="comp-text" font-size="12">• 命令式编程风格</text>
                <text x="485" y="250" class="comp-text" font-size="12">• 可能引入副作用</text>
            </svg>
        </div>
        
        <h3>三者性能对比</h3>
        <pre><code>import Foundation

// 准备测试数据
let testArray = Array(1...1000000)
var result = 0

// 使用for循环
let startTime1 = CFAbsoluteTimeGetCurrent()
for num in testArray {
    if num % 2 == 0 {
        result += num
    }
}
let endTime1 = CFAbsoluteTimeGetCurrent()
result = 0

// 使用forEach
let startTime2 = CFAbsoluteTimeGetCurrent()
testArray.forEach { num in
    if num % 2 == 0 {
        result += num
    }
}
let endTime2 = CFAbsoluteTimeGetCurrent()
result = 0

// 使用reduce
let startTime3 = CFAbsoluteTimeGetCurrent()
result = testArray.reduce(0) { acc, num in
    return num % 2 == 0 ? acc + num : acc
}
let endTime3 = CFAbsoluteTimeGetCurrent()

print("for循环耗时: \(endTime1 - startTime1)秒")
print("forEach耗时: \(endTime2 - startTime2)秒")
print("reduce耗时: \(endTime3 - startTime3)秒")

// 在大多数情况下，三者性能相近
// 但for循环通常略快，因为有更多编译器优化机会</code></pre>
    </div>

    <div class="card">
        <h2>相关资源</h2>
        
        <div class="resources">
            <div class="resource-card">
                <h3>官方文档</h3>
                <ul>
                    <li><a href="https://developer.apple.com/documentation/swift/array/reduce(_:_:)" target="_blank">Swift Array.reduce 官方文档</a></li>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Closures.html" target="_blank">Swift 闭包文档</a></li>
                    <li><a href="https://developer.apple.com/videos/play/wwdc2019/723/" target="_blank">WWDC: Modern Swift API Design</a></li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h3>推荐书籍</h3>
                <ul>
                    <li>《Functional Swift》by Chris Eidhof</li>
                    <li>《Swift in Depth》by Tjeerd in 't Veen</li>
                    <li>《Pro Swift》by Paul Hudson</li>
                    <li>《Swift Apprentice》by raywenderlich.com</li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h3>优质博客</h3>
                <ul>
                    <li><a href="https://www.swiftbysundell.com/articles/reducing-in-swift/" target="_blank">Swift by Sundell: Reducing in Swift</a></li>
                    <li><a href="https://www.hackingwithswift.com/articles/85/how-to-use-map-flatmap-and-compactmap-in-swift" target="_blank">Hacking with Swift: Map, FlatMap & Reduce</a></li>
                    <li><a href="https://www.avanderlee.com/swift/reduce-all-things/" target="_blank">SwiftLee: Reduce all the things</a></li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h3>开源项目</h3>
                <ul>
                    <li><a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms</a> - Swift算法与数据结构</li>
                    <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 函数响应式编程</li>
                    <li><a href="https://github.com/SnapKit/SnapKit" target="_blank">SnapKit</a> - 一个现代的Swift布局框架</li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h3>视频教程</h3>
                <ul>
                    <li><a href="https://www.pointfree.co" target="_blank">Point Free</a> - 函数式Swift编程视频</li>
                    <li><a href="https://www.raywenderlich.com/3925-functional-programming-with-swift" target="_blank">raywenderlich: 函数式编程</a></li>
                    <li><a href="https://www.udemy.com/course/swift-functional-programming-for-beginners/" target="_blank">Udemy: Swift函数式编程入门</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="card">
        <h2>总结</h2>
        <p><code>reduce</code>是Swift函数式编程的重要组成部分，它巧妙地将集合转化为单一值，让代码更简洁优雅。通过掌握基础形式和链式形式，开发者可以根据不同场景选择最合适的方式。</p>
        
        <p>记住这些关键点：</p>
        <ol>
            <li>基础形式适合简单转换，每次迭代返回新值</li>
            <li>链式形式(into)更高效，适合数组、字典等复杂数据结构</li>
            <li>与map、filter等组合使用可以构建强大的数据处理管道</li>
            <li>实践是掌握reduce的关键，从简单案例开始尝试</li>
        </ol>
        
        <div class="note">
            <p>函数式编程是一种思维方式，reduce只是其中一个工具。随着经验积累，你会发现更多elegant应用场景。</p>
        </div>
    </div>

</body>
</html>
