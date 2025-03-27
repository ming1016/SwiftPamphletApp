<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 基础 - 变量</title>
    <style>
        :root {
            --background-color: #e8f0e8;
            --card-background: rgba(255, 255, 255, 0.85);
            --text-color: #333;
            --heading-color: #2c3e50;
            --link-color: #3498db;
            --code-background: #f8f8f8;
            --card-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            --gradient-start: #FFD966;
            --gradient-end: #FF7F50;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #1e2429;
                --card-background: rgba(40, 44, 52, 0.85);
                --text-color: #eee;
                --heading-color: #8eb3ed;
                --link-color: #61afef;
                --code-background: #282c34;
                --card-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: var(--background-color);
            color: var(--text-color);
        }

        .gradient-background {
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            min-height: 200px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: -1;
        }

        .navbar {
            position: sticky;
            top: 0;
            background-color: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 16px 24px;
            z-index: 1000;
        }

        @media (prefers-color-scheme: dark) {
            .navbar {
                background-color: rgba(30, 36, 41, 0.85);
            }
        }

        .navbar h1 {
            margin: 0;
            font-size: 1.5rem;
            color: var(--heading-color);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px;
        }

        .header {
            text-align: center;
            padding: 60px 0 30px;
        }

        .header h1 {
            font-size: 3rem;
            margin-bottom: 16px;
            color: var(--heading-color);
        }

        .card {
            background-color: var(--card-background);
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            padding: 24px;
            margin-bottom: 32px;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .section-title {
            color: var(--heading-color);
            border-bottom: 2px solid var(--gradient-end);
            padding-bottom: 8px;
            margin-top: 0;
        }

        pre {
            background-color: var(--code-background);
            border-radius: 8px;
            padding: 16px;
            overflow-x: auto;
            margin: 20px 0;
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.95em;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .example-card {
            background-color: rgba(52, 152, 219, 0.1);
            border-left: 4px solid var(--link-color);
            padding: 16px;
            margin: 20px 0;
            border-radius: 8px;
        }

        .note-card {
            background-color: rgba(241, 196, 15, 0.1);
            border-left: 4px solid #f1c40f;
            padding: 16px;
            margin: 20px 0;
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        @media (prefers-color-scheme: dark) {
            th, td {
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }
        }

        th {
            background-color: rgba(0, 0, 0, 0.05);
        }

        @media (prefers-color-scheme: dark) {
            th {
                background-color: rgba(255, 255, 255, 0.05);
            }
        }

        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 24px;
        }

        .resource-card {
            background-color: var(--card-background);
            border-radius: 12px;
            padding: 16px;
            box-shadow: var(--card-shadow);
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .card {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="gradient-background"></div>
    
    <div class="navbar">
        <h1>Swift 开发技术手册</h1>
    </div>
    
    <div class="container">
        <div class="header">
            <h1>Swift 基础 - 变量</h1>
            <p>了解 Swift 中变量的基本概念、声明方式和使用技巧</p>
        </div>
        
        <div class="card">
            <h2 class="section-title">变量与常量的基本概念</h2>
            <p>变量是程序中可以存储和修改数据的命名存储空间，而常量一旦赋值后就不能修改。Swift 使用关键字 <code>var</code> 声明变量，用 <code>let</code> 声明常量。</p>

            <div class="example-card">
                <h3>基本示例</h3>
                <pre><code>// 声明变量
var greeting = "你好，世界"
greeting = "Hello, world"  // 变量可以修改

// 声明常量
let maximumLoginAttempts = 3
// maximumLoginAttempts = 5  // 错误：常量不能被修改</code></pre>
            </div>

            <div class="note-card">
                <h3>最佳实践</h3>
                <p>Swift 鼓励尽可能使用常量（let）而不是变量（var），这样可以使代码更安全、更清晰。只有在需要修改值的情况下才使用变量。</p>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">类型注解与类型推断</h2>
            <p>Swift 是一种类型安全的语言。你可以在声明变量时显式指定类型（类型注解），也可以让 Swift 自动推断类型（类型推断）。</p>

            <svg width="100%" height="200" viewBox="0 0 800 200" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .text { font-family: sans-serif; font-size: 14px; fill: var(--text-color); }
                    .arrow { stroke: var(--text-color); stroke-width: 2; fill: none; }
                    .box { fill: rgba(52, 152, 219, 0.2); stroke: #3498db; stroke-width: 2; }
                    .highlight { fill: rgba(231, 76, 60, 0.2); stroke: #e74c3c; stroke-width: 2; }
                </style>
                <rect x="50" y="30" width="700" height="40" class="box" rx="5" />
                <text x="60" y="55" class="text">var temperature = 27.5</text>
                <text x="400" y="55" class="text">// Swift 自动推断为 Double 类型</text>

                <rect x="50" y="90" width="700" height="40" class="box" rx="5" />
                <text x="60" y="115" class="text">var temperature: Double = 27.5</text>
                <rect x="196" y="95" width="70" height="30" class="highlight" rx="3" />
                <text x="400" y="115" class="text">// 显式指定类型为 Double</text>
                
                <path d="M400,160 L400,140 L380,140 L420,140" class="arrow" />
                <text x="320" y="180" class="text">类型注解（Type Annotation）</text>
            </svg>

            <div class="example-card">
                <h3>类型注解示例</h3>
                <pre><code>// 使用类型注解
var name: String = "张三"
var age: Int = 30
var height: Double = 175.5
var isStudent: Bool = true

// 使用类型推断
var city = "北京"        // 推断为 String
var population = 21540000 // 推断为 Int
var temperature = 27.5    // 推断为 Double
var isCapital = true      // 推断为 Bool</code></pre>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">Swift 基本数据类型</h2>
            <p>Swift 提供了多种基本数据类型，包括整数、浮点数、布尔值和字符串等。</p>

            <table>
                <thead>
                    <tr>
                        <th>类型</th>
                        <th>描述</th>
                        <th>示例</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Int</td>
                        <td>整数类型，根据平台可能是 Int32 或 Int64</td>
                        <td><code>let score = 100</code></td>
                    </tr>
                    <tr>
                        <td>UInt</td>
                        <td>无符号整数类型</td>
                        <td><code>let count: UInt = 50</code></td>
                    </tr>
                    <tr>
                        <td>Float</td>
                        <td>32 位浮点数</td>
                        <td><code>let height: Float = 175.5</code></td>
                    </tr>
                    <tr>
                        <td>Double</td>
                        <td>64 位浮点数（默认的小数类型）</td>
                        <td><code>let pi = 3.14159265359</code></td>
                    </tr>
                    <tr>
                        <td>Bool</td>
                        <td>布尔值，只能是 true 或 false</td>
                        <td><code>let isEnabled = true</code></td>
                    </tr>
                    <tr>
                        <td>String</td>
                        <td>文本字符串</td>
                        <td><code>let message = "你好"</code></td>
                    </tr>
                    <tr>
                        <td>Character</td>
                        <td>单个字符</td>
                        <td><code>let symbol: Character = "¥"</code></td>
                    </tr>
                </tbody>
            </table>

            <div class="example-card">
                <h3>数值字面量示例</h3>
                <pre><code>// 整数字面量
let decimal = 17         // 十进制
let binary = 0b10001     // 二进制，值为 17
let octal = 0o21         // 八进制，值为 17
let hexadecimal = 0x11   // 十六进制，值为 17

// 浮点数字面量
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1  // 12.1875
let hexadecimalDouble = 0xC.3p0 // 12.1875

// 数字可读性
let oneMillion = 1_000_000       // 使用下划线分隔，提高可读性
let creditCardNumber = 1234_5678_9012_3456
let pi = 3.141_592_653_589_793</code></pre>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">类型转换</h2>
            <p>Swift 是类型安全的，不同类型之间的转换必须显式进行。</p>

            <svg width="100%" height="180" viewBox="0 0 800 180" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .text { font-family: sans-serif; font-size: 14px; fill: var(--text-color); }
                    .arrow { stroke: var(--text-color); stroke-width: 2; marker-end: url(#arrowhead); }
                    .type-box { fill: rgba(52, 152, 219, 0.2); stroke: #3498db; stroke-width: 2; rx: 10; }
                </style>
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)" />
                    </marker>
                </defs>
                <rect x="100" y="40" width="150" height="50" class="type-box" />
                <text x="175" y="70" class="text" text-anchor="middle">Int: 42</text>
                
                <rect x="500" y="40" width="150" height="50" class="type-box" />
                <text x="575" y="70" class="text" text-anchor="middle">String: "42"</text>
                
                <line x1="250" y1="65" x2="490" y2="65" class="arrow" />
                <text x="370" y="50" class="text" text-anchor="middle">String(42)</text>
                
                <rect x="100" y="120" width="150" height="50" class="type-box" />
                <text x="175" y="150" class="text" text-anchor="middle">String: "42"</text>
                
                <rect x="500" y="120" width="150" height="50" class="type-box" />
                <text x="575" y="150" class="text" text-anchor="middle">Int: 42</text>
                
                <line x1="250" y1="145" x2="490" y2="145" class="arrow" />
                <text x="370" y="130" class="text" text-anchor="middle">Int("42")</text>
            </svg>

            <div class="example-card">
                <h3>类型转换示例</h3>
                <pre><code>// 整数和浮点数之间的转换
let integer = 42
let double = Double(integer)       // 42.0

let pi = 3.14159
let integerPi = Int(pi)            // 3 (截断小数部分)

// 数值和字符串之间的转换
let intString = String(integer)    // "42"
let doubleString = String(double)  // "42.0"
let formatted = String(format: "%.2f", pi)  // "3.14"

// 字符串转数值
if let parsedInt = Int("42") {
    print("转换成功：\(parsedInt)")
} else {
    print("转换失败")
}

// 注意：无效转换会返回 nil
let invalidNumber = Int("42a")     // 返回 nil，因为 "42a" 不是有效整数</code></pre>
            </div>

            <div class="note-card">
                <h3>安全转换提示</h3>
                <p>从字符串转换为数值类型时，如果字符串不包含有效数值，转换会失败并返回 nil。因此必须使用可选绑定（if let）或强制解包来处理结果。</p>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">变量作用域</h2>
            <p>变量的作用域决定了它可以被访问的范围。Swift 中的变量可以有全局作用域、函数作用域或代码块作用域。</p>

            <div class="example-card">
                <h3>作用域示例</h3>
                <pre><code>// 全局变量
var globalVar = "我是全局变量"

func demonstrateScope() {
    // 函数作用域变量
    var functionVar = "我是函数作用域变量"
    print(globalVar)      // 可以访问全局变量
    print(functionVar)    // 可以访问函数作用域变量
    
    // if 代码块作用域
    if true {
        var blockVar = "我是代码块作用域变量"
        print(globalVar)      // 可以访问全局变量
        print(functionVar)    // 可以访问函数作用域变量
        print(blockVar)       // 可以访问代码块作用域变量
    }
    
    // 这里不能访问 blockVar
    // print(blockVar)  // 错误：找不到名称 'blockVar'
}

// 这里不能访问 functionVar
// print(functionVar)  // 错误：找不到名称 'functionVar'</code></pre>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">可选类型 (Optionals)</h2>
            <p>可选类型是 Swift 的一个重要特性，表示一个变量可以有值，也可以没有值（nil）。</p>

            <svg width="100%" height="230" viewBox="0 0 800 230" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .text { font-family: sans-serif; font-size: 14px; fill: var(--text-color); }
                    .label { font-family: sans-serif; font-size: 12px; fill: var(--text-color); }
                    .box { fill: rgba(52, 152, 219, 0.2); stroke: #3498db; stroke-width: 2; }
                    .optional-box { fill: rgba(231, 76, 60, 0.1); stroke: #e74c3c; stroke-width: 2; }
                    .value-box { fill: rgba(46, 204, 113, 0.2); stroke: #2ecc71; stroke-width: 2; }
                    .nil-box { fill: rgba(189, 195, 199, 0.4); stroke: #bdc3c7; stroke-width: 2; }
                </style>
                
                <text x="50" y="30" class="text">非可选类型</text>
                <rect x="50" y="40" width="300" height="60" class="box" rx="5" />
                <text x="200" y="75" class="text" text-anchor="middle">String: "Hello"</text>
                
                <text x="450" y="30" class="text">可选类型</text>
                <rect x="450" y="40" width="300" height="60" class="optional-box" rx="5" />
                <rect x="470" y="50" width="260" height="40" class="value-box" rx="5" />
                <text x="600" y="75" class="text" text-anchor="middle">String?: "Hello"</text>
                
                <text x="50" y="140" class="text">不能为 nil（会报错）</text>
                <rect x="50" y="150" width="300" height="60" class="box" rx="5" stroke-dasharray="5,5" />
                <text x="200" y="185" class="text" text-anchor="middle" fill="#e74c3c">❌ 不允许 nil</text>
                
                <text x="450" y="140" class="text">可以为 nil（有效值）</text>
                <rect x="450" y="150" width="300" height="60" class="optional-box" rx="5" />
                <rect x="470" y="160" width="260" height="40" class="nil-box" rx="5" />
                <text x="600" y="185" class="text" text-anchor="middle">String?: nil</text>
            </svg>

            <div class="example-card">
                <h3>可选类型示例</h3>
                <pre><code>// 声明可选类型
var name: String? = "张三"
var age: Int? = 30

// 可选类型可以为 nil
name = nil
age = nil

// 可选绑定
if let unwrappedName = name {
    print("名字是 \(unwrappedName)")
} else {
    print("名字为 nil")
}

// 使用 guard let 解包
func greet(name: String?) {
    guard let unwrappedName = name else {
        print("你好，陌生人")
        return
    }
    
    print("你好，\(unwrappedName)")
}

// 使用 nil 合并运算符
let defaultName = "访客"
let displayName = name ?? defaultName  // 如果 name 为 nil，则使用默认值

// 可选链
struct Person {
    var address: Address?
}

struct Address {
    var city: String
}

let person: Person? = Person(address: Address(city: "上海"))
let city = person?.address?.city  // 类型为 String?</code></pre>
            </div>

            <div class="note-card">
                <h3>强制解包</h3>
                <p>使用感叹号（!）可以强制解包可选值，但如果可选值为 nil，会导致运行时错误。只有在确定可选值不为 nil 时才应使用强制解包。</p>
                <pre><code>let number: Int? = 42
let unwrappedNumber = number!  // 确定 number 不是 nil 时可以这样做

// 隐式解包可选类型
var implicitOptional: String! = "Hello"
let implicitUnwrapped: String = implicitOptional  // 不需要使用 ! 解包</code></pre>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">属性</h2>
            <p>Swift 中的属性分为存储属性（存储实际值）和计算属性（计算值）。</p>

            <div class="example-card">
                <h3>存储属性与计算属性</h3>
                <pre><code>struct Rectangle {
    // 存储属性
    var width: Double
    var height: Double
    
    // 计算属性
    var area: Double {
        get {
            return width * height
        }
    }
    
    // 同时具有 getter 和 setter 的计算属性
    var perimeter: Double {
        get {
            return 2 * (width + height)
        }
        set(newPerimeter) {
            // 假设宽高比保持不变
            let ratio = width / height
            height = newPerimeter / (2 * (1 + ratio))
            width = height * ratio
        }
    }
}</code></pre>
            </div>

            <div class="example-card">
                <h3>属性观察器</h3>
                <pre><code>class StepCounter {
    // 带有属性观察器的存储属性
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("即将更新步数到 \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("新增了 \(totalSteps - oldValue) 步")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// 打印: 即将更新步数到 200
// 打印: 新增了 200 步

stepCounter.totalSteps = 360
// 打印: 即将更新步数到 360
// 打印: 新增了 160 步</code></pre>
            </div>

            <div class="example-card">
                <h3>懒加载属性</h3>
                <pre><code>class DataManager {
    // 懒加载属性：直到第一次被访问时才初始化
    lazy var data: [String] = {
        // 这个闭包会在首次访问 data 时执行
        print("正在加载大量数据...")
        // 模拟加载大量数据
        var result = [String]()
        for i in 1...1000 {
            result.append("数据项 \(i)")
        }
        return result
    }()
}

let manager = DataManager()
// 此时 data 还未被初始化

print("准备访问数据")
print("第一项: \(manager.data[0])")
// 打印：正在加载大量数据...
// 打印：第一项: 数据项 1

// 再次访问时不会重新初始化
print("再次访问: \(manager.data[1])")
// 打印：再次访问: 数据项 2</code></pre>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">类型属性</h2>
            <p>类型属性属于类型本身，而不是类型的实例。类型属性使用 <code>static</code> 关键字（在类中，可以用 <code>class</code> 关键字来允许子类重写）。</p>

            <div class="example-card">
                <h3>类型属性示例</h3>
                <pre><code>struct SomeStructure {
    // 存储类型属性
    static var storedTypeProperty = "某些值"
    
    // 计算类型属性
    static var computedTypeProperty: Int {
        return 42
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "某些枚举值"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    // 类型属性（用 static 修饰）
    static var storedTypeProperty = "某些类值"
    static var computedTypeProperty: Int {
        return 27
    }
    
    // 可被子类重写的类型属性（用 class 修饰）
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// 访问类型属性
print(SomeStructure.storedTypeProperty)  // 某些值
print(SomeEnumeration.computedTypeProperty)  // 6
print(SomeClass.overrideableComputedTypeProperty)  // 107

// 修改类型属性
SomeStructure.storedTypeProperty = "另一个值"
print(SomeStructure.storedTypeProperty)  // 另一个值</code></pre>
            </div>
        </div>

        <div class="card">
            <h2 class="section-title">资源推荐</h2>
            <div class="resources">
                <div class="resource-card">
                    <h3>官方文档</h3>
                    <ul>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html" target="_blank">Swift 官方文档 - 基础</a></li>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Properties.html" target="_blank">Swift 官方文档 - 属性</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift" target="_blank">Apple 开发者文档 - Swift</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h3>推荐书籍</h3>
                    <ul>
                        <li>《Swift 编程权威指南》（The Swift Programming Language）- Apple 官方</li>
                        <li>《Swift 进阶》- 王巍（又名 objc 中国）</li>
                        <li>《Hacking with Swift》- Paul Hudson</li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h3>优质博客</h3>
                    <ul>
                        <li><a href="https://www.hackingwithswift.com" target="_blank">Hacking with Swift</a></li>
                        <li><a href="https://www.swiftbysundell.com" target="_blank">Swift by Sundell</a></li>
                        <li><a href="https://onevcat.com" target="_blank">OneV's Den - 王巍的博客</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h3>教学视频</h3>
                    <ul>
                        <li><a href="https://developer.apple.com/videos/swift" target="_blank">Apple WWDC Swift 相关视频</a></li>
                        <li><a href="https://www.raywenderlich.com/ios/videos" target="_blank">raywenderlich.com Swift 视频教程</a></li>
                        <li><a href="https://www.youtube.com/c/CodeWithChris" target="_blank">Code with Chris - YouTube 频道</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h3>开源项目</h3>
                    <ul>
                        <li><a href="https://github.com/apple/swift" target="_blank">Swift 语言官方仓库</a></li>
                        <li><a href="https://github.com/vsouza/awesome-ios" target="_blank">awesome-ios - iOS 生态资源集合</a></li>
                        <li><a href="https://github.com/matteocrippa/awesome-swift" target="_blank">awesome-swift - Swift 资源集合</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
