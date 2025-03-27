<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift基础 - 元组(Tuple)</title>
    <style>
        :root {
            --bg-color: #f8e8dd;
            --text-color: #333344;
            --code-bg: #d8e8f8;
            --heading-color: #4466aa;
            --link-color: #6644aa;
            --border-color: #88aacc;
            --accent-color: #ff7744;
            --accent-secondary: #44aa66;
            --pixel-border: 2px solid #5577aa;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --bg-color: #332222;
                --text-color: #eeeeff;
                --code-bg: #334455;
                --heading-color: #88aaff;
                --link-color: #aa88ff;
                --border-color: #5577aa;
                --accent-color: #ff9966;
                --accent-secondary: #66cc88;
                --pixel-border: 2px solid #6688cc;
            }
        }

        @font-face {
            font-family: 'PixelFont';
            src: url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
            font-display: swap;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', sans-serif;
            line-height: 1.6;
            max-width: 90%;
            margin: 0 auto;
            padding: 20px;
        }

        h1, h2, h3, h4 {
            font-family: 'PixelFont', 'PingFang SC', sans-serif;
            color: var(--heading-color);
            padding: 8px;
            border-bottom: var(--pixel-border);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        h1 {
            text-align: center;
            font-size: 2.2rem;
            margin-top: 20px;
            padding: 15px;
            background: linear-gradient(to right, #4466aa, #6644aa);
            color: white;
            border: 4px solid #4466aa;
            text-shadow: 2px 2px #333333;
        }

        .content-container {
            background-color: rgba(255, 255, 255, 0.08);
            border: var(--pixel-border);
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 5px 5px 0 rgba(0, 0, 0, 0.2);
        }

        pre, code {
            font-family: 'Menlo', 'Monaco', 'Courier New', monospace;
            background-color: var(--code-bg);
            color: var(--text-color);
            border-radius: 4px;
        }

        code {
            padding: 2px 4px;
        }

        pre {
            padding: 15px;
            overflow-x: auto;
            border-left: 4px solid var(--accent-color);
            margin: 20px 0;
        }

        pre code {
            background-color: transparent;
            padding: 0;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 2px dashed var(--link-color);
            padding-bottom: 2px;
        }

        a:hover {
            color: var(--accent-color);
            border-bottom: 2px solid var(--accent-color);
        }

        .note {
            background-color: rgba(102, 204, 136, 0.15);
            border-left: 4px solid var(--accent-secondary);
            padding: 10px 15px;
            margin: 15px 0;
        }

        .warning {
            background-color: rgba(255, 119, 68, 0.15);
            border-left: 4px solid var(--accent-color);
            padding: 10px 15px;
            margin: 15px 0;
        }

        .example-block {
            margin: 20px 0;
            padding: 15px;
            border: var(--pixel-border);
            background-color: rgba(136, 170, 204, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: var(--pixel-border);
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: rgba(68, 102, 170, 0.2);
        }

        .resource-section {
            margin-top: 40px;
            padding: 20px;
            background-color: rgba(102, 68, 170, 0.1);
            border: var(--pixel-border);
        }

        .resource-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .resource-item {
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.05);
            border: 2px solid var(--border-color);
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
                max-width: 100%;
            }
            
            h1 {
                font-size: 1.8rem;
            }
            
            .resource-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <h1>Swift基础 - 元组(Tuple)</h1>
    
    <div class="content-container">
        <h2>1. 元组概述</h2>
        
        <p>元组（Tuple）是Swift中一种特殊的组合数据类型，它允许你将多个值组合成一个复合值。这些值可以是不同类型，并且数量是固定的。元组是Swift中轻量级数据组织的理想选择，特别适用于需要临时组织或传递一组相关值的场景。</p>
        
        <svg width="100%" height="180" viewBox="0 0 600 180">
            <defs>
                <linearGradient id="tupleGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                    <stop offset="0%" style="stop-color:#4466aa;stop-opacity:1" />
                    <stop offset="100%" style="stop-color:#6644aa;stop-opacity:1" />
                </linearGradient>
            </defs>
            <rect x="50" y="40" width="500" height="100" rx="10" ry="10" 
                  style="fill:url(#tupleGrad);stroke:#333;stroke-width:2;" />
            <rect x="70" y="60" width="80" height="60" rx="5" ry="5" 
                  style="fill:#ff7744;stroke:#333;stroke-width:2;" />
            <rect x="170" y="60" width="80" height="60" rx="5" ry="5" 
                  style="fill:#44aa66;stroke:#333;stroke-width:2;" />
            <rect x="270" y="60" width="80" height="60" rx="5" ry="5" 
                  style="fill:#88aaff;stroke:#333;stroke-width:2;" />
            <rect x="370" y="60" width="80" height="60" rx="5" ry="5" 
                  style="fill:#aa88ff;stroke:#333;stroke-width:2;" />
            <text x="110" y="95" text-anchor="middle" fill="white">String</text>
            <text x="210" y="95" text-anchor="middle" fill="white">Int</text>
            <text x="310" y="95" text-anchor="middle" fill="white">Double</text>
            <text x="410" y="95" text-anchor="middle" fill="white">Bool</text>
            <text x="300" y="30" text-anchor="middle" fill="#333" font-weight="bold">元组可以包含不同类型的值</text>
            <text x="300" y="160" text-anchor="middle" fill="#333" font-weight="bold">(String, Int, Double, Bool)</text>
        </svg>

        <h2>2. 创建和使用元组</h2>
        
        <h3>2.1 创建元组</h3>
        <p>在Swift中，创建元组非常简单，只需将多个值用括号括起来，并用逗号分隔：</p>
        
        <pre><code>// 创建一个包含姓名和年龄的元组
let person = ("张三", 30)

// 创建一个更复杂的元组，包含不同类型的值
let httpResponse = (404, "Not Found", true, ["timestamp": "2023-10-15"])

// 创建时可以指定元素名称
let employee = (name: "李四", age: 35, department: "研发部")</code></pre>

        <h3>2.2 访问元组元素</h3>
        <p>有多种方式可以访问元组中的元素：</p>
        
        <pre><code>// 1. 通过索引访问（从0开始）
let person = ("张三", 30)
let name = person.0     // "张三"
let age = person.1      // 30

// 2. 通过命名元素访问
let employee = (name: "李四", age: 35, department: "研发部")
let employeeName = employee.name         // "李四"
let employeeAge = employee.age           // 35
let employeeDept = employee.department   // "研发部"

// 3. 通过解构来访问元组元素
let product = (id: 1001, name: "iPhone", price: 6999.0)
let (productId, productName, productPrice) = product
print("商品ID: \(productId)")      // 输出: 商品ID: 1001
print("商品名称: \(productName)")   // 输出: 商品名称: iPhone
print("商品价格: \(productPrice)")  // 输出: 商品价格: 6999.0

// 4. 解构时忽略某些元素（使用下划线）
let company = ("Apple", "USA", 1976, 2000000000)
let (companyName, country, _, revenue) = company
// 忽略了成立年份，只获取公司名、国家和营收</code></pre>

        <div class="note">
            <p><strong>提示：</strong>给元组元素命名是一种良好的实践，它可以提高代码的可读性，让其他开发者更容易理解每个值的含义。</p>
        </div>

        <h2>3. 元组的主要特性</h2>

        <h3>3.1 元组是值类型</h3>
        <p>元组和Swift中的其他基础类型一样，是值类型。这意味着当你将一个元组赋值给另一个变量或常量时，是在复制这个元组。</p>
        
        <pre><code>let originalTuple = (1, "Hello")
var copyTuple = originalTuple
copyTuple.0 = 2
print(originalTuple) // 输出: (1, "Hello")
print(copyTuple)     // 输出: (2, "Hello")</code></pre>

        <h3>3.2 元组比较</h3>
        <p>元组支持比较操作，但有一些限制：</p>
        
        <pre><code>// 元组比较要求：元素数量相同，对应位置的元素类型相同且可比较
let tuple1 = (1, "张三")
let tuple2 = (2, "李四")
let tuple3 = (1, "王五")

// 从左到右逐个比较元素
print(tuple1 < tuple2)  // 输出: true，因为1 < 2
print(tuple1 < tuple3)  // 输出: false，因为1 == 1，但"张三" !< "王五"

// 注意：元组最多只能比较前6个元素</code></pre>

        <div class="warning">
            <p><strong>注意：</strong>元组的比较是按照从左到右的顺序进行的。只有当所有元素都相同时，两个元组才被视为相等。如果元组包含不可比较的类型（如数组或字典），则无法直接比较这些元组。</p>
        </div>

        <h3>3.3 元组类型</h3>
        <p>元组的类型由其包含的元素类型决定：</p>
        
        <pre><code>// 类型为(String, Int)的元组
let person: (String, Int) = ("张三", 30)

// 带有元素名称的元组类型
let employee: (name: String, age: Int, department: String) = (name: "李四", age: 35, department: "研发部")

// 作为函数返回类型
func getUserInfo() -> (name: String, age: Int) {
    return ("王五", 25)
}

// 函数调用并解构返回值
let (userName, userAge) = getUserInfo()

// 作为函数参数类型
func processUserData(data: (name: String, age: Int)) {
    print("处理用户数据：\(data.name), \(data.age)岁")
}

processUserData(data: ("赵六", 40))</code></pre>

        <h2>4. 元组的实际应用场景</h2>

        <svg width="100%" height="280" viewBox="0 0 600 280">
            <rect x="50" y="20" width="500" height="240" rx="10" ry="10" fill="#eeeeff" stroke="#4466aa" stroke-width="2" opacity="0.1" />
            
            <!-- 数据返回场景 -->
            <rect x="80" y="40" width="160" height="80" rx="5" ry="5" fill="#4466aa" stroke="#333" stroke-width="2" />
            <text x="160" y="85" text-anchor="middle" fill="white" font-weight="bold">函数返回多个值</text>
            
            <!-- 临时组织数据场景 -->
            <rect x="320" y="40" width="160" height="80" rx="5" ry="5" fill="#6644aa" stroke="#333" stroke-width="2" />
            <text x="400" y="85" text-anchor="middle" fill="white" font-weight="bold">临时组织数据</text>
            
            <!-- 数据交换场景 -->
            <rect x="80" y="160" width="160" height="80" rx="5" ry="5" fill="#ff7744" stroke="#333" stroke-width="2" />
            <text x="160" y="205" text-anchor="middle" fill="white" font-weight="bold">快速数据交换</text>
            
            <!-- 字典键场景 -->
            <rect x="320" y="160" width="160" height="80" rx="5" ry="5" fill="#44aa66" stroke="#333" stroke-width="2" />
            <text x="400" y="205" text-anchor="middle" fill="white" font-weight="bold">字典复合键</text>
        </svg>

        <h3>4.1 作为函数返回多个值</h3>
        <p>元组最常见的应用是让函数返回多个相关的值：</p>
        
        <pre><code>// 计算一个数组的最小值、最大值和平均值
func calculateStatistics(_ numbers: [Double]) -> (min: Double, max: Double, average: Double) {
    var min = numbers[0]
    var max = numbers[0]
    var sum = 0.0
    
    for number in numbers {
        if number < min {
            min = number
        }
        if number > max {
            max = number
        }
        sum += number
    }
    
    let average = sum / Double(numbers.count)
    return (min, max, average)
}

// 使用返回的元组
let statistics = calculateStatistics([5.0, 3.0, 9.0, 1.0, 7.0])
print("最小值：\(statistics.min)")
print("最大值：\(statistics.max)")
print("平均值：\(statistics.average)")</code></pre>

        <h3>4.2 临时数据组织</h3>
        <p>当需要临时组织一组相关数据，但又不需要创建专门的类或结构体时：</p>
        
        <pre><code>// 使用元组表示坐标点
let locations = [
    (x: 10, y: 20, name: "起点"),
    (x: 35, y: 42, name: "中间点"),
    (x: 55, y: 60, name: "终点")
]

// 遍历并处理坐标点
for location in locations {
    print("\(location.name)的坐标: (\(location.x), \(location.y))")
}</code></pre>

        <h3>4.3 快速数据交换</h3>
        <p>元组提供了一种优雅的方式来交换变量的值：</p>
        
        <pre><code>// 传统方式交换两个变量
var a = 10
var b = 20
var temp = a
a = b
b = temp
// 现在a = 20，b = 10

// 使用元组进行交换，更加简洁
var x = 5
var y = 10
(x, y) = (y, x)
// 现在x = 10，y = 5</code></pre>

        <h3>4.4 字典复合键</h3>
        <p>元组可以作为字典的键，创建复合键：</p>
        
        <pre><code>// 使用元组作为字典键
// 注意：作为字典键的元组必须只包含遵守Hashable协议的类型
var employeesByDepartmentAndLevel: [
    (department: String, level: Int): [String]
] = [:]

// 添加数据
employeesByDepartmentAndLevel[("工程部", 1)] = ["张三", "李四"]
employeesByDepartmentAndLevel[("工程部", 2)] = ["王五"]
employeesByDepartmentAndLevel[("市场部", 1)] = ["赵六", "钱七"]

// 查询特定部门和级别的员工
if let engineers = employeesByDepartmentAndLevel[("工程部", 1)] {
    print("工程部一级员工: \(engineers.joined(separator: ", "))")
}</code></pre>

        <h2>5. 元组与其他数据结构的对比</h2>
        
        <table>
            <tr>
                <th>特性</th>
                <th>元组(Tuple)</th>
                <th>数组(Array)</th>
                <th>字典(Dictionary)</th>
                <th>结构体(Struct)</th>
            </tr>
            <tr>
                <td>数据类型</td>
                <td>可以混合不同类型</td>
                <td>所有元素必须相同类型</td>
                <td>键和值各自必须相同类型</td>
                <td>可以有不同类型的属性</td>
            </tr>
            <tr>
                <td>元素数量</td>
                <td>固定</td>
                <td>可变</td>
                <td>可变</td>
                <td>固定</td>
            </tr>
            <tr>
                <td>访问元素</td>
                <td>通过索引或命名</td>
                <td>通过索引</td>
                <td>通过键</td>
                <td>通过属性名</td>
            </tr>
            <tr>
                <td>可变性</td>
                <td>根据声明(let/var)</td>
                <td>根据声明(let/var)</td>
                <td>根据声明(let/var)</td>
                <td>根据声明(let/var)</td>
            </tr>
            <tr>
                <td>适用场景</td>
                <td>临时组织小量相关数据</td>
                <td>同类型数据集合</td>
                <td>键值对映射</td>
                <td>模型化具有行为的数据</td>
            </tr>
        </table>

        <div class="example-block">
            <h3>综合实例：天气预报系统</h3>
            <p>以下示例展示了如何在一个天气预报系统中使用元组来组织和处理数据：</p>
            
            <pre><code>// 定义表示天气数据的元组
typealias WeatherData = (
    city: String,
    date: Date,
    temperature: (current: Double, high: Double, low: Double),
    conditions: String,
    humidity: Double,
    precipitationChance: Double
)

// 创建一个天气预报函数
func getWeatherForecast(for city: String) -> [WeatherData] {
    // 在实际应用中，这里会调用API获取真实数据
    // 这里仅用模拟数据作为演示
    let today = Date()
    let calendar = Calendar.current
    
    var forecasts: [WeatherData] = []
    
    // 生成5天的天气预报
    for day in 0..<5 {
        guard let forecastDate = calendar.date(byAdding: .day, value: day, to: today) else {
            continue
        }
        
        // 根据城市和日期生成模拟数据
        let currentTemp = Double.random(in: 15...30)
        let highTemp = currentTemp + Double.random(in: 2...5)
        let lowTemp = currentTemp - Double.random(in: 3...8)
        
        let conditions = ["晴朗", "多云", "阴天", "小雨", "雷阵雨"].randomElement()!
        let humidity = Double.random(in: 0.3...0.9)
        let precipChance = conditions.contains("雨") ? Double.random(in: 0.4...0.9) : Double.random(in: 0...0.3)
        
        // 创建天气数据元组
        let forecast: WeatherData = (
            city: city,
            date: forecastDate,
            temperature: (current: currentTemp, high: highTemp, low: lowTemp),
            conditions: conditions,
            humidity: humidity,
            precipitationChance: precipChance
        )
        
        forecasts.append(forecast)
    }
    
    return forecasts
}

// 使用天气预报函数并处理结果
let beijingForecasts = getWeatherForecast(for: "北京")

// 格式化日期的辅助函数
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

// 打印天气预报信息
for forecast in beijingForecasts {
    let dateString = dateFormatter.string(from: forecast.date)
    
    print("【\(forecast.city) - \(dateString)】")
    print("天气状况: \(forecast.conditions)")
    print("当前温度: \(forecast.temperature.current)°C")
    print("最高温度: \(forecast.temperature.high)°C")
    print("最低温度: \(forecast.temperature.low)°C")
    print("湿度: \(Int(forecast.humidity * 100))%")
    print("降水概率: \(Int(forecast.precipitationChance * 100))%")
    print("-------------------------")
}</code></pre>
        </div>

        <h2>6. 元组的限制与最佳实践</h2>

        <h3>6.1 元组的限制</h3>
        <ul>
            <li>元组不支持添加方法或扩展</li>
            <li>大量使用未命名元组可能导致代码可读性降低</li>
            <li>元组比较最多只支持前6个元素</li>
            <li>不能对元组元素的类型或数量进行修改（结构固定）</li>
        </ul>

        <h3>6.2 最佳实践</h3>
        <ul>
            <li>为元组元素命名，提高代码可读性</li>
            <li>使用 typealias 为复杂元组创建别名</li>
            <li>当元组变得复杂或需要添加方法时，考虑改用结构体或类</li>
            <li>避免创建过于复杂的嵌套元组</li>
            <li>元组最适合临时数据组织和多值返回场景</li>
        </ul>

        <pre><code>// 使用typealias创建元组类型别名
typealias HTTPResponse = (code: Int, message: String, success: Bool, data: [String: Any]?)

func fetchUserData(userId: String) -> HTTPResponse {
    // 模拟网络请求
    return (200, "OK", true, ["name": "张三", "age": 30, "email": "zhang@example.com"])
}

// 使用命名元组提高可读性
let response = fetchUserData(userId: "user123")
if response.success && response.code == 200 {
    if let userData = response.data {
        print("用户数据获取成功: \(userData)")
    }
} else {
    print("错误: \(response.message)")
}</code></pre>

        <div class="resource-section">
            <h2>7. 学习资源</h2>
            
            <h3>7.1 官方文档</h3>
            <div class="resource-grid">
                <div class="resource-item">
                    <h4>Swift编程语言 - 基础部分</h4>
                    <p><a href="https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html" target="_blank">https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html</a></p>
                </div>
                <div class="resource-item">
                    <h4>Swift标准库 - 元组类型</h4>
                    <p><a href="https://developer.apple.com/documentation/swift/tuples" target="_blank">https://developer.apple.com/documentation/swift/tuples</a></p>
                </div>
            </div>
            
            <h3>7.2 博客和文章</h3>
            <div class="resource-grid">
                <div class="resource-item">
                    <h4>Swift中的元组——小而美的数据结构</h4>
                    <p><a href="https://www.swiftbysundell.com/articles/tuples-in-swift/" target="_blank">Swift by Sundell: Tuples in Swift</a></p>
                </div>
                <div class="resource-item">
                    <h4>何时使用元组而非自定义类型</h4>
                    <p><a href="https://www.hackingwithswift.com/example-code/language/when-to-use-tuples-in-swift" target="_blank">Hacking with Swift: When to use tuples</a></p>
                </div>
                <div class="resource-item">
                    <h4>Swift元组高级用法</h4>
                    <p><a href="https://www.avanderlee.com/swift/tuples-explained/" target="_blank">SwiftLee: Swift tuples explained</a></p>
                </div>
            </div>
            
            <h3>7.3 推荐书籍</h3>
            <div class="resource-grid">
                <div class="resource-item">
                    <h4>Swift编程权威指南 (第六版)</h4>
                    <p>作者: Matthew Mathias, John Gallagher</p>
                </div>
                <div class="resource-item">
                    <h4>Swift实战编程 (第三版)</h4>
                    <p>作者: Jon Hoffman</p>
                </div>
                <div class="resource-item">
                    <h4>Swift进阶</h4>
                    <p>作者: 王巍(喵神)</p>
                </div>
            </div>
            
            <h3>7.4 开源项目</h3>
            <div class="resource-grid">
                <div class="resource-item">
                    <h4>Alamofire</h4>
                    <p>网络请求库，使用元组处理HTTP响应</p>
                    <p><a href="https://github.com/Alamofire/Alamofire" target="_blank">GitHub链接</a></p>
                </div>
                <div class="resource-item">
                    <h4>SwifterSwift</h4>
                    <p>Swift扩展集合，包含元组相关的便捷方法</p>
                    <p><a href="https://github.com/SwifterSwift/SwifterSwift" target="_blank">GitHub链接</a></p>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>
