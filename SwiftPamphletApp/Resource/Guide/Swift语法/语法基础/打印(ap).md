<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 打印详解</title>
    <style>
        :root {
            --primary-bg: #ffffff;
            --card-mint: #e8f5e9;
            --card-yellow: #fff9c4;
            --text-primary: #333333;
            --text-secondary: #888888;
            --code-bg: #f5f5f5;
            --border-color: #dddddd;
            --link-color: #2196F3;
            --shadow-color: rgba(0,0,0,0.1);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-bg: #121212;
                --card-mint: #1b2e22;
                --card-yellow: #2d2b1f;
                --text-primary: #e0e0e0;
                --text-secondary: #b0b0b0;
                --code-bg: #2d2d2d;
                --border-color: #444444;
                --link-color: #64B5F6;
                --shadow-color: rgba(0,0,0,0.3);
            }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background-color: var(--primary-bg);
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        h1, h2, h3, h4, h5, h6 {
            margin-top: 1.5em;
            margin-bottom: 0.5em;
            font-weight: 600;
        }

        h1 {
            font-size: 2.2em;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
            margin-top: 0;
        }

        h2 {
            font-size: 1.8em;
        }

        h3 {
            font-size: 1.5em;
        }

        p, ul, ol {
            margin-bottom: 1em;
            text-align: left;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .card {
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px var(--shadow-color);
        }

        .mint-card {
            background-color: var(--card-mint);
        }

        .yellow-card {
            background-color: var(--card-yellow);
        }

        pre {
            background-color: var(--code-bg);
            border-radius: 4px;
            padding: 15px;
            overflow-x: auto;
            margin-bottom: 1em;
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9em;
        }

        .note {
            font-style: italic;
            color: var(--text-secondary);
        }

        .resources {
            margin-top: 1.5em;
            padding-top: 1em;
            border-top: 1px solid var(--border-color);
        }

        .tag {
            display: inline-block;
            background-color: var(--link-color);
            color: white;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.8em;
            margin-right: 5px;
            margin-bottom: 5px;
        }

        .two-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .two-col {
                grid-template-columns: 1fr;
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1em;
        }

        th, td {
            text-align: left;
            padding: 8px 12px;
            border: 1px solid var(--border-color);
        }

        th {
            background-color: var(--card-mint);
        }

        .example-output {
            background-color: var(--code-bg);
            border-left: 4px solid #4CAF50;
            padding: 10px 15px;
            margin-bottom: 1em;
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
        }
        
        img, svg {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <h1>Swift 打印详解</h1>
    
    <p>在 Swift 编程中，打印功能是最基础也是最常用的调试和输出工具。本章将详细介绍 Swift 中的各种打印功能、技巧和最佳实践，帮助您更有效地使用这些工具进行开发和调试。</p>

    <div class="card mint-card">
        <h2>目录</h2>
        <ol>
            <li><a href="#basic-print">基础打印函数</a></li>
            <li><a href="#string-interpolation">字符串插值与格式化</a></li>
            <li><a href="#custom-print">自定义打印</a></li>
            <li><a href="#logging">日志系统</a></li>
            <li><a href="#console-redirection">控制台输出重定向</a></li>
            <li><a href="#file-output">文件输出</a></li>
            <li><a href="#performance">性能考量</a></li>
            <li><a href="#resources">学习资源</a></li>
        </ol>
    </div>

    <h2 id="basic-print">1. 基础打印函数</h2>

    <p>Swift 提供了几个内置的打印函数，每个都有其特定的用途。</p>

    <svg width="600" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
        <style>
            @media (prefers-color-scheme: dark) {
                .box { fill: #2d2d2d; stroke: #555; }
                .text { fill: #e0e0e0; }
                .arrow { stroke: #b0b0b0; }
            }
            @media (prefers-color-scheme: light) {
                .box { fill: #f5f5f5; stroke: #ccc; }
                .text { fill: #333; }
                .arrow { stroke: #666; }
            }
        </style>
        <rect class="box" x="50" y="30" width="150" height="60" rx="5" ry="5"/>
        <text class="text" x="125" y="55" text-anchor="middle" font-family="sans-serif">print()</text>
        <text class="text" x="125" y="75" text-anchor="middle" font-family="sans-serif" font-size="12">标准输出</text>
        
        <rect class="box" x="225" y="30" width="150" height="60" rx="5" ry="5"/>
        <text class="text" x="300" y="55" text-anchor="middle" font-family="sans-serif">dump()</text>
        <text class="text" x="300" y="75" text-anchor="middle" font-family="sans-serif" font-size="12">反射详细输出</text>
        
        <rect class="box" x="400" y="30" width="150" height="60" rx="5" ry="5"/>
        <text class="text" x="475" y="55" text-anchor="middle" font-family="sans-serif">debugPrint()</text>
        <text class="text" x="475" y="75" text-anchor="middle" font-family="sans-serif" font-size="12">调试输出</text>
        
        <rect class="box" x="225" y="120" width="150" height="60" rx="5" ry="5"/>
        <text class="text" x="300" y="145" text-anchor="middle" font-family="sans-serif">输出目标</text>
        <text class="text" x="300" y="165" text-anchor="middle" font-family="sans-serif" font-size="12">标准输出/错误/文件</text>
        
        <line class="arrow" x1="125" y1="90" x2="225" y2="140" stroke-width="2" marker-end="url(#arrow)"/>
        <line class="arrow" x1="300" y1="90" x2="300" y2="120" stroke-width="2" marker-end="url(#arrow)"/>
        <line class="arrow" x1="475" y1="90" x2="375" y2="140" stroke-width="2" marker-end="url(#arrow)"/>
        
        <defs>
            <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
                <path d="M0,0 L0,6 L9,3 z" class="arrow"/>
            </marker>
        </defs>
    </svg>

    <h3>print() 函数</h3>
    <p>最常用的打印函数，将内容输出到标准输出（通常是控制台）。</p>

    <pre><code>// 基本用法
print("Hello, World!")

// 多个参数
print("Name:", "Swift", "Version:", 5.5)

// 自定义分隔符
print("Swift", "is", "awesome", separator: "-")

// 自定义终止符（默认是换行符）
print("This won't end with a newline", terminator: "")
print(" and this will continue on the same line")

// 打印不同类型
let number = 42
let boolean = true
let array = [1, 2, 3]
print("Number:", number, "Boolean:", boolean, "Array:", array)
</code></pre>

    <div class="example-output">
        Hello, World!<br>
        Name: Swift Version: 5.5<br>
        Swift-is-awesome<br>
        This won't end with a newline and this will continue on the same line<br>
        Number: 42 Boolean: true Array: [1, 2, 3]
    </div>

    <h3>dump() 函数</h3>
    <p>用于显示对象的详细结构，特别适合复杂对象和自定义类型的调试。dump() 使用反射机制提供更详细的内部结构。</p>

    <pre><code>// 定义一个简单的结构体
struct Person {
    let name: String
    let age: Int
    let hobbies: [String]
}

// 创建实例
let person = Person(name: "Alice", age: 30, hobbies: ["Reading", "Coding", "Hiking"])

// 使用 print
print("使用 print:")
print(person)

// 使用 dump
print("\n使用 dump:")
dump(person)

// 限制输出深度
print("\n使用 dump 并限制深度为 1:")
dump(person, name: "人物信息", maxDepth: 1)
</code></pre>

    <div class="example-output">
        使用 print:<br>
        Person(name: "Alice", age: 30, hobbies: ["Reading", "Coding", "Hiking"])<br>
        <br>
        使用 dump:<br>
        ▿ Person<br>
        &nbsp;&nbsp;- name: "Alice"<br>
        &nbsp;&nbsp;- age: 30<br>
        &nbsp;&nbsp;▿ hobbies: 3 elements<br>
        &nbsp;&nbsp;&nbsp;&nbsp;- 0: "Reading"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;- 1: "Coding"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;- 2: "Hiking"<br>
        <br>
        使用 dump 并限制深度为 1:<br>
        ▿ 人物信息: Person<br>
        &nbsp;&nbsp;- name: "Alice"<br>
        &nbsp;&nbsp;- age: 30<br>
        &nbsp;&nbsp;▿ hobbies: 3 elements
    </div>

    <h3>debugPrint() 函数</h3>
    <p>类似于 print()，但会调用类型的 debugDescription 而不是 description，通常会提供更多调试信息。</p>

    <pre><code>let text = "Hello"
let array = [1, 2, 3]

print("使用 print:")
print(text)
print(array)

print("\n使用 debugPrint:")
debugPrint(text)
debugPrint(array)
</code></pre>

    <div class="example-output">
        使用 print:<br>
        Hello<br>
        [1, 2, 3]<br>
        <br>
        使用 debugPrint:<br>
        "Hello"<br>
        [1, 2, 3]
    </div>

    <div class="card yellow-card">
        <h3>打印函数对比</h3>
        <table>
            <thead>
                <tr>
                    <th>函数</th>
                    <th>主要用途</th>
                    <th>输出方式</th>
                    <th>适用场景</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>print()</td>
                    <td>一般输出</td>
                    <td>使用类型的 description</td>
                    <td>日常开发、用户展示</td>
                </tr>
                <tr>
                    <td>debugPrint()</td>
                    <td>调试输出</td>
                    <td>使用类型的 debugDescription</td>
                    <td>开发调试</td>
                </tr>
                <tr>
                    <td>dump()</td>
                    <td>详细结构展示</td>
                    <td>反射机制展示详细结构</td>
                    <td>复杂对象调试、结构分析</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h2 id="string-interpolation">2. 字符串插值与格式化</h2>

    <p>Swift 提供了强大的字符串插值功能，可以在字符串中嵌入表达式和格式化输出。</p>

    <h3>基本字符串插值</h3>

    <pre><code>let name = "Swift"
let version = 5.5
let year = 2021

// 基本插值
print("Welcome to \(name) \(version), released in \(year)!")

// 在插值中使用表达式
print("Next year will be \(year + 1)")
print("Version after 5 years: \(version + 5)")

// 使用三元运算符
let isNew = true
print("This version is \(isNew ? "new" : "old")")
</code></pre>

    <div class="example-output">
        Welcome to Swift 5.5, released in 2021!<br>
        Next year will be 2022<br>
        Version after 5 years: 10.5<br>
        This version is new
    </div>

    <h3>高级格式化</h3>

    <pre><code>import Foundation

let number = 123.456789
let date = Date()

// 数字格式化
let formatter = NumberFormatter()
formatter.numberStyle = .decimal
formatter.maximumFractionDigits = 2
print("格式化数字: \(formatter.string(from: NSNumber(value: number)) ?? "")")

// 百分比
formatter.numberStyle = .percent
print("百分比: \(formatter.string(from: 0.75 as NSNumber) ?? "")")

// 货币
formatter.numberStyle = .currency
formatter.locale = Locale(identifier: "zh_CN")
print("货币 (中国): \(formatter.string(from: 1234.56 as NSNumber) ?? "")")

// 日期格式化
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .full
dateFormatter.timeStyle = .medium
print("完整日期: \(dateFormatter.string(from: date))")

// 自定义日期格式
dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
print("自定义格式: \(dateFormatter.string(from: date))")
</code></pre>

    <div class="example-output">
        格式化数字: 123.46<br>
        百分比: 75%<br>
        货币 (中国): ¥1,234.56<br>
        完整日期: 2025年3月27日 星期四 下午12:00:00<br>
        自定义格式: 2025年03月27日 12:00
    </div>

    <h3>自定义字符串插值（Swift 5+）</h3>

    <pre><code>// 自定义格式化扩展
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Double, precision: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = precision
        if let result = formatter.string(from: NSNumber(value: value)) {
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(currency value: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        if let result = formatter.string(from: NSNumber(value: value)) {
            appendLiteral(result)
        }
    }
}

// 使用自定义字符串插值
let pi = 3.14159265359
print("Pi 保留 2 位小数: \(pi, precision: 2)")
print("Pi 保留 4 位小数: \(pi, precision: 4)")
print("价格: \(currency: 1299.99)")
</code></pre>

    <div class="example-output">
        Pi 保留 2 位小数: 3.14<br>
        Pi 保留 4 位小数: 3.1416<br>
        价格: $1,299.99 (或根据当前语言环境显示相应货币)
    </div>

    <h2 id="custom-print">3. 自定义打印</h2>

    <p>Swift 提供了几个协议，可以让你自定义类型的打印表现形式：</p>

    <h3>CustomStringConvertible 协议</h3>

    <pre><code>struct Book: CustomStringConvertible {
    let title: String
    let author: String
    let year: Int
    let pages: Int
    
    // 自定义 description 属性
    var description: String {
        return "\"\(title)\" by \(author) (\(year))"
    }
}

let swiftBook = Book(
    title: "Swift Programming",
    author: "Apple Inc.",
    year: 2021,
    pages: 500
)

// 使用 print 将自动调用 description
print(swiftBook)
</code></pre>

    <div class="example-output">
        "Swift Programming" by Apple Inc. (2021)
    </div>

    <h3>CustomDebugStringConvertible 协议</h3>

    <pre><code>struct Book: CustomStringConvertible, CustomDebugStringConvertible {
    let title: String
    let author: String
    let year: Int
    let pages: Int
    
    // 用于普通打印
    var description: String {
        return "\"\(title)\" by \(author) (\(year))"
    }
    
    // 用于调试打印
    var debugDescription: String {
        return "Book(title: \"\(title)\", author: \"\(author)\", year: \(year), pages: \(pages))"
    }
}

let swiftBook = Book(
    title: "Swift Programming",
    author: "Apple Inc.",
    year: 2021,
    pages: 500
)

// 普通打印
print("普通打印:")
print(swiftBook)

// 调试打印
print("\n调试打印:")
debugPrint(swiftBook)
</code></pre>

    <div class="example-output">
        普通打印:<br>
        "Swift Programming" by Apple Inc. (2021)<br>
        <br>
        调试打印:<br>
        Book(title: "Swift Programming", author: "Apple Inc.", year: 2021, pages: 500)
    </div>

    <h3>更多自定义打印协议</h3>

    <pre><code>struct Vector: CustomStringConvertible, CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible {
    let x: Double
    let y: Double
    let z: Double
    
    var description: String {
        return "Vector(\(x), \(y), \(z))"
    }
    
    var debugDescription: String {
        return "Vector(x: \(x), y: \(y), z: \(z))"
    }
    
    // 用于在 Playground 中自定义显示
    var playgroundDescription: Any {
        return "3D Vector (\(x), \(y), \(z))"
    }
}

let vector = Vector(x: 1.0, y: 2.5, z: 3.7)
print(vector)
debugPrint(vector)
</code></pre>

    <h2 id="logging">4. 日志系统</h2>

    <p>在现代 Swift 应用中，结构化日志比简单的 print 语句更适合开发和调试。</p>

    <h3>OSLog 和 Logger (iOS 14+, macOS 11+)</h3>

    <pre><code>import os.log

// 在 iOS 14/macOS 11 之前使用 OSLog
if #available(iOS 14, macOS 11, *) {
    // 使用新的 Logger API
    let logger = Logger(subsystem: "com.example.myapp", category: "networking")
    
    // 不同级别的日志
    logger.debug("这是一个调试消息")
    logger.info("这是一个信息消息")
    logger.notice("这是一个通知消息")
    logger.warning("这是一个警告消息")
    logger.error("这是一个错误消息")
    logger.critical("这是一个严重错误消息")
    
    // 使用插值
    let url = "https://example.com"
    let statusCode = 200
    logger.info("成功获取数据: \(url) 状态: \(statusCode)")
    
    // 私有数据（不会记录在系统日志中）
    let password = "secret123"
    logger.info("处理认证，密码: \(privacy: .private, password)")
} else {
    // 旧版 OSLog
    let log = OSLog(subsystem: "com.example.myapp", category: "networking")
    os_log("API 调用完成", log: log, type: .info)
    
    // 不同级别
    os_log("调试信息", log: log, type: .debug)
    os_log("错误信息: %{public}@", log: log, type: .error, "连接失败")
}
</code></pre>

    <div class="card mint-card">
        <h3>日志级别对比</h3>
        <table>
            <thead>
                <tr>
                    <th>级别</th>
                    <th>使用场景</th>
                    <th>保留时间</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>debug</td>
                    <td>开发阶段细节信息</td>
                    <td>短期（调试时）</td>
                </tr>
                <tr>
                    <td>info</td>
                    <td>一般信息</td>
                    <td>中期</td>
                </tr>
                <tr>
                    <td>notice</td>
                    <td>重要事件通知</td>
                    <td>较长期</td>
                </tr>
                <tr>
                    <td>warning</td>
                    <td>潜在问题警告</td>
                    <td>长期</td>
                </tr>
                <tr>
                    <td>error</td>
                    <td>错误信息</td>
                    <td>长期</td>
                </tr>
                <tr>
                    <td>critical</td>
                    <td>严重错误，可能导致程序崩溃</td>
                    <td>长期</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h3>自定义日志框架</h3>

    <pre><code>enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
    case critical = "CRITICAL"
    
    var emoji: String {
        switch self {
        case .debug: return "🔍"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "❌"
        case .critical: return "🚨"
        }
    }
}

class AppLogger {
    static let shared = AppLogger()
    private init() {}
    
    var enabledLevels: Set<LogLevel> = [.info, .warning, .error, .critical]
    
    func log(_ message: String, level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line) {
        guard enabledLevels.contains(level) else { return }
        
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let timestamp = dateFormatter.string(from: Date())
        
        let logMessage = "[\(timestamp)] \(level.emoji) [\(level.rawValue)] [\(fileName):\(line)] \(function) - \(message)"
        print(logMessage)
        
        // 在这里可以添加将日志写入文件或发送到服务器的代码
    }
    
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }
    
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }
    
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }
    
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
    
    func critical(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .critical, file: file, function: function, line: line)
    }
}

// 使用示例
let logger = AppLogger.shared

logger.debug("这是一条调试信息")
logger.info("用户成功登录")
logger.warning("API 响应缓慢")
logger.error("无法连接到服务器")
logger.critical("数据库连接失败")

// 更改日志级别
logger.enabledLevels = [.error, .critical]  // 只显示错误和严重错误
logger.info("这条消息不会显示")
logger.error("这条错误消息会显示")
</code></pre>

    <div class="example-output">
        [2025-03-27 12:30:45.123] ℹ️ [INFO] [ViewController.swift:25] viewDidLoad - 用户成功登录<br>
        [2025-03-27 12:30:45.124] ⚠️ [WARNING] [ViewController.swift:26] viewDidLoad - API 响应缓慢<br>
        [2025-03-27 12:30:45.124] ❌ [ERROR] [ViewController.swift:27] viewDidLoad - 无法连接到服务器<br>
        [2025-03-27 12:30:45.125] 🚨 [CRITICAL] [ViewController.swift:28] viewDidLoad - 数据库连接失败<br>
        [2025-03-27 12:30:45.126] ❌ [ERROR] [ViewController.swift:32] viewDidLoad - 这条错误消息会显示
    </div>

    <h2 id="console-redirection">5. 控制台输出重定向</h2>

    <p>有时候我们需要重定向标准输出，例如将输出保存到字符串或文件中。</p>

    <pre><code>import Foundation

// 一种捕获标准输出的方法
class StdoutCapture {
    private let pipe = Pipe()
    private let originalStdout: Int32
    private var savedData = Data()
    
    init() {
        // 保存原始的文件描述符
        originalStdout = dup(FileHandle.standardOutput.fileDescriptor)
        
        // 重定向标准输出到我们的管道
        dup2(pipe.fileHandleForWriting.fileDescriptor, FileHandle.standardOutput.fileDescriptor)
        
        // 设置管道读取回调
        pipe.fileHandleForReading.readabilityHandler = { [weak self] fileHandle in
            let data = fileHandle.availableData
            if !data.isEmpty {
                self?.savedData.append(data)
                
                // 如果想实时查看输出，可以写回原始的stdout
                write(self?.originalStdout ?? 1, data.withUnsafeBytes { $0.baseAddress }, data.count)
            }
        }
    }
    
    func stop() -> String {
        // 停止捕获，关闭管道
        pipe.fileHandleForWriting.closeFile()
        pipe.fileHandleForReading.readabilityHandler = nil
        
        // 恢复原始的stdout
        dup2(originalStdout, FileHandle.standardOutput.fileDescriptor)
        close(originalStdout)
        
        // 返回捕获的输出
        return String(data: savedData, encoding: .utf8) ?? ""
    }
}

// 使用示例
func testStdoutCapture() {
    let capture = StdoutCapture()
    
    print("这是第一行输出")
    print("这是第二行输出")
    
    let capturedOutput = capture.stop()
    print("捕获的输出:")
    print(capturedOutput)
}

testStdoutCapture()
</code></pre>

    <h2 id="file-output">6. 文件输出</h2>

    <p>将输出保存到文件对于日志记录和调试非常有用。</p>

    <pre><code>import Foundation

// 简单的文件日志记录器
class FileLogger {
    private let fileURL: URL
    private let dateFormatter: DateFormatter
    
    init(filename: String = "app.log") {
        // 获取文档目录
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = documentsDirectory.appendingPathComponent(filename)
        
        // 创建时间格式化器
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // 创建或清空日志文件
        try? "".write(to: fileURL, atomically: true, encoding: .utf8)
        
        print("日志文件位置: \(fileURL.path)")
    }
    
    func log(_ message: String) {
        let timestamp = dateFormatter.string(from: Date())
        let logMessage = "[\(timestamp)] \(message)\n"
        
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            fileHandle.seekToEndOfFile()
            if let data = logMessage.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        } catch {
            // 如果文件不存在，创建它
            try? logMessage.write(to: fileURL, atomically: true, encoding: .utf8)
        }
        
        // 同时在控制台显示
        print(logMessage, terminator: "")
    }
    
    // 读取日志文件内容
    func readLogs() -> String {
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            return "无法读取日志文件: \(error.localizedDescription)"
        }
    }
}

