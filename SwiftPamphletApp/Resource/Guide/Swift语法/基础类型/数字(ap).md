<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift基础 - 数字</title>
    <style>
        /* 全局样式 */
        :root {
            --primary-color: #55AAEE;
            --accent-green: #99DD44;
            --accent-purple: #AA77DD;
            --accent-orange: #FF9955;
            --text-color: #333;
            --background-color: #fff;
            --code-background: #f5f5f5;
            --card-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #f0f0f0;
                --background-color: #222;
                --code-background: #333;
                --card-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            }
        }

        body {
            font-family: 'Comic Sans MS', cursive, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--background-color);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 100 100'%3E%3Cpath d='M30,20 Q40,5 50,20 T70,20' fill='white' opacity='0.5'/%3E%3Cpath d='M70,30 Q80,15 90,30 T110,30' fill='white' opacity='0.5'/%3E%3C/svg%3E");
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: var(--primary-color);
            color: white;
            padding: 20px;
            border-radius: 20px;
            margin-bottom: 30px;
            text-align: center;
            border: 4px solid black;
            box-shadow: var(--card-shadow);
        }

        h1, h2, h3 {
            font-weight: bold;
            border-bottom: 3px solid var(--accent-green);
            padding-bottom: 10px;
        }

        .card {
            background-color: var(--background-color);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            border: 3px solid black;
            box-shadow: var(--card-shadow);
        }

        .example-card {
            border-left: 5px solid var(--accent-purple);
            padding-left: 15px;
            margin: 20px 0;
        }

        pre, code {
            font-family: 'Menlo', 'Courier New', monospace;
            background-color: var(--code-background);
            border-radius: 5px;
            padding: 2px 5px;
            overflow-x: auto;
        }

        pre {
            padding: 15px;
            border: 2px dashed var(--accent-orange);
        }

        .resource-section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .resource-card {
            border: 2px solid var(--accent-purple);
            border-radius: 10px;
            padding: 15px;
            background-color: var(--background-color);
        }

        img, svg {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 20px auto;
        }

        a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .note {
            background-color: var(--accent-green);
            color: black;
            padding: 10px;
            border-radius: 10px;
            margin: 15px 0;
        }

        @media (max-width: 768px) {
            .resource-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Swift基础 - 数字</h1>
            <p>探索Swift中的数字类型、操作和最佳实践</p>
        </header>

        <div class="card">
            <h2>Swift中的数字类型概览</h2>
            <p>Swift提供了丰富的数字类型来处理不同场景中的数值需求，包括整数和浮点数。</p>

            <svg width="600" height="300" viewBox="0 0 600 300">
                <style>
                    .title { font: bold 18px sans-serif; fill: var(--text-color); }
                    .subtitle { font: 14px sans-serif; fill: var(--text-color); }
                    .box { stroke: black; stroke-width: 3; rx: 10; ry: 10; }
                    .int-box { fill: #55AAEE; }
                    .float-box { fill: #FF9955; }
                    .arrow { stroke: black; stroke-width: 2; }
                </style>
                <rect x="50" y="50" width="200" height="200" class="box int-box" />
                <text x="150" y="30" text-anchor="middle" class="title">整数类型</text>
                <text x="150" y="90" text-anchor="middle" class="subtitle">Int / UInt</text>
                <text x="150" y="120" text-anchor="middle" class="subtitle">Int8, Int16, Int32, Int64</text>
                <text x="150" y="150" text-anchor="middle" class="subtitle">UInt8, UInt16, UInt32, UInt64</text>

                <rect x="350" y="50" width="200" height="200" class="box float-box" />
                <text x="450" y="30" text-anchor="middle" class="title">浮点数类型</text>
                <text x="450" y="90" text-anchor="middle" class="subtitle">Double (64位)</text>
                <text x="450" y="120" text-anchor="middle" class="subtitle">Float (32位)</text>

                <line x1="150" y1="270" x2="450" y2="270" stroke="black" stroke-width="2" />
                <text x="300" y="295" text-anchor="middle" class="title">精度</text>
            </svg>
        </div>

        <div class="card">
            <h2>整数类型</h2>
            <p>Swift提供了有符号和无符号的整数类型，可以选择8位、16位、32位或64位的存储空间。</p>

            <div class="example-card">
                <h3>整数类型示例</h3>
                <pre><code>// 使用各种整数类型
let defaultInt = 42         // 默认Int类型，与系统架构相关(32位或64位)
let explicitInt: Int = 42   // 显式指定Int类型
let int8Value: Int8 = 127   // 8位有符号整数，范围: -128 到 127
let uint8Value: UInt8 = 255 // 8位无符号整数，范围: 0 到 255
let int16Value: Int16 = 32767 // 16位有符号整数
let uint16Value: UInt16 = 65535 // 16位无符号整数
let int32Value: Int32 = 2147483647 // 32位有符号整数
let uint32Value: UInt32 = 4294967295 // 32位无符号整数
let int64Value: Int64 = 9223372036854775807 // 64位有符号整数
let uint64Value: UInt64 = 18446744073709551615 // 64位无符号整数

// 整数的最大值和最小值
print("Int的最大值: \(Int.max)")
print("Int的最小值: \(Int.min)")
print("UInt8的最大值: \(UInt8.max)")
print("UInt8的最小值: \(UInt8.min)")</code></pre>
            </div>

            <div class="note">
                <p><strong>开发提示：</strong> 除非有特定需求，一般建议使用默认的Int类型，这样代码在不同平台间更具可移植性。</p>
            </div>
        </div>

        <div class="card">
            <h2>浮点数类型</h2>
            <p>Swift提供了两种浮点数类型：Double和Float，用于表示带小数部分的数字。</p>

            <svg width="600" height="200" viewBox="0 0 600 200">
                <rect x="50" y="50" width="500" height="80" fill="#AA77DD" stroke="black" stroke-width="3" rx="10" ry="10" />
                <text x="300" y="30" text-anchor="middle" font-weight="bold" fill="var(--text-color)">浮点数精度对比</text>
                <rect x="60" y="60" width="300" height="60" fill="#FF9955" />
                <rect x="360" y="60" width="180" height="60" fill="var(--accent-green)" />
                <text x="210" y="95" text-anchor="middle" font-weight="bold">Double (15-17位小数精度)</text>
                <text x="450" y="95" text-anchor="middle" font-weight="bold">Float (6-9位小数精度)</text>
            </svg>

            <div class="example-card">
                <h3>浮点数类型示例</h3>
                <pre><code>// 使用浮点数类型
let pi = 3.14159           // 默认Double类型
let explicitDouble: Double = 3.14159
let explicitFloat: Float = 3.14159

// 精度差异演示
let preciseDouble = 0.1 + 0.2
print("Double: 0.1 + 0.2 = \(preciseDouble)") // 输出接近0.3

let lessePreciseFloat: Float = 0.1 + 0.2
print("Float: 0.1 + 0.2 = \(lessePreciseFloat)") // 精度较低

// 科学计数法
let largeNumber = 1.25e5  // 125000
let smallNumber = 1.25e-5 // 0.0000125</code></pre>
            </div>

            <div class="note">
                <p><strong>开发提示：</strong> Swift中默认的浮点类型是Double，它比Float提供更高的精度，在不需要节省内存的情况下优先使用Double。</p>
            </div>
        </div>

        <div class="card">
            <h2>数字字面量</h2>
            <p>Swift支持多种形式的数字字面量表示法，包括十进制、二进制、八进制和十六进制。</p>

            <div class="example-card">
                <h3>数字字面量示例</h3>
                <pre><code>// 不同进制的整数表示
let decimal = 17       // 十进制
let binary = 0b10001   // 二进制，前缀0b
let octal = 0o21       // 八进制，前缀0o
let hexadecimal = 0x11 // 十六进制，前缀0x

print("十进制17 = 二进制\(binary) = 八进制\(octal) = 十六进制\(hexadecimal)")

// 使用下划线增强数字可读性
let oneMillion = 1_000_000
let creditCardNumber = 1234_5678_9012_3456
let socialSecurityNumber = 999_99_9999

// 浮点数字面量
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1  // 12.1875
let hexadecimalDouble = 0xC.3p0 // 12.1875 (12 + 3/16)</code></pre>
            </div>
        </div>

        <div class="card">
            <h2>数值转换</h2>
            <p>Swift是类型安全的语言，不会自动进行隐式类型转换，需要显式地进行类型转换。</p>

            <div class="example-card">
                <h3>数值类型转换示例</h3>
                <pre><code>// 整数与整数之间的转换
let tinyInt: Int8 = 42
let regularInt = Int(tinyInt)  // Int8 转 Int

// 检查转换是否会导致溢出
let big = Int16.max  // 32767
// let tooBigForInt8: Int8 = Int8(big)  // 运行时错误：值太大

// 安全转换方式
if let safelyConverted = Int8(exactly: 100) {
    print("转换成功: \(safelyConverted)")
} else {
    print("转换失败，值超出范围")
}

// 整数和浮点数之间的转换
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi等于3.14159

let integerPart = Int(pi)  // 等于3，小数部分被截断

// 字面量可以直接赋值给不同类型的变量，因为字面量本身没有类型
let floatFromInteger: Float = 42
let doubleFromInteger: Double = 42</code></pre>
            </div>

            <div class="note">
                <p><strong>开发提示：</strong> 在进行类型转换时，特别是处理用户输入或外部数据时，务必考虑可能的溢出问题，使用条件绑定或可选类型来安全地进行转换。</p>
            </div>
        </div>

        <div class="card">
            <h2>数学运算</h2>
            <p>Swift支持常见的数学运算符和函数，用于进行各种数值计算。</p>

            <div class="example-card">
                <h3>基本数学运算示例</h3>
                <pre><code>// 基本算术运算符
let sum = 5 + 3         // 加法: 8
let difference = 10 - 4 // 减法: 6
let product = 2 * 6     // 乘法: 12
let quotient = 10 / 3   // 整数除法: 3
let remainder = 10 % 3  // 取余: 1

// 带小数的除法需要浮点数
let preciseQuotient = 10.0 / 3.0 // 3.3333...

// 复合赋值运算符
var value = 5
value += 3 // 等同于 value = value + 3
value -= 2 // 等同于 value = value - 2
value *= 2 // 等同于 value = value * 2
value /= 4 // 等同于 value = value / 4

// 数学函数
import Foundation

let squareRoot = sqrt(16)     // 4.0
let power = pow(2.0, 3.0)     // 8.0
let rounded = round(3.7)      // 4.0
let ceiling = ceil(3.1)       // 4.0
let floor = floor(3.9)        // 3.0
let absolute = abs(-42)       // 42
let maximum = max(10, 5, 8)   // 10
let minimum = min(10, 5, 8)   // 5

// 三角函数
let angle = Double.pi / 4   // 45度（弧度制）
let sineValue = sin(angle)  // 约0.7071
let cosineValue = cos(angle) // 约0.7071
let tangentValue = tan(angle) // 约1.0</code></pre>
            </div>
        </div>

        <div class="card">
            <h2>数字比较和范围</h2>
            <p>Swift提供了丰富的比较运算符和范围操作符，用于比较数值和创建数值范围。</p>

            <div class="example-card">
                <h3>数字比较和范围示例</h3>
                <pre><code>// 比较运算符
let isEqual = 5 == 5          // true
let isNotEqual = 5 != 6       // true
let isGreater = 7 > 3         // true
let isLess = 4 < 10           // true
let isGreaterOrEqual = 5 >= 5 // true
let isLessOrEqual = 4 <= 6    // true

// 闭区间操作符
let closedRange = 1...5 // 包含1, 2, 3, 4, 5
for number in closedRange {
    print(number) // 打印1到5
}

// 半开区间操作符
let halfOpenRange = 1..<5 // 包含1, 2, 3, 4
for number in halfOpenRange {
    print(number) // 打印1到4
}

// 单侧区间
let names = ["Anna", "Ben", "Charlie", "Daniel"]
let fromSecondToEnd = names[1...]  // ["Ben", "Charlie", "Daniel"]
let upToThird = names[..<3]        // ["Anna", "Ben", "Charlie"]
let throughThird = names[...3]     // ["Anna", "Ben", "Charlie", "Daniel"]

// 检查值是否在范围内
let temperature = 25
if temperature >= 20 && temperature <= 30 {
    print("温度适宜")
}

// 或者更简洁地
if (20...30).contains(temperature) {
    print("温度适宜")
}</code></pre>
            </div>
        </div>

        <div class="card">
            <h2>数值处理最佳实践</h2>
            <p>处理数值时的一些常见陷阱和最佳实践方法。</p>

            <div class="example-card">
                <h3>溢出操作</h3>
                <pre><code>// 标准运算符会在溢出时触发运行时错误
let maxInt8 = Int8.max  // 127
// let willOverflow = maxInt8 + 1  // 运行时错误

// 溢出运算符允许溢出操作
let overflowingResult = maxInt8 &+ 1  // -128（循环回到最小值）
let underflowingResult = Int8.min &- 1 // 127（循环回到最大值）
let overflowingProduct = Int8.max &* 2 // -2</code></pre>

                <h3>避免浮点数精度问题</h3>
                <pre><code>// 浮点数比较问题
let a = 0.1 + 0.2
let b = 0.3

// 直接比较可能失败
print(a == b)  // 在某些情况下可能是false

// 使用epsilon比较
let epsilon = 0.000001
if abs(a - b) < epsilon {
    print("可以认为a和b相等")
}

// 货币计算时避免使用浮点数
// 错误方式
let price = 19.99
let quantity = 3
let totalFloat = price * Double(quantity)  // 可能得到59.969999999999...

// 正确方式：使用整数表示分
let priceInCents = 1999
let totalInCents = priceInCents * quantity  // 5997
let formattedTotal = Double(totalInCents) / 100  // 59.97</code></pre>
            </div>

            <div class="note">
                <p><strong>开发提示：</strong> 处理金融数据时，考虑使用NSDecimalNumber或Decimal类型，它们专为需要精确小数计算的场景设计。</p>
            </div>
        </div>

        <div class="card">
            <h2>高级数字功能</h2>
            <p>Swift和Foundation框架提供了更高级的数字处理功能。</p>

            <div class="example-card">
                <h3>NumberFormatter示例</h3>
                <pre><code>import Foundation

// 设置数字格式化器
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal
numberFormatter.minimumFractionDigits = 2
numberFormatter.maximumFractionDigits = 2

let formattedNumber = numberFormatter.string(from: NSNumber(value: 1234567.89))
// 输出: "1,234,567.89"（根据地区设置可能有所不同）

// 货币格式化
let currencyFormatter = NumberFormatter()
currencyFormatter.numberStyle = .currency
currencyFormatter.locale = Locale(identifier: "zh_CN")

let price = 99.99
let formattedPrice = currencyFormatter.string(from: NSNumber(value: price))
// 输出: "¥99.99"（根据地区设置可能有所不同）

// 百分比格式化
let percentFormatter = NumberFormatter()
percentFormatter.numberStyle = .percent
percentFormatter.minimumFractionDigits = 1

let ratio = 0.753
let formattedPercent = percentFormatter.string(from: NSNumber(value: ratio))
// 输出: "75.3%"</code></pre>

                <h3>Decimal类型示例</h3>
                <pre><code>// 使用Decimal进行精确小数计算
let decimal1 = Decimal(string: "0.1")!
let decimal2 = Decimal(string: "0.2")!
let decimalSum = decimal1 + decimal2
print(decimalSum) // 正好等于0.3

// 使用NSDecimalNumber进行复杂运算
let decimalNumber1 = NSDecimalNumber(string: "0.1")
let decimalNumber2 = NSDecimalNumber(string: "0.2")
let decimalNumberSum = decimalNumber1.adding(decimalNumber2)
print(decimalNumberSum) // 正好等于0.3</code></pre>
            </div>
        </div>

        <div class="card">
            <h2>参考资源</h2>
            <div class="resource-section">
                <div class="resource-card">
                    <h3>官方文档</h3>
                    <ul>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html" target="_blank">Swift官方文档 - 基础知识</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/int" target="_blank">Swift Int类型文档</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/double" target="_blank">Swift Double类型文档</a></li>
                        <li><a href="https://developer.apple.com/documentation/foundation/numberformatter" target="_blank">NumberFormatter文档</a></li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h3>推荐博客</h3>
                    <ul>
                        <li><a href="https://www.swiftbysundell.com/articles/working-with-dates-in-swift/" target="_blank">Swift by Sundell - 数值处理</a></li>
                        <li><a href="https://www.hackingwithswift.com/articles/126/numeric-protocols-in-swift" target="_blank">Hacking with Swift - Swift中的数值协议</a></li>
                        <li><a href="https://www.objc.io/blog/2018/05/22/binary-fixed-point/" target="_blank">objc.io - 二进制定点数</a></li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h3>推荐书籍</h3>
                    <ul>
                        <li>《Swift进阶》 - 王巍(喵神)</li>
                        <li>《Swift编程权威指南》(第2版) - The Swift Programming Language</li>
                        <li>《Swift实战》- Jon Manning & Paris Buttfield-Addison</li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h3>视频资源</h3>
                    <ul>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2018/223/" target="_blank">WWDC - Swift中的泛型和协议</a></li>
                        <li><a href="https://www.youtube.com/watch?v=TWzWd_DiaOQ" target="_blank">Stanford CS193p - Swift编程中的数值处理</a></li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h3>开源项目</h3>
                    <ul>
                        <li><a href="https://github.com/apple/swift-numerics" target="_blank">Swift Numerics</a> - Swift标准库的数值计算扩展</li>
                        <li><a href="https://github.com/Flight-School/Money" target="_blank">Money</a> - Swift货币和金融类型库</li>
                        <li><a href="https://github.com/attaswift/BigInt" target="_blank">BigInt</a> - Swift大整数库</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 可以添加交互功能
        document.addEventListener('DOMContentLoaded', function() {
            // 根据系统偏好自动切换模式的功能已通过CSS实现
            console.log("Swift数字章节页面加载完成");
        });
    </script>
</body>
</html>
