<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 集合 - Sets</title>
    <style>
        :root {
            --bg-color: #F9EEE2;
            --text-color: #2A363B;
            --code-bg: #F7C9AA;
            --accent-color: #C5E0D8;
            --secondary-color: #D9D9D9;
            --border-color: #2A363B;
            --link-color: #2A363B;
            --link-hover: #F7C9AA;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --bg-color: #2A363B;
                --text-color: #F9EEE2;
                --code-bg: #3A464B;
                --accent-color: #C5E0D8;
                --secondary-color: #4A565B;
                --border-color: #C5E0D8;
                --link-color: #C5E0D8;
                --link-hover: #F7C9AA;
            }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        header {
            margin-bottom: 3rem;
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 1rem;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }

        h2 {
            font-size: 2rem;
            margin: 2rem 0 1rem;
            color: var(--text-color);
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 0.5rem;
        }

        h3 {
            font-size: 1.5rem;
            margin: 1.5rem 0 1rem;
            color: var(--text-color);
        }

        p {
            margin-bottom: 1rem;
            text-align: justify;
        }

        pre {
            background-color: var(--code-bg);
            padding: 1rem;
            border-radius: 5px;
            overflow-x: auto;
            margin: 1rem 0;
            border-left: 4px solid var(--accent-color);
        }

        code {
            font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
            font-size: 0.9rem;
            color: var(--text-color);
        }

        .note {
            background-color: var(--accent-color);
            padding: 1rem;
            border-radius: 5px;
            margin: 1rem 0;
        }

        .diagram {
            max-width: 100%;
            margin: 1.5rem auto;
            display: block;
        }

        .resource-list {
            list-style-type: none;
        }

        .resource-list li {
            margin-bottom: 0.5rem;
            padding-left: 1rem;
            border-left: 2px solid var(--accent-color);
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px solid var(--accent-color);
            transition: all 0.2s ease;
        }

        a:hover {
            color: var(--link-hover);
            border-bottom-color: var(--link-hover);
        }

        .example-container {
            background-color: var(--secondary-color);
            border-radius: 5px;
            padding: 1.5rem;
            margin: 1.5rem 0;
        }

        .two-column {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        @media (max-width: 768px) {
            .two-column {
                grid-template-columns: 1fr;
            }
            
            body {
                padding: 1rem;
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
        }

        th, td {
            border: 1px solid var(--border-color);
            padding: 0.75rem;
            text-align: left;
        }

        th {
            background-color: var(--accent-color);
        }

        .tag {
            display: inline-block;
            background-color: var(--accent-color);
            padding: 0.2rem 0.5rem;
            border-radius: 3px;
            margin-right: 0.5rem;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift 集合 - Sets</h1>
        <p>Swift中的集合类型解析及最佳实践 - 集合(Set)篇</p>
    </header>

    <section id="introduction">
        <h2>Sets 简介</h2>
        <p>Set是Swift中用于存储相同类型且唯一值的无序集合。它是基于哈希表实现的，提供了高效的查找、插入和删除操作。</p>
        
        <div class="note">
            <p><strong>集合的关键特性:</strong></p>
            <ul>
                <li>无序集合 - 元素没有特定的顺序</li>
                <li>元素唯一 - 不允许重复值</li>
                <li>元素必须是可哈希的 - 遵循Hashable协议</li>
                <li>O(1)时间复杂度的查找、插入和删除操作</li>
            </ul>
        </div>

        <svg class="diagram" width="600" height="300" viewBox="0 0 600 300">
            <style>
                @media (prefers-color-scheme: dark) {
                    .set-diagram text { fill: #F9EEE2; }
                    .set-diagram .box { stroke: #C5E0D8; }
                    .set-diagram .arrow { stroke: #C5E0D8; }
                }
            </style>
            <g class="set-diagram">
                <rect class="box" x="50" y="50" width="500" height="200" rx="10" ry="10" fill="none" stroke="#2A363B" stroke-width="2"/>
                <text x="275" y="30" text-anchor="middle" font-size="18" fill="#2A363B">Swift Set</text>
                
                <!-- 哈希表示意图 -->
                <rect x="100" y="80" width="80" height="40" fill="#C5E0D8" rx="5" ry="5"/>
                <text x="140" y="105" text-anchor="middle" font-size="14" fill="#2A363B">"Apple"</text>
                
                <rect x="230" y="80" width="80" height="40" fill="#C5E0D8" rx="5" ry="5"/>
                <text x="270" y="105" text-anchor="middle" font-size="14" fill="#2A363B">"Banana"</text>
                
                <rect x="360" y="80" width="80" height="40" fill="#C5E0D8" rx="5" ry="5"/>
                <text x="400" y="105" text-anchor="middle" font-size="14" fill="#2A363B">"Orange"</text>
                
                <rect x="100" y="170" width="80" height="40" fill="#C5E0D8" rx="5" ry="5"/>
                <text x="140" y="195" text-anchor="middle" font-size="14" fill="#2A363B">"Grape"</text>
                
                <rect x="230" y="170" width="80" height="40" fill="#C5E0D8" rx="5" ry="5"/>
                <text x="270" y="195" text-anchor="middle" font-size="14" fill="#2A363B">"Melon"</text>
                
                <!-- 哈希特性 -->
                <text x="500" y="100" text-anchor="middle" font-size="12" fill="#2A363B">无序</text>
                <text x="500" y="130" text-anchor="middle" font-size="12" fill="#2A363B">唯一</text>
                <text x="500" y="160" text-anchor="middle" font-size="12" fill="#2A363B">可哈希</text>
                <text x="500" y="190" text-anchor="middle" font-size="12" fill="#2A363B">高效查询</text>
            </g>
        </svg>
    </section>

    <section id="creating-sets">
        <h2>创建和初始化Sets</h2>
        
        <p>Swift中有多种方式可以创建和初始化Set集合：</p>
        
        <div class="example-container">
            <h3>基本创建方法</h3>
            <pre><code>// 使用数组字面量创建Set
let fruitsSet: Set&lt;String&gt; = ["Apple", "Orange", "Banana"]

// 使用Set初始化器
let numbersSet = Set&lt;Int&gt;([1, 2, 3, 4, 5])

// 创建空Set
var emptySet = Set&lt;Double&gt;()

// 类型推断
var inferredSet: Set = ["Swift", "Objective-C", "C++"]</code></pre>
            
            <p><strong>运行结果:</strong></p>
            <pre><code>fruitsSet: {"Orange", "Apple", "Banana"} // 输出顺序可能不同，因为Set是无序的
numbersSet: {5, 2, 3, 1, 4} // 输出顺序可能不同
emptySet: {}
inferredSet: {"C++", "Swift", "Objective-C"} // 输出顺序可能不同</code></pre>
        </div>
        
        <div class="example-container">
            <h3>使用范围和序列创建</h3>
            <pre><code>// 使用范围创建
let rangeSet = Set(1...5) // 包含1,2,3,4,5的Set

// 使用序列创建
let sequenceSet = Set(stride(from: 0, to: 10, by: 2)) // 包含0,2,4,6,8的Set

// 使用字符串字符创建字符集
let characterSet = Set("Hello Swift".unicodeScalars) // 包含"Hello Swift"中所有唯一字符的集合</code></pre>
            
            <p><strong>运行结果:</strong></p>
            <pre><code>rangeSet: {5, 2, 3, 1, 4} // 输出顺序可能不同
sequenceSet: {6, 0, 8, 4, 2} // 输出顺序可能不同
characterSet: {"H", "e", "l", "o", " ", "S", "w", "i", "f", "t"} // 注意"l"只出现一次</code></pre>
        </div>
    </section>

    <section id="basic-operations">
        <h2>Set的基本操作</h2>
        
        <div class="two-column">
            <div>
                <h3>添加与删除元素</h3>
                <div class="example-container">
                    <pre><code>var programmingLanguages: Set&lt;String&gt; = ["Swift", "Objective-C"]

// 添加元素
programmingLanguages.insert("Java") // 返回(inserted: true, memberAfterInsert: "Java")
programmingLanguages.insert("Swift") // 重复元素，返回(inserted: false, memberAfterInsert: "Swift")

// 删除元素
let removedLanguage = programmingLanguages.remove("Objective-C") // 返回"Objective-C"
let nonExistentResult = programmingLanguages.remove("C++") // 返回nil

// 删除所有元素
programmingLanguages.removeAll() // 现在集合为空</code></pre>
                </div>
            </div>
            
            <div>
                <h3>检查与访问</h3>
                <div class="example-container">
                    <pre><code>let colors: Set&lt;String&gt; = ["Red", "Green", "Blue"]

// 检查是否包含某元素
let containsRed = colors.contains("Red") // true
let containsYellow = colors.contains("Yellow") // false

// 访问元素（因为Set是无序的，所以使用迭代）
for color in colors {
    print(color)
}

// 检查Set是否为空
let isEmpty = colors.isEmpty // false

// 获取元素数量
let count = colors.count // 3

// 获取随机元素
let randomColor = colors.randomElement() // 随机返回一个颜色，或为空集合时返回nil</code></pre>
                </div>
            </div>
        </div>

        <h3>转换与排序</h3>
        <div class="example-container">
            <pre><code>let numberSet: Set&lt;Int&gt; = [3, 1, 5, 2, 4]

// 转换为数组（无序）
let numberArray = Array(numberSet) // [5, 2, 3, 1, 4] (顺序可能不同)

// 转换为有序数组
let sortedNumbers = numberSet.sorted() // [1, 2, 3, 4, 5]

// 使用自定义排序
let descendingNumbers = numberSet.sorted(by: >) // [5, 4, 3, 2, 1]

// 映射操作
let squaredNumbers = numberSet.map { $0 * $0 } // [25, 4, 9, 1, 16] (顺序可能不同)

// 过滤操作
let evenNumbers = numberSet.filter { $0 % 2 == 0 } // [2, 4] (顺序可能不同)</code></pre>
        </div>
    </section>

    <section id="set-operations">
        <h2>集合操作</h2>
        
        <p>Set类型提供了强大的数学集合操作，使其成为处理集合关系的理想选择。</p>
        
        <svg class="diagram" width="600" height="380" viewBox="0 0 600 380">
            <style>
                @media (prefers-color-scheme: dark) {
                    .venn-diagram text { fill: #F9EEE2; }
                    .venn-diagram circle { stroke: #C5E0D8; }
                    .venn-diagram .label { fill: #F9EEE2; }
                }
            </style>
            <g class="venn-diagram">
                <!-- 集合A和B的韦恩图 -->
                <circle cx="200" cy="140" r="100" fill-opacity="0.5" fill="#C5E0D8" stroke="#2A363B" stroke-width="2"/>
                <circle cx="320" cy="140" r="100" fill-opacity="0.5" fill="#F7C9AA" stroke="#2A363B" stroke-width="2"/>
                
                <text x="160" y="140" text-anchor="middle" class="label" font-size="16" fill="#2A363B">A</text>
                <text x="360" y="140" text-anchor="middle" class="label" font-size="16" fill="#2A363B">B</text>
                <text x="260" y="140" text-anchor="middle" class="label" font-size="16" fill="#2A363B">A∩B</text>
                
                <!-- 集合运算图示 -->
                <text x="90" y="280" text-anchor="middle" font-size="14" fill="#2A363B">并集 (A∪B)</text>
                <text x="240" y="280" text-anchor="middle" font-size="14" fill="#2A363B">交集 (A∩B)</text>
                <text x="390" y="280" text-anchor="middle" font-size="14" fill="#2A363B">差集 (A-B)</text>
                <text x="520" y="280" text-anchor="middle" font-size="14" fill="#2A363B">对称差 (A△B)</text>
                
                <circle cx="90" cy="330" r="30" fill-opacity="0.5" fill="#C5E0D8" stroke="#2A363B" stroke-width="2"/>
                <circle cx="120" cy="330" r="30" fill-opacity="0.5" fill="#F7C9AA" stroke="#2A363B" stroke-width="2"/>
                
                <circle cx="220" cy="330" r="30" fill-opacity="0.5" fill="#C5E0D8" stroke="#2A363B" stroke-width="2"/>
                <circle cx="260" cy="330" r="30" fill-opacity="0.5" fill="#F7C9AA" stroke="#2A363B" stroke-width="2"/>
                <circle cx="240" cy="330" r="15" fill="#2A363B" stroke="none"/>
                
                <circle cx="370" cy="330" r="30" fill-opacity="0.5" fill="#C5E0D8" stroke="#2A363B" stroke-width="2"/>
                <circle cx="410" cy="330" r="30" fill-opacity="0.5" fill="#F7C9AA" stroke="#2A363B" stroke-width="2"/>
                <path d="M395,330 a15,15 0 0,0 30,0 a15,15 0 0,0 -30,0" fill="#F7C9AA" stroke="none"/>
                
                <circle cx="500" cy="330" r="30" fill-opacity="0.5" fill="#C5E0D8" stroke="#2A363B" stroke-width="2"/>
                <circle cx="540" cy="330" r="30" fill-opacity="0.5" fill="#F7C9AA" stroke="#2A363B" stroke-width="2"/>
                <circle cx="520" cy="330" r="15" fill="#D9D9D9" stroke="none"/>
            </g>
        </svg>
        
        <div class="example-container">
            <h3>基本集合操作</h3>
            <pre><code>let setA: Set&lt;Int&gt; = [1, 2, 3, 4, 5]
let setB: Set&lt;Int&gt; = [3, 4, 5, 6, 7]

// 并集 (Union) - 包含两个集合中所有的元素
let union = setA.union(setB) // {1, 2, 3, 4, 5, 6, 7}

// 交集 (Intersection) - 只包含同时存在于两个集合中的元素
let intersection = setA.intersection(setB) // {3, 4, 5}

// 差集 (Subtracting) - 包含只在第一个集合中存在的元素
let difference = setA.subtracting(setB) // {1, 2}

// 对称差 (Symmetric Difference) - 包含只在一个集合中存在的元素
let symmetricDifference = setA.symmetricDifference(setB) // {1, 2, 6, 7}</code></pre>
        </div>
        
        <div class="example-container">
            <h3>集合关系操作</h3>
            <pre><code>let superSet: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let subSet: Set = [3, 5, 7]
let disjointSet: Set = [11, 12, 13]
let overlappingSet: Set = [5, 6, 7, 11]

// 检查是否为子集
let isSubset = subSet.isSubset(of: superSet) // true
let isStrictSubset = subSet.isStrictSubset(of: superSet) // true（严格子集：子集且不相等）

// 检查是否为超集
let isSuperSet = superSet.isSuperset(of: subSet) // true
let isStrictSuperSet = superSet.isStrictSuperset(of: subSet) // true（严格超集：超集且不相等）

// 检查是否没有交集
let isDisjoint = superSet.isDisjoint(with: disjointSet) // true
let isNotDisjoint = superSet.isDisjoint(with: overlappingSet) // false</code></pre>
        </div>
        
        <div class="example-container">
            <h3>原地修改集合操作</h3>
            <pre><code>var mutableSet: Set = [1, 2, 3, 4, 5]
let otherSet: Set = [4, 5, 6, 7]

// 原地并集
mutableSet.formUnion(otherSet) // mutableSet现在为{1, 2, 3, 4, 5, 6, 7}

// 重置集合
mutableSet = [1, 2, 3, 4, 5]

// 原地交集
mutableSet.formIntersection(otherSet) // mutableSet现在为{4, 5}

// 重置集合
mutableSet = [1, 2, 3, 4, 5]

// 原地差集
mutableSet.subtract(otherSet) // mutableSet现在为{1, 2, 3}

// 重置集合
mutableSet = [1, 2, 3, 4, 5]

// 原地对称差
mutableSet.formSymmetricDifference(otherSet) // mutableSet现在为{1, 2, 3, 6, 7}</code></pre>
        </div>
    </section>

    <section id="hashable-protocol">
        <h2>Hashable协议</h2>
        
        <p>Set中的元素必须遵循Hashable协议，这是集合能够高效工作的基础。</p>
        
        <div class="example-container">
            <h3>自定义类型作为Set元素</h3>
            <pre><code>// 自定义类型需要遵循Hashable协议才能存储在Set中
struct Person: Hashable {
    let id: Int
    let name: String
    
    // 实现hash(into:)方法 (Swift 4.2+)
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)  // 只使用id来计算哈希值
    }
    
    // 实现==操作符
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}

// 使用自定义类型创建Set
var personSet = Set&lt;Person&gt;()
personSet.insert(Person(id: 1, name: "Alice"))
personSet.insert(Person(id: 2, name: "Bob"))
personSet.insert(Person(id: 1, name: "Charlie")) // 不会被添加，因为id相同

// personSet现在包含两个元素，id为1的Charlie没有被添加进去
print("Set contains \(personSet.count) people")</code></pre>
            <p><strong>运行结果:</strong></p>
            <pre><code>Set contains 2 people</code></pre>
        </div>
        
        <div class="note">
            <p><strong>重要提示:</strong> 对于自定义类型，确保：</p>
            <ul>
                <li>hash(into:)方法应当考虑对象标识所必需的所有属性</li>
                <li>一致性原则：如果两个对象相等(==)，它们必须有相同的哈希值</li>
                <li>哈希值相同的对象不一定相等，但相等的对象哈希值必须相同</li>
                <li>对于作为哈希键的属性，修改后可能导致集合操作异常</li>
            </ul>
        </div>
    </section>

    <section id="performance">
        <h2>性能特性</h2>
        
        <p>Set的性能特性使它在许多场景下成为数组的理想替代品：</p>
        
        <table>
            <thead>
                <tr>
                    <th>操作</th>
                    <th>Set</th>
                    <th>Array</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>查找元素</td>
                    <td>O(1) - 常量时间</td>
                    <td>O(n) - 线性时间</td>
                </tr>
                <tr>
                    <td>插入元素</td>
                    <td>O(1) - 平均常量时间</td>
                    <td>O(1) - 在末尾; O(n) - 在中间</td>
                </tr>
                <tr>
                    <td>删除元素</td>
                    <td>O(1) - 平均常量时间</td>
                    <td>O(n) - 线性时间</td>
                </tr>
                <tr>
                    <td>唯一性检查</td>
                    <td>自动保证</td>
                    <td>需手动实现 O(n)</td>
                </tr>
            </tbody>
        </table>
        
        <div class="example-container">
            <h3>性能对比示例</h3>
            <pre><code>import Foundation

// 准备测试数据
let testSize = 100_000
var testArray = Array(0..&lt;testSize)
var testSet = Set(testArray)
let searchItems = (0..&lt;1000).map { _ in Int.random(in: 0..&lt;testSize) }

// 测量Array查找性能
func measureArrayPerformance() {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    for item in searchItems {
        _ = testArray.contains(item)
    }
    
    let endTime = CFAbsoluteTimeGetCurrent()
    print("Array查找耗时: \(endTime - startTime) 秒")
}

// 测量Set查找性能
func measureSetPerformance() {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    for item in searchItems {
        _ = testSet.contains(item)
    }
    
    let endTime = CFAbsoluteTimeGetCurrent()
    print("Set查找耗时: \(endTime - startTime) 秒")
}

// 执行性能测试
measureArrayPerformance()  // 通常需要更长时间
measureSetPerformance()    // 通常快得多</code></pre>
            <p><strong>可能的运行结果:</strong></p>
            <pre><code>Array查找耗时: 0.5687239170074463 秒
Set查找耗时: 0.0003581047058105469 秒</code></pre>
        </div>
    </section>

    <section id="use-cases">
        <h2>常见使用场景</h2>
        
        <div class="two-column">
            <div class="example-container">
                <h3>去除重复元素</h3>
                <pre><code>// 从数组中去除重复元素
let numbersWithDuplicates = [1, 2, 3, 2, 1, 4, 5, 4]
let uniqueNumbers = Array(Set(numbersWithDuplicates))
// uniqueNumbers 包含 [1, 2, 3, 4, 5]，但顺序可能不同

// 保持原始顺序的去重方法
let orderedUniqueNumbers = NSOrderedSet(array: numbersWithDuplicates).array as! [Int]
// 或者纯Swift实现
let ordered = numbersWithDuplicates.enumerated()
    .filter { idx, elem in numbersWithDuplicates.prefix(idx).contains(elem) == false }
    .map { $0.element }</code></pre>
            </div>
            
            <div class="example-container">
                <h3>快速查找与成员检查</h3>
                <pre><code>// 使用Set进行高效查找
let allowedUsers: Set&lt;String&gt; = ["user1", "user2", "admin"]

func checkAccess(for user: String) -> Bool {
    return allowedUsers.contains(user)
}

// 测试访问权限
let hasAccess = checkAccess(for: "user1") // true
let noAccess = checkAccess(for: "guest") // false

// 对比Array和Set的查找效率
let largeArray = Array(1...10000)
let largeSet = Set(largeArray)

// 在大型数据集中查找元素时，Set更高效</code></pre>
            </div>
        </div>
        
        <div class="example-container">
            <h3>数据去重与交集分析</h3>
            <pre><code>// 数据分析中寻找共同元素
let customersLastMonth: Set&lt;Int&gt; = [101, 102, 103, 104, 105]
let customersThisMonth: Set&lt;Int&gt; = [102, 104, 105, 106, 107]

// 本月新客户
let newCustomers = customersThisMonth.subtracting(customersLastMonth)
// [106, 107]

// 连续两个月都活跃的客户
let loyalCustomers = customersLastMonth.intersection(customersThisMonth)
// [102, 104, 105]

// 流失的客户
let lostCustomers = customersLastMonth.subtracting(customersThisMonth)
// [101, 103]

// 所有客户
let allCustomers = customersLastMonth.union(customersThisMonth)
// [101, 102, 103, 104, 105, 106, 107]</code></pre>
        </div>
        
        <div class="example-container">
            <h3>缓存与去重处理</h3>
            <pre><code>// 使用Set作为简单缓存，避免重复处理
class ImageDownloader {
    private var downloadedImageURLs: Set&lt;URL&gt; = []
    
    func downloadImageIfNeeded(from url: URL) {
        if !downloadedImageURLs.contains(url) {
            // 下载图片的代码
            print("Downloading image from \(url.absoluteString)")
            
            // 下载完成后添加到已下载集合
            downloadedImageURLs.insert(url)
        } else {
            print("Image already downloaded, using cached version")
        }
    }
}

// 使用示例
let downloader = ImageDownloader()
let imageURL = URL(string: "https://example.com/image.jpg")!

downloader.downloadImageIfNeeded(from: imageURL) // 输出: Downloading image from https://example.com/image.jpg
downloader.downloadImageIfNeeded(from: imageURL) // 输出: Image already downloaded, using cached version</code></pre>
        </div>
    </section>

    <section id="optimization-tips">
        <h2>Set优化技巧</h2>
        
        <div class="note">
            <p><strong>性能优化提示:</strong></p>
            <ol>
                <li>预分配容量 - 使用<code>reserveCapacity(_:)</code>预先分配足够大的容量可以避免频繁重新分配</li>
                <li>选择正确的集合类型 - 对于只需检查成员资格而不需要存储元素的场景，考虑使用<code>AnyHashable</code></li>
                <li>减少哈希计算复杂度 - 自定义<code>Hashable</code>实现时，使用关键标识字段而不是整个对象状态</li>
                <li>使用<code>first(where:)</code>代替过滤整个集合 - 当只需要找到第一个匹配项时</li>
            </ol>
        </div>
        
        <div class="example-container">
            <h3>容量优化示例</h3>
            <pre><code>// 优化大型集合的创建
func createOptimizedSet(withApproximateCount count: Int) -> Set&lt;Int&gt; {
    var optimizedSet = Set&lt;Int&gt;()
    
    // 预分配容量以避免动态增长
    optimizedSet.reserveCapacity(count)
    
    // 填充集合
    for i in 0..&lt;count {
        optimizedSet.insert(i)
    }
    
    return optimizedSet
}

// 性能对比
func compareSetCreationPerformance(count: Int) {
    let startTime1 = CFAbsoluteTimeGetCurrent()
    var regularSet = Set&lt;Int&gt;()
    for i in 0..&lt;count {
        regularSet.insert(i)
    }
    let endTime1 = CFAbsoluteTimeGetCurrent()
    
    let startTime2 = CFAbsoluteTimeGetCurrent()
    let optimizedSet = createOptimizedSet(withApproximateCount: count)
    let endTime2 = CFAbsoluteTimeGetCurrent()
    
    print("常规Set创建耗时: \(endTime1 - startTime1) 秒")
    print("优化Set创建耗时: \(endTime2 - startTime2) 秒")
}</code></pre>
        </div>
    </section>

    <section id="resources">
        <h2>参考资源</h2>
        
        <h3>官方文档</h3>
        <ul class="resource-list">
            <li><a href="https://developer.apple.com/documentation/swift/set" target="_blank">Swift Set Documentation</a> - Apple官方Set文档</li>
            <li><a href="https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html#ID484" target="_blank">Swift Programming Language: Collection Types - Sets</a> - Swift编程语言指南</li>
            <li><a href="https://developer.apple.com/documentation/swift/hashable" target="_blank">Hashable Protocol Documentation</a> - Swift Hashable协议文档</li>
        </ul>
        
        <h3>相关书籍</h3>
        <ul class="resource-list">
            <li><span class="tag">书籍</span> <strong>Swift in Depth</strong> - Tjeerd in 't Veen（探讨集合类型的深入知识）</li>
            <li><span class="tag">书籍</span> <strong>Advanced Swift</strong> - Chris Eidhof, Ole Begemann, and Airspeed Velocity（涵盖Swift集合性能优化）</li>
            <li><span class="tag">书籍</span> <strong>Pro Swift</strong> - Paul Hudson（包含Set深度解析章节）</li>
        </ul>
        
        <h3>优秀博客文章</h3>
        <ul class="resource-list">
            <li><a href="https://www.swiftbysundell.com/articles/sets-in-swift/" target="_blank">Sets in Swift</a> - Swift by Sundell</li>
            <li><a href="https://www.hackingwithswift.com/articles/42/how-and-why-to-use-hashable" target="_blank">How and why to use Hashable</a> - Hacking with Swift</li>
            <li><a href="https://www.objc.io/blog/2018/04/03/hashable/" target="_blank">Hashable/Equatable</a> - objc.io</li>
        </ul>
        
        <h3>视频教程</h3>
        <ul class="resource-list">
            <li><span class="tag">视频</span> <a href="https://www.youtube.com/watch?v=qGZ6OfP4OqQ" target="_blank">Swift Sets Tutorial</a> - Sean Allen</li>
            <li><span class="tag">视频</span> <a href="https://www.raywenderlich.com/3-swift-collections-protocols" target="_blank">Swift Collections Protocols</a> - Ray Wenderlich</li>
        </ul>
        
        <h3>相关开源项目</h3>
        <ul class="resource-list">
            <li><a href="https://github.com/apple/swift-collections" target="_blank">Swift Collections</a> - Apple官方Swift集合扩展库</li>
            <li><a href="https://github.com/attaswift/BTree" target="_blank">BTree</a> - 高效有序集合实现</li>
            <li><a href="https://github.com/khanlou/OrderedSet" target="_blank">OrderedSet</a> - 保持元素插入顺序的Set实现</li>
        </ul>
    </section>
</body>
</html>
