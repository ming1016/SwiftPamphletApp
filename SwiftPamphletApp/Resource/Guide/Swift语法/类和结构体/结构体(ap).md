<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 结构体 - Apple 开发技术手册</title>
    <style>
        :root {
            --bg-color: #ffffff;
            --text-color: #333333;
            --primary-color: #6a1b9a;
            --secondary-color: #00b8d4;
            --accent-color: #ff9800;
            --accent-secondary: #ff6d00;
            --card-bg: #ffffff;
            --code-bg: #f5f5f5;
            --shadow-color: rgba(0, 0, 0, 0.15);
            --border-color: #e0e0e0;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --bg-color: #1a1a2e;
                --text-color: #e0e0e0;
                --primary-color: #9c64a6;
                --secondary-color: #00e5ff;
                --accent-color: #ffb74d;
                --accent-secondary: #ffa726;
                --card-bg: #2d2d42;
                --code-bg: #272741;
                --shadow-color: rgba(0, 0, 0, 0.3);
                --border-color: #444464;
            }
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }
        
        header {
            position: relative;
            padding: 40px 20px;
            margin-bottom: 40px;
            background-color: var(--primary-color);
            border-radius: 15px;
            box-shadow: 0 8px 30px var(--shadow-color);
            overflow: hidden;
            transform: rotate(-1deg);
        }
        
        header::before {
            content: '';
            position: absolute;
            top: -10px;
            right: -10px;
            bottom: -10px;
            left: -10px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            z-index: -1;
            transform: rotate(2deg);
            border-radius: 15px;
        }
        
        h1 {
            color: white;
            font-size: 2.5rem;
            margin-top: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            transform: rotate(1deg);
        }
        
        h2 {
            color: var(--primary-color);
            border-bottom: 3px solid var(--accent-color);
            padding-bottom: 8px;
            margin-top: 40px;
            position: relative;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: var(--accent-secondary);
        }
        
        h3 {
            color: var(--secondary-color);
            margin-top: 30px;
        }
        
        .card {
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 25px;
            margin: 25px 0;
            box-shadow: 0 5px 15px var(--shadow-color);
            position: relative;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transform: rotate(0.3deg);
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: -2px;
            right: -2px;
            bottom: -2px;
            left: -2px;
            z-index: -1;
            background: linear-gradient(135deg, var(--accent-color), var(--secondary-color));
            border-radius: 14px;
            transform: rotate(-0.5deg);
        }
        
        .tip {
            background-color: rgba(0, 184, 212, 0.1);
            border-left: 4px solid var(--secondary-color);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 8px 8px 0;
        }
        
        .warning {
            background-color: rgba(255, 152, 0, 0.1);
            border-left: 4px solid var(--accent-color);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 8px 8px 0;
        }
        
        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            background-color: var(--code-bg);
            padding: 2px 5px;
            border-radius: 4px;
            font-size: 90%;
        }
        
        pre {
            background-color: var(--code-bg);
            padding: 15px;
            border-radius: 8px;
            overflow-x: auto;
            position: relative;
            border: 1px solid var(--border-color);
        }
        
        pre code {
            background-color: transparent;
            padding: 0;
        }
        
        .example-title {
            position: absolute;
            top: 0;
            right: 15px;
            background-color: var(--secondary-color);
            color: white;
            padding: 2px 10px;
            border-radius: 0 0 8px 8px;
            font-size: 0.8rem;
        }
        
        .resources {
            margin-top: 50px;
            padding: 20px;
            background-color: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 5px 15px var(--shadow-color);
        }
        
        .resource-category {
            margin-bottom: 20px;
        }
        
        .resource-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        
        .resource-link {
            display: inline-block;
            padding: 8px 15px;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 20px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px var(--shadow-color);
        }
        
        .resource-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px var(--shadow-color);
            background-color: var(--secondary-color);
        }
        
        .comparison-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        
        .comparison-table th,
        .comparison-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        
        .comparison-table th {
            background-color: var(--primary-color);
            color: white;
        }
        
        .comparison-table tr:nth-child(even) {
            background-color: rgba(106, 27, 154, 0.05);
        }
        
        @media (max-width: 768px) {
            h1 {
                font-size: 2rem;
            }
            
            .container {
                padding: 10px;
            }
            
            .card {
                padding: 15px;
            }
            
            .comparison-table th,
            .comparison-table td {
                padding: 8px;
            }
        }
        
        .paper-curl {
            position: relative;
        }
        
        .paper-curl::after {
            content: '';
            position: absolute;
            bottom: -5px;
            right: -5px;
            width: 25px;
            height: 25px;
            background: linear-gradient(135deg, transparent 50%, var(--accent-color) 50%);
            border-radius: 0 0 0 5px;
            box-shadow: -2px 2px 5px rgba(0,0,0,0.2);
            transform: rotate(3deg);
        }
        
        .diagram-container {
            margin: 30px 0;
            text-align: center;
        }
        
        .collapsible {
            background-color: var(--primary-color);
            color: white;
            cursor: pointer;
            padding: 18px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 15px;
            border-radius: 8px;
            margin-top: 10px;
        }
        
        .active, .collapsible:hover {
            background-color: var(--secondary-color);
        }
        
        .content {
            padding: 0 18px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.2s ease-out;
            background-color: var(--card-bg);
            border-radius: 0 0 8px 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Swift 结构体（Struct）详解</h1>
        </header>
        
        <section class="card">
            <h2>结构体概述</h2>
            <p>结构体是 Swift 中一种基本的自定义数据类型，可以封装数据和相关功能。结构体是<strong>值类型</strong>，在赋值或传递时会被复制，而不是引用原始数据。</p>
            
            <div class="diagram-container">
                <svg width="600" height="220" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
                            <feDropShadow dx="3" dy="3" stdDeviation="2" flood-color="#000" flood-opacity="0.3"/>
                        </filter>
                    </defs>
                    <!-- 结构体框架 -->
                    <rect x="50" y="30" width="220" height="160" rx="10" fill="#9c64a6" filter="url(#shadow)"/>
                    <text x="160" y="55" font-family="Arial" font-size="16" fill="white" text-anchor="middle">结构体 (Struct)</text>
                    
                    <!-- 属性部分 -->
                    <rect x="70" y="70" width="180" height="50" rx="5" fill="#00e5ff" filter="url(#shadow)"/>
                    <text x="160" y="95" font-family="Arial" font-size="14" fill="#333" text-anchor="middle">属性 (Properties)</text>
                    
                    <!-- 方法部分 -->
                    <rect x="70" y="130" width="180" height="50" rx="5" fill="#ffb74d" filter="url(#shadow)"/>
                    <text x="160" y="155" font-family="Arial" font-size="14" fill="#333" text-anchor="middle">方法 (Methods)</text>
                    
                    <!-- 类框架 -->
                    <rect x="330" y="30" width="220" height="160" rx="10" fill="#6a1b9a" filter="url(#shadow)"/>
                    <text x="440" y="55" font-family="Arial" font-size="16" fill="white" text-anchor="middle">类 (Class)</text>
                    
                    <!-- 属性部分 -->
                    <rect x="350" y="70" width="180" height="50" rx="5" fill="#00e5ff" filter="url(#shadow)"/>
                    <text x="440" y="95" font-family="Arial" font-size="14" fill="#333" text-anchor="middle">属性 (Properties)</text>
                    
                    <!-- 方法部分 -->
                    <rect x="350" y="130" width="180" height="50" rx="5" fill="#ffb74d" filter="url(#shadow)"/>
                    <text x="440" y="155" font-family="Arial" font-size="14" fill="#333" text-anchor="middle">方法 (Methods)</text>
                    
                    <!-- 区别文字 -->
                    <text x="160" y="210" font-family="Arial" font-size="14" fill="var(--text-color)" text-anchor="middle">值类型 (Value Type)</text>
                    <text x="440" y="210" font-family="Arial" font-size="14" fill="var(--text-color)" text-anchor="middle">引用类型 (Reference Type)</text>
                </svg>
            </div>
        </section>
        
        <section class="card">
            <h2>结构体声明与初始化</h2>
            
            <h3>基本语法</h3>
            <p>Swift 中声明结构体的基本语法如下：</p>
            
            <pre><code>struct 结构体名称 {
    // 属性
    // 方法
    // 初始化方法
    // 下标等
}</code></pre>

            <div class="tip">
                <p>Swift 会自动为结构体生成一个包含所有存储属性的默认初始化方法，称为成员初始化器（Memberwise Initializer）。</p>
            </div>
            
            <h3>示例：创建一个表示点的结构体</h3>
            <pre><code>// 声明一个点结构体
struct Point {
    // 存储属性
    var x: Double
    var y: Double
    
    // 自定义初始化方法
    init() {
        x = 0
        y = 0
    }
    
    // 计算属性
    var description: String {
        return "Point(x: \(x), y: \(y))"
    }
    
    // 方法
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

// 使用默认成员初始化器创建实例
let point1 = Point(x: 10.5, y: 15.0)

// 使用自定义初始化方法创建实例
let origin = Point()

// 使用点语法访问属性
print(point1.x)  // 输出: 10.5
print(point1.description)  // 输出: Point(x: 10.5, y: 15.0)

// 创建可变实例，并调用修改方法
var movingPoint = Point(x: 5.0, y: 5.0)
movingPoint.moveBy(x: 2.0, y: 3.0)
print(movingPoint.description)  // 输出: Point(x: 7.0, y: 8.0)</code></pre>

        </section>
        
        <section class="card">
            <h2>结构体的特性</h2>
            
            <h3>值类型行为</h3>
            <p>结构体是值类型，这意味着它在赋值或传递时会被复制，而不是共享引用。</p>
            
            <div class="diagram-container">
                <svg width="600" height="300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <filter id="shadow2" x="-20%" y="-20%" width="140%" height="140%">
                            <feDropShadow dx="3" dy="3" stdDeviation="2" flood-color="#000" flood-opacity="0.3"/>
                        </filter>
                    </defs>
                    <!-- 标题 -->
                    <text x="300" y="30" font-family="Arial" font-size="16" fill="var(--text-color)" text-anchor="middle" font-weight="bold">结构体（值类型）vs 类（引用类型）赋值比较</text>
                    
                    <!-- 结构体示例 -->
                    <rect x="50" y="60" width="220" height="90" rx="10" fill="#9c64a6" filter="url(#shadow2)"/>
                    <text x="160" y="85" font-family="Arial" font-size="14" fill="white" text-anchor="middle">var struct1 = MyStruct(value: 10)</text>
                    <rect x="90" y="100" width="140" height="30" rx="5" fill="#00e5ff" filter="url(#shadow2)"/>
                    <text x="160" y="120" font-family="Arial" font-size="12" fill="#333" text-anchor="middle">value: 10</text>
                    
                    <rect x="50" y="180" width="220" height="90" rx="10" fill="#9c64a6" filter="url(#shadow2)"/>
                    <text x="160" y="205" font-family="Arial" font-size="14" fill="white" text-anchor="middle">var struct2 = struct1</text>
                    <rect x="90" y="220" width="140" height="30" rx="5" fill="#00e5ff" filter="url(#shadow2)"/>
                    <text x="160" y="240" font-family="Arial" font-size="12" fill="#333" text-anchor="middle">value: 10</text>
                    
                    <!-- 箭头 -->
                    <text x="160" y="165" font-family="Arial" font-size="14" fill="var(--text-color)" text-anchor="middle">数据复制</text>
                    <path d="M160 150 L160 180" stroke="var(--text-color)" stroke-width="2" fill="none" marker-end="url(#arrowhead)"/>
                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)"/>
                        </marker>
                    </defs>
                    
                    <!-- 类示例 -->
                    <rect x="330" y="60" width="220" height="90" rx="10" fill="#6a1b9a" filter="url(#shadow2)"/>
                    <text x="440" y="85" font-family="Arial" font-size="14" fill="white" text-anchor="middle">var class1 = MyClass(value: 10)</text>
                    <rect x="370" y="100" width="140" height="30" rx="5" fill="#00e5ff" filter="url(#shadow2)"/>
                    <text x="440" y="120" font-family="Arial" font-size="12" fill="#333" text-anchor="middle">value: 10</text>
                    
                    <rect x="330" y="180" width="220" height="90" rx="10" fill="#6a1b9a" filter="url(#shadow2)"/>
                    <text x="440" y="205" font-family="Arial" font-size="14" fill="white" text-anchor="middle">var class2 = class1</text>
                    
                    <!-- 箭头 -->
                    <text x="440" y="165" font-family="Arial" font-size="14" fill="var(--text-color)" text-anchor="middle">引用相同对象</text>
                    <path d="M440 130 C480 165, 400 165, 440 200" stroke="var(--text-color)" stroke-width="2" fill="none" marker-end="url(#arrowhead)"/>
                </svg>
            </div>
            
            <pre><code>// 结构体的值类型行为示例
struct Size {
    var width: Double
    var height: Double
}

// 创建一个实例
var originalSize = Size(width: 10.0, height: 20.0)

// 赋值给另一个变量会创建一个完整的复制
var copiedSize = originalSize

// 修改复制后的实例
copiedSize.width = 30.0

// 原始实例不受影响
print("原始尺寸: \(originalSize.width) x \(originalSize.height)")  // 输出: 10.0 x 20.0
print("复制尺寸: \(copiedSize.width) x \(copiedSize.height)")      // 输出: 30.0 x 20.0</code></pre>

            <h3>结构体的可变性</h3>
            <p>在结构体中，要修改实例的属性，方法必须标记为 <code>mutating</code>。</p>
            
            <pre><code>struct Counter {
    var count: Int = 0
    
    // 标记为 mutating，表示这个方法会修改结构体的属性
    mutating func increment() {
        count += 1
    }
    
    // 非 mutating 方法不能修改属性
    func display() -> String {
        return "当前计数: \(count)"
    }
}

var counter = Counter()
counter.increment()  // 正确
print(counter.display())  // 输出: 当前计数: 1

// 如果实例是常量，则无法调用 mutating 方法
let fixedCounter = Counter()
// fixedCounter.increment()  // 错误：无法调用常量结构体实例的 mutating 方法</code></pre>
        </section>
        
        <section class="card">
            <h2>结构体与类的比较</h2>
            
            <p>结构体和类是 Swift 中两种主要的自定义类型，它们有很多相似之处，但也有显著的区别。</p>
            
            <table class="comparison-table">
                <tr>
                    <th>特性</th>
                    <th>结构体</th>
                    <th>类</th>
                </tr>
                <tr>
                    <td>类型</td>
                    <td>值类型</td>
                    <td>引用类型</td>
                </tr>
                <tr>
                    <td>继承</td>
                    <td>不支持</td>
                    <td>支持</td>
                </tr>
                <tr>
                    <td>初始化</td>
                    <td>自动提供成员初始化器</td>
                    <td>不提供成员初始化器</td>
                </tr>
                <tr>
                    <td>引用计数</td>
                    <td>不需要</td>
                    <td>使用 ARC 管理内存</td>
                </tr>
                <tr>
                    <td>析构</td>
                    <td>无析构函数</td>
                    <td>有 deinit 方法</td>
                </tr>
                <tr>
                    <td>类型转换</td>
                    <td>不支持运行时类型转换</td>
                    <td>支持运行时类型转换</td>
                </tr>
                <tr>
                    <td>内存分配</td>
                    <td>通常在栈上分配</td>
                    <td>在堆上分配</td>
                </tr>
            </table>
            
            <div class="warning">
                <p>关于何时选择结构体还是类的一般准则：</p>
                <ul>
                    <li>当数据表示简单且独立值时，首选结构体</li>
                    <li>当需要共享可变状态或需要继承时，使用类</li>
                    <li>Swift 标准库中的大多数数据类型（如 String、Array、Dictionary）都是结构体</li>
                </ul>
            </div>
        </section>
        
        <section class="card">
            <h2>结构体的实际应用</h2>
            
            <h3>几何图形与坐标</h3>
            <pre><code>// 表示二维和三维坐标点的结构体
struct Point2D {
    var x: Double
    var y: Double
    
    // 计算距离的方法
    func distanceTo(point: Point2D) -> Double {
        let deltaX = x - point.x
        let deltaY = y - point.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
}

struct Point3D {
    var x: Double
    var y: Double
    var z: Double
}

// 表示矩形的结构体
struct Rectangle {
    var origin: Point2D
    var size: Size
    
    // 计算面积的计算属性
    var area: Double {
        return size.width * size.height
    }
    
    // 检查点是否在矩形内的方法
    func contains(point: Point2D) -> Bool {
        return point.x >= origin.x && 
               point.x < origin.x + size.width &&
               point.y >= origin.y && 
               point.y < origin.y + size.height
    }
}

// 使用示例
let rect = Rectangle(origin: Point2D(x: 0, y: 0), 
                     size: Size(width: 100, height: 50))
let testPoint = Point2D(x: 50, y: 25)

print("矩形面积: \(rect.area)")  // 输出: 5000.0
print("点 (50, 25) 在矩形内: \(rect.contains(point: testPoint))")  // 输出: true</code></pre>

            <h3>值类型的数据模型</h3>
            <pre><code>// 表示用户配置的结构体
struct UserSettings {
    var username: String
    var isDarkModeEnabled: Bool
    var notificationsEnabled: Bool
    var fontSize: Int
    
    // 创建默认设置的静态方法
    static func defaultSettings() -> UserSettings {
        return UserSettings(
            username: "Guest",
            isDarkModeEnabled: false,
            notificationsEnabled: true,
            fontSize: 12
        )
    }
}

// 使用示例
var settings = UserSettings.defaultSettings()
print("当前用户: \(settings.username)")

// 修改设置
settings.isDarkModeEnabled = true
settings.fontSize = 14

// 创建设置的备份（因为是结构体，所以会复制）
let settingsBackup = settings

// 验证备份不会受到原始设置更改的影响
settings.username = "ActiveUser"
print("当前用户: \(settings.username)")         // 输出: ActiveUser
print("备份的用户: \(settingsBackup.username)") // 输出: Guest</code></pre>
            
            <h3>复杂数据类型的组合</h3>
            <pre><code>// 表示地址的结构体
struct Address {
    var street: String
    var city: String
    var state: String
    var zipCode: String
    var country: String
}

// 表示联系人的结构体
struct Contact {
    var name: String
    var phoneNumber: String
    var email: String
    var address: Address  // 嵌套结构体
    
    // 格式化地址的方法
    func formattedAddress() -> String {
        return """
        \(name)
        \(address.street)
        \(address.city), \(address.state) \(address.zipCode)
        \(address.country)
        """
    }
}

// 使用示例
let homeAddress = Address(
    street: "123 Swift Street",
    city: "Cupertino",
    state: "CA",
    zipCode: "95014",
    country: "USA"
)

let johnContact = Contact(
    name: "John Appleseed",
    phoneNumber: "408-555-1234",
    email: "john@example.com",
    address: homeAddress
)

print(johnContact.formattedAddress())
// 输出:
// John Appleseed
// 123 Swift Street
// Cupertino, CA 95014
// USA</code></pre>
        </section>
        
        <section class="card">
            <h2>结构体的高级特性</h2>
            
            <h3>扩展结构体</h3>
            <p>可以使用扩展（Extension）为已有的结构体添加新功能。</p>
            
            <pre><code>// 原始结构体
struct Temperature {
    var celsius: Double
    
    var fahrenheit: Double {
        return celsius * 9/5 + 32
    }
}

// 扩展结构体，添加新功能
extension Temperature {
    // 添加新的计算属性
    var kelvin: Double {
        return celsius + 273.15
    }
    
    // 添加新的初始化方法
    init(fahrenheit: Double) {
        celsius = (fahrenheit - 32) * 5/9
    }
    
    // 添加新的方法
    func isDangerous() -> Bool {
        return celsius > 60 || celsius < -20
    }
}

// 使用扩展后的功能
let boilingPoint = Temperature(celsius: 100)
print("沸点: \(boilingPoint.celsius)°C, \(boilingPoint.fahrenheit)°F, \(boilingPoint.kelvin)K")
// 输出: 沸点: 100.0°C, 212.0°F, 373.15K

let winterTemp = Temperature(fahrenheit: 14)
print("冬天温度: \(winterTemp.celsius)°C")
// 输出: 冬天温度: -10.0°C

print("这个温度危险吗? \(winterTemp.isDangerous())")
// 输出: 这个温度危险吗? false</code></pre>
            
            <h3>协议与结构体</h3>
            <p>结构体可以遵循协议（Protocol），实现协议要求的功能。</p>
            
            <pre><code>// 定义描述协议
protocol Describable {
    var description: String { get }
    func detailedDescription() -> String
}

// 定义可比较协议
protocol Comparable {
    func isGreaterThan(_ other: Self) -> Bool
}

// 实现两个协议的结构体
struct Product: Describable, Comparable {
    var name: String
    var price: Double
    var stockQuantity: Int
    
    // 实现 Describable 协议
    var description: String {
        return "\(name) - ¥\(price)"
    }
    
    func detailedDescription() -> String {
        return "\(name) - ¥\(price) (库存: \(stockQuantity)件)"
    }
    
    // 实现 Comparable 协议
    func isGreaterThan(_ other: Product) -> Bool {
        return self.price > other.price
    }
}

// 使用示例
let laptop = Product(name: "MacBook Pro", price: 9999, stockQuantity: 10)
let phone = Product(name: "iPhone", price: 6999, stockQuantity: 50)

print(laptop.description)  // 输出: MacBook Pro - ¥9999.0
print(phone.detailedDescription())  // 输出: iPhone - ¥6999.0 (库存: 50件)

if laptop.isGreaterThan(phone) {
    print("\(laptop.name) 比 \(phone.name) 贵")
} else {
    print("\(phone.name) 比 \(laptop.name) 贵")
}
// 输出: MacBook Pro 比 iPhone 贵</code></pre>

            <h3>泛型结构体</h3>
            <p>结构体可以使用泛型，提高代码的灵活性和复用性。</p>
            
            <pre><code>// 定义泛型结构体，可以存储任意类型的数据对
struct Pair<T, U> {
    var first: T
    var second: U
    
    // 交换两个值的位置，返回一个新的 Pair
    func swapped() -> Pair<U, T> {
        return Pair<U, T>(first: second, second: first)
    }
    
    // 将两个值都映射到新类型
    func map<V, W>(_ firstTransform: (T) -> V, _ secondTransform: (U) -> W) -> Pair<V, W> {
        return Pair<V, W>(
            first: firstTransform(first), 
            second: secondTransform(second)
        )
    }
}

// 使用示例
// 存储不同类型数据
let nameAndAge = Pair(first: "张三", second: 30)
print("姓名: \(nameAndAge.first), 年龄: \(nameAndAge.second)")
// 输出: 姓名: 张三, 年龄: 30

// 交换值
let ageAndName = nameAndAge.swapped()
print("年龄: \(ageAndName.first), 姓名: \(ageAndName.second)")
// 输出: 年龄: 30, 姓名: 张三

// 转换值
let userInfo = nameAndAge.map({ $0.uppercased() }, { "已工作\($0)年" })
print("用户: \(userInfo.first), 状态: \(userInfo.second)")
// 输出: 用户: 张三, 状态: 已工作30年</code></pre>
        </section>
        
        <section class="card">
            <h2>结构体性能优化</h2>
            
            <div class="tip">
                <p>结构体作为值类型，在某些情况下可能比类更高效。Swift 编译器会对结构体进行优化，例如通过复制优化（Copy-on-Write）来避免不必要的复制。</p>
            </div>
            
            <h3>Copy-on-Write 机制</h3>
            <pre><code>// 使用 Copy-on-Write 优化自定义结构体
struct OptimizedBuffer<T> {
    // 使用引用类型存储实际数据
    private var storage: [T]
    
    init(_ elements: [T] = []) {
        storage = elements
    }
    
    // 访问元素
    subscript(index: Int) -> T {
        get {
            return storage[index]
        }
        set {
            // 写入时才复制，实现 COW
            if !isKnownUniquelyReferenced(&storage) {
                storage = storage  // 创建存储的副本
            }
            storage[index] = newValue
        }
    }
    
    // 添加元素
    mutating func append(_ element: T) {
        // 写入时才复制，实现 COW
        if !isKnownUniquelyReferenced(&storage) {
            storage = storage  // 创建存储的副本
        }
        storage.append(element)
    }
    
    // 计算属性
    var count: Int {
        return storage.count
    }
}

// 使用示例
var buffer1 = OptimizedBuffer([1, 2, 3])
var buffer2 = buffer1  // 此时不会复制底层存储

print("Buffer1[0]: \(buffer1[0])")  // 输出: 1

// 修改 buffer2，触发 COW 机制
buffer2.append(4)

print("Buffer1 count: \(buffer1.count)")  // 输出: 3
print("Buffer2 count: \(buffer2.count)")  // 输出: 4</code></pre>

            <h3>内存布局优化</h3>
            <p>适当排列结构体内的属性，可以减少结构体大小和内存对齐问题。</p>
            
            <pre><code>// 结构体属性排序不佳，导致内存浪费
struct IneffientLayout {
    var byte: Int8      // 1 字节
    var integer: Int    // 8 字节 (64位系统)
    var anotherByte: Int8  // 1 字节
    var double: Double  // 8 字节
}
// 会有内存填充，实际占用超过18字节

// 优化后的结构体属性排序
struct OptimizedLayout {
    var integer: Int    // 8 字节
    var double: Double  // 8 字节
    var byte: Int8      // 1 字节
    var anotherByte: Int8  // 1 字节
}
// 占用更少的内存，更友好的内存对齐</code></pre>
        </section>
        
        <section class="resources">
            <h2>学习资源</h2>
            
            <div class="resource-category">
                <h3>官方文档</h3>
                <div class="resource-links">
                    <a href="https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html" class="resource-link" target="_blank">Swift 官方文档 - 类和结构体</a>
                    <a href="https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes" class="resource-link" target="_blank">Apple 开发者文档 - 选择结构体还是类</a>
                    <a href="https://docs.swift.org/swift-book/LanguageGuide/Properties.html" class="resource-link" target="_blank">Swift 官方文档 - 属性</a>
                </div>
            </div>
            
            <div class="resource-category">
                <h3>推荐博客</h3>
                <div class="resource-links">
                    <a href="https://www.hackingwithswift.com/articles/41/swift-structs-vs-classes" class="resource-link" target="_blank">Hacking with Swift - 结构体与类的比较</a>
                    <a href="https://www.swiftbysundell.com/articles/reference-and-value-types-in-swift/" class="resource-link" target="_blank">Swift by Sundell - 引用类型和值类型</a>
                    <a href="https://www.objc.io/issues/16-swift/swift-classes-vs-structs/" class="resource-link" target="_blank">objc.io - Swift 类与结构体</a>
                </div>
            </div>
            
            <div class="resource-category">
                <h3>推荐书籍</h3>
                <div class="resource-links">
                    <a href="https://www.amazon.com/Swift-Programming-Ranch-Guide-Guides/dp/0134610431" class="resource-link" target="_blank">Swift Programming: The Big Nerd Ranch Guide</a>
                    <a href="https://www.amazon.com/Advanced-Swift-Chris-Eidhof/dp/1973400073" class="resource-link" target="_blank">Advanced Swift</a>
                    <a href="https://www.manning.com/books/swift-in-depth" class="resource-link" target="_blank">Swift in Depth</a>
                </div>
            </div>
            
            <div class="resource-category">
                <h3>开源项目</h3>
                <div class="resource-links">
                    <a href="https://github.com/apple/swift" class="resource-link" target="_blank">Swift 官方仓库</a>
                    <a href="https://github.com/raywenderlich/swift-algorithm-club" class="resource-link" target="_blank">Swift Algorithm Club</a>
                    <a href="https://github.com/pointfreeco/swift-composable-architecture" class="resource-link" target="_blank">Swift Composable Architecture</a>
                </div>
            </div>
            
            <div class="resource-category">
                <h3>视频教程</h3>
                <div class="resource-links">
                    <a href="https://developer.apple.com/videos/play/wwdc2015/414/" class="resource-link" target="_blank">WWDC - 构建更好的应用：值语义</a>
                    <a href="https://www.coursera.org/learn/swift-programming" class="resource-link" target="_blank">Coursera - Swift 编程基础</a>
                    <a href="https://www.youtube.com/watch?v=V3ronF4Z1Qc" class="resource-link" target="_blank">Sean Allen - 结构体 vs 类</a>
                </div>
            </div>
        </section>
    </div>

    <script>
        // 折叠面板功能
        document.addEventListener('DOMContentLoaded', function() {
            var coll = document.getElementsByClassName("collapsible");
            for (var i = 0; i < coll.length; i++) {
                coll[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var content = this.nextElementSibling;
                    if (content.style.maxHeight) {
                        content.style.maxHeight = null;
                    } else {
                        content.style.maxHeight = content.scrollHeight + "px";
                    }
                });
            }
        });
    </script>
</body>
</html>
