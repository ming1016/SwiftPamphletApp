<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift函数式编程 - sorted 排序函数详解</title>
    <style>
        :root {
            --text-color: #333;
            --bg-color: #fff;
            --code-bg: #f5f5f5;
            --accent-color: #e6d7c3;
            --shadow-color: rgba(0, 0, 0, 0.05);
            --border-color: #eaeaea;
            --link-color: #6b5b95;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #e0e0e0;
                --bg-color: #1a1a1a;
                --code-bg: #2d2d2d;
                --accent-color: #5d4e2c;
                --shadow-color: rgba(0, 0, 0, 0.2);
                --border-color: #3d3d3d;
                --link-color: #a79bc7;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--bg-color);
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
        }

        h1, h2, h3, h4 {
            font-weight: 600;
            margin-top: 2.5rem;
            margin-bottom: 1.5rem;
        }

        h1 {
            font-size: 2.5rem;
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 0.5rem;
        }

        h2 {
            font-size: 1.8rem;
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 0.3rem;
        }

        h3 {
            font-size: 1.4rem;
        }

        p {
            margin-bottom: 1.5rem;
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            background-color: var(--code-bg);
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-size: 0.9rem;
        }

        pre {
            background-color: var(--code-bg);
            padding: 1.5rem;
            border-radius: 8px;
            overflow-x: auto;
            margin: 1.5rem 0;
            box-shadow: 0 4px 6px var(--shadow-color);
        }

        pre code {
            padding: 0;
            background-color: transparent;
            font-size: 0.9rem;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px solid transparent;
            transition: border-color 0.2s;
        }

        a:hover {
            border-bottom-color: var(--link-color);
        }

        .container {
            background-color: var(--bg-color);
            border-radius: 12px;
            box-shadow: 0 8px 30px var(--shadow-color);
            padding: 2.5rem;
            margin-bottom: 3rem;
        }

        .example-box {
            border-left: 4px solid var(--accent-color);
            padding: 1rem 1.5rem;
            margin: 1.5rem 0;
            background-color: rgba(230, 215, 195, 0.1);
            border-radius: 0 8px 8px 0;
        }

        .note {
            padding: 1rem 1.5rem;
            background-color: rgba(107, 91, 149, 0.1);
            border-radius: 8px;
            margin: 1.5rem 0;
        }

        .resource-section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .resource-card {
            background-color: var(--bg-color);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 1.2rem;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .resource-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px var(--shadow-color);
        }

        .tag {
            display: inline-block;
            background: var(--accent-color);
            color: var(--bg-color);
            font-size: 0.7rem;
            padding: 0.2rem 0.6rem;
            border-radius: 20px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
        }

        figure {
            margin: 2rem 0;
            text-align: center;
        }

        figcaption {
            font-size: 0.9rem;
            color: #666;
            margin-top: 0.5rem;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .container {
                padding: 1.5rem;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            .resource-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Swift函数式编程 - sorted 排序函数详解</h1>

        <p>在Swift的函数式编程范式中，<code>sorted</code>方法是一个强大而灵活的工具，它允许我们以声明式的方式对集合进行排序。本章将深入讲解<code>sorted</code>的使用方法、原理及最佳实践。</p>

        <h2>1. sorted 基础概念</h2>

        <p><code>sorted</code>是Swift标准库中的高阶函数，用于返回一个有序的集合副本，而不修改原始集合。它基于函数式编程的不可变性原则，保持原始数据不变。</p>

        <figure>
            <svg width="600" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .box { fill: var(--bg-color); stroke: var(--accent-color); stroke-width: 2; }
                    .arrow { fill: none; stroke: var(--text-color); stroke-width: 2; marker-end: url(#arrowhead); }
                    .label { font-family: -apple-system, system-ui, sans-serif; font-size: 14px; fill: var(--text-color); }
                    .value { font-family: monospace; font-size: 12px; fill: var(--text-color); }
                </style>
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)" />
                    </marker>
                </defs>
                <rect x="50" y="50" width="200" height="100" rx="10" ry="10" class="box" />
                <text x="150" y="40" text-anchor="middle" class="label">原始数组</text>
                <text x="150" y="100" text-anchor="middle" class="value">[5, 2, 8, 1, 9, 3]</text>

                <rect x="350" y="50" width="200" height="100" rx="10" ry="10" class="box" />
                <text x="450" y="40" text-anchor="middle" class="label">排序后的新数组</text>
                <text x="450" y="100" text-anchor="middle" class="value">[1, 2, 3, 5, 8, 9]</text>

                <path d="M260 100 H340" class="arrow" />
                <text x="300" y="85" text-anchor="middle" class="label">sorted()</text>
            </svg>
            <figcaption>图1：sorted 函数的工作原理</figcaption>
        </figure>

        <h2>2. sorted 的基本用法</h2>

        <p>Swift中的<code>sorted</code>方法有两种主要形式：</p>

        <h3>2.1 默认排序</h3>

        <p>当元素遵循<code>Comparable</code>协议时，可以使用无参数版本，按升序排列：</p>

        <pre><code>// 默认排序（升序）
let numbers = [5, 3, 8, 1, 4]
let sortedNumbers = numbers.sorted()
// 结果: [1, 3, 4, 5, 8]</code></pre>

        <h3>2.2 自定义排序</h3>

        <p>使用闭包表达式来自定义排序逻辑：</p>

        <pre><code>// 使用闭包的自定义排序
let descendingNumbers = numbers.sorted { $0 > $1 }
// 结果: [8, 5, 4, 3, 1]

// 等价于：
let descendingNumbers2 = numbers.sorted(by: >)
// 结果: [8, 5, 4, 3, 1]</code></pre>

        <h2>3. sorted 的高级用法</h2>

        <h3>3.1 排序复杂对象</h3>

        <p>当处理自定义类型时，可以通过闭包定义排序规则：</p>

        <pre><code>struct Person {
    let name: String
    let age: Int
}

let people = [
    Person(name: "张三", age: 30),
    Person(name: "李四", age: 25),
    Person(name: "王五", age: 35)
]

// 按年龄升序排序
let sortedByAge = people.sorted { $0.age < $1.age }
// 结果: [李四(25岁), 张三(30岁), 王五(35岁)]

// 按姓名字母顺序排序
let sortedByName = people.sorted { $0.name < $1.name }
// 结果: [李四, 王五, 张三]</code></pre>

        <h3>3.2 多条件排序</h3>

        <p>可以在闭包中组合多个条件来创建复杂的排序规则：</p>

        <pre><code>struct Student {
    let name: String
    let score: Int
    let grade: String
}

let students = [
    Student(name: "张三", score: 85, grade: "B"),
    Student(name: "李四", score: 92, grade: "A"),
    Student(name: "王五", score: 78, grade: "C"),
    Student(name: "赵六", score: 92, grade: "A")
]

// 先按分数降序，分数相同时按姓名字母升序
let sortedStudents = students.sorted { (s1, s2) -> Bool in
    if s1.score == s2.score {
        return s1.name < s2.name
    }
    return s1.score > s2.score
}
// 结果: [李四(92分), 赵六(92分), 张三(85分), 王五(78分)]</code></pre>

        <figure>
            <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .diagram-box { fill: var(--bg-color); stroke: var(--accent-color); stroke-width: 2; }
                    .diagram-text { font-family: -apple-system, system-ui, sans-serif; font-size: 14px; fill: var(--text-color); }
                    .diagram-arrow { fill: none; stroke: var(--text-color); stroke-width: 2; marker-end: url(#arrow); }
                    .decision { fill: var(--bg-color); stroke: var(--link-color); stroke-width: 2; }
                </style>
                <defs>
                    <marker id="arrow" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)" />
                    </marker>
                </defs>

                <!-- 流程图示例：多条件排序决策树 -->
                <rect x="250" y="20" width="100" height="50" rx="5" class="diagram-box" />
                <text x="300" y="50" text-anchor="middle" class="diagram-text">开始比较</text>

                <path d="M300 70 L300 100" class="diagram-arrow" />

                <polygon points="200,100 400,100 300,150" class="decision" />
                <text x="300" y="130" text-anchor="middle" class="diagram-text">分数相同？</text>

                <path d="M200 100 L150 150" class="diagram-arrow" />
                <text x="180" y="130" text-anchor="start" class="diagram-text">否</text>

                <path d="M400 100 L450 150" class="diagram-arrow" />
                <text x="420" y="130" text-anchor="start" class="diagram-text">是</text>

                <rect x="100" y="150" width="100" height="50" rx="5" class="diagram-box" />
                <text x="150" y="180" text-anchor="middle" class="diagram-text">按分数降序</text>

                <rect x="400" y="150" width="100" height="50" rx="5" class="diagram-box" />
                <text x="450" y="180" text-anchor="middle" class="diagram-text">按名字升序</text>

                <path d="M150 200 L150 230" class="diagram-arrow" />
                <path d="M450 200 L450 230" class="diagram-arrow" />

                <path d="M150 230 L300 230" class="diagram-arrow" />
                <path d="M450 230 L300 230" class="diagram-arrow" />

                <rect x="250" y="230" width="100" height="50" rx="5" class="diagram-box" />
                <text x="300" y="260" text-anchor="middle" class="diagram-text">返回排序结果</text>
            </svg>
            <figcaption>图2：多条件排序的决策流程</figcaption>
        </figure>

        <h3>3.3 使用 keyPath 进行排序</h3>

        <p>Swift 5.2 后，我们可以结合 KeyPath 语法来简化排序操作：</p>

        <pre><code>// 使用自定义函数结合KeyPath
func sortedBy&lt;T, V: Comparable&gt;(_ keyPath: KeyPath&lt;T, V&gt;, ascending: Bool = true) -> (T, T) -> Bool {
    return { a, b in
        let aValue = a[keyPath: keyPath]
        let bValue = b[keyPath: keyPath]
        return ascending ? aValue < bValue : aValue > bValue
    }
}

// 使用KeyPath简化的排序
let sortedByScore = students.sorted(by: sortedBy(\.score, ascending: false))
// 结果等同于按分数降序排列

// 也可以使用第三方库如SwiftUI中的排序相关API
// let sortedByScoreThenName = students
//     .sorted(using: KeyPathComparator(\.score, order: .reverse)
//     .then(KeyPathComparator(\.name)))
</code></pre>

        <h2>4. sorted 与其他排序函数的比较</h2>

        <h3>4.1 sorted vs. sort</h3>

        <p><code>sorted</code>返回新的排序后的集合，而<code>sort</code>则直接修改原集合：</p>

        <pre><code>var mutableNumbers = [5, 2, 8, 1]

// sorted不改变原数组
let sortedArray = mutableNumbers.sorted()
// mutableNumbers仍然是 [5, 2, 8, 1]
// sortedArray是 [1, 2, 5, 8]

// sort直接修改原数组
mutableNumbers.sort()
// mutableNumbers变为 [1, 2, 5, 8]</code></pre>

        <figure>
            <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .method-box { fill: var(--bg-color); stroke: var(--text-color); stroke-width: 2; }
                    .method-text { font-family: -apple-system, system-ui, sans-serif; font-size: 14px; fill: var(--text-color); }
                    .method-title { font-family: -apple-system, system-ui, sans-serif; font-size: 16px; font-weight: bold; fill: var(--text-color); }
                    .method-arrow { fill: none; stroke: var(--text-color); stroke-width: 2; marker-end: url(#method-arrow); }
                </style>
                <defs>
                    <marker id="method-arrow" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)" />
                    </marker>
                </defs>

                <!-- sorted方法 -->
                <text x="150" y="30" text-anchor="middle" class="method-title">sorted()</text>
                <rect x="50" y="50" width="200" height="50" rx="5" class="method-box" />
                <text x="150" y="80" text-anchor="middle" class="method-text">原始数组 [5, 2, 8, 1]</text>

                <path d="M150 100 L150 130" class="method-arrow" />

                <rect x="50" y="130" width="200" height="50" rx="5" class="method-box" />
                <text x="150" y="160" text-anchor="middle" class="method-text">原始数组保持不变</text>

                <rect x="50" y="190" width="200" height="50" rx="5" class="method-box" />
                <text x="150" y="220" text-anchor="middle" class="method-text">新数组 [1, 2, 5, 8]</text>

                <!-- sort方法 -->
                <text x="450" y="30" text-anchor="middle" class="method-title">sort()</text>
                <rect x="350" y="50" width="200" height="50" rx="5" class="method-box" />
                <text x="450" y="80" text-anchor="middle" class="method-text">原始数组 [5, 2, 8, 1]</text>

                <path d="M450 100 L450 130" class="method-arrow" />

                <rect x="350" y="130" width="200" height="50" rx="5" class="method-box" />
                <text x="450" y="160" text-anchor="middle" class="method-text">原始数组被修改为</text>

                <rect x="350" y="190" width="200" height="50" rx="5" class="method-box" />
                <text x="450" y="220" text-anchor="middle" class="method-text">[1, 2, 5, 8]</text>
            </svg>
            <figcaption>图3：sorted 和 sort 方法的区别</figcaption>
        </figure>

        <div class="note">
            <p>函数式编程推荐使用<code>sorted</code>以保持数据不可变性，这有利于代码的可预测性和并发安全。</p>
        </div>

        <h2>5. 性能优化考虑</h2>

        <p><code>sorted</code>在时间复杂度上通常为O(n log n)，但在某些特定场景下可以通过以下方式优化性能：</p>

        <pre><code>// 对大型数据集进行排序前先过滤，减少排序的元素数量
let largeArray = Array(1...10000)
let result = largeArray
    .filter { $0 % 2 == 0 } // 先过滤，减少元素数量
    .sorted()                // 然后排序

// 仅获取前几个元素时，可以先排序再取前几个，提高性能
let topThree = largeArray
    .sorted()
    .prefix(3)

// 或者使用性能更好的方法(如果只需要前几个)
var topThreeEfficient: [Int] = []
var tempArray = largeArray
for _ in 0..<3 {
    if let min = tempArray.min() {
        topThreeEfficient.append(min)
        tempArray.removeAll { $0 == min }
    }
}</code></pre>

        <h2>6. 实际应用案例</h2>

        <h3>6.1 数据表格排序</h3>

        <pre><code>struct Product {
    let id: Int
    let name: String
    let price: Double
    let stockCount: Int
}

class ProductListViewModel {
    enum SortOption {
        case nameAsc, nameDesc
        case priceAsc, priceDesc
        case stockAsc, stockDesc
    }

    private var products: [Product]
    private var currentSortOption: SortOption = .nameAsc

    init(products: [Product]) {
        self.products = products
    }

    func sortedProducts() -> [Product] {
        switch currentSortOption {
        case .nameAsc:
            return products.sorted { $0.name < $1.name }
        case .nameDesc:
            return products.sorted { $0.name > $1.name }
        case .priceAsc:
            return products.sorted { $0.price < $1.price }
        case .priceDesc:
            return products.sorted { $0.price > $1.price }
        case .stockAsc:
            return products.sorted { $0.stockCount < $1.stockCount }
        case .stockDesc:
            return products.sorted { $0.stockCount > $1.stockCount }
        }
    }

    func applySorting(_ option: SortOption) {
        self.currentSortOption = option
        // 视图更新逻辑...
    }
}</code></pre>

        <h3>6.2 搜索结果排序</h3>

        <pre><code>struct SearchResult {
    let title: String
    let relevance: Double
    let datePublished: Date
}

func sortSearchResults(_ results: [SearchResult], prioritizeRecent: Bool) -> [SearchResult] {
    if prioritizeRecent {
        // 先按日期排序，相同日期再按相关性排序
        return results.sorted { (a, b) -> Bool in
            if Calendar.current.isDate(a.datePublished, inSameDayAs: b.datePublished) {
                return a.relevance > b.relevance
            }
            return a.datePublished > b.datePublished
        }
    } else {
        // 仅按相关性排序
        return results.sorted { $0.relevance > $1.relevance }
    }
}</code></pre>

        <h2>7. sorted 与函数式编程链式调用</h2>

        <p><code>sorted</code>作为函数式API，可以与其他高阶函数优雅地结合，形成强大的数据处理管道：</p>

        <pre><code>let transactions = [
    (id: "T1001", amount: 120.0, date: Date(timeIntervalSince1970: 1609459200)),  // 2021-01-01
    (id: "T1002", amount: 75.5, date: Date(timeIntervalSince1970: 1609545600)),   // 2021-01-02
    (id: "T1003", amount: 240.0, date: Date(timeIntervalSince1970: 1609632000)),  // 2021-01-03
    (id: "T1004", amount: 50.0, date: Date(timeIntervalSince1970: 1609718400)),   // 2021-01-04
    (id: "T1005", amount: 195.5, date: Date(timeIntervalSince1970: 1609804800)),  // 2021-01-05
]

// 链式调用示例：过滤+排序+映射
let formattedTopTransactions = transactions
    .filter { $0.amount > 100 }                 // 筛选大额交易
    .sorted { $0.amount > $1.amount }           // 按金额降序排序
    .prefix(2)                                  // 获取前两笔
    .map { "交易 \($0.id): ¥\($0.amount)" }     // 格式化输出

// 结果: ["交易 T1003: ¥240.0", "交易 T1005: ¥195.5"]</code></pre>

        <figure>
            <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .pipe-box { fill: var(--bg-color); stroke: var(--accent-color); stroke-width: 2; }
                    .pipe-text { font-family: -apple-system, system-ui, sans-serif; font-size: 14px; fill: var(--text-color); }
                    .pipe-arrow { fill: none; stroke: var(--text-color); stroke-width: 2; marker-end: url(#pipe-arrow); }
                    .pipe-data { font-family: monospace; font-size: 12px; fill: var(--text-color); }
                </style>
                <defs>
                    <marker id="pipe-arrow" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)" />
                    </marker>
                </defs>

                <!-- 数据流处理管道图 -->
                <rect x="10" y="40" width="120" height="60" rx="5" class="pipe-box" />
                <text x="70" y="30" text-anchor="middle" class="pipe-text">原始数据</text>
                <text x="70" y="75" text-anchor="middle" class="pipe-data">[5条交易]</text>

                <path d="M130 70 L170 70" class="pipe-arrow" />

                <rect x="170" y="40" width="120" height="60" rx="5" class="pipe-box" />
                <text x="230" y="30" text-anchor="middle" class="pipe-text">filter</text>
                <text x="230" y="75" text-anchor="middle" class="pipe-data">[3条交易]</text>

                <path d="M290 70 L330 70" class="pipe-arrow" />

                <rect x="330" y="40" width="120" height="60" rx="5" class="pipe-box" />
                <text x="390" y="30" text-anchor="middle" class="pipe-text">sorted</text>
                <text x="390" y="75" text-anchor="middle" class="pipe-data">[排序后3条]</text>

                <path d="M450 70 L490 70" class="pipe-arrow" />

                <rect x="490" y="40" width="100" height="60" rx="5" class="pipe-box" />
                <text x="540" y="30" text-anchor="middle" class="pipe-text">prefix(2)</text>
                <text x="540" y="75" text-anchor="middle" class="pipe-data">[前2条]</text>

                <path d="M540 100 L540 130" class="pipe-arrow" />

                <rect x="330" y="130" width="420" height="60" rx="5" class="pipe-box" />
                <text x="540" y="120" text-anchor="middle" class="pipe-text">map</text>
                <text x="540" y="165" text-anchor="middle" class="pipe-data">["交易 T1003: ¥240.0", "交易 T1005: ¥195.5"]</text>
            </svg>
            <figcaption>图4：函数式编程链式调用数据流</figcaption>
        </figure>

        <h2>8. sorted 最佳实践</h2>

        <div class="example-box">
            <h3>排序规则封装</h3>
            <p>将常用的排序逻辑封装为可复用的函数：</p>

            <pre><code>// 创建通用的排序函数
struct SortDescriptors {
    static func byKeyPath&lt;T, V: Comparable&gt;(_ keyPath: KeyPath&lt;T, V&gt;, ascending: Bool = true) -> (T, T) -> Bool {
        return { a, b in
            let aValue = a[keyPath: keyPath]
            let bValue = b[keyPath: keyPath]
            return ascending ? aValue < bValue : aValue > bValue
        }
    }

    static func compound&lt;T&gt;(_ descriptors: ((T, T) -> Bool)...) -> (T, T) -> Bool {
        return { lhs, rhs in
            for descriptor in descriptors {
                if descriptor(lhs, rhs) { return true }
                if descriptor(rhs, lhs) { return false }
            }
            return false
        }
    }
}

// 使用排序规则
let sortedByPriceAndName = products.sorted(by: SortDescriptors.compound(
    SortDescriptors.byKeyPath(\.price),
    SortDescriptors.byKeyPath(\.name)
))</code></pre>
        </div>

        <h3>8.1 性能与内存考量</h3>

        <p>在处理大型数据集时的最佳实践：</p>

        <pre><code>// 对于大数据集，考虑先过滤再排序
func processLargeDataset(data: [BigData]) -> [BigData] {
    // ✅ 推荐：先过滤再排序，可能大幅减少需要排序的元素数量
    return data.filter { meetsFilteringCriteria($0) }
               .sorted { $0.value < $1.value }

    // ❌ 不推荐：先排序再过滤，对全部元素进行不必要的排序
    // return data.sorted { $0.value < $1.value }
    //            .filter { meetsFilteringCriteria($0) }
}

// 只需要部分有序元素时，使用prefix或suffix
func topFiveItems(from items: [Item]) -> [Item] {
    // ✅ 推荐：直接获取前五个元素
    return items.sorted { $0.rating > $1.rating }.prefix(5).map { $0 }
}</code></pre>

        <h3>8.2 稳定排序</h3>

        <p>Swift的<code>sorted</code>实现是稳定排序，相等元素保持原始顺序，这在某些场景下很重要：</p>

        <pre><code>struct Student {
    let name: String
    let grade: Int
}

let students = [
    Student(name: "李明", grade: 85),
    Student(name: "王芳", grade: 90),
    Student(name: "张伟", grade: 85),
    Student(name: "刘洋", grade: 90)
]

// 按成绩降序排序后，相同成绩的学生保持原有顺序
let sortedStudents = students.sorted { $0.grade > $1.grade }
// 结果：[王芳(90), 刘洋(90), 李明(85), 张伟(85)]
// 注意：王芳在刘洋之前，李明在张伟之前，保持了原始顺序</code></pre>

        <h2>9. 常见陷阱和解决方案</h2>

        <h3>9.1 排序可选值</h3>

        <p>处理可能包含nil的数组时的特殊考虑：</p>

        <pre><code>let scores: [Int?] = [5, nil, 3, 10, nil, 7]

// ❌ 错误做法：直接排序可选值可能导致不可预期的结果
let sortedWithNils = scores.sorted { (a, b) -> Bool in
    guard let aValue = a, let bValue = b else { return false }
    return aValue < bValue
}

// ✅ 正确做法：将nil值放在特定位置（例如末尾）
let sortedScores = scores.sorted { (a, b) -> Bool in
    switch (a, b) {
    case (nil, nil): return false   // 两个nil相等
    case (nil, _):   return false   // nil放在末尾
    case (_, nil):   return true    // 非nil值排在nil之前
    case (let aValue?, let bValue?): return aValue < bValue // 正常比较
    }
}
// 结果: [3, 5, 7, 10, nil, nil]</code></pre>

        <h3>9.2 自定义类型的排序</h3>

        <p>如果需要频繁对自定义类型排序，让类型遵循<code>Comparable</code>协议是更好的选择：</p>

        <pre><code>// ✅ 推荐：通过让类型遵循Comparable协议实现排序
struct Book: Comparable {
    let title: String
    let publicationYear: Int

    // 实现Comparable协议的要求
    static func < (lhs: Book, rhs: Book) -> Bool {
        if lhs.publicationYear == rhs.publicationYear {
            return lhs.title < rhs.title
        }
        return lhs.publicationYear < rhs.publicationYear
    }
}

let books = [
    Book(title: "Swift编程", publicationYear: 2019),
    Book(title: "iOS应用开发", publicationYear: 2020),
    Book(title: "Swift高级教程", publicationYear: 2019)
]

// 现在可以直接使用sorted()，无需额外闭包
let sortedBooks = books.sorted()
// 按年份升序，相同年份按标题字母顺序升序</code></pre>

        <h3>9.3 避免排序闭包中的副作用</h3>

        <pre><code>// ❌ 不好的做法：排序闭包中包含副作用
var callCount = 0
let badSorting = numbers.sorted { (a, b) -> Bool in
    callCount += 1  // 副作用：修改外部状态
    print("Comparing \(a) and \(b)")  // 副作用：输出
    return a < b
}

// ✅ 好的做法：排序闭包应该是纯函数
let goodSorting = numbers.sorted { a, b in
    return a < b  // 纯函数，无副作用
}</code></pre>

        <h2>10. 参考资源</h2>

        <div class="resource-section">
            <div class="resource-card">
                <h3>官方文档</h3>
                <div class="tag">Swift</div>
                <p><a href="https://developer.apple.com/documentation/swift/array/sorted()" target="_blank">Array.sorted() - Apple Developer Documentation</a></p>
                <p><a href="https://developer.apple.com/documentation/swift/sequence/sorted(by:)" target="_blank">Sequence.sorted(by:) - Apple Developer Documentation</a></p>
            </div>

            <div class="resource-card">
                <h3>相关博客</h3>
                <div class="tag">教程</div>
                <p><a href="https://www.hackingwithswift.com/articles/148/an-introduction-to-functional-programming-in-swift" target="_blank">Hacking with Swift: Functional Programming</a></p>
                <p><a href="https://www.swiftbysundell.com/articles/sorting-swift-collections/" target="_blank">Swift by Sundell: Sorting Collections</a></p>
                <p><a href="https://www.avanderlee.com/swift/compactmap-flatmap-reduce-filter-map/" target="_blank">SwiftLee: Higher Order Functions</a></p>
            </div>

            <div class="resource-card">
                <h3>推荐书籍</h3>
                <div class="tag">学习资源</div>
                <p>《Swift进阶》by 王巍(onevcat)</p>
                <p>《函数式Swift》by Chris Eidhof等</p>
                <p>《Swift编程权威指南》by 苹果官方文档中文版</p>
            </div>

            <div class="resource-card">
                <h3>相关视频</h3>
                <div class="tag">学习资源</div>
                <p><a href="https://developer.apple.com/videos/play/wwdc2018/223/" target="_blank">WWDC: Swift Collections and High Order Functions</a></p>
                <p><a href="https://www.youtube.com/watch?v=6sUbt-Qp6Pg" target="_blank">Swift Talk: Sort Descriptors in Swift</a></p>
            </div>

            <div class="resource-card">
                <h3>开源项目</h3>
                <div class="tag">代码示例</div>
                <p><a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms</a> - 苹果官方算法库</p>
                <p><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Composable Architecture</a> - 函数式架构示例</p>
                <p><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 反应式编程与排序相关示例</p>
            </div>
        </div>

        <h2>11. 总结</h2>

        <p><code>sorted</code>是Swift函数式编程工具箱中的重要组件，它使我们能够以简洁、声明式的方式排序集合。正确使用它可以让代码更加清晰和可维护。关键要点：</p>

        <ol>
            <li>相比于直接修改集合的<code>sort</code>，<code>sorted</code>返回新集合，保持了数据不可变性</li>
            <li>可以通过闭包自定义复杂的排序逻辑</li>
            <li>与其他高阶函数结合使用时功能更加强大</li>
            <li>对于自定义类型，遵循<code>Comparable</code>协议可简化排序</li>
            <li>处理大型数据集时应考虑性能优化，如先过滤再排序</li>
        </ol>

        <p>掌握<code>sorted</code>及相关函数式编程概念，将帮助你编写更简洁、更可读的Swift代码，让数据处理变得更加优雅。</p>

    </div>
</body>
</html>
