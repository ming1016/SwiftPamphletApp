<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 字典 (Dictionary) - Apple 开发技术手册</title>
    <style>
        :root {
            --primary-color: #5a67d8;
            --secondary-color: #f687b3;
            --accent-color: #68d391;
            --background-color: #ffffff;
            --card-background: #f7fafc;
            --text-color: #2d3748;
            --code-background: #edf2f7;
            --border-color: #e2e8f0;
            --shadow-color: rgba(0, 0, 0, 0.1);
            --link-color: #4299e1;
            --highlight-color: #faf089;
            --header-gradient-start: #667eea;
            --header-gradient-end: #764ba2;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --primary-color: #7f9cf5;
                --secondary-color: #f8b4d9;
                --accent-color: #9ae6b4;
                --background-color: #1a202c;
                --card-background: #2d3748;
                --text-color: #e2e8f0;
                --code-background: #2d3748;
                --border-color: #4a5568;
                --shadow-color: rgba(0, 0, 0, 0.3);
                --link-color: #63b3ed;
                --highlight-color: #faf089;
                --header-gradient-start: #434190;
                --header-gradient-end: #553c9a;
            }
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--background-color);
            transition: background-color 0.3s ease;
            padding-bottom: 3rem;
        }
        
        header {
            background: linear-gradient(135deg, var(--header-gradient-start), var(--header-gradient-end));
            color: white;
            padding: 2rem 1rem;
            text-align: center;
            border-radius: 0 0 2rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px var(--shadow-color);
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
        }
        
        h2 {
            font-size: 1.8rem;
            margin: 2rem 0 1rem;
            color: var(--primary-color);
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
        }
        
        h3 {
            font-size: 1.4rem;
            margin: 1.5rem 0 0.75rem;
            color: var(--secondary-color);
        }
        
        p {
            margin-bottom: 1.2rem;
        }
        
        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--link-color);
            transition: all 0.2s ease;
        }
        
        a:hover {
            border-bottom: 1px solid var(--link-color);
        }
        
        pre {
            background-color: var(--code-background);
            border-radius: 0.75rem;
            padding: 1rem;
            overflow-x: auto;
            margin: 1.5rem 0;
            box-shadow: 0 2px 4px var(--shadow-color);
            border: 1px solid var(--border-color);
        }
        
        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9rem;
            color: var(--primary-color);
        }
        
        pre code {
            color: inherit;
        }
        
        .note {
            background-color: var(--card-background);
            border-left: 4px solid var(--accent-color);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 0 0.5rem 0.5rem 0;
        }
        
        .warning {
            background-color: var(--card-background);
            border-left: 4px solid var(--secondary-color);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 0 0.5rem 0.5rem 0;
        }
        
        .example-card {
            background-color: var(--card-background);
            border-radius: 1rem;
            padding: 1.5rem;
            margin: 2rem 0;
            box-shadow: 0 4px 6px var(--shadow-color);
        }
        
        .example-card h4 {
            color: var(--primary-color);
            margin-bottom: 0.75rem;
            font-size: 1.2rem;
        }
        
        .references {
            background-color: var(--card-background);
            border-radius: 1rem;
            padding: 1.5rem;
            margin: 2rem 0;
        }
        
        .tag {
            display: inline-block;
            background-color: var(--accent-color);
            color: var(--background-color);
            padding: 0.25rem 0.5rem;
            border-radius: 1rem;
            font-size: 0.8rem;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
        }
        
        .highlight {
            background-color: var(--highlight-color);
            padding: 0 0.25rem;
            border-radius: 0.25rem;
        }
        
        ul, ol {
            margin: 1rem 0 1rem 1.5rem;
        }
        
        li {
            margin-bottom: 0.5rem;
        }
        
        .key-concept {
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 1rem;
            margin: 1.5rem 0;
            background-color: var(--card-background);
        }
        
        @media (max-width: 768px) {
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
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
            border-radius: 0.5rem;
            overflow: hidden;
        }
        
        th, td {
            padding: 0.75rem;
            text-align: left;
            border: 1px solid var(--border-color);
        }
        
        th {
            background-color: var(--primary-color);
            color: white;
        }
        
        tr:nth-child(even) {
            background-color: var(--card-background);
        }
        
        .svg-container {
            text-align: center;
            margin: 2rem 0;
        }
        
        .emoji-icon {
            font-size: 1.5rem;
            vertical-align: middle;
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift 字典 (Dictionary)</h1>
        <p>高效存储键值对的集合类型</p>
    </header>
    
    <div class="container">
        <section id="introduction">
            <h2>字典简介</h2>
            <p>Swift 的字典是一种无序集合，用于存储具有相同类型的键和相同类型的值的键值对。每个值都与唯一的键相关联，作为该值在字典中的标识符。与数组不同，字典中的项没有特定的顺序。</p>
            
            <div class="svg-container">
                <svg width="500" height="220" viewBox="0 0 500 220" xmlns="http://www.w3.org/2000/svg">
                    <!-- 背景 -->
                    <rect x="50" y="20" width="400" height="180" rx="15" ry="15" fill="#f0f4f8" stroke="#a0aec0" stroke-width="2" />
                    
                    <!-- 字典标题 -->
                    <text x="250" y="45" font-family="Arial" font-size="16" text-anchor="middle" fill="#4a5568">Dictionary&lt;Key, Value&gt;</text>
                    
                    <!-- 键值对 1 -->
                    <rect x="80" y="60" width="100" height="40" rx="8" ry="8" fill="#bee3f8" stroke="#63b3ed" stroke-width="2" />
                    <text x="130" y="85" font-family="Arial" font-size="14" text-anchor="middle" fill="#2b6cb0">Key1</text>
                    
                    <line x1="190" y1="80" x2="220" y2="80" stroke="#4a5568" stroke-width="2" stroke-dasharray="5,3" />
                    
                    <rect x="230" y="60" width="100" height="40" rx="8" ry="8" fill="#feebc8" stroke="#ed8936" stroke-width="2" />
                    <text x="280" y="85" font-family="Arial" font-size="14" text-anchor="middle" fill="#c05621">Value1</text>
                    
                    <!-- 键值对 2 -->
                    <rect x="80" y="110" width="100" height="40" rx="8" ry="8" fill="#bee3f8" stroke="#63b3ed" stroke-width="2" />
                    <text x="130" y="135" font-family="Arial" font-size="14" text-anchor="middle" fill="#2b6cb0">Key2</text>
                    
                    <line x1="190" y1="130" x2="220" y2="130" stroke="#4a5568" stroke-width="2" stroke-dasharray="5,3" />
                    
                    <rect x="230" y="110" width="100" height="40" rx="8" ry="8" fill="#feebc8" stroke="#ed8936" stroke-width="2" />
                    <text x="280" y="135" font-family="Arial" font-size="14" text-anchor="middle" fill="#c05621">Value2</text>
                    
                    <!-- 键值对 3 -->
                    <rect x="80" y="160" width="100" height="40" rx="8" ry="8" fill="#bee3f8" stroke="#63b3ed" stroke-width="2" />
                    <text x="130" y="185" font-family="Arial" font-size="14" text-anchor="middle" fill="#2b6cb0">Key3</text>
                    
                    <line x1="190" y1="180" x2="220" y2="180" stroke="#4a5568" stroke-width="2" stroke-dasharray="5,3" />
                    
                    <rect x="230" y="160" width="100" height="40" rx="8" ry="8" fill="#feebc8" stroke="#ed8936" stroke-width="2" />
                    <text x="280" y="185" font-family="Arial" font-size="14" text-anchor="middle" fill="#c05621">Value3</text>
                    
                    <!-- 标记 -->
                    <rect x="350" y="110" width="80" height="40" rx="8" ry="8" fill="#e9d8fd" stroke="#805ad5" stroke-width="2" />
                    <text x="390" y="135" font-family="Arial" font-size="12" text-anchor="middle" fill="#553c9a">哈希表结构</text>
                </svg>
            </div>
            
            <div class="key-concept">
                <h3>字典的核心特性</h3>
                <ul>
                    <li><strong>键的唯一性：</strong>每个键在字典中只能出现一次</li>
                    <li><strong>键必须可哈希：</strong>Swift 中的键必须遵循 <code>Hashable</code> 协议</li>
                    <li><strong>无序集合：</strong>字典中的元素没有固定的顺序</li>
                    <li><strong>类型安全：</strong>字典中所有键必须是相同类型，所有值也必须是相同类型</li>
                </ul>
            </div>
        </section>
        
        <section id="creating-dictionaries">
            <h2>创建字典</h2>
            <p>Swift 提供了多种创建字典的方法。以下是一些常用的字典创建方式：</p>
            
            <div class="example-card">
                <h4>创建空字典</h4>
                <pre><code>// 方法1: 使用类型注解创建空字典
var emptyDictionary: [String: Int] = [:]

// 方法2: 使用字典类型的初始化语法
var otherEmptyDictionary = Dictionary&lt;String, Int&gt;()</code></pre>
            </div>
            
            <div class="example-card">
                <h4>使用字典字面量创建</h4>
                <pre><code>// 创建一个存储国家和首都的字典
var capitals = ["中国": "北京", "日本": "东京", "法国": "巴黎"]

// 使用显式类型注解
var population: [String: Int] = [
    "北京": 21893095,
    "上海": 24870895,
    "广州": 18676605
]</code></pre>
            </div>
            
            <div class="example-card">
                <h4>使用序列创建</h4>
                <pre><code>// 通过键值对数组创建字典
let cityInfo = Dictionary(uniqueKeysWithValues: [
    ("北京", "中国北部"),
    ("上海", "中国东部"),
    ("广州", "中国南部")
])

// 从两个数组创建字典
let cities = ["北京", "上海", "广州"]
let countries = ["中国", "中国", "中国"]
let cityCountry = Dictionary(uniqueKeysWithValues: zip(cities, countries))

// 使用 Dictionary(grouping:by:) 创建
let names = ["Michael", "Mary", "John", "Michelle", "Mark"]
let nameDict = Dictionary(grouping: names) { $0.first! }
// nameDict 结果: ["M": ["Michael", "Mary", "Michelle", "Mark"], "J": ["John"]]</code></pre>
            </div>
            
            <div class="note">
                <p><span class="emoji-icon">💡</span> 键必须是可哈希的类型，即实现了 <code>Hashable</code> 协议的类型。Swift 的基本类型（如 <code>String</code>、<code>Int</code>、<code>Double</code>、<code>Bool</code>）默认都是可哈希的。</p>
            </div>
        </section>
        
        <section id="accessing-modifying">
            <h2>访问和修改字典</h2>
            
            <div class="example-card">
                <h4>访问字典中的值</h4>
                <pre><code>// 创建一个学生成绩字典
var studentScores = ["小明": 85, "小红": 92, "小华": 78]

// 通过键访问值
let xiaomingScore = studentScores["小明"]  // 返回类型是 Int?，值为 85
let xiaofengScore = studentScores["小峰"]  // 返回 nil，因为键不存在

// 使用默认值访问
let xiaohongScore = studentScores["小红", default: 0]  // 返回 92
let xiaoqiangScore = studentScores["小强", default: 0]  // 返回默认值 0</code></pre>
            </div>
            
            <div class="example-card">
                <h4>修改字典中的值</h4>
                <pre><code>// 更新现有值
studentScores["小明"] = 90
print(studentScores["小明"]!)  // 输出: 90

// 添加新的键值对
studentScores["小芳"] = 88
print(studentScores)  // 包含新增的键值对

// 使用 updateValue(_:forKey:) 方法更新
// 这个方法返回更新前的旧值（如果存在）
if let oldScore = studentScores.updateValue(95, forKey: "小红") {
    print("小红的旧分数是 \(oldScore)")  // 输出: 小红的旧分数是 92
}

// 对不存在的键使用 updateValue
if let oldScore = studentScores.updateValue(79, forKey: "小刚") {
    print("小刚的旧分数是 \(oldScore)")  // 不会执行，因为之前不存在"小刚"的记录
} else {
    print("添加了小刚的成绩记录")  // 输出: 添加了小刚的成绩记录
}</code></pre>
            </div>
            
            <div class="example-card">
                <h4>删除键值对</h4>
                <pre><code>// 通过将值设为 nil 来删除键值对
studentScores["小华"] = nil
print(studentScores["小华"])  // 输出: nil

// 使用 removeValue(forKey:) 方法删除键值对
// 返回被删除的值，如果键不存在则返回 nil
if let removedScore = studentScores.removeValue(forKey: "小芳") {
    print("移除了小芳的分数: \(removedScore)")  // 输出: 移除了小芳的分数: 88
}

// 清空整个字典
studentScores.removeAll()
print(studentScores)  // 输出: [:]

// 带选项的 removeAll
var bigDictionary = ["a": 1, "b": 2, "c": 3]
// keepingCapacity: true 表示保留已分配的内存空间，适用于要再次填充字典的情况
bigDictionary.removeAll(keepingCapacity: true)</code></pre>
            </div>
        </section>
        
        <section id="iterating">
            <h2>迭代字典</h2>
            
            <div class="example-card">
                <h4>遍历所有键值对</h4>
                <pre><code>let fruitCounts = ["苹果": 5, "橘子": 10, "香蕉": 3]

// 迭代字典中的所有键值对
for (fruit, count) in fruitCounts {
    print("\(fruit): \(count)个")
}

// 使用元组解构
for pair in fruitCounts {
    print("\(pair.key): \(pair.value)个")
}</code></pre>
            </div>
            
            <div class="example-card">
                <h4>单独访问键或值</h4>
                <pre><code>// 只遍历键
for fruit in fruitCounts.keys {
    print(fruit)
}

// 只遍历值
for count in fruitCounts.values {
    print(count)
}

// 将键或值转换为数组
let fruits = Array(fruitCounts.keys)   // ["苹果", "橘子", "香蕉"]
let counts = Array(fruitCounts.values) // [5, 10, 3]

// 对键或值排序遍历
for fruit in fruitCounts.keys.sorted() {
    print("\(fruit): \(fruitCounts[fruit]!)个")
}</code></pre>
            </div>
            
            <div class="note">
                <p><span class="emoji-icon">⚠️</span> 字典是无序集合，迭代字典的键值对时，它们的顺序是不确定的。如果需要按特定顺序处理键值对，应先对键或值进行排序。</p>
            </div>
        </section>
        
        <section id="dictionary-operations">
            <h2>字典操作</h2>
            
            <div class="example-card">
                <h4>合并字典</h4>
                <pre><code>var baseSettings = ["主题": "明亮", "字体大小": "中等"]
let overrideSettings = ["字体大小": "大", "声音": "开启"]

// 使用 merge 方法合并，对于重复的键采用新值
baseSettings.merge(overrideSettings) { (current, new) in current }
print(baseSettings)  // ["主题": "明亮", "字体大小": "中等", "声音": "开启"]

// 重置并使用新值覆盖
baseSettings = ["主题": "明亮", "字体大小": "中等"]
baseSettings.merge(overrideSettings) { (_, new) in new }
print(baseSettings)  // ["主题": "明亮", "字体大小": "大", "声音": "开启"]

// merging 方法创建新字典而不修改原字典
baseSettings = ["主题": "明亮", "字体大小": "中等"]
let newSettings = baseSettings.merging(overrideSettings) { (_, new) in new }
print(newSettings)   // ["主题": "明亮", "字体大小": "大", "声音": "开启"]
print(baseSettings)  // ["主题": "明亮", "字体大小": "中等"]</code></pre>
            </div>
            
            <div class="example-card">
                <h4>过滤字典</h4>
                <pre><code>let scores = ["Amy": 85, "Bill": 92, "Charles": 78, "David": 65]

// 过滤出分数高于80的学生
let highScorers = scores.filter { (_, score) in score > 80 }
print(highScorers)  // ["Bill": 92, "Amy": 85]

// 过滤名字以B开头的学生
let bStudents = scores.filter { (name, _) in name.hasPrefix("B") }
print(bStudents)  // ["Bill": 92]</code></pre>
            </div>
            
            <div class="example-card">
                <h4>转换字典</h4>
                <pre><code>// 使用 mapValues 转换值
let stringScores = scores.mapValues { score in 
    return "得分: \(score)"
}
print(stringScores)  // ["Amy": "得分: 85", "Bill": "得分: 92", ...]

// 使用 compactMapValues 过滤掉为 nil 的转换结果
let passedStudents = scores.compactMapValues { score in 
    score >= 70 ? score : nil
}
print(passedStudents)  // ["Amy": 85, "Bill": 92, "Charles": 78]</code></pre>
            </div>
        </section>
        
        <section id="performance">
            <h2>性能考量</h2>
            
            <div class="svg-container">
                <svg width="500" height="250" viewBox="0 0 500 250" xmlns="http://www.w3.org/2000/svg">
                    <rect x="50" y="20" width="400" height="210" rx="10" ry="10" fill="#edf2f7" stroke="#a0aec0" stroke-width="2" />
                    
                    <text x="250" y="45" font-family="Arial" font-size="16" text-anchor="middle" font-weight="bold" fill="#4a5568">字典操作时间复杂度</text>
                    
                    <!-- 表格背景 -->
                    <rect x="80" y="60" width="340" height="150" fill="#fff" stroke="#cbd5e0" stroke-width="1" />
                    
                    <!-- 表头 -->
                    <rect x="80" y="60" width="170" height="30" fill="#4299e1" stroke="#2b6cb0" stroke-width="1" />
                    <rect x="250" y="60" width="170" height="30" fill="#4299e1" stroke="#2b6cb0" stroke-width="1" />
                    
                    <text x="165" y="80" font-family="Arial" font-size="14" text-anchor="middle" fill="white">操作</text>
                    <text x="335" y="80" font-family="Arial" font-size="14" text-anchor="middle" fill="white">平均时间复杂度</text>
                    
                    <!-- 行 1 -->
                    <rect x="80" y="90" width="170" height="30" fill="#ebf8ff" stroke="#cbd5e0" stroke-width="1" />
                    <rect x="250" y="90" width="170" height="30" fill="#ebf8ff" stroke="#cbd5e0" stroke-width="1" />
                    
                    <text x="165" y="110" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">查找元素</text>
                    <text x="335" y="110" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">O(1)</text>
                    
                    <!-- 行 2 -->
                    <rect x="80" y="120" width="170" height="30" fill="white" stroke="#cbd5e0" stroke-width="1" />
                    <rect x="250" y="120" width="170" height="30" fill="white" stroke="#cbd5e0" stroke-width="1" />
                    
                    <text x="165" y="140" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">插入元素</text>
                    <text x="335" y="140" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">O(1)</text>
                    
                    <!-- 行 3 -->
                    <rect x="80" y="150" width="170" height="30" fill="#ebf8ff" stroke="#cbd5e0" stroke-width="1" />
                    <rect x="250" y="150" width="170" height="30" fill="#ebf8ff" stroke="#cbd5e0" stroke-width="1" />
                    
                    <text x="165" y="170" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">删除元素</text>
                    <text x="335" y="170" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">O(1)</text>
                    
                    <!-- 行 4 -->
                    <rect x="80" y="180" width="170" height="30" fill="white" stroke="#cbd5e0" stroke-width="1" />
                    <rect x="250" y="180" width="170" height="30" fill="white" stroke="#cbd5e0" stroke-width="1" />
                    
                    <text x="165" y="200" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">迭代所有元素</text>
                    <text x="335" y="200" font-family="Arial" font-size="12" text-anchor="middle" fill="#2d3748">O(n)</text>
                </svg>
            </div>
            
            <p>Swift 的字典是基于哈希表实现的，所以具有以下性能特点：</p>
            
            <ul>
                <li>查找、插入和删除操作的平均时间复杂度是常数时间 O(1)</li>
                <li>最坏情况下（哈希冲突严重时）可能退化到 O(n)</li>
                <li>空间复杂度通常高于数组，因为需要存储键和哈希值</li>
            </ul>
            
            <div class="warning">
                <h4>键的哈希性能影响</h4>
                <p>自定义类型作为字典键时，其哈希函数的实现质量会显著影响字典的性能。良好的哈希函数应当使不同对象生成不同的哈希值，并且计算速度要快。</p>
            </div>
        </section>
        
        <section id="custom-types-as-keys">
            <h2>自定义类型作为键</h2>
            
            <div class="example-card">
                <h4>让自定义类型成为字典的键</h4>
                <pre><code>// 自定义结构体作为字典键，需要实现 Hashable 协议
struct User: Hashable {
    var id: Int
    var name: String
    
    // Swift 5.0+ 自动合成 Hashable 的实现
    // 如果需要自定义哈希方法：
    func hash(into hasher: inout Hasher) {
        // 只使用 id 作为哈希的依据，因为它是唯一标识符
        hasher.combine(id)
    }
    
    // 如果需要自定义相等性检查：
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

// 使用 User 作为字典的键
var userRoles: [User: String] = [
    User(id: 1, name: "张三"): "管理员",
    User(id: 2, name: "李四"): "编辑",
    User(id: 3, name: "王五"): "访客"
]

let user = User(id: 1, name: "张三")
print(userRoles[user] ?? "未知角色")  // 输出: "管理员"

// 即使名称不同，具有相同 id 的 User 也被视为相等
let sameUser = User(id: 1, name: "张三 (改名)")
print(userRoles[sameUser] ?? "未知角色")  // 输出: "管理员"</code></pre>
            </div>
            
            <div class="note">
                <p>从 Swift 4.1 开始，对于遵循 <code>Hashable</code> 协议的自定义类型，如果其所有存储属性也都遵循 <code>Hashable</code>，编译器会自动合成 <code>hash(into:)</code> 和 <code>==</code> 方法的实现。</p>
            </div>
        </section>
        
        <section id="advanced-techniques">
            <h2>高级技巧</h2>
            
            <div class="example-card">
                <h4>嵌套字典</h4>
                <pre><code>// 创建一个嵌套字典，表示城市和各城市的地标信息
var cityLandmarks: [String: [String: String]] = [
    "北京": [
        "故宫": "中国古代宫廷建筑",
        "长城": "世界文化遗产",
        "天坛": "明清两代皇帝祭天场所"
    ],
    "上海": [
        "东方明珠": "上海的标志性建筑",
        "外滩": "万国建筑博览群",
        "豫园": "明代古典园林"
    ]
]

// 访问嵌套字典中的值
if let beijingLandmarks = cityLandmarks["北京"],
   let forbiddenCity = beijingLandmarks["故宫"] {
    print("北京故宫: \(forbiddenCity)")  // 输出: 北京故宫: 中国古代宫廷建筑
}

// 更新嵌套字典中的值
cityLandmarks["北京"]?["天坛"] = "北京著名的祭祀建筑"

// 添加新的嵌套信息
cityLandmarks["广州"] = [
    "白云山": "广州市最高峰",
    "陈家祠": "清代建筑"
]</code></pre>
            </div>
            
            <div class="example-card">
                <h4>字典和数组组合使用</h4>
                <pre><code>// 创建一个字典，其值是数组
var userPreferences: [String: [String]] = [
    "小明": ["足球", "篮球", "游泳"],
    "小红": ["绘画", "舞蹈"],
    "小华": ["阅读", "编程", "象棋"]
]

// 访问和修改数组值
if var xiaomingPreferences = userPreferences["小明"] {
    xiaomingPreferences.append("网球")
    userPreferences["小明"] = xiaomingPreferences
    print(userPreferences["小明"] ?? [])  // ["足球", "篮球", "游泳", "网球"]
}

// 更简单的方法
userPreferences["小红"]?.append("钢琴")
print(userPreferences["小红"] ?? [])  // ["绘画", "舞蹈", "钢琴"]

// 使用字典存储对象数组
struct Book {
    var title: String
    var author: String
    var year: Int
}

var libraryByCategory: [String: [Book]] = [
    "科幻": [
        Book(title: "三体", author: "刘慈欣", year: 2008),
        Book(title: "银河帝国", author: "阿西莫夫", year: 1951)
    ],
    "历史": [
        Book(title: "明朝那些事", author: "当年明月", year: 2006)
    ]
]

// 添加新书
let newBook = Book(title: "流浪地球", author: "刘慈欣", year: 2000)
libraryByCategory["科幻"]?.append(newBook)

// 遍历科幻类别的所有书籍
if let scifiBooks = libraryByCategory["科幻"] {
    for book in scifiBooks {
        print("\(book.title) - \(book.author) (\(book.year))")
    }
}</code></pre>
            </div>
            
            <div class="example-card">
                <h4>使用字典作为缓存</h4>
                <pre><code>// 创建一个简单的缓存类
class SimpleCache&lt;Key: Hashable, Value&gt; {
    private var storage: [Key: Value] = [:]
    private var accessCount: [Key: Int] = [:]
    
    func setValue(_ value: Value, forKey key: Key) {
        storage[key] = value
        accessCount[key] = 0
    }
    
    func getValue(forKey key: Key) -> Value? {
        if let value = storage[key] {
            accessCount[key, default: 0] += 1
            return value
        }
        return nil
    }
    
    func getMostAccessedKey() -> Key? {
        return accessCount.max { $0.value < $1.value }?.key
    }
    
    func removeValue(forKey key: Key) {
        storage.removeValue(forKey: key)
        accessCount.removeValue(forKey: key)
    }
}

// 使用缓存
let cache = SimpleCache&lt;String, String&gt;()
cache.setValue("www.example.com/image1.jpg", forKey: "image1")
cache.setValue("www.example.com/image2.jpg", forKey: "image2")

// 访问缓存
for _ in 1...5 {
    _ = cache.getValue(forKey: "image1")
}
for _ in 1...3 {
    _ = cache.getValue(forKey: "image2")
}

// 获取最常访问的键
if let mostAccessed = cache.getMostAccessedKey() {
    print("最常访问的是: \(mostAccessed)")  // 输出: 最常访问的是: image1
}</code></pre>
            </div>
        </section>
        
        <section id="best-practices">
            <h2>最佳实践</h2>
            
            <div class="key-concept">
                <h3>使用字典的建议</h3>
                <ul>
                    <li><strong>合理处理可能不存在的键：</strong> 使用可选绑定或默认值来处理nil结果</li>
                    <li><strong>选择合适的键类型：</strong> 选择有意义且唯一的键，并确保它们是可哈希的</li>
                    <li><strong>避免频繁增删操作：</strong> 大量增删操作可能导致哈希表重新平衡，影响性能</li>
                    <li><strong>预分配空间：</strong> 如果预先知道字典的大小，可以使用预分配容量来提高性能</li>
                    <li><strong>考虑值语义：</strong> 字典是值类型，在传递时会被复制，注意性能影响</li>
                </ul>
            </div>
            
            <div class="example-card">
                <h4>预分配容量</h4>
                <pre><code>// 为大字典预分配容量，减少重新哈希操作
var largeDict = Dictionary&lt;String, Int&gt;(minimumCapacity: 1000)</code></pre>
            </div>
            
            <div class="example-card">
                <h4>安全访问字典值</h4>
                <pre><code>let users = ["user1": "张三", "user2": "李四"]

// 不推荐: 强制解包可能导致崩溃
// let user = users["user3"]!  // 崩溃!

// 推荐方式1: 使用可选绑定
if let user = users["user3"] {
    print("用户名: \(user)")
} else {
    print("用户不存在")
}

// 推荐方式2: 使用空合并运算符提供默认值
let user = users["user3"] ?? "未知用户"
print("用户名: \(user)")  // 输出: 用户名: 未知用户

// 推荐方式3: 使用 default 参数
let userName = users["user3", default: "未知用户"]</code></pre>
            </div>
            
            <div class="example-card">
                <h4>字典变换与链式操作</h4>
                <pre><code>let rawScores = ["小明": "85", "小红": "92", "小华": "78", "小强": "invalid"]

// 将字符串分数转换为整数并过滤无效值
let validScores = rawScores.compactMapValues { Int($0) }
print(validScores)  // ["小明": 85, "小红": 92, "小华": 78]

// 链式操作: 过滤然后转换
let highScorersFormatted = rawScores
    .compactMapValues { Int($0) }  // 转换为整数并过滤无效值
    .filter { $0.value >= 80 }     // 只保留高分
    .mapValues { "\($0)分 - 优秀" } // 格式化
print(highScorersFormatted)  // ["小明": "85分 - 优秀", "小红": "92分 - 优秀"]</code></pre>
            </div>
        </section>
        
        <section id="references">
            <h2>参考资料</h2>
            <div class="references">
                <h3>官方文档</h3>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html#ID113" target="_blank">Swift 官方文档 - 集合类型 (字典)</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift/dictionary" target="_blank">Swift API 文档 - Dictionary</a></li>
                </ul>
                
                <h3>推荐书籍</h3>
                <ul>
                    <li>《Swift 进阶》- 王巍 (书中有专门讨论字典实现和性能的章节)</li>
                    <li>《Swift 编程权威指南》(The Swift Programming Language) - Apple Inc.</li>
                    <li>《Pro Swift》- Paul Hudson (包含字典的高级用法)</li>
                </ul>
                
                <h3>优秀博客文章</h3>
                <ul>
                    <li><a href="https://www.hackingwithswift.com/articles/109/how-to-use-dictionaries-in-swift" target="_blank">How to use dictionaries in Swift - Hacking with Swift</a></li>
                    <li><a href="https://www.swiftbysundell.com/articles/dictionaries-default-values-keypaths-and-type-safety/" target="_blank">Dictionaries, Default Values, KeyPaths and Type Safety - Swift by Sundell</a></li>
                    <li><a href="https://nshipster.com/dictionary/" target="_blank">Dictionary in Swift - NSHipster</a></li>
                </ul>
                
                <h3>视频教程</h3>
                <ul>
                    <li><a href="https://www.youtube.com/watch?v=yJnTbum7jYs" target="_blank">Understanding Swift Collections - WWDC</a></li>
                    <li><a href="https://www.raywenderlich.com/video-tutorials" target="_blank">raywenderlich.com Swift 视频教程</a></li>
                </ul>
                
                <h3>相关开源项目</h3>
                <ul>
                    <li><a href="https://github.com/apple/swift-collections" target="_blank">Swift Collections - Apple</a> - 提供额外的集合类型实现</li>
                    <li><a href="https://github.com/attaswift/BTree" target="_blank">BTree - attaswift</a> - 高效的有序字典实现</li>
                    <li><a href="https://github.com/khawars/KTCenterFlowLayout" target="_blank">Ordered Dictionary - SwiftLint</a> - SwiftLint 中的有序字典实现</li>
                </ul>
            </div>
        </section>
    </div>
    
    <script>
        // 可添加一些交互功能，如代码示例切换、暗黑模式手动切换等
        document.addEventListener('DOMContentLoaded', function() {
            // 在这里添加页面交互逻辑
        });
    </script>
</body>
</html>
