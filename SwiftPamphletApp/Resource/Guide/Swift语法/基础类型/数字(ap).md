<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 数字类型 - Apple 开发技术手册</title>
    <style>
        :root {
            --bg-color: #ffffff;
            --text-color: #333333;
            --heading-color: #1d1d1f;
            --code-bg: #f6f8fa;
            --border-color: #e1e4e8;
            --link-color: #0070c9;
            --accent-color: #007aff;
            --callout-bg: #f5f9fc;
            --callout-border: #dcedfc;
            --table-header-bg: #f6f8fa;
            --table-border: #e1e4e8;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --bg-color: #1c1c1e;
                --text-color: #f2f2f7;
                --heading-color: #ffffff;
                --code-bg: #2a2a2c;
                --border-color: #38383c;
                --link-color: #4eb5ff;
                --accent-color: #0a84ff;
                --callout-bg: #2c333a;
                --callout-border: #434c56;
                --table-header-bg: #2a2a2c;
                --table-border: #38383c;
            }
        }
        
        * {
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--bg-color);
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem 1.5rem;
        }
        
        h1, h2, h3, h4, h5, h6 {
            color: var(--heading-color);
            margin-top: 2em;
            margin-bottom: 0.75em;
            font-weight: 600;
            letter-spacing: -0.02em;
            line-height: 1.2;
        }
        
        h1 {
            font-size: 2.5rem;
            margin-top: 0;
            font-weight: 700;
        }
        
        h2 {
            font-size: 1.8rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.3em;
        }
        
        h3 {
            font-size: 1.4rem;
        }
        
        p, ul, ol {
            margin-bottom: 1.5rem;
        }
        
        a {
            color: var(--link-color);
            text-decoration: none;
        }
        
        a:hover {
            text-decoration: underline;
        }
        
        code {
            font-family: SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace;
            background-color: var(--code-bg);
            padding: 0.2em 0.4em;
            border-radius: 3px;
            font-size: 85%;
        }
        
        pre {
            background-color: var(--code-bg);
            border-radius: 6px;
            padding: 1rem;
            overflow-x: auto;
            margin: 1.5rem 0;
            border: 1px solid var(--border-color);
        }
        
        pre code {
            padding: 0;
            background-color: transparent;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
        }
        
        th, td {
            padding: 0.75rem;
            text-align: left;
            border: 1px solid var(--table-border);
        }
        
        th {
            background-color: var(--table-header-bg);
            font-weight: 600;
        }
        
        img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 2rem auto;
            border-radius: 6px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
        }
        
        .callout {
            background-color: var(--callout-bg);
            border-left: 4px solid var(--accent-color);
            padding: 1rem 1.5rem;
            margin: 1.5rem 0;
            border-radius: 0 6px 6px 0;
        }
        
        .callout-title {
            font-weight: 600;
            margin-top: 0;
            margin-bottom: 0.5rem;
        }
        
        .diagram {
            margin: 2rem 0;
            text-align: center;
        }
        
        .reference-section {
            margin-top: 3rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
        }

        .reference-list {
            list-style-type: none;
            padding-left: 0;
        }
        
        .reference-list li {
            margin-bottom: 0.75rem;
            padding-left: 1.5rem;
            position: relative;
        }
        
        .reference-list li:before {
            content: "•";
            position: absolute;
            left: 0;
            color: var(--accent-color);
        }

        .numeric-range-table td {
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift 数字类型全解析</h1>
        <p>Swift 提供了丰富而强大的数字类型系统，使开发者能够根据需要精确控制数据。本章将全面介绍 Swift 中的各种数字类型、它们的特性以及适用场景。</p>
    </header>
    
    <section id="overview">
        <h2>数字类型概述</h2>
        <p>Swift 提供了两大类数字类型：</p>
        <ul>
            <li><strong>整数类型</strong>：用于表示不含小数部分的数值</li>
            <li><strong>浮点类型</strong>：用于表示带小数部分的数值</li>
        </ul>
        
        <div class="diagram">
            <svg width="700" height="400" xmlns="http://www.w3.org/2000/svg">
                <!-- Light mode -->
                <style>
                    @media (prefers-color-scheme: light) {
                        .bg-rect { fill: #f6f8fa; }
                        .border { stroke: #d1d5da; }
                        .text { fill: #24292e; }
                        .arrow { stroke: #6a737d; }
                        .highlight { fill: #dbedff; }
                    }
                    /* Dark mode */
                    @media (prefers-color-scheme: dark) {
                        .bg-rect { fill: #2a2a2c; }
                        .border { stroke: #38383c; }
                        .text { fill: #e1e4e8; }
                        .arrow { stroke: #8b949e; }
                        .highlight { fill: #2c333a; }
                    }
                </style>
                
                <!-- Main categories -->
                <rect class="bg-rect border" x="250" y="20" width="200" height="50" rx="5" ry="5"/>
                <text class="text" x="350" y="50" text-anchor="middle" font-weight="bold">Swift 数字类型</text>
                
                <!-- Arrows to subcategories -->
                <line class="arrow" x1="350" y1="70" x2="350" y2="100" stroke-width="2" marker-end="url(#arrowhead)"/>
                <line class="arrow" x1="350" y1="100" x2="200" y2="130" stroke-width="2" marker-end="url(#arrowhead)"/>
                <line class="arrow" x1="350" y1="100" x2="500" y2="130" stroke-width="2" marker-end="url(#arrowhead)"/>
                
                <!-- Integer Types -->
                <rect class="bg-rect border" x="100" y="140" width="200" height="50" rx="5" ry="5"/>
                <text class="text" x="200" y="170" text-anchor="middle" font-weight="bold">整数类型</text>
                
                <line class="arrow" x1="200" y1="190" x2="130" y2="220" stroke-width="2" marker-end="url(#arrowhead)"/>
                <line class="arrow" x1="200" y1="190" x2="270" y2="220" stroke-width="2" marker-end="url(#arrowhead)"/>
                
                <!-- Signed integers -->
                <rect class="bg-rect border highlight" x="50" y="230" width="160" height="100" rx="5" ry="5"/>
                <text class="text" x="130" y="255" text-anchor="middle" font-weight="bold">有符号整数</text>
                <text class="text" x="130" y="280" text-anchor="middle">Int</text>
                <text class="text" x="130" y="305" text-anchor="middle">Int8, Int16, Int32, Int64</text>
                
                <!-- Unsigned integers -->
                <rect class="bg-rect border" x="230" y="230" width="160" height="100" rx="5" ry="5"/>
                <text class="text" x="310" y="255" text-anchor="middle" font-weight="bold">无符号整数</text>
                <text class="text" x="310" y="280" text-anchor="middle">UInt</text>
                <text class="text" x="310" y="305" text-anchor="middle">UInt8, UInt16, UInt32, UInt64</text>
                
                <!-- Float Types -->
                <rect class="bg-rect border" x="400" y="140" width="200" height="50" rx="5" ry="5"/>
                <text class="text" x="500" y="170" text-anchor="middle" font-weight="bold">浮点类型</text>
                
                <line class="arrow" x1="500" y1="190" x2="500" y2="220" stroke-width="2" marker-end="url(#arrowhead)"/>
                
                <!-- Float types details -->
                <rect class="bg-rect border" x="420" y="230" width="160" height="100" rx="5" ry="5"/>
                <text class="text" x="500" y="255" text-anchor="middle" font-weight="bold">浮点数</text>
                <text class="text" x="500" y="280" text-anchor="middle">Float (32位)</text>
                <text class="text" x="500" y="305" text-anchor="middle">Double (64位)</text>
                
                <!-- Arrow marker definition -->
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" class="arrow"/>
                    </marker>
                </defs>
            </svg>
        </div>
    </section>

    <section id="integer-types">
        <h2>整数类型</h2>
        <p>Swift 提供了带符号和不带符号两种整数类型，每种类型又有不同的位宽。</p>
        
        <h3>整数类型范围</h3>
        <table class="numeric-range-table">
            <thead>
                <tr>
                    <th>类型</th>
                    <th>大小</th>
                    <th>范围</th>
                    <th>适用场景</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>Int8</code></td>
                    <td>8位</td>
                    <td>-128 ~ 127</td>
                    <td>节省内存的小范围数值</td>
                </tr>
                <tr>
                    <td><code>Int16</code></td>
                    <td>16位</td>
                    <td>-32,768 ~ 32,767</td>
                    <td>中等范围数值</td>
                </tr>
                <tr>
                    <td><code>Int32</code></td>
                    <td>32位</td>
                    <td>-2,147,483,648 ~ 2,147,483,647</td>
                    <td>大范围数值</td>
                </tr>
                <tr>
                    <td><code>Int64</code></td>
                    <td>64位</td>
                    <td>-9,223,372,036,854,775,808 ~ 9,223,372,036,854,775,807</td>
                    <td>极大范围数值</td>
                </tr>
                <tr>
                    <td><code>Int</code></td>
                    <td>平台相关<br>(32位或64位)</td>
                    <td>与平台的原生字长相同</td>
                    <td>一般使用场景的首选类型</td>
                </tr>
                <tr>
                    <td><code>UInt8</code></td>
                    <td>8位</td>
                    <td>0 ~ 255</td>
                    <td>字节数据、无符号小范围数值</td>
                </tr>
                <tr>
                    <td><code>UInt16</code></td>
                    <td>16位</td>
                    <td>0 ~ 65,535</td>
                    <td>无符号中等范围数值</td>
                </tr>
                <tr>
                    <td><code>UInt32</code></td>
                    <td>32位</td>
                    <td>0 ~ 4,294,967,295</td>
                    <td>无符号大范围数值</td>
                </tr>
                <tr>
                    <td><code>UInt64</code></td>
                    <td>64位</td>
                    <td>0 ~ 18,446,744,073,709,551,615</td>
                    <td>无符号极大范围数值</td>
                </tr>
                <tr>
                    <td><code>UInt</code></td>
                    <td>平台相关<br>(32位或64位)</td>
                    <td>与平台的原生字长相同</td>
                    <td>需要无符号整数时的首选类型</td>
                </tr>
            </tbody>
        </table>

        <div class="callout">
            <p class="callout-title">最佳实践</p>
            <p>在大多数情况下，应该使用 <code>Int</code> 类型来表示整数，即使你确定数值不会为负。这样能保持代码一致性并便于类型推断。只有在明确需要其他整数类型的特定行为或约束时，才考虑使用其他整数类型。</p>
        </div>
        
        <h3>整数字面量</h3>
        <p>Swift 支持多种整数字面量格式，使代码更加清晰可读：</p>
        
        <pre><code>// 不同进制的整数字面量示例
let decimalInteger = 17       // 十进制，没有前缀
let binaryInteger = 0b10001   // 二进制，0b 前缀
let octalInteger = 0o21       // 八进制，0o 前缀
let hexadecimalInteger = 0x11 // 十六进制，0x 前缀

// 使用下划线增加可读性
let largeNumber = 1_000_000  // 等同于 1000000，但更易读
let creditCardNumber = 1234_5678_9012_3456
let socialSecurityNumber = 999_99_9999</code></pre>
    </section>
    
    <section id="floating-point-types">
        <h2>浮点类型</h2>
        <p>Swift 提供两种浮点数类型，用于表示包含小数部分的数值。</p>
        
        <h3>浮点类型特性</h3>
        <table>
            <thead>
                <tr>
                    <th>类型</th>
                    <th>精度</th>
                    <th>有效数字</th>
                    <th>适用场景</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>Float</code></td>
                    <td>32位，单精度</td>
                    <td>约6位小数</td>
                    <td>内存受限且不需要高精度的场景</td>
                </tr>
                <tr>
                    <td><code>Double</code></td>
                    <td>64位，双精度</td>
                    <td>约15位小数</td>
                    <td>需要高精度计算的默认选择</td>
                </tr>
            </tbody>
        </table>
        
        <div class="callout">
            <p class="callout-title">提示</p>
            <p>Swift 默认推断小数字面量为 <code>Double</code> 类型，除非显式指定类型。在大多数情况下推荐使用 <code>Double</code> 而非 <code>Float</code>。</p>
        </div>
        
        <h3>浮点数字面量</h3>
        <pre><code>// 浮点数字面量示例
let decimalFloat = 12.1875       // 十进制表示
let exponentFloat = 1.21875e1    // 使用指数表示，等同于 12.1875
let hexFloat = 0xC.3p0           // 十六进制表示，等同于 12.1875
                                 // 0xC.3 = 12.1875 (12 + 3/16)

// 使用下划线增加可读性
let pi = 3.141_592_653_589_793
let avogadroConstant = 6.022_140_76e23</code></pre>
    </section>
    
    <section id="number-operations">
        <h2>数字操作</h2>
        
        <h3>类型转换</h3>
        <p>Swift 是类型安全的语言，不会隐式执行类型转换，必须通过显式类型转换进行数值类型之间的转换。</p>
        
        <pre><code>// 完整的类型转换示例
func demoTypeConversions() {
    // 整数类型之间的转换
    let smallInt: Int8 = 127
    let regularInt: Int = Int(smallInt)      // Int8 转 Int
    
    // 可能溢出的转换需要特别注意
    let largeInt: Int = 1000
    let smallerInt: Int8 = Int8(exactly: largeInt) ?? 0  // 使用 exactly 方法安全转换
    
    // 浮点数转整数（会丢失小数部分）
    let floatValue: Float = 3.14
    let intFromFloat: Int = Int(floatValue)   // 结果为 3
    
    // 整数转浮点数
    let intValue: Int = 42
    let floatFromInt: Float = Float(intValue) // 结果为 42.0
    
    // 数字和字符串转换
    let stringNumber = "42"
    if let numFromString = Int(stringNumber) {
        print("转换成功: \(numFromString)")
    }
    
    let numberToString = String(123)         // "123"
    
    // 不同进制之间的转换
    let decimal = 42
    let binaryString = String(decimal, radix: 2)  // "101010"
    let hexString = String(decimal, radix: 16)    // "2a"
}</code></pre>
        
        <h3>数值操作和计算</h3>
        <pre><code>// 全面的数值操作示例
func demoNumericOperations() {
    // 基本算术运算
    let sum = 5 + 3          // 加法: 8
    let difference = 5 - 3   // 减法: 2
    let product = 5 * 3      // 乘法: 15
    let quotient = 10 / 3    // 整数除法: 3
    let remainder = 10 % 3   // 取余: 1
    
    // 浮点数运算
    let floatQuotient = 10.0 / 3.0  // 浮点除法: 3.33333...
    
    // 复合赋值运算符
    var value = 5
    value += 3   // 等同于 value = value + 3，结果为 8
    value -= 1   // 结果为 7
    value *= 2   // 结果为 14
    value /= 7   // 结果为 2
    
    // 比较运算
    let isEqual = 5 == 5            // true
    let isNotEqual = 5 != 3         // true
    let isGreater = 5 > 3           // true
    let isLess = 5 < 10             // true
    let isGreaterOrEqual = 5 >= 5   // true
    let isLessOrEqual = 5 <= 10     // true
    
    // 三目运算符
    let score = 85
    let result = score >= 60 ? "及格" : "不及格"  // "及格"
    
    // 位运算
    let bitwiseAND = 0b1100 & 0b1010  // 按位与: 0b1000 (8)
    let bitwiseOR = 0b1100 | 0b1010   // 按位或: 0b1110 (14)
    let bitwiseXOR = 0b1100 ^ 0b1010  // 按位异或: 0b0110 (6)
    let bitwiseNOT = ~0b1100          // 按位取反: 取决于平台的整数大小
    
    // 移位运算
    let leftShift = 1 << 3   // 左移3位: 8
    let rightShift = 32 >> 2 // 右移2位: 8
    
    // 溢出操作符
    let maxInt8 = Int8.max               // 127
    // let overflow = maxInt8 + 1        // 这会导致运行时错误!
    let overflowResult = maxInt8 &+ 1    // 使用溢出加法: -128
    
    // 边界值和特殊属性
    print("Int 类型范围: \(Int.min) 到 \(Int.max)")
    print("Double 精度: \(Double.ulpOfOne)") // 计算机的双精度浮点数的最小增量
}</code></pre>

        <h3>数值精度和处理</h3>
        <pre><code>// 数值精度和特殊值处理
func demoPrecisionAndSpecialValues() {
    // 浮点数精度问题
    let a = 0.1
    let b = 0.2
    let sum = a + b                    // 0.30000000000000004
    let isExactlyPointThree = sum == 0.3  // false，浮点精度问题
    
    // 近似相等比较
    let isApproximatelyEqual = abs(sum - 0.3) < 0.000001  // true
    
    // 特殊浮点值
    let infinity = Double.infinity     // 无穷大
    let negInfinity = -Double.infinity // 负无穷大
    let notANumber = Double.nan        // 非数值 (NaN)
    
    // 检查特殊值
    let isInfinite = infinity.isInfinite  // true
    let isNaN = notANumber.isNaN          // true
    
    // 使用 NSDecimalNumber 处理高精度计算
    import Foundation
    let decimalA = Decimal(string: "0.1")!
    let decimalB = Decimal(string: "0.2")!
    let decimalSum = decimalA + decimalB   // 精确的 0.3
    
    // 数值格式化
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    let formattedNumber = formatter.string(from: NSNumber(value: 12345.6789))  // "12,345.68"
}</code></pre>
    </section>
    
    <section id="advanced-topics">
        <h2>高级主题</h2>
        
        <h3>精确小数计算 - Decimal</h3>
        <p>当需要进行财务或货币计算等高精度场景时，应使用 <code>Decimal</code> 类型代替标准浮点类型。</p>
        
        <pre><code>// 精确小数计算示例
import Foundation

func demonstrateDecimalCalculations() {
    // 浮点数计算中的精度问题
    let floatResult = 0.1 + 0.2             // 0.30000000000000004
    print("浮点数计算结果: \(floatResult)")
    
    // 使用 Decimal 进行精确计算
    let decimalA = Decimal(string: "0.1")!
    let decimalB = Decimal(string: "0.2")!
    let decimalSum = decimalA + decimalB    // 精确的 0.3
    print("Decimal 计算结果: \(decimalSum)")
    
    // 货币计算示例
    let price = Decimal(string: "19.99")!
    let quantity = Decimal(string: "3")!
    let subtotal = price * quantity          // 59.97
    let taxRate = Decimal(string: "0.0725")! // 7.25% 税率
    let tax = subtotal * taxRate
    let total = subtotal + tax
    
    print("小计: \(subtotal)")
    print("税金: \(tax)")
    print("总额: \(total)")
    
    // 格式化为货币
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "zh_CN")
    if let formattedTotal = formatter.string(from: NSDecimalNumber(decimal: total)) {
        print("格式化后的总金额: \(formattedTotal)")
    }
}</code></pre>

        <h3>数学与数值计算 - Foundation</h3>
        <pre><code>// 数学计算扩展
import Foundation

func demonstrateMathOperations() {
    // 基本数学函数
    let squareRoot = sqrt(16.0)          // 4.0
    let power = pow(2.0, 3.0)            // 8.0
    let sine = sin(.pi / 2)              // 1.0
    let logarithm = log10(100)           // 2.0
    
    // 四舍五入和取整
    let rounded = round(3.7)             // 4.0
    let ceiling = ceil(3.1)              // 4.0
    let floor = floor(3.9)               // 3.0
    
    // 最大最小值
    let maximum = max(5, 10, 3)          // 10
    let minimum = min(5, 10, 3)          // 3
    
    // 绝对值
    let absoluteValue = abs(-42)         // 42
    
    // 随机数
    let randomInt = Int.random(in: 1...6) // 骰子点数 1-6
    let randomDouble = Double.random(in: 0..<1.0) // 0.0 到小于 1.0 之间的值
    
    // 度量单位转换
    let meters = Measurement(value: 1.5, unit: UnitLength.kilometers).converted(to: .meters)
    print("\(meters.value) 米") // 1500.0 米
    
    // 复杂数字 (Complex Numbers)
    var complex = Complex<Double>(1, 1)  // 1 + 1i
    let anotherComplex = Complex<Double>(2, -1) // 2 - 1i
    complex = complex * anotherComplex
    print("复数运算结果: \(complex)")
}</code></pre>

        <h3>为数字类型扩展功能</h3>
        <pre><code>// 通过扩展为数字类型添加功能
extension Int {
    // 计算属性
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var isOdd: Bool {
        return self % 2 != 0
    }
    
    var isPrime: Bool {
        if self <= 1 { return false }
        if self <= 3 { return true }
        if self % 2 == 0 || self % 3 == 0 { return false }
        
        var i = 5
        while i * i <= self {
            if self % i == 0 || self % (i + 2) == 0 {
                return false
            }
            i += 6
        }
        return true
    }
    
    // 方法
    func times(_ action: () -> Void) {
        guard self > 0 else { return }
        for _ in 1...self {
            action()
        }
    }
    
    func squared() -> Int {
        return self * self
    }
}

// 为 Double 类型添加扩展
extension Double {
    // 角度和弧度转换
    var degreesToRadians: Double {
        return self * .pi / 180
    }
    
    var radiansToDegrees: Double {
        return self * 180 / .pi
    }
    
    // 四舍五入到指定小数位
    func rounded(toDecimalPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

// 使用扩展示例
func useExtensions() {
    // 使用 Int 扩展
    let number = 7
    print("\(number) 是否为素数: \(number.isPrime)")
    
    5.times {
        print("这会执行5次")
    }
    
    print("8的平方是: \(8.squared())")
    
    // 使用 Double 扩展
    let angle = 45.0
    print("\(angle)度 = \(angle.degreesToRadians)弧度")
    
    let value = 3.14159
    print("π四舍五入到2位小数: \(value.rounded(toDecimalPlaces: 2))")
}</code></pre>
    </section>
    
    <section class="reference-section">
        <h2>参考资料</h2>
        <h3>官方文档</h3>
        <ul class="reference-list">
            <li><a href="https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html" target="_blank">Swift 官方文档 - The Basics</a></li>
            <li><a href="https://developer.apple.com/documentation/swift/swift_standard_library/numbers_and_basic_values" target="_blank">Apple Developer - Numbers and Basic Values</a></li>
            <li><a href="https://developer.apple.com/documentation/foundation/nsnumber" target="_blank">Apple Developer - NSNumber</a></li>
            <li><a href="https://developer.apple.com/documentation/foundation/nsdecimalnumber" target="_blank">Apple Developer - NSDecimalNumber</a></li>
        </ul>
        
        <h3>优质博客与资源</h3>
        <ul class="reference-list">
            <li><a href="https://swiftsenpai.com/swift/decimal-calculate-currency/" target="_blank">Swift Senpai - 精确的小数计算</a></li>
            <li><a href="https://www.swiftbysundell.com/articles/the-power-of-type-aliases-in-swift/" target="_blank">Swift by Sundell - 类型别名的力量</a></li>
            <li><a href="https://www.hackingwithswift.com/articles/176/swift-in-sixty-seconds-number-formats" target="_blank">Hacking with Swift - 60秒学会数字格式</a></li>
            <li><a href="https://nshipster.com/numericcast/" target="_blank">NSHipster - NumericCast</a></li>
            <li><a href="https://www.raywenderlich.com/3736-swift-tutorial-numeric-protocols-and-generic-math" target="_blank">Ray Wenderlich - Swift 数字协议和泛型数学</a></li>
        </ul>
    </section>
</body>
</html>