// 使用示例
let logger = FileLogger()
logger.log("应用启动")
logger.log("用户登录: user123")
logger.log("API 请求发送到 https://api.example.com")

// 稍后读取日志
DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    let logs = logger.readLogs()
    print("日志内容:")
    print(logs)
}
</code></pre>

    <h2 id="performance">7. 性能考量</h2>

    <p>打印操作在性能敏感的代码中可能会成为瓶颈。以下是一些优化建议：</p>

    <div class="card yellow-card">
        <h3>打印性能优化技巧</h3>
        <ul>
            <li><strong>条件编译</strong>：在发布版本中移除调试打印</li>
            <li><strong>惰性求值</strong>：延迟昂贵操作的执行，直到需要时才进行</li>
            <li><strong>异步日志</strong>：在后台线程处理日志记录</li>
            <li><strong>缓冲日志</strong>：批量处理日志而不是单独处理</li>
            <li><strong>采样日志</strong>：在高频操作中只记录一部分事件</li>
        </ul>
    </div>

    <pre><code>// 条件编译示例
func logDebug(_ message: @autoclosure () -> String) {
    #if DEBUG
    print("DEBUG: \(message())")
    #endif
}

// 使用
logDebug("这条消息只在调试构建中显示")

// 昂贵操作的惰性求值
func logWithDetails(_ message: String, details: @autoclosure () -> String) {
    #if DEBUG
    print("\(message): \(details())")  // 只在DEBUG模式下执行details()
    #endif
}

