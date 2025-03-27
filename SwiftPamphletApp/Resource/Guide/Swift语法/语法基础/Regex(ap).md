<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift正则表达式指南</title>
    <style>
        :root {
            --background-color: #b9c42a;
            --primary-color: #ffde00;
            --text-color: #000000;
            --border-color: #ffffff;
            --code-bg: #f8f8f8;
            --code-color: #333;
            --link-color: #006633;
            --shadow-color: rgba(0, 0, 0, 0.15);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #2a2f0f;
                --primary-color: #d4b800;
                --text-color: #ffffff;
                --border-color: #444444;
                --code-bg: #222222;
                --code-color: #e0e0e0;
                --link-color: #8bc34a;
                --shadow-color: rgba(0, 0, 0, 0.3);
            }
        }

        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            padding: 20px;
            margin: 0;
            max-width: 100%;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: var(--primary-color);
            border: 3px solid var(--text-color);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 8px 8px 0 var(--shadow-color);
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 10px;
            background: repeating-linear-gradient(
                90deg,
                transparent,
                transparent 15px,
                var(--text-color) 15px,
                var(--text-color) 20px
            );
        }

        h1, h2, h3, h4 {
            font-family: 'Arial Black', 'Arial Bold', sans-serif;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 3px dashed var(--text-color);
            padding-bottom: 10px;
            margin-top: 40px;
        }

        h1 {
            font-size: 2.8rem;
            text-align: center;
            background-color: var(--text-color);
            color: var(--primary-color);
            padding: 20px;
            border-radius: 10px;
            margin-top: 0;
            transform: rotate(-2deg);
            box-shadow: 5px 5px 0 var(--shadow-color);
        }

        h2 {
            font-size: 2rem;
            transform: rotate(1deg);
        }

        h3 {
            font-size: 1.5rem;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px dotted var(--link-color);
            transition: all 0.3s ease;
        }

        a:hover {
            background-color: var(--link-color);
            color: var(--primary-color);
        }

        pre {
            background-color: var(--code-bg);
            border: 2px solid var(--text-color);
            border-radius: 10px;
            padding: 15px;
            overflow-x: auto;
            position: relative;
            margin: 20px 0;
            box-shadow: 5px 5px 0 var(--shadow-color);
        }

        code {
            font-family: 'Courier New', monospace;
            color: var(--code-color);
        }

        .code-label {
            position: absolute;
            top: -10px;
            left: 20px;
            background-color: var(--primary-color);
            padding: 2px 10px;
            border: 2px solid var(--text-color);
            border-radius: 5px;
            font-weight: bold;
            font-size: 0.8rem;
        }

        .note {
            background-color: rgba(255, 255, 255, 0.3);
            border-left: 5px solid var(--text-color);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 10px 10px 0;
        }

        .resource-section {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 20px;
        }

        .resource-card {
            background-color: rgba(255, 255, 255, 0.2);
            border: 2px solid var(--text-color);
            border-radius: 10px;
            padding: 15px;
            flex: 1 1 200px;
            transition: transform 0.3s ease;
        }

        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px var(--shadow-color);
        }

        .example-output {
            background-color: rgba(0, 0, 0, 0.05);
            border: 2px dashed var(--text-color);
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            font-family: 'Courier New', monospace;
        }

        .stitch {
            height: 10px;
            background: repeating-linear-gradient(
                -45deg,
                transparent,
                transparent 10px,
                var(--text-color) 10px,
                var(--text-color) 12px
            );
            margin: 30px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            border: 2px solid var(--text-color);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid var(--text-color);
        }

        th {
            background-color: rgba(0, 0, 0, 0.1);
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .svg-container {
            display: flex;
            justify-content: center;
            margin: 30px 0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            .resource-section {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Swift 正则表达式指南</h1>

        <div class="note">
            正则表达式是一种强大的文本处理工具，在Swift中有多种实现方式。本章节将全面介绍Swift中的正则表达式使用方法，从基础到高级应用。
        </div>

        <h2>1. 正则表达式基础</h2>

        <p>正则表达式(Regular Expression，简称Regex)是用于匹配字符串中字符组合的模式。在Swift中，正则表达式功能经历了显著的演变，特别是在Swift 5.7中引入了原生正则表达式支持。</p>

        <div class="svg-container">
            <svg width="600" height="200" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .title { fill: var(--text-color); font-size: 16px; font-weight: bold; font-family: Arial, sans-serif; }
                    .box { fill: var(--primary-color); stroke: var(--text-color); stroke-width: 3; }
                    .arrow { stroke: var(--text-color); stroke-width: 3; fill: none; }
                    .label { fill: var(--text-color); font-size: 14px; font-family: Arial, sans-serif; }
                    .highlight { fill: #ff6b6b; stroke: var(--text-color); stroke-width: 3; }
                </style>
                <text x="300" y="25" text-anchor="middle" class="title">Swift正则表达式演进</text>
                <!-- 时间线 -->
                <line x1="50" y1="100" x2="550" y2="100" stroke="var(--text-color)" stroke-width="3"/>
                <!-- Swift 4 -->
                <circle cx="100" cy="100" r="10" fill="var(--primary-color)" stroke="var(--text-color)" stroke-width="3"/>
                <text x="100" y="130" text-anchor="middle" class="label">Swift 4</text>
                <text x="100" y="150" text-anchor="middle" class="label">NSRegularExpression</text>
                <!-- Swift 5.0-5.6 -->
                <circle cx="250" cy="100" r="10" fill="var(--primary-color)" stroke="var(--text-color)" stroke-width="3"/>
                <text x="250" y="130" text-anchor="middle" class="label">Swift 5.0-5.6</text>
                <text x="250" y="150" text-anchor="middle" class="label">改进的API</text>
                <!-- Swift 5.7 -->
                <circle cx="400" cy="100" r="15" fill="var(--primary-color)" stroke="var(--text-color)" stroke-width="3"/>
                <text x="400" y="130" text-anchor="middle" class="label">Swift 5.7</text>
                <text x="400" y="150" text-anchor="middle" class="label">原生Regex支持</text>
                <text x="400" y="170" text-anchor="middle" class="label">RegexBuilder</text>
                <!-- 未来 -->
                <circle cx="500" cy="100" r="10" fill="var(--primary-color)" stroke="var(--text-color)" stroke-width="3"/>
                <text x="500" y="130" text-anchor="middle" class="label">未来发展</text>
            </svg>
        </div>

        <h2>2. Swift 5.7之前的正则表达式</h2>

        <p>在Swift 5.7之前，主要通过Foundation框架中的<code>NSRegularExpression</code>来处理正则表达式。</p>

        <pre><code class="code-label">示例：使用NSRegularExpression</code><code>
// 使用NSRegularExpression进行字符串匹配
import Foundation

func findMatches(in text: String, pattern: String) -> [String] {
    do {
        // 创建正则表达式对象
        let regex = try NSRegularExpression(pattern: pattern, options: [])

        // 在文本中寻找匹配项
        let matches = regex.matches(
            in: text,
            options: [],
            range: NSRange(location: 0, length: text.utf16.count)
        )

        // 提取匹配的内容
        return matches.compactMap { match in
            guard let range = Range(match.range, in: text) else { return nil }
            return String(text[range])
        }
    } catch {
        print("正则表达式错误: \(error)")
        return []
    }
}

// 测试示例
let text = "联系方式：电话13800138000，邮箱example@email.com"
let phonePattern = "[1][3-9][0-9]{9}" // 简单的手机号匹配模式
let emailPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

let phones = findMatches(in: text, pattern: phonePattern)
print("找到的电话号码: \(phones)")

let emails = findMatches(in: text, pattern: emailPattern)
print("找到的邮箱: \(emails)")
</code></pre>

        <div class="example-output">
            找到的电话号码: ["13800138000"]<br>
            找到的邮箱: ["example@email.com"]
        </div>

        <div class="note">
            <strong>注意：</strong>在使用<code>NSRegularExpression</code>时需要处理NSRange与Swift字符串Range的转换，这增加了代码的复杂性。
        </div>

        <h2>3. Swift 5.7中的原生正则表达式</h2>

        <p>Swift 5.7引入了<code>Regex</code>类型和<code>RegexBuilder</code>DSL，大大简化了正则表达式的使用。</p>

        <h3>3.1 基本的Regex字面量</h3>

        <pre><code class="code-label">Swift 5.7的Regex字面量</code><code>
import Foundation

let text = "联系方式：电话13800138000，邮箱example@email.com"

// 使用正则表达式字面量
let phoneRegex = /[1][3-9][0-9]{9}/
if let match = text.firstMatch(of: phoneRegex) {
    print("找到电话号码: \(match.0)")
}

// 查找所有匹配项
let allPhoneMatches = text.matches(of: phoneRegex)
for match in allPhoneMatches {
    print("电话号码: \(match.0)")
}

// 使用捕获组
let emailRegex = /([A-Za-z0-9._%+-]+)@([A-Za-z0-9.-]+\.[A-Za-z]{2,6})/
if let emailMatch = text.firstMatch(of: emailRegex) {
    print("完整邮箱: \(emailMatch.0)")
    print("用户名部分: \(emailMatch.1)")
    print("域名部分: \(emailMatch.2)")
}
</code></pre>

        <div class="example-output">
            找到电话号码: 13800138000<br>
            电话号码: 13800138000<br>
            完整邮箱: example@email.com<br>
            用户名部分: example<br>
            域名部分: email.com
        </div>

        <h3>3.2 使用RegexBuilder</h3>

        <p><code>RegexBuilder</code>是Swift 5.7引入的一种类型安全、声明式的正则表达式构建方式。</p>

        <div class="svg-container">
            <svg width="600" height="280" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .title { fill: var(--text-color); font-size: 16px; font-weight: bold; font-family: Arial, sans-serif; }
                    .box { fill: var(--primary-color); stroke: var(--text-color); stroke-width: 3; rx: 10; ry: 10; }
                    .arrow { stroke: var(--text-color); stroke-width: 3; fill: none; marker-end: url(#arrowhead); }
                    .label { fill: var(--text-color); font-size: 14px; font-family: Arial, sans-serif; }
                </style>
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-color)" />
                    </marker>
                </defs>
                <text x="300" y="25" text-anchor="middle" class="title">正则表达式构建方式比较</text>
                <!-- 传统正则表达式 -->
                <rect x="50" y="50" width="200" height="80" class="box"/>
                <text x="150" y="85" text-anchor="middle" class="label">传统正则表达式</text>
                <text x="150" y="110" text-anchor="middle" class="label" font-size="12">/[A-Z]\d{3}-\d{2}-\d{4}/</text>
                <!-- RegexBuilder -->
                <rect x="350" y="50" width="200" height="80" class="box"/>
                <text x="450" y="75" text-anchor="middle" class="label">RegexBuilder</text>
                <text x="450" y="100" text-anchor="middle" class="label" font-size="12">结构化、声明式</text>
                <text x="450" y="120" text-anchor="middle" class="label" font-size="12">类型安全</text>
                <!-- 优势对比 -->
                <rect x="50" y="180" width="200" height="80" class="box"/>
                <text x="150" y="205" text-anchor="middle" class="label" font-size="12">• 简洁紧凑</text>
                <text x="150" y="225" text-anchor="middle" class="label" font-size="12">• 传统标准语法</text>
                <text x="150" y="245" text-anchor="middle" class="label" font-size="12">• 跨平台通用</text>
                <rect x="350" y="180" width="200" height="80" class="box"/>
                <text x="450" y="205" text-anchor="middle" class="label" font-size="12">• 可读性强</text>
                <text x="450" y="225" text-anchor="middle" class="label" font-size="12">• 编译时类型检查</text>
                <text x="450" y="245" text-anchor="middle" class="label" font-size="12">• Swift原生集成</text>
                <!-- 连接箭头 -->
                <line x1="270" y1="90" x2="330" y2="90" class="arrow"/>
            </svg>
        </div>

        <pre><code class="code-label">RegexBuilder示例</code><code>
import Foundation
import RegexBuilder

let text = "订单信息: ORDER-2023-05-18-1234, 客户ID: CUST-789"

// 使用RegexBuilder构建正则表达式
let orderNumberRegex = Regex {
    "ORDER-"
    Capture {
        One(.digit)
        One(.digit)
        One(.digit)
        One(.digit)
    }
    "-"
    Capture {
        One(.digit)
        One(.digit)
    }
    "-"
    Capture {
        One(.digit)
        One(.digit)
    }
    "-"
    Capture {
        OneOrMore(.digit)
    }
}

// 更简洁的写法
let orderRegexSimplified = Regex {
    "ORDER-"
    Capture { Repeat(.digit, count: 4) }
    "-"
    Capture { Repeat(.digit, count: 2) }
    "-"
    Capture { Repeat(.digit, count: 2) }
    "-"
    Capture { OneOrMore(.digit) }
}

if let match = text.firstMatch(of: orderRegexSimplified) {
    let (wholeMatch, year, month, day, number) = match.output
    print("订单号: \(wholeMatch)")
    print("年份: \(year)")
    print("月份: \(month)")
    print("日期: \(day)")
    print("编号: \(number)")
}

// 使用TryCapture进行验证
let validOrderRegex = Regex {
    "ORDER-"
    TryCapture {
        Repeat(.digit, count: 4)
    } transform: { year in
        Int(year).map { $0 >= 2020 && $0 <= 2030 } ?? false ? year : nil
    }
    "-"
    TryCapture {
        Repeat(.digit, count: 2)
    } transform: { month in
        Int(month).map { $0 >= 1 && $0 <= 12 } ?? false ? month : nil
    }
    "-"
    Capture { Repeat(.digit, count: 2) }
    "-"
    Capture { OneOrMore(.digit) }
}

if let validMatch = text.firstMatch(of: validOrderRegex) {
    print("有效订单: \(validMatch.0)")
} else {
    print("订单格式无效或日期不在有效范围")
}
</code></pre>

        <div class="example-output">
            订单号: ORDER-2023-05-18-1234<br>
            年份: 2023<br>
            月份: 05<br>
            日期: 18<br>
            编号: 1234<br>
            有效订单: ORDER-2023-05-18-1234
        </div>

        <h3>3.3 正则表达式替换操作</h3>

        <pre><code class="code-label">字符串替换</code><code>
import Foundation

let text = "联系客服电话：13912345678 或 13887654321"

// 使用正则表达式替换字符串
let maskedText = text.replacing(/1\d{10}/) { match in
    let number = String(match.0)
    return number.prefix(3) + "****" + number.suffix(4)
}

print("替换后的文本: \(maskedText)")

// 多个正则表达式替换
let sensitiveData = "身份证号: 310123200001015432, 银行卡: 6222021234567890123"

func maskSensitiveData(_ input: String) -> String {
    var result = input

    // 掩盖身份证号
    result = result.replacing(/[1-9]\d{5}(19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dX]/) { match in
        let id = String(match.0)
        return id.prefix(6) + "********" + id.suffix(4)
    }

    // 掩盖银行卡号
    result = result.replacing(/\b\d{16,19}\b/) { match in
        let card = String(match.0)
        return card.prefix(4) + " **** **** " + card.suffix(4)
    }

    return result
}

let maskedData = maskSensitiveData(sensitiveData)
print("掩盖敏感信息后: \(maskedData)")
</code></pre>

        <div class="example-output">
            替换后的文本: 联系客服电话：139****5678 或 138****4321<br>
            掩盖敏感信息后: 身份证号: 310123********5432, 银行卡: 6222 **** **** 0123
        </div>

        <h2>4. 正则表达式语法参考</h2>

        <p>理解正则表达式的常用语法元素对于高效使用正则表达式至关重要。</p>

        <table>
            <tr>
                <th>语法元素</th>
                <th>说明</th>
                <th>示例</th>
            </tr>
            <tr>
                <td>.</td>
                <td>匹配任意单个字符</td>
                <td>a.c 匹配 abc, adc, a1c 等</td>
            </tr>
            <tr>
                <td>^</td>
                <td>匹配字符串开头</td>
                <td>^apple 匹配以apple开头的字符串</td>
            </tr>
            <tr>
                <td>$</td>
                <td>匹配字符串结尾</td>
                <td>apple$ 匹配以apple结尾的字符串</td>
            </tr>
            <tr>
                <td>[abc]</td>
                <td>匹配字符集中的任意一个</td>
                <td>[aeiou] 匹配任一元音字母</td>
            </tr>
            <tr>
                <td>[^abc]</td>
                <td>匹配不在字符集中的任意字符</td>
                <td>[^0-9] 匹配任意非数字字符</td>
            </tr>
            <tr>
                <td>a|b</td>
                <td>匹配a或b</td>
                <td>apple|orange 匹配apple或orange</td>
            </tr>
            <tr>
                <td>(ab)</td>
                <td>分组</td>
                <td>(apple) 捕获apple作为一个组</td>
            </tr>
            <tr>
                <td>\d</td>
                <td>匹配数字[0-9]</td>
                <td>\d{3} 匹配三位数字</td>
            </tr>
            <tr>
                <td>\w</td>
                <td>匹配字母数字下划线</td>
                <td>\w+ 匹配一个或多个字母/数字/下划线</td>
            </tr>
            <tr>
                <td>\s</td>
                <td>匹配空白字符</td>
                <td>\s 匹配空格、制表符等</td>
            </tr>
            <tr>
                <td>*</td>
                <td>零次或多次</td>
                <td>a* 匹配零个或多个a</td>
            </tr>
            <tr>
                <td>+</td>
                <td>一次或多次</td>
                <td>a+ 匹配一个或多个a</td>
            </tr>
            <tr>
                <td>?</td>
                <td>零次或一次</td>
                <td>a? 匹配零个或一个a</td>
            </tr>
            <tr>
                <td>{n}</td>
                <td>恰好n次</td>
                <td>a{3} 匹配aaa</td>
            </tr>
            <tr>
                <td>{n,}</td>
                <td>至少n次</td>
                <td>a{2,} 匹配aa或更多</td>
            </tr>
            <tr>
                <td>{n,m}</td>
                <td>n到m次之间</td>
                <td>a{2,4} 匹配aa,aaa或aaaa</td>
            </tr>
        </table>

        <h2>5. 高级正则表达式技巧</h2>

        <h3>5.1 前瞻和后顾</h3>

        <pre><code class="code-label">前瞻与后顾断言</code><code>
import Foundation

let text = "价格: $100, €200, ¥300"

// 肯定前瞻(只匹配后面跟着特定内容的价格)
// 匹配形如 $100、€200 的价格，但不捕获货币符号
let priceRegex = /(?<=[$€¥])\d+/

let prices = text.matches(of: priceRegex).map { String($0.0) }
print("找到的价格: \(prices)")

// 否定前瞻(匹配不跟着特定内容的价格)
let textWithSuffix = "价格: 100元, 200美元, 300日元"
let priceWithoutSuffix = /\d+(?!元)/

let nonYuanPrices = textWithSuffix.matches(of: priceWithoutSuffix).map { String($0.0) }
print("非"元"结尾的价格: \(nonYuanPrices)")

// 肯定后顾(只匹配前面是特定内容的价格)
let pricesWithCurrencySymbol = "小米手机 1299, iPhone 8999"
let phoneRegex = /(?<=iPhone\s)\d+/

if let iPhonePrice = pricesWithCurrencySymbol.firstMatch(of: phoneRegex) {
    print("iPhone价格: \(iPhonePrice.0)")
}

// 否定后顾(匹配前面不是特定内容的价格)
let nonXiaomiRegex = /(?<!小米手机\s)\b\d+/

let nonXiaomiPrice = pricesWithCurrencySymbol.matches(of: nonXiaomiRegex).map { String($0.0) }
print("非小米手机的价格: \(nonXiaomiPrice)")
</code></pre>

        <div class="example-output">
            找到的价格: ["100", "200", "300"]<br>
            非"元"结尾的价格: ["10", "20", "30"]<br>
            iPhone价格: 8999<br>
            非小米手机的价格: ["8999"]
        </div>

        <h3>5.2 反向引用</h3>

        <pre><code class="code-label">反向引用示例</code><code>
import Foundation

// 找出重复的单词
let text = "这是是一个示例文本文本"

// 使用传统正则表达式的反向引用
let duplicateRegex = /(\p{Han})\1/

let duplicates = text.matches(of: duplicateRegex).map { String($0.0) }
print("重复的汉字: \(duplicates)")

// 匹配HTML标签
let htmlText = "<div>这是一段HTML内容</div><span>这是另一段内容</span>"

// 捕获开标签名称并在关标签中引用
// 正则表达式：<([a-z]+)>.*?</\1>
let tagRegex = /<([a-z]+)>.*?<\/\1>/

let tags = htmlText.matches(of: tagRegex).map { String($0.0) }
print("匹配的HTML标签: \(tags)")

// 使用命名捕获组和引用
// 在Swift 5.7的RegexBuilder中使用命名捕获组
let nameTagRegex = Regex {
    "<"
    Capture {
        OneOrMore(.anyOf("abcdefghijklmnopqrstuvwxyz"))
    } as: \.tagName
    ">"
    ZeroOrMore(.any, .reluctant)
    "</"
    Reference(\.tagName)
    ">"
}
.asciiOnlyDigits()

// 定义自定义输出类型
struct TagMatch {
    var tagName: Substring
}

let htmlMatches = htmlText.matches(of: nameTagRegex)
for match in htmlMatches {
    print("标签名: \(match.output.tagName), 完整内容: \(match.0)")
}
</code></pre>

        <div class="example-output">
            重复的汉字: ["是是", "文文"]<br>
            匹配的HTML标签: ["&lt;div&gt;这是一段HTML内容&lt;/div&gt;", "&lt;span&gt;这是另一段内容&lt;/span&gt;"]<br>
            标签名: div, 完整内容: &lt;div&gt;这是一段HTML内容&lt;/div&gt;<br>
            标签名: span, 完整内容: &lt;span&gt;这是另一段内容&lt;/span&gt;
        </div>

        <h3>5.3 贪婪与非贪婪匹配</h3>

        <pre><code class="code-label">贪婪与非贪婪匹配对比</code><code>
import Foundation

let htmlContent = "<div><p>第一段</p><p>第二段</p></div>"

// 贪婪匹配 (会匹配尽可能多的字符)
let greedyRegex = /<p>.*<\/p>/

if let greedyMatch = htmlContent.firstMatch(of: greedyRegex) {
    print("贪婪匹配结果: \(greedyMatch.0)")
}

// 非贪婪匹配 (匹配尽可能少的字符)
let nonGreedyRegex = /<p>.*?<\/p>/

let nonGreedyMatches = htmlContent.matches(of: nonGreedyRegex).map { String($0.0) }
print("非贪婪匹配结果: \(nonGreedyMatches)")

// RegexBuilder中的贪婪与非贪婪
let greedyBuilder = Regex {
    "<p>"
    ZeroOrMore(.any)  // 默认贪婪
    "</p>"
}

let nonGreedyBuilder = Regex {
    "<p>"
    ZeroOrMore(.any, .reluctant)  // .reluctant 指定非贪婪
    "</p>"
}

print("RegexBuilder贪婪匹配: \(htmlContent.firstMatch(of: greedyBuilder)?.0 ?? "")")
print("RegexBuilder非贪婪匹配列表: \(htmlContent.matches(of: nonGreedyBuilder).map { String($0.0) })")
</code></pre>

        <div class="example-output">
            贪婪匹配结果: &lt;p&gt;第一段&lt;/p&gt;&lt;p&gt;第二段&lt;/p&gt;<br>
            非贪婪匹配结果: ["&lt;p&gt;第一段&lt;/p&gt;", "&lt;p&gt;第二段&lt;/p&gt;"]<br>
            RegexBuilder贪婪匹配: &lt;p&gt;第一段&lt;/p&gt;&lt;p&gt;第二段&lt;/p&gt;<br>
            RegexBuilder非贪婪匹配列表: ["&lt;p&gt;第一段&lt;/p&gt;", "&lt;p&gt;第二段&lt;/p&gt;"]
        </div>

        <h2>6. 正则表达式性能优化</h2>

        <div class="note">
            <strong>性能提示：</strong>不恰当的正则表达式可能导致性能问题，特别是在处理大型文本时。以下是一些优化策略：
        </div>

        <ul>
            <li>避免过度使用贪婪量词和回溯</li>
            <li>使用非捕获组 <code>(?:pattern)</code> 代替不需要引用的捕获组</li>
            <li>尽可能具体化模式，避免过于宽泛的匹配</li>
            <li>对于简单的字符串操作，考虑使用String API而非正则表达式</li>
            <li>对于频繁使用的正则表达式，预编译并重用</li>
        </ul>

        <pre><code class="code-label">性能优化示例</code><code>
import Foundation

// 反面教材：可能导致灾难性回溯的正则表达式
// 在大文本上尝试这个可能会导致应用程序挂起
let badRegex = /(a+)+b/

// 优化版本：避免嵌套重复
let goodRegex = /a+b/

// 预编译正则表达式以提高性能
let emailRegexPattern = #"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"#
let compiledEmailRegex = try! Regex(emailRegexPattern)

func validateEmails(_ emails: [String]) -> [Bool] {
    // 重用编译好的正则表达式，而不是每次都创建新的
    return emails.map { email in
        email.contains(compiledEmailRegex)
    }
}

// 使用非捕获组提高性能
let captureGroup = /(Swift|SwiftUI) (is|was) (great|awesome)/
let nonCaptureGroup = /(?:Swift|SwiftUI) (?:is|was) (?:great|awesome)/

// 限制回溯的复杂度
// 在支持possessive quantifiers的正则表达式引擎中可以使用 a++
// 在Swift regex中，可以使用明确的边界或更精确的模式
</code></pre>

        <h2>7. 实用正则表达式示例</h2>

        <pre><code class="code-label">常见验证正则表达式</code><code>
import Foundation
import RegexBuilder

// 常用验证正则表达式
struct ValidationPatterns {
    // 简单邮箱验证
    static let email = /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/

    // 中国大陆手机号
    static let chinesePhone = /1[3-9]\d{9}/

    // 中国身份证号
    static let chineseID = /[1-9]\d{5}(19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dX]/

    // URL
    static let url = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)/

    // IP地址 (IPv4)
    static let ipv4 = /((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/

    // 日期格式 (YYYY-MM-DD)
    static let date = /\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])/

    // 强密码 (至少8位，包含大小写字母、数字和特殊字符)
    static let strongPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/
}

// 使用校验器
func validate(input: String, pattern: Regex<Substring>) -> Bool {
    return input.contains(pattern)
}

// 测试各种校验
let testEmail = "example@email.com"
print("邮箱验证: \(validate(input: testEmail, pattern: ValidationPatterns.email))")

let testPhone = "13912345678"
print("手机号验证: \(validate(input: testPhone, pattern: ValidationPatterns.chinesePhone))")

let testURL = "https://www.example.com/path?query=value"
print("URL验证: \(validate(input: testURL, pattern: ValidationPatterns.url))")

let testDate = "2023-05-15"
print("日期验证: \(validate(input: testDate, pattern: ValidationPatterns.date))")
</code></pre>

        <div class="example-output">
            邮箱验证: true<br>
            手机号验证: true<br>
            URL验证: true<br>
            日期验证: true
        </div>

        <h3>7.1 文本处理与提取</h3>

        <pre><code class="code-label">文本处理示例</code><code>
import Foundation
import RegexBuilder

// 从文本中提取所有URL
func extractURLs(from text: String) -> [String] {
    let urlRegex = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)/
    return text.matches(of: urlRegex).map { String($0.0) }
}

// 提取文本中的标签（形如#标签#）
func extractTags(from text: String) -> [String] {
    let tagRegex = /#([^\s#]+)#/
    return text.matches(of: tagRegex).map { String($0.1) }
}

// 格式化电话号码
func formatPhoneNumber(phone: String) -> String {
    let regex = /(\d{3})(\d{4})(\d{4})/
    return phone.replacing(regex) { match in
        "\($0.1)-\($0.2)-\($0.3)"
    }
}

// 从原始日志中提取日期、级别和消息
func parseLogLine(log: String) -> (date: String, level: String, message: String)? {
    let logRegex = /\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\] (\w+): (.*)/

    if let match = log.firstMatch(of: logRegex) {
        return (date: String(match.1), level: String(match.2), message: String(match.3))
    }
    return nil
}

// 测试
let sampleText = """
访问 https://www.apple.com 或 https://developer.apple.com 获取更多信息。
流行话题: #Swift# #iOS开发# #正则表达式#
"""

let phoneNumber = "13912345678"
let logLine = "[2023-05-15 14:30:45] ERROR: 无法连接到服务器"

print("提取的URL: \(extractURLs(from: sampleText))")
print("提取的标签: \(extractTags(from: sampleText))")
print("格式化电话号码: \(formatPhoneNumber(phone: phoneNumber))")

if let logInfo = parseLogLine(log: logLine) {
    print("日志日期: \(logInfo.date)")
    print("日志级别: \(logInfo.level)")
    print("日志消息: \(logInfo.message)")
}
</code></pre>

        <div class="example-output">
            提取的URL: ["https://www.apple.com", "https://developer.apple.com"]<br>
            提取的标签: ["Swift", "iOS开发", "正则表达式"]<br>
            格式化电话号码: 139-1234-5678<br>
            日志日期: 2023-05-15 14:30:45<br>
            日志级别: ERROR<br>
            日志消息: 无法连接到服务器
        </div>

        <div class="stitch"></div>

        <h2>8. 参考资源</h2>

        <h3>8.1 官方文档与参考</h3>

        <div class="resource-section">
            <div class="resource-card">
                <h4>Apple官方资源</h4>
                <ul>
                    <li><a href="https://developer.apple.com/documentation/swift/regex" target="_blank">Swift Regex官方文档</a></li>
                    <li><a href="https://developer.apple.com/documentation/foundation/nsregularexpression" target="_blank">NSRegularExpression文档</a></li>
                    <li><a href="https://developer.apple.com/videos/play/wwdc2022/110357/" target="_blank">WWDC22: 迎接Swift正则表达式</a></li>
                </ul>
            </div>

            <div class="resource-card">
                <h4>Swift Evolution提案</h4>
                <ul>
                    <li><a href="https://github.com/apple/swift-evolution/blob/main/proposals/0350-regex-literals.md" target="_blank">SE-0350: 正则表达式字面量</a></li>
                    <li><a href="https://github.com/apple/swift-evolution/blob/main/proposals/0351-regex-builder.md" target="_blank">SE-0351: RegexBuilder DSL</a></li>
                    <li><a href="https://github.com/apple/swift-evolution/blob/main/proposals/0357-regex-string-processing-algorithms.md" target="_blank">SE-0357: 正则表达式的字符串处理算法</a></li>
                </ul>
            </div>
        </div>

        <h3>8.2 博客与教程</h3>

        <div class="resource-section">
            <div class="resource-card">
                <h4>优质博客文章</h4>
                <ul>
                    <li><a href="https://www.swiftbysundell.com/articles/gets-regex-new-regex-dsl/" target="_blank">Swift by Sundell: Swift正则表达式详解</a></li>
                    <li><a href="https://www.hackingwithswift.com/articles/242/how-to-use-regular-expressions-in-swift" target="_blank">Hacking with Swift: Swift中的正则表达式</a></li>
                    <li><a href="https://nshipster.com/swift-regular-expressions/" target="_blank">NSHipster: Swift正则表达式</a></li>
                </ul>
            </div>

            <div class="resource-card">
                <h4>视频教程</h4>
                <ul>
                    <li><a href="https://www.youtube.com/watch?v=VHr35TjYZ0Q" target="_blank">Swift正则表达式入门到精通</a></li>
                    <li><a href="https://www.pointfree.co/episodes/ep166-regex-part-1" target="_blank">Point-Free: Swift正则表达式深度解析</a></li>
                </ul>
            </div>
        </div>

        <h3>8.3 书籍与在线工具</h3>

        <div class="resource-section">
            <div class="resource-card">
                <h4>推荐书籍</h4>
                <ul>
                    <li>"正则表达式必知必会" by Jan Goyvaerts & Steven Levithan</li>
                    <li>"精通正则表达式" by Jeffrey Friedl</li>
                    <li>"正则表达式30分钟入门" by ZhuoQiang</li>
                </ul>
            </div>

            <div class="resource-card">
                <h4>实用工具</h4>
                <ul>
                    <li><a href="https://regex101.com/" target="_blank">Regex101: 在线正则表达式测试工具</a></li>
                    <li><a href="https://regexr.com/" target="_blank">RegExr: 学习、构建和测试正则表达式</a></li>
                    <li><a href="https://github.com/sindresorhus/awesome-regex" target="_blank">Awesome Regex: 正则表达式资源集合</a></li>
                </ul>
            </div>
        </div>

        <h3>8.4 开源项目</h3>

        <div class="resource-section">
            <div class="resource-card">
                <h4>相关Swift开源项目</h4>
                <ul>
                    <li><a href="https://github.com/apple/swift-experimental-string-processing" target="_blank">Swift实验性字符串处理</a> - Swift正则表达式的实验性实现</li>
                    <li><a href="https://github.com/crossroadlabs/Regex" target="_blank">Crossroad Labs Regex</a> - Swift正则表达式库</li>
                    <li><a href="https://github.com/sharplet/Regex" target="_blank">Sharplet Regex</a> - Swift的简单、类型安全的正则表达式</li>
                </ul>
            </div>

            <div class="resource-card">
                <h4>实用工具项目</h4>
                <ul>
                    <li><a href="https://github.com/SwiftyBeaver/SwiftyBeaver" target="_blank">SwiftyBeaver</a> - 使用正则表达式进行日志过滤的日志库</li>
                    <li><a href="https://github.com/malcommac/SwiftDate" target="_blank">SwiftDate</a> - 使用正则表达式解析日期的时间库</li>
                    <li><a href="https://github.com/SwiftGen/SwiftGen" target="_blank">SwiftGen</a> - 使用正则表达式进行代码生成的工具</li>
                </ul>
            </div>
        </div>

        <div class="note">
            <strong>注意：</strong>正则表达式是一个强大的工具，但过度复杂的正则表达式可能导致代码难以维护。在实际开发中，应根据具体需求选择适当的复杂度级别，并进行充分的测试。
        </div>
    </div>
</body>
</html>
