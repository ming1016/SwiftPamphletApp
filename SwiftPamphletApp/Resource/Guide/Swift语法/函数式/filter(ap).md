<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift函数式编程 - Filter方法详解</title>
    <style>
        :root {
            --text-color: #333;
            --bg-color: #fff;
            --code-bg: #f5f5f5;
            --accent-color: #0077cc;
            --secondary-color: #ff6b6b;
            --tertiary-color: #4ecdc4;
            --quaternary-color: #7bc043;
            --quinary-color: #ff9f1c;
            --border-color: #ddd;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #e0e0e0;
                --bg-color: #121212;
                --code-bg: #2d2d2d;
                --accent-color: #61dafb;
                --secondary-color: #ff9e9e;
                --tertiary-color: #76e6df;
                --quaternary-color: #9ed566;
                --quinary-color: #ffbc5d;
                --border-color: #444;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--bg-color);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 100 100'%3E%3Cpath fill='%23f0f0f0' fill-opacity='0.2' d='M50 0C22.4 0 0 22.4 0 50s22.4 50 50 50 50-22.4 50-50S77.6 0 50 0zm0 80c-16.6 0-30-13.4-30-30s13.4-30 30-30 30 13.4 30 30-13.4 30-30 30z'/%3E%3C/svg%3E");
            margin: 0;
            padding: 0;
        }

        @media (prefers-color-scheme: dark) {
            body {
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 100 100'%3E%3Cpath fill='%23303030' fill-opacity='0.2' d='M50 0C22.4 0 0 22.4 0 50s22.4 50 50 50 50-22.4 50-50S77.6 0 50 0zm0 80c-16.6 0-30-13.4-30-30s13.4-30 30-30 30 13.4 30 30-13.4 30-30 30z'/%3E%3C/svg%3E");
            }
        }

        .container {
            max-width: 960px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        header {
            position: relative;
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 1rem;
            background: linear-gradient(135deg, var(--accent-color), var(--tertiary-color));
            color: white;
            text-align: center;
            overflow: hidden;
        }

        header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='50' viewBox='0 0 100 50'%3E%3Cpath fill='%23ffffff' fill-opacity='0.1' d='M0 25c0 0 20-25 50-25s50 25 50 25-20 25-50 25S0 25 0 25z'/%3E%3C/svg%3E");
            background-size: 100px 50px;
            opacity: 0.5;
            z-index: 0;
        }

        header h1 {
            position: relative;
            margin: 0;
            font-size: 2.5rem;
            z-index: 1;
        }

        header p {
            position: relative;
            margin: 1rem 0 0;
            font-size: 1.2rem;
            z-index: 1;
        }

        .fish-decoration {
            position: absolute;
            width: 80px;
            height: 40px;
            opacity: 0.7;
        }

        .fish-1 {
            top: 30px;
            right: 10%;
            transform: rotate(30deg);
        }

        .fish-2 {
            bottom: 20px;
            left: 15%;
            transform: rotate(-20deg);
        }

        section {
            background-color: var(--bg-color);
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            border-left: 5px solid var(--accent-color);
        }

        h2 {
            color: var(--accent-color);
            margin-top: 0;
            font-size: 1.8rem;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
        }

        h3 {
            color: var(--secondary-color);
            font-size: 1.4rem;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }

        pre {
            background-color: var(--code-bg);
            border-radius: 0.5rem;
            padding: 1rem;
            overflow-x: auto;
            border-left: 3px solid var(--tertiary-color);
            margin: 1rem 0;
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9em;
        }

        .code-comment {
            color: #6a9955;
            font-style: italic;
        }

        a {
            color: var(--accent-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--accent-color);
            transition: all 0.2s ease;
        }

        a:hover {
            color: var(--secondary-color);
            border-bottom: 1px solid var(--secondary-color);
        }

        .resource-card {
            display: flex;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: transform 0.2s ease;
        }

        .resource-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .resource-icon {
            min-width: 40px;
            height: 40px;
            margin-right: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: var(--accent-color);
            color: white;
            font-size: 1.2rem;
        }

        .resource-content {
            flex-grow: 1;
        }

        .resource-title {
            font-weight: bold;
            margin-bottom: 0.25rem;
        }

        .resource-description {
            font-size: 0.9rem;
            color: var(--text-color);
            opacity: 0.8;
        }

        figure {
            margin: 2rem 0;
            text-align: center;
        }

        figcaption {
            font-size: 0.9rem;
            margin-top: 0.5rem;
            font-style: italic;
            color: var(--text-color);
            opacity: 0.8;
        }

        .note {
            background-color: rgba(var(--accent-color-rgb), 0.1);
            border-left: 4px solid var(--accent-color);
            padding: 1rem;
            margin: 1rem 0;
            border-radius: 0 0.5rem 0.5rem 0;
        }

        .note-title {
            font-weight: bold;
            color: var(--accent-color);
            margin-bottom: 0.5rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            header {
                padding: 1.5rem 1rem;
            }

            header h1 {
                font-size: 2rem;
            }

            section {
                padding: 1.5rem;
            }

            .fish-decoration {
                width: 60px;
                height: 30px;
            }
        }

        .koinobori {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 40px;
            height: 120px;
            z-index: 10;
            animation: sway 4s ease-in-out infinite;
        }

        @keyframes sway {
            0%, 100% { transform: rotate(-5deg); }
            50% { transform: rotate(5deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <svg class="fish-decoration fish-1" viewBox="0 0 100 50" xmlns="http://www.w3.org/2000/svg">
                <path fill="#FFBC5D" d="M95,25c0,0-20,25-50,25S0,25,0,25s20-25,50-25S95,25,95,25z"/>
                <circle cx="30" cy="20" r="5" fill="#333"/>
                <path fill="#FF6B6B" d="M15,25c0,0,5-10,15-10s15,10,15,10s-5,10-15,10S15,25,15,25z"/>
            </svg>
            <svg class="fish-decoration fish-2" viewBox="0 0 100 50" xmlns="http://www.w3.org/2000/svg">
                <path fill="#4ECDC4" d="M95,25c0,0-20,25-50,25S0,25,0,25s20-25,50-25S95,25,95,25z"/>
                <circle cx="30" cy="20" r="5" fill="#333"/>
                <path fill="#7BC043" d="M15,25c0,0,5-10,15-10s15,10,15,10s-5,10-15,10S15,25,15,25z"/>
            </svg>
            <h1>Swift函数式编程 - Filter方法详解</h1>
            <p>在数组和序列中筛选元素的强大工具</p>
        </header>

        <svg class="koinobori" viewBox="0 0 40 120" xmlns="http://www.w3.org/2000/svg">
            <rect x="19" y="0" width="2" height="20" fill="#555"/>
            <path fill="#0077cc" d="M20,20 C35,20 35,35 35,50 C25,50 15,50 5,50 C5,35 5,20 20,20z"/>
            <path fill="#ff6b6b" d="M20,50 C35,50 35,65 35,80 C25,80 15,80 5,80 C5,65 5,50 20,50z"/>
            <path fill="#7bc043" d="M20,80 C35,80 35,95 35,110 C25,110 15,110 5,110 C5,95 5,80 20,80z"/>
            <circle cx="15" cy="30" r="3" fill="white"/>
            <circle cx="15" cy="60" r="3" fill="white"/>
            <circle cx="15" cy="90" r="3" fill="white"/>
        </svg>

        <section>
            <h2>Filter 方法概述</h2>
            <p>在Swift的函数式编程中，<code>filter</code>是一种高阶函数，它用于根据指定的条件筛选集合中的元素。<code>filter</code>方法返回一个新的集合，其中包含原集合中满足给定条件的所有元素。</p>

            <figure>
                <svg width="100%" height="180" viewBox="0 0 600 180" xmlns="http://www.w3.org/2000/svg">
                    <rect x="20" y="40" width="560" height="60" rx="10" fill="none" stroke="var(--accent-color)" stroke-width="2"/>
                    <text x="300" y="25" text-anchor="middle" fill="var(--text-color)" font-size="16">原始数组</text>

                    <!-- 原始数组元素 -->
                    <rect x="40" y="55" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="90" y="55" width="30" height="30" rx="5" fill="var(--secondary-color)"/>
                    <rect x="140" y="55" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="190" y="55" width="30" height="30" rx="5" fill="var(--tertiary-color)"/>
                    <rect x="240" y="55" width="30" height="30" rx="5" fill="var(--quaternary-color)"/>
                    <rect x="290" y="55" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="340" y="55" width="30" height="30" rx="5" fill="var(--quinary-color)"/>
                    <rect x="390" y="55" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="440" y="55" width="30" height="30" rx="5" fill="var(--secondary-color)"/>
                    <rect x="490" y="55" width="30" height="30" rx="5" fill="var(--tertiary-color)"/>
                    <rect x="540" y="55" width="30" height="30" rx="5" fill="var(--accent-color)"/>

                    <!-- Filter过程 -->
                    <path d="M300,110 L300,130" stroke="var(--text-color)" stroke-width="2" stroke-dasharray="5,3"/>
                    <path d="M260,130 L340,130 L320,160 L280,160 Z" fill="none" stroke="var(--text-color)" stroke-width="2"/>
                    <text x="300" y="150" text-anchor="middle" fill="var(--text-color)" font-size="12">filter</text>

                    <!-- 结果数组 -->
                    <rect x="150" y="170" width="300" height="40" rx="10" fill="none" stroke="var(--accent-color)" stroke-width="2"/>
                    <text x="300" y="196" text-anchor="middle" fill="var(--text-color)" font-size="16">过滤后数组</text>

                    <!-- 结果元素 -->
                    <rect x="170" y="175" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="220" y="175" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="270" y="175" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="320" y="175" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                    <rect x="370" y="175" width="30" height="30" rx="5" fill="var(--accent-color)"/>
                </svg>
                <figcaption>图1: Filter方法的工作原理 - 根据条件筛选集合元素</figcaption>
            </figure>

            <p>与传统的循环和条件语句相比，使用<code>filter</code>可以：</p>
            <ul>
                <li>编写更简洁、更具表达力的代码</li>
                <li>减少变量和状态的管理</li>
                <li>避免常见的循环错误（如边界条件处理）</li>
                <li>使代码更易于阅读和维护</li>
            </ul>
        </section>

        <section>
            <h2>基本语法与用法</h2>
            <p><code>filter</code>方法的基本语法如下：</p>

            <pre><code>let filteredCollection = collection.filter { (element) -> Bool in
    // 条件判断，返回true表示保留元素，false表示过滤掉
    return condition(element)
}</code></pre>

            <h3>简单示例：过滤偶数</h3>
            <pre><code>let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 过滤出所有偶数
let evenNumbers = numbers.filter { number in
    return number % 2 == 0
}
// 输出: [2, 4, 6, 8, 10]
print(evenNumbers)

// 使用简写语法
let evenNumbersShort = numbers.filter { $0 % 2 == 0 }
// 输出: [2, 4, 6, 8, 10]
print(evenNumbersShort)</code></pre>

            <div class="note">
                <div class="note-title">Swift语法小提示</div>
                <p>当闭包是函数的最后一个参数时，可以使用尾随闭包语法，省略小括号；当闭包表达式较短时，可以使用简写语法，通过<code>$0</code>、<code>$1</code>等表示参数。</p>
            </div>
        </section>

        <section>
            <h2>进阶使用技巧</h2>

            <h3>1. 链式调用</h3>
            <p><code>filter</code>通常与其他高阶函数（如<code>map</code>和<code>reduce</code>）配合使用，形成强大的数据处理管道。</p>

            <pre><code>let transactions = [
    ["id": "001", "amount": 100, "status": "completed"],
    ["id": "002", "amount": 200, "status": "pending"],
    ["id": "003", "amount": 300, "status": "completed"],
    ["id": "004", "amount": 400, "status": "failed"],
    ["id": "005", "amount": 500, "status": "completed"]
]

// 先筛选出已完成的交易，然后计算总金额
let completedTotal = transactions
    .filter { $0["status"] as? String == "completed" } // 筛选已完成交易
    .compactMap { $0["amount"] as? Int }               // 提取金额并确保类型安全
    .reduce(0, +)                                      // 计算总和

// 输出: 900
print(completedTotal)</code></pre>

            <figure>
                <svg width="100%" height="160" viewBox="0 0 600 160" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="0" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)"/>
                        </marker>
                    </defs>

                    <!-- 原始数据 -->
                    <rect x="20" y="40" width="120" height="60" rx="10" fill="var(--accent-color)" opacity="0.7"/>
                    <text x="80" y="75" text-anchor="middle" fill="white" font-size="14">[数据集合]</text>

                    <!-- 箭头 -->
                    <line x1="140" y1="70" x2="190" y2="70" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="165" y="60" text-anchor="middle" fill="var(--text-color)" font-size="12">filter</text>

                    <!-- filter结果 -->
                    <rect x="200" y="40" width="120" height="60" rx="10" fill="var(--secondary-color)" opacity="0.7"/>
                    <text x="260" y="75" text-anchor="middle" fill="white" font-size="14">[已筛选数据]</text>

                    <!-- 箭头 -->
                    <line x1="320" y1="70" x2="370" y2="70" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="345" y="60" text-anchor="middle" fill="var(--text-color)" font-size="12">compactMap</text>

                    <!-- map结果 -->
                    <rect x="380" y="40" width="120" height="60" rx="10" fill="var(--tertiary-color)" opacity="0.7"/>
                    <text x="440" y="75" text-anchor="middle" fill="white" font-size="14">[转换后数据]</text>

                    <!-- 箭头 -->
                    <line x1="500" y1="70" x2="550" y2="70" stroke="var(--text-color)" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="525" y="60" text-anchor="middle" fill="var(--text-color)" font-size="12">reduce</text>

                    <!-- reduce结果 -->
                    <circle cx="570" cy="70" r="20" fill="var(--quaternary-color)"/>
                    <text x="570" y="75" text-anchor="middle" fill="white" font-size="14">900</text>
                </svg>
                <figcaption>图2: 函数式链式调用流程示意图</figcaption>
            </figure>

            <h3>2. 使用复杂条件</h3>
            <pre><code>struct User {
    let id: Int
    let name: String
    let age: Int
    let isPremium: Bool
}

let users = [
    User(id: 1, name: "小明", age: 25, isPremium: true),
    User(id: 2, name: "小红", age: 17, isPremium: false),
    User(id: 3, name: "张三", age: 30, isPremium: true),
    User(id: 4, name: "李四", age: 16, isPremium: false),
    User(id: 5, name: "王五", age: 42, isPremium: true)
]

// 筛选出年龄大于18且是高级会员的用户
let adultPremiumUsers = users.filter { user in
    // 复合条件：成年 AND 高级会员
    return user.age >= 18 && user.isPremium
}

// 输出: 筛选出的是id为1、3、5的用户
adultPremiumUsers.forEach { user in
    print("\(user.id): \(user.name), \(user.age)岁, 高级会员: \(user.isPremium)")
}</code></pre>

            <h3>3. 过滤可选类型</h3>
            <p>使用<code>compactMap</code>和<code>filter</code>的组合来处理包含可选值的集合：</p>

            <pre><code>let optionalNumbers: [Int?] = [1, nil, 3, nil, 5, 6, nil, 8]

// 方法1: 先用compactMap移除nil，再过滤
let filteredNumbers1 = optionalNumbers
    .compactMap { $0 }        // 移除nil值并解包
    .filter { $0 > 3 }        // 过滤大于3的数

// 方法2: 在filter内部处理可选值
let filteredNumbers2 = optionalNumbers
    .filter {
        // 使用可选绑定判断，nil值将被过滤
        if let number = $0, number > 3 {
            return true
        }
        return false
    }
    .compactMap { $0 }        // 最后解包

// 输出: [5, 6, 8]
print(filteredNumbers1)
// 输出: [5, 6, 8]
print(filteredNumbers2)</code></pre>
        </section>

        <section>
            <h2>实际应用场景</h2>

            <h3>1. 数据分析与处理</h3>
            <pre><code>// 假设我们有一组销售数据
struct SaleRecord {
    let product: String
    let quantity: Int
    let revenue: Double
    let date: Date
}

let salesData = [
    // 假设这里有大量销售记录...
]

// 分析特定时间段的高利润产品
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

let startDate = dateFormatter.date(from: "2023-01-01")!
let endDate = dateFormatter.date(from: "2023-03-31")!

let highPerformanceProducts = salesData.filter { record in
    // 筛选条件：在指定日期范围内且收入超过1000
    return record.date >= startDate &&
           record.date <= endDate &&
           record.revenue > 1000.0
}</code></pre>

            <h3>2. UI组件的数据过滤</h3>
            <pre><code>import UIKit

class ProductListViewController: UIViewController {
    // 所有产品数据
    var allProducts: [Product] = []
    // 当前显示的过滤后产品
    var filteredProducts: [Product] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // 用户选择的筛选类别
    var selectedCategory: String?

    func applyFilters() {
        // 基于多个条件进行过滤
        filteredProducts = allProducts.filter { product in
            var matchesSearch = true
            var matchesCategory = true

            // 搜索词过滤
            if let searchText = searchBar.text, !searchText.isEmpty {
                matchesSearch = product.name.localizedCaseInsensitiveContains(searchText) ||
                                product.description.localizedCaseInsensitiveContains(searchText)
            }

            // 类别过滤
            if let category = selectedCategory {
                matchesCategory = product.category == category
            }

            // 两个条件必须同时满足
            return matchesSearch && matchesCategory
        }

        // 更新UI
        tableView.reloadData()
    }
}</code></pre>

            <h3>3. 数据验证与处理</h3>
            <pre><code>// 假设我们有一组从API获取的用户数据
let apiUserData: [[String: Any]] = [
    ["id": 1, "name": "张三", "email": "zhangsan@example.com"],
    ["id": 2, "name": nil, "email": "lisi@example.com"],
    ["id": 3, "name": "王五", "email": nil],
    ["id": 4, "name": "赵六", "email": "invalid-email"],
    ["id": 5, "name": "田七", "email": "tianqi@example.com"]
]

// 验证用户数据是否完整有效
func isValidEmail(_ email: String) -> Bool {
    // 使用简单的正则表达式验证邮箱格式
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let regex = try! NSRegularExpression(pattern: pattern)
    let range = NSRange(location: 0, length: email.utf16.count)
    return regex.firstMatch(in: email, options: [], range: range) != nil
}

// 过滤出有效用户数据
let validUsers = apiUserData.filter { userData in
    // 确保名字不为空
    guard let name = userData["name"] as? String, !name.isEmpty else {
        return false
    }

    // 确保邮箱不为空且格式有效
    guard let email = userData["email"] as? String, isValidEmail(email) else {
        return false
    }

    return true
}

// 输出结果将只包含id为1和5的用户
print("有效用户数: \(validUsers.count)")</code></pre>
        </section>

        <section>
            <h2>性能考虑</h2>
            <p>虽然<code>filter</code>提供了优雅的语法，但在处理大型集合时需要注意性能问题：</p>

            <figure>
                <svg width="100%" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                    <!-- 坐标轴 -->
                    <line x1="50" y1="200" x2="550" y2="200" stroke="var(--text-color)" stroke-width="2"/>
                    <line x1="50" y1="50" x2="50" y2="200" stroke="var(--text-color)" stroke-width="2"/>

                    <!-- X轴标签 -->
                    <text x="50" y="220" text-anchor="middle" fill="var(--text-color)">0</text>
                    <text x="300" y="220" text-anchor="middle" fill="var(--text-color)">集合大小</text>
                    <text x="550" y="220" text-anchor="middle" fill="var(--text-color)">n</text>

                    <!-- Y轴标签 -->
                    <text x="30" y="200" text-anchor="end" fill="var(--text-color)">0</text>
                    <text x="30" y="50" text-anchor="end" fill="var(--text-color)">时间</text>

                    <!-- 线性时间复杂度 O(n) -->
                    <path d="M50,200 L550,50" stroke="var(--accent-color)" stroke-width="3" fill="none"/>
                    <text x="560" y="50" fill="var(--accent-color)">O(n)</text>

                    <!-- 标注点 -->
                    <circle cx="175" cy="163" r="5" fill="var(--secondary-color)"/>
                    <text x="175" y="153" text-anchor="middle" fill="var(--secondary-color)">小集合</text>

                    <circle cx="425" cy="88" r="5" fill="var(--secondary-color)"/>
                    <text x="425" y="78" text-anchor="middle" fill="var(--secondary-color)">大集合</text>
                </svg>
                <figcaption>图3: filter方法的时间复杂度为O(n)</figcaption>
            </figure>

            <ul>
                <li>每次调用<code>filter</code>都会创建一个新的集合，这会带来内存开销</li>
                <li>链式调用多个<code>filter</code>会多次遍历集合，可能影响性能</li>
                <li>对于大型集合，考虑合并多个过滤条件或使用<code>lazy</code>集合</li>
            </ul>

            <h3>优化示例：合并多个过滤条件</h3>
            <pre><code>// 低效写法: 多次遍历集合
let result = numbers
    .filter { $0 > 10 }
    .filter { $0 % 2 == 0 }
    .filter { $0 < 100 }

// 优化写法: 一次遍历，合并所有条件
let optimizedResult = numbers.filter { number in
    return number > 10 && number % 2 == 0 && number < 100
}</code></pre>

            <h3>使用lazy集合延迟执行</h3>
            <pre><code>// 创建一个非常大的数组
let largeArray = Array(1...1_000_000)

// 使用lazy避免中间结果的内存分配
let result = largeArray.lazy
    .filter { $0 % 2 == 0 }    // 过滤偶数
    .filter { $0 % 3 == 0 }    // 过滤能被3整除的数
    .prefix(10)                // 只取前10个结果

// 转换为数组 - 只有到这一步才会实际执行过滤操作
let finalResult = Array(result)

// 输出: [6, 12, 18, 24, 30, 36, 42, 48, 54, 60]
print(finalResult)</code></pre>
        </section>

        <section>
            <h2>关于值语义与对象引用</h2>
            <p><code>filter</code>方法遵循Swift的值语义原则，这意味着对于值类型的集合（如Array、Dictionary等），<code>filter</code>会创建新的集合，而不修改原集合。</p>

            <div class="note">
                <div class="note-title">重要提示</div>
                <p>当过滤引用类型元素的集合时，新集合中的元素仍然引用原始对象。修改这些对象会影响原始集合中的对象。</p>
            </div>

            <pre><code>// 值类型示例
var numbers = [1, 2, 3, 4, 5]
let evenNumbers = numbers.filter { $0 % 2 == 0 } // [2, 4]

// 修改原集合不影响过滤后的集合
numbers[0] = 2
print(numbers)      // [2, 2, 3, 4, 5]
print(evenNumbers)  // [2, 4] - 没有变化

// 引用类型示例
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

var people = [
    Person(name: "张三", age: 25),
    Person(name: "李四", age: 17),
    Person(name: "王五", age: 30)
]

let adults = people.filter { $0.age >= 18 }
// adults包含张三和王五对象的引用

// 修改原集合中对象的属性会影响过滤后的集合
people[0].name = "张三丰"
print(adults[0].name)  // 输出: "张三丰" - 原对象被修改</code></pre>
        </section>

        <section>
            <h2>与其他高阶函数的对比</h2>
            <p>Swift提供了多种高阶函数用于集合处理，了解它们之间的差异对于选择正确工具很重要：</p>

            <table style="width:100%; border-collapse:collapse; margin:1rem 0;">
                <tr style="background-color:var(--accent-color); color:white;">
                    <th style="padding:0.5rem; text-align:left; border:1px solid var(--border-color);">函数</th>
                    <th style="padding:0.5rem; text-align:left; border:1px solid var(--border-color);">用途</th>
                    <th style="padding:0.5rem; text-align:left; border:1px solid var(--border-color);">返回值</th>
                </tr>
                <tr>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);"><code>filter</code></td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">根据条件筛选元素</td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">原集合的子集</td>
                </tr>
                <tr>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);"><code>map</code></td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">转换集合中的每个元素</td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">转换后的新集合</td>
                </tr>
                <tr>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);"><code>reduce</code></td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">将集合合并为单个值</td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">单个聚合值</td>
                </tr>
                <tr>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);"><code>forEach</code></td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">对每个元素执行操作</td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">无返回值（Void）</td>
                </tr>
                <tr>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);"><code>compactMap</code></td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">转换并移除nil结果</td>
                    <td style="padding:0.5rem; border:1px solid var(--border-color);">非nil转换结果集合</td>
                </tr>
            </table>

            <h3>综合示例</h3>
            <pre><code>let mixedData = ["1", "two", "3", "4", "five", "6"]