// 使用
func expensiveOperation() -> String {
    // 假设这是一个耗时操作
    return "复杂对象详情..."
}

logWithDetails("对象状态", details: expensiveOperation())

// 异步日志示例
let logQueue = DispatchQueue(label: "com.example.logqueue", qos: .background)

func asyncLog(_ message: @autoclosure @escaping () -> String) {
    logQueue.async {
        let logMessage = message()
        print(logMessage)
        // 写入文件或其他操作...
    }
}

// 使用
for i in 1...1000 {
    asyncLog("处理项目 \(i)")
}
</code></pre>

    <h2 id="resources">8. 学习资源</h2>

    <div class="resources">
        <h3>官方文档</h3>
        <ul>
            <li><a href="https://developer.apple.com/documentation/swift/string#2919514" target="_blank">Swift 字符串文档</a></li>
            <li><a href="https://developer.apple.com/documentation/os/logging" target="_blank">Apple 日志框架文档</a></li>
            <li><a href="https://developer.apple.com/documentation/swift/customstringconvertible" target="_blank">CustomStringConvertible 协议文档</a></li>
        </ul>
        
        <h3>优秀博客和文章</h3>
        <ul>
            <li><a href="https://www.swiftbysundell.com/articles/string-interpolation-in-swift/" target="_blank">String interpolation in Swift - Swift by Sundell</a></li>
            <li><a href="https://www.avanderlee.com/swift/logging-oslog-console-app/" target="_blank">Unified logging with OSLog: introduction and best practices - SwiftLee</a></li>
            <li><a href="https://www.hackingwithswift.com/articles/68/how-to-use-the-logger-api-in-ios-14" target="_blank">How to use the Logger API in iOS 14 - Hacking with Swift</a></li>
        </ul>
        
        <h3>书籍推荐</h3>
        <ul>
            <li>《Swift in Depth》- Tjeerd in 't Veen (包含高级字符串处理章节)</li>
            <li>《Advanced Swift》- Chris Eidhof, Ole Begemann, and Airspeed Velocity</li>
            <li>《Swift 进阶》- 王巍</li>
        </ul>
        
        <h3>视频教程</h3>
        <ul>
            <li><a href="https://developer.apple.com/videos/play/wwdc2020/10168/" target="_blank">WWDC 2020 - Explore logging in Swift</a></li>
            <li><a href="https://www.youtube.com/watch?v=rIBmP9InAJA" target="_blank">Swift 中的字符串插值和格式化 - YouTube</a></li>
        </ul>
        
        <h3>相关开源项目</h3>
        <ul>
            <li><a href="https://github.com/SwiftyBeaver/SwiftyBeaver" target="_blank">SwiftyBeaver - 便捷的日志框架</a></li>
            <li><a href="https://github.com/apple/swift-log" target="_blank">Swift Log - Apple 官方日志 API</a></li>
            <li><a href="https://github.com/onevcat/Rainbow" target="_blank">Rainbow - 终端文本着色</a></li>
            <li><a href="https://github.com/DaveWoodCom/XCGLogger" target="_blank">XCGLogger - 功能丰富的日志工具</a></li>
        </ul>
    </div>
    
</body>
</html>
