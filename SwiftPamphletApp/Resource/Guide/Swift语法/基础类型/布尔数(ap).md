<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift基础 - 布尔数</title>
    <style>
        :root {
            --background-color: #fef6e4;
            --text-color: #333333;
            --primary-color: #f582ae;
            --secondary-color: #8bd3dd;
            --accent-color: #f3d2c1;
            --code-background: #ebebeb;
            --code-color: #001858;
            --link-color: #f582ae;
            --border-color: #001858;
            --heading-color: #001858;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #172c66;
                --text-color: #fef6e4;
                --primary-color: #f582ae;
                --secondary-color: #8bd3dd;
                --accent-color: #3a5199;
                --code-background: #001858;
                --code-color: #fef6e4;
                --link-color: #f582ae;
                --border-color: #fef6e4;
                --heading-color: #f582ae;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        h1, h2, h3, h4 {
            color: var(--heading-color);
            font-weight: 700;
            margin-top: 1.5em;
            margin-bottom: 0.5em;
            border-bottom: 3px solid var(--primary-color);
            padding-bottom: 5px;
            display: inline-block;
        }

        h1 {
            font-size: 2.5em;
            text-align: center;
            border-bottom: none;
            margin-bottom: 1em;
        }

        h2 {
            font-size: 1.8em;
        }

        h3 {
            font-size: 1.5em;
            border-bottom: 2px solid var(--secondary-color);
        }

        p {
            margin-bottom: 1em;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 2px dotted var(--link-color);
            transition: all 0.3s ease;
        }

        a:hover {
            opacity: 0.8;
        }

        pre {
            background-color: var(--code-background);
            padding: 15px;
            border-radius: 10px;
            overflow-x: auto;
            border: 3px solid var(--border-color);
            margin: 20px 0;
        }

        code {
            font-family: 'Menlo', 'Monaco', 'Courier New', monospace;
            color: var(--code-color);
        }

        .info-box {
            background-color: var(--accent-color);
            border-radius: 10px;
            padding: 15px;
            margin: 20px 0;
            border: 3px solid var(--border-color);
        }

        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .resource-card {
            background-color: var(--accent-color);
            border-radius: 10px;
            padding: 15px;
            border: 3px solid var(--border-color);
        }

        .example-wrapper {
            margin: 20px 0;
        }

        .example-title {
            background-color: var(--primary-color);
            color: white;
            padding: 8px 15px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            font-weight: bold;
            display: inline-block;
        }

        img, svg {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        .icon {
            width: 24px;
            height: 24px;
            vertical-align: middle;
            margin-right: 5px;
            display: inline-block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            border-radius: 10px;
            overflow: hidden;
            border: 3px solid var(--border-color);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 2px solid var(--border-color);
        }

        th {
            background-color: var(--primary-color);
            color: white;
        }

        tr:nth-child(even) {
            background-color: var(--accent-color);
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            h1 {
                font-size: 2em;
            }

            h2 {
                font-size: 1.6em;
            }

            .resources {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Swift基础：布尔数（Bool）</h1>

        <div class="info-box">
            <p>布尔类型（Bool）是Swift中最基础的数据类型之一，用于表示逻辑值：真（true）和假（false）。布尔值在条件语句、逻辑控制和流程控制中扮演着重要角色。</p>
        </div>

        <h2>1. 布尔类型基础</h2>

        <h3>1.1 布尔值的声明与初始化</h3>

        <svg width="400" height="200" viewBox="0 0 400 200" xmlns="http://www.w3.org/2000/svg">
            <rect x="50" y="50" width="300" height="100" rx="20" fill="#8bd3dd" stroke="#001858" stroke-width="3"/>
            <text x="110" y="105" font-size="24" font-family="sans-serif" fill="#001858">var isTrue: Bool = true</text>
            <text x="110" y="135" font-size="24" font-family="sans-serif" fill="#001858">var isFalse = false</text>
        </svg>

        <div class="example-wrapper">
            <div class="example-title">示例：布尔值的声明与初始化</div>
            <pre><code>// 显式类型声明
let isCompleted: Bool = true

// 类型推断
let isAvailable = false

// 通过表达式初始化
let isSunny = 25 > 20

print(isCompleted)  // 输出: true
print(isAvailable)  // 输出: false
print(isSunny)      // 输出: true (因为25确实大于20)</code></pre>
        </div>

        <h3>1.2 布尔值的本质</h3>
        <p>在Swift中，布尔类型是一个明确的类型，不像某些语言中可以用整数1和0来代替。Swift是强类型语言，布尔值只能是true或false，不能用其他值替代。</p>

        <div class="example-wrapper">
            <div class="example-title">示例：布尔值的类型安全</div>
            <pre><code>// 这在Swift中是不允许的
// let wrongBool: Bool = 1  // 错误：不能将Int值赋给Bool类型

// 正确的做法是使用比较运算
let correctBool: Bool = (1 == 1)  // true</code></pre>
        </div>

        <h2>2. 布尔运算符</h2>

        <h3>2.1 逻辑运算符</h3>

        <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
            <rect x="50" y="20" width="500" height="260" rx="15" fill="none" stroke="#001858" stroke-width="3"/>

            <rect x="70" y="40" width="460" height="60" rx="10" fill="#f582ae" stroke="#001858" stroke-width="2"/>
            <text x="200" y="80" font-size="24" font-weight="bold" font-family="sans-serif" fill="white">逻辑非 (!)</text>

            <rect x="70" y="120" width="460" height="60" rx="10" fill="#8bd3dd" stroke="#001858" stroke-width="2"/>
            <text x="200" y="160" font-size="24" font-weight="bold" font-family="sans-serif" fill="#001858">逻辑与 (&&)</text>

            <rect x="70" y="200" width="460" height="60" rx="10" fill="#f3d2c1" stroke="#001858" stroke-width="2"/>
            <text x="200" y="240" font-size="24" font-weight="bold" font-family="sans-serif" fill="#001858">逻辑或 (||)</text>
        </svg>

        <table>
            <tr>
                <th>运算符</th>
                <th>描述</th>
                <th>示例</th>
            </tr>
            <tr>
                <td><code>!</code> (非)</td>
                <td>反转布尔值</td>
                <td><code>!true</code> 结果为 <code>false</code></td>
            </tr>
            <tr>
                <td><code>&&</code> (与)</td>
                <td>两个条件都为true时结果为true</td>
                <td><code>true && false</code> 结果为 <code>false</code></td>
            </tr>
            <tr>
                <td><code>||</code> (或)</td>
                <td>至少一个条件为true时结果为true</td>
                <td><code>true || false</code> 结果为 <code>true</code></td>
            </tr>
        </table>

        <div class="example-wrapper">
            <div class="example-title">示例：逻辑运算符的使用</div>
            <pre><code>let sunny = true
let warm = false

// 逻辑非运算符
let notSunny = !sunny
print("今天不是晴天？\(notSunny)")  // 输出: 今天不是晴天？false

// 逻辑与运算符
let perfectDay = sunny && warm
print("今天是完美的一天？\(perfectDay)")  // 输出: 今天是完美的一天？false

// 逻辑或运算符
let niceWeather = sunny || warm
print("今天天气不错？\(niceWeather)")  // 输出: 今天天气不错？true

// 组合运算符
let complexCondition = (sunny && !warm) || (!sunny && warm)
print("今天是晴天但不热或者今天不是晴天但很热？\(complexCondition)")  // 输出: 今天是晴天但不热或者今天不是晴天但很热？true</code></pre>
        </div>

        <h3>2.2 比较运算符</h3>
        <p>比较运算符用于比较两个值，返回布尔结果。</p>

        <table>
            <tr>
                <th>运算符</th>
                <th>描述</th>
            </tr>
            <tr><td><code>==</code></td><td>等于</td></tr>
            <tr><td><code>!=</code></td><td>不等于</td></tr>
            <tr><td><code>></code></td><td>大于</td></tr>
            <tr><td><code><</code></td><td>小于</td></tr>
            <tr><td><code>>=</code></td><td>大于等于</td></tr>
            <tr><td><code><=</code></td><td>小于等于</td></tr>
        </table>

        <div class="example-wrapper">
            <div class="example-title">示例：比较运算符</div>
            <pre><code>let temperature = 25
let isWarm = temperature > 20
print("温度高于20度？\(isWarm)")  // 输出: 温度高于20度？true

let targetTemperature = 25
let isTargetReached = temperature == targetTemperature
print("达到目标温度？\(isTargetReached)")  // 输出: 达到目标温度？true

// 比较字符串
let name = "Swift"
let isSwift = name == "Swift"
print("编程语言是Swift？\(isSwift)")  // 输出: 编程语言是Swift？true</code></pre>
        </div>

        <h2>3. 布尔值在条件语句中的应用</h2>

        <h3>3.1 if语句</h3>

        <svg width="500" height="250" viewBox="0 0 500 250" xmlns="http://www.w3.org/2000/svg">
            <rect x="50" y="30" width="400" height="180" rx="20" fill="#ffffff" stroke="#001858" stroke-width="3"/>
            <polygon points="250,50 150,100 250,150 350,100" fill="#8bd3dd" stroke="#001858" stroke-width="3"/>
            <text x="225" y="105" font-family="sans-serif" font-weight="bold" fill="#001858">条件</text>
            <rect x="175" y="160" width="150" height="40" fill="#f582ae" stroke="#001858" stroke-width="3" rx="10"/>
            <text x="210" y="185" font-family="sans-serif" font-weight="bold" fill="white">执行代码</text>
            <path d="M250,150 L250,160" stroke="#001858" stroke-width="3"/>
            <text x="260" y="135" font-family="sans-serif" fill="#001858" font-weight="bold">true</text>
        </svg>

        <div class="example-wrapper">
            <div class="example-title">示例：if语句</div>
            <pre><code>let isRaining = true

// 基本if语句
if isRaining {
    print("带上雨伞")
}

// if-else语句
if isRaining {
    print("带上雨伞")
} else {
    print("享受阳光")
}

// if-else if-else语句
let temperature = 22
if isRaining {
    print("带上雨伞")
} else if temperature > 25 {
    print("天气热，带上太阳镜")
} else {
    print("天气很好")
}

// 输出: 带上雨伞</code></pre>
        </div>

        <h3>3.2 三元条件运算符</h3>

        <div class="example-wrapper">
            <div class="example-title">示例：三元条件运算符</div>
            <pre><code>let isRaining = true

// 使用三元条件运算符
let action = isRaining ? "带上雨伞" : "享受阳光"
print(action)  // 输出: 带上雨伞

// 嵌套三元运算符（尽量避免过度嵌套，影响可读性）
let temperature = 22
let weatherAdvice = isRaining ? "带上雨伞" :
                   (temperature > 25 ? "涂防晒霜" : "天气很好")
print(weatherAdvice)  // 输出: 带上雨伞</code></pre>
        </div>

        <h3>3.3 guard语句</h3>

        <div class="example-wrapper">
            <div class="example-title">示例：guard语句中的布尔条件</div>
            <pre><code>func goOutside(isRaining: Bool, hasUmbrella: Bool) {
    // 使用guard语句进行早期返回
    guard !isRaining || hasUmbrella else {
        print("下雨了，没伞，不能出门")
        return
    }

    print("可以出门了")
}

goOutside(isRaining: true, hasUmbrella: false)  // 输出: 下雨了，没伞，不能出门
goOutside(isRaining: true, hasUmbrella: true)   // 输出: 可以出门了
goOutside(isRaining: false, hasUmbrella: false) // 输出: 可以出门了</code></pre>
        </div>

        <h3>3.4 switch语句</h3>

        <div class="example-wrapper">
            <div class="example-title">示例：在switch中使用布尔值</div>
            <pre><code>let isWeekend = true
let isRaining = false

// 使用元组组合多个布尔条件
switch (isWeekend, isRaining) {
case (true, true):
    print("周末下雨，宅在家里")
case (true, false):
    print("周末天气好，出去玩")
case (false, true):
    print("工作日下雨，带伞上班")
case (false, false):
    print("工作日天气好，愉快上班")
}
// 输出: 周末天气好，出去玩</code></pre>
        </div>

        <h2>4. 短路求值</h2>

        <p>Swift中的逻辑运算符使用"短路求值"（short-circuit evaluation）来提高效率。</p>

        <svg width="500" height="200" viewBox="0 0 500 200" xmlns="http://www.w3.org/2000/svg">
            <rect x="50" y="30" width="400" height="140" rx="15" fill="#ffffff" stroke="#001858" stroke-width="3"/>

            <rect x="70" y="50" width="170" height="50" rx="10" fill="#f582ae" stroke="#001858" stroke-width="2"/>
            <text x="95" y="80" font-size="16" font-family="sans-serif" fill="white">条件1 = false</text>

            <rect x="260" y="50" width="170" height="50" rx="10" fill="#8bd3dd" stroke="#001858" stroke-width="2"/>
            <text x="295" y="80" font-size="16" font-family="sans-serif" fill="#001858">条件2 (跳过)</text>

            <line x1="240" y1="75" x2="260" y2="75" stroke="#001858" stroke-width="3" stroke-dasharray="5,5"/>
            <text x="210" y="130" font-size="20" font-weight="bold" font-family="sans-serif" fill="#001858">false && ? = false</text>
        </svg>

        <div class="example-wrapper">
            <div class="example-title">示例：短路求值</div>
            <pre><code>// && 运算符的短路求值
func checkFirst() -> Bool {
    print("检查第一个条件")
    return false
}

func checkSecond() -> Bool {
    print("检查第二个条件")
    return true
}

// 由于checkFirst()返回false，checkSecond()不会被调用
if checkFirst() && checkSecond() {
    print("两个条件都为true")
} else {
    print("至少一个条件为false")
}
// 输出:
// 检查第一个条件
// 至少一个条件为false

// || 运算符的短路求值
func checkA() -> Bool {
    print("检查条件A")
    return true
}

func checkB() -> Bool {
    print("检查条件B")
    return false
}

// 由于checkA()返回true，checkB()不会被调用
if checkA() || checkB() {
    print("至少一个条件为true")
}
// 输出:
// 检查条件A
// 至少一个条件为true</code></pre>
        </div>

        <h2>5. 布尔值与可选类型</h2>

        <div class="example-wrapper">
            <div class="example-title">示例：Optional布尔值</div>
            <pre><code>// 声明可选布尔类型
var userConsent: Bool? = nil

// 检查用户是否已给予同意
if let consent = userConsent {
    if consent {
        print("用户已同意")
    } else {
        print("用户已拒绝")
    }
} else {
    print("用户尚未做出选择")
}
// 输出: 用户尚未做出选择

// 使用nil合并运算符设置默认值
let defaultConsent = userConsent ?? false
print("默认同意状态: \(defaultConsent)")  // 输出: 默认同意状态: false

// 更新用户同意状态
userConsent = true
if userConsent == true {  // 同时检查非nil和值为true
    print("已确认用户同意")
}
// 输出: 已确认用户同意</code></pre>
        </div>

        <h2>6. 高级布尔操作</h2>

        <h3>6.1 布尔值数组</h3>

        <div class="example-wrapper">
            <div class="example-title">示例：布尔数组操作</div>
            <pre><code>// 布尔值数组
let conditions = [true, false, true, true, false]

// 检查是否所有条件都为true
let allTrue = conditions.allSatisfy { $0 }
print("所有条件都为true? \(allTrue)")  // 输出: 所有条件都为true? false

// 检查是否任何条件为true
let anyTrue = conditions.contains(true)
print("任何条件为true? \(anyTrue)")  // 输出: 任何条件为true? true

// 计算true的数量
let trueCount = conditions.filter { $0 }.count
print("true的数量: \(trueCount)")  // 输出: true的数量: 3

// 使用reduce合并所有布尔值（使用逻辑与）
let combinedAnd = conditions.reduce(true) { $0 && $1 }
print("所有条件的与运算结果: \(combinedAnd)")  // 输出: 所有条件的与运算结果: false

// 使用reduce合并所有布尔值（使用逻辑或）
let combinedOr = conditions.reduce(false) { $0 || $1 }
print("所有条件的或运算结果: \(combinedOr)")  // 输出: 所有条件的或运算结果: true</code></pre>
        </div>

        <h3>6.2 自定义布尔逻辑</h3>

        <div class="example-wrapper">
            <div class="example-title">示例：实现自定义逻辑运算</div>
            <pre><code>// 定义一个结构体，实现布尔操作
struct Condition {
    let value: Bool
    let description: String

    // 重载逻辑与运算符
    static func &&(lhs: Condition, rhs: Condition) -> Condition {
        let newValue = lhs.value && rhs.value
        let newDescription = "(\(lhs.description) && \(rhs.description))"
        return Condition(value: newValue, description: newDescription)
    }

    // 重载逻辑或运算符
    static func ||(lhs: Condition, rhs: Condition) -> Condition {
        let newValue = lhs.value || rhs.value
        let newDescription = "(\(lhs.description) || \(rhs.description))"
        return Condition(value: newValue, description: newDescription)
    }

    // 重载逻辑非运算符
    static prefix func !(condition: Condition) -> Condition {
        return Condition(value: !condition.value, description: "!(\(condition.description))")
    }
}

// 使用自定义布尔逻辑
let sunny = Condition(value: true, description: "晴天")
let warm = Condition(value: false, description: "温暖")
let weekend = Condition(value: true, description: "周末")

// 组合条件
let goodDay = sunny && warm
let goodOutingDay = goodDay || weekend

print("\(goodOutingDay.description) 的结果是: \(goodOutingDay.value)")
// 输出: ((晴天 && 温暖) || 周末) 的结果是: true</code></pre>
        </div>

        <h2>7. 布尔值的内存表示</h2>

        <p>在Swift中，Bool类型通常使用一个字节（8位）来存储，尽管它只需要1位就能表示true或false。这是为了内存对齐和访问效率。</p>

        <div class="example-wrapper">
            <div class="example-title">示例：检查布尔值的内存大小</div>
            <pre><code>import Foundation

// 获取Bool类型的内存大小
let boolSize = MemoryLayout&lt;Bool&gt;.size
let boolStride = MemoryLayout&lt;Bool&gt;.stride
let boolAlignment = MemoryLayout&lt;Bool&gt;.alignment

print("Bool size: \(boolSize) 字节")      // 通常输出: Bool size: 1 字节
print("Bool stride: \(boolStride) 字节")  // 通常输出: Bool stride: 1 字节
print("Bool alignment: \(boolAlignment) 字节")  // 通常输出: Bool alignment: 1 字节

// 布尔数组的内存布局
let boolArray = [true, false, true, true]
let arraySize = MemoryLayout.size(ofValue: boolArray)
print("布尔数组[\(boolArray.count)个元素]的大小不仅仅是 \(boolArray.count) 字节")</code></pre>
        </div>

        <h2>8. 最佳实践</h2>

        <div class="info-box">
            <h3>布尔值使用的最佳实践</h3>
            <ul>
                <li>使用有意义的变量名，通常以<code>is</code>、<code>has</code>、<code>can</code>、<code>should</code>等前缀命名</li>
                <li>避免双重否定，如<code>if !isNotAvailable</code>，会降低代码可读性</li>
                <li>对布尔表达式适当添加括号，提高可读性</li>
                <li>利用短路求值优化性能</li>
                <li>使用guard语句进行提前退出，减少嵌套</li>
            </ul>
        </div>

        <div class="example-wrapper">
            <div class="example-title">示例：布尔值命名最佳实践</div>
            <pre><code>// 好的命名习惯
let isAvailable = true
let hasPermission = false
let canEdit = true
let shouldRefresh = false

// 避免双重否定
// 不好的写法
let isNotUnavailable = true
if !isNotUnavailable { /* ... */ }

// 好的写法
let isAvailable = true
if !isAvailable { /* ... */ }

// 使用括号提高复杂表达式的清晰度
let complexCondition = (isAvailable && hasPermission) || (canEdit && shouldRefresh)

// 使用guard提前退出
func processDocument(canEdit: Bool, hasPermission: Bool) {
    guard canEdit else {
        print("文档不可编辑")
        return
    }

    guard hasPermission else {
        print("没有权限编辑文档")
        return
    }

    print("开始编辑文档")
}</code></pre>
        </div>

        <h2>9. 相关资源</h2>

        <div class="resources">
            <div class="resource-card">
                <h3>官方文档</h3>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Booleans" target="_blank">Swift官方文档 - 布尔值</a></li>
                    <li><a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators/#Logical-Operators" target="_blank">Swift官方文档 - 逻辑运算符</a></li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>优秀博客文章</h3>
                <ul>
                    <li><a href="https://www.swiftbysundell.com/articles/boolean-logic-in-swift/" target="_blank">Swift by Sundell - Boolean Logic in Swift</a></li>
                    <li><a href="https://www.hackingwithswift.com/quick-start/beginners/how-to-use-conditions-to-check-for-things" target="_blank">Hacking with Swift - 条件检查</a></li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>相关书籍</h3>
                <ul>
                    <li>《Swift编程权威指南》(The Swift Programming Language) - Apple官方</li>
                    <li>《Swift进阶》(Advanced Swift) - Chris Eidhof等著</li>
                    <li>《Swift实战编程》(Swift in Practice) - Erica Sadun著</li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>视频教程</h3>
                <ul>
                    <li><a href="https://developer.apple.com/videos/play/wwdc2020/10170/" target="_blank">WWDC - Swift中的内存安全</a></li>
                    <li><a href="https://www.raywenderlich.com/5665-fluid-interfaces-in-swift" target="_blank">Ray Wenderlich - Swift流畅接口设计</a></li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>开源项目</h3>
                <ul>
                    <li><a href="https://github.com/apple/swift-evolution" target="_blank">Swift Evolution</a> - Swift语言演进提案</li>
                    <li><a href="https://github.com/apple/swift" target="_blank">Swift</a> - Swift语言的源代码</li>
                </ul>
            </div>
        </div>

    </div>
</body>
</html>