// 使用filter：筛选出纯数字字符串
let numbersAsStrings = mixedData.filter { Int($0) != nil }
// ["1", "3", "4", "6"]

// 使用map：将字符串转为整数（可能产生nil）
let optionalNumbers = mixedData.map { Int($0) }
// [Optional(1), nil, Optional(3), Optional(4), nil, Optional(6)]

// 使用compactMap：转换并移除nil
let validNumbers = mixedData.compactMap { Int($0) }
// [1, 3, 4, 6]

// 使用reduce：计算总和
let sum = validNumbers.reduce(0, +)
// 14</code></pre>
        </section>

        <section>
            <h2>学习资源</h2>

            <h3>官方文档</h3>
            <div class="resource-card">
                <div class="resource-icon">📚</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://developer.apple.com/documentation/swift/array/3017530-filter" target="_blank">Swift官方文档 - Array.filter</a></div>
                    <div class="resource-description">Swift标准库中关于filter方法的官方文档</div>
                </div>
            </div>

            <div class="resource-card">
                <div class="resource-icon">🍎</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://docs.swift.org/swift-book/LanguageGuide/Closures.html" target="_blank">Swift编程语言 - 闭包</a></div>
                    <div class="resource-description">Swift官方编程语言指南中关于闭包的介绍，filter方法使用闭包作为参数</div>
                </div>
            </div>

            <h3>推荐书籍</h3>
            <div class="resource-card">
                <div class="resource-icon">📖</div>
                <div class="resource-content">
                    <div class="resource-title">《Swift进阶》 - 王巍(onevcat)</div>
                    <div class="resource-description">深入介绍Swift语言特性，包括函数式编程和高阶函数</div>
                </div>
            </div>

            <div class="resource-card">
                <div class="resource-icon">📖</div>
                <div class="resource-content">
                    <div class="resource-title">《Functional Swift》 - Chris Eidhof等</div>
                    <div class="resource-description">专注于Swift函数式编程的书籍，详细介绍了高阶函数的使用</div>
                </div>
            </div>

            <h3>优秀博客与文章</h3>
            <div class="resource-card">
                <div class="resource-icon">📝</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://www.swiftbysundell.com/articles/filtering-in-swift/" target="_blank">Swift by Sundell - Filtering in Swift</a></div>
                    <div class="resource-description">详细介绍Swift中过滤数据的各种方法和技巧</div>
                </div>
            </div>

            <div class="resource-card">
                <div class="resource-icon">📝</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://www.hackingwithswift.com/articles/148/higher-order-functions-in-swift-filter-map-and-reduce" target="_blank">Hacking with Swift - Higher-order functions: filter, map, and reduce</a></div>
                    <div class="resource-description">Paul Hudson对Swift高阶函数的详细讲解</div>
                </div>
            </div>

            <h3>开源项目</h3>
            <div class="resource-card">
                <div class="resource-icon">🧩</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a></div>
                    <div class="resource-description">ReactiveX的Swift实现，大量使用了函数式编程的概念，包括filter操作符</div>
                </div>
            </div>

            <div class="resource-card">
                <div class="resource-icon">🧩</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">The Composable Architecture</a></div>
                    <div class="resource-description">Point-Free团队开发的函数式架构库，展示了高阶函数在应用架构中的应用</div>
                </div>
            </div>

            <h3>视频教程</h3>
            <div class="resource-card">
                <div class="resource-icon">🎬</div>
                <div class="resource-content">
                    <div class="resource-title"><a href="https://www.pointfree.co" target="_blank">Point-Free - 函数式编程视频教程</a></div>
                    <div class="resource-description">专注于Swift函数式编程的高质量视频教程系列</div>
                </div>
            </div>
        </section>

        <section>
            <h2>总结</h2>
            <p><code>filter</code>作为Swift函数式编程工具箱中的重要组件，为开发者提供了一种简洁、表达力强且安全的方式来处理集合数据。通过本章的学习，我们已经掌握了：</p>

            <ul>
                <li>filter的基本原理和语法</li>
                <li>使用filter进行简单和复杂的数据筛选</li>
                <li>与其他高阶函数配合使用的方法</li>
                <li>性能优化技巧</li>
                <li>在实际应用场景中的使用方法</li>
            </ul>

            <p>对于现代Swift开发者来说，熟练使用<code>filter</code>和其他高阶函数，是提高代码质量和开发效率的关键技能。希望本章内容能够帮助您在实际项目中更自信地应用函数式编程技术。</p>
        </section>
    </div>

    <script>
        // 如果需要添加任何交互功能，可以在这里添加JavaScript代码
        document.addEventListener('DOMContentLoaded', function() {
            // 页面加载完成后执行的代码
            console.log('Swift函数式编程 - Filter方法文档已加载');
        });
    </script>
</body>
</html>
