<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift控制流 - Switch语句详解</title>
    <style>
        :root {
            --background-color: #fff9e6;
            --text-color: #333;
            --code-bg: #f5f5f5;
            --card-bg: #ffffff;
            --accent-color: #ff9a52;
            --border-color: #ffc107;
            --link-color: #0066cc;
            --header-color: #e67e22;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background-color: #2a2a2a;
                --text-color: #e0e0e0;
                --code-bg: #383838;
                --card-bg: #3a3a3a;
                --accent-color: #ff9a52;
                --border-color: #ffc107;
                --link-color: #66b3ff;
                --header-color: #ff9a52;
            }
        }

        body {
            font-family: "SF Pro Text", "SF Pro Icons", "Helvetica Neue", Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--background-color);
            margin: 0;
            padding: 20px;
            max-width: 900px;
            margin: 0 auto;
        }

        h1, h2, h3, h4 {
            color: var(--header-color);
            font-weight: 700;
            margin-top: 1.5em;
            margin-bottom: 0.5em;
            border-bottom: 2px dashed var(--border-color);
            padding-bottom: 5px;
        }

        h1 {
            text-align: center;
            font-size: 2.5em;
            border-bottom: none;
            margin-bottom: 30px;
            position: relative;
        }

        h1::after {
            content: "";
            display: block;
            width: 100px;
            height: 5px;
            background: var(--accent-color);
            border-radius: 5px;
            margin: 15px auto 0;
        }

        .card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border: 2px solid var(--border-color);
        }

        pre {
            background-color: var(--code-bg);
            padding: 15px;
            border-radius: 10px;
            overflow-x: auto;
            border-left: 4px solid var(--accent-color);
        }

        code {
            font-family: "SF Mono", monospace;
            font-size: 0.9em;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dashed;
        }

        a:hover {
            border-bottom: 1px solid;
        }

        .note {
            background-color: rgba(255, 193, 7, 0.1);
            border-left: 4px solid var(--accent-color);
            padding: 10px 15px;
            margin: 15px 0;
            border-radius: 5px;
        }

        .resources {
            margin-top: 40px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .resource-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 15px;
            border: 2px solid var(--border-color);
        }

        .resource-card h4 {
            margin-top: 0;
            border-bottom: 1px dashed var(--border-color);
        }

        .example-container {
            margin: 20px 0;
        }

        .svg-container {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            pre {
                font-size: 0.8em;
            }
            .resources {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift控制流: Switch语句详解</h1>
    </header>

    <div class="card">
        <h2>Switch语句简介</h2>
        <p>Swift中的switch语句是一种强大的控制流机制，与其他语言相比有很多独特和灵活的特性。在Swift中，switch语句不会默认贯穿到下一个case，且必须处理所有可能的输入值。</p>
        
        <div class="svg-container">
            <svg width="500" height="250" viewBox="0 0 500 250">
                <style>
                    .diagram-text { font-family: "SF Pro Text", sans-serif; font-size: 14px; }
                    .diagram-box { stroke-width: 2px; rx: 10; ry: 10; }
                    .diagram-arrow { stroke-width: 2px; fill: none; }
                    @media (prefers-color-scheme: dark) {
                        .diagram-text { fill: #e0e0e0; }
                        .diagram-box { stroke: #ffc107; fill: #3a3a3a; }
                        .diagram-arrow { stroke: #e0e0e0; }
                    }
                    @media (prefers-color-scheme: light) {
                        .diagram-text { fill: #333; }
                        .diagram-box { stroke: #ff9a52; fill: #fff; }
                        .diagram-arrow { stroke: #333; }
                    }
                </style>
                <rect x="150" y="10" width="200" height="40" class="diagram-box" />
                <text x="250" y="35" text-anchor="middle" class="diagram-text">switch 表达式 {</text>
                
                <rect x="50" y="100" width="120" height="40" class="diagram-box" />
                <text x="110" y="125" text-anchor="middle" class="diagram-text">case 模式1:</text>
                
                <rect x="190" y="100" width="120" height="40" class="diagram-box" />
                <text x="250" y="125" text-anchor="middle" class="diagram-text">case 模式2:</text>
                
                <rect x="330" y="100" width="120" height="40" class="diagram-box" />
                <text x="390" y="125" text-anchor="middle" class="diagram-text">default:</text>
                
                <rect x="50" y="180" width="120" height="40" class="diagram-box" />
                <text x="110" y="205" text-anchor="middle" class="diagram-text">代码1</text>
                
                <rect x="190" y="180" width="120" height="40" class="diagram-box" />
                <text x="250" y="205" text-anchor="middle" class="diagram-text">代码2</text>
                
                <rect x="330" y="180" width="120" height="40" class="diagram-box" />
                <text x="390" y="205" text-anchor="middle" class="diagram-text">默认代码</text>
                
                <path d="M250 50 L250 70 L110 70 L110 100" class="diagram-arrow" marker-end="url(#arrowhead)" />
                <path d="M250 50 L250 100" class="diagram-arrow" marker-end="url(#arrowhead)" />
                <path d="M250 50 L250 70 L390 70 L390 100" class="diagram-arrow" marker-end="url(#arrowhead)" />
                
                <path d="M110 140 L110 180" class="diagram-arrow" marker-end="url(#arrowhead)" />
                <path d="M250 140 L250 180" class="diagram-arrow" marker-end="url(#arrowhead)" />
                <path d="M390 140 L390 180" class="diagram-arrow" marker-end="url(#arrowhead)" />
                
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" />
                    </marker>
                </defs>
            </svg>
        </div>
    </div>

    <div class="card">
        <h2>Swift Switch的基本语法</h2>
        <p>Swift的switch语句检查一个值是否与多个可能的模式匹配。</p>
        
        <div class="example-container">
            <h3>基本示例</h3>
            <pre><code>// Swift中的基本switch语法
let someCharacter: Character = "z"

switch someCharacter {
case "a":
    print("这是字母a") // 如果someCharacter是"a"，执行这行
case "z":
    print("这是最后一个字母z") // 如果someCharacter是"z"，执行这行
default:
    print("这是其他字符") // 如果someCharacter不是"a"也不是"z"，执行这行
}
// 输出: 这是最后一个字母z</code></pre>
        </div>
        
        <div class="note">
            <p><strong>注意：</strong> Swift中的switch语句必须是详尽的，这意味着每个可能的值都必须在某个case中匹配。如果无法列举所有可能的值，可以使用default来捕获任何其他可能的值。</p>
        </div>
    </div>

    <div class="card">
        <h2>Swift Switch的独特特性</h2>
        
        <h3>1. 无隐式贯穿</h3>
        <p>与C和Objective-C不同，Swift中的switch语句不会默认贯穿到下一个case。每个case执行完后会自动退出switch语句，无需使用break语句。</p>
        
        <div class="example-container">
            <pre><code>// Swift中不会默认贯穿到下一个case
let fruit = "apple"

switch fruit {
case "apple":
    print("这是苹果")
    // 不需要break，Swift会自动退出switch
case "banana":
    print("这是香蕉")
default:
    print("这是其他水果")
}
// 输出: 这是苹果</code></pre>
        </div>
        
        <h3>2. 使用fallthrough关键字实现贯穿</h3>
        <p>如果您确实需要C风格的贯穿行为，可以使用fallthrough关键字：</p>
        
        <div class="example-container">
            <pre><code>// 使用fallthrough实现贯穿效果
let number = 5

switch number {
case 5:
    print("数字是5")
    fallthrough // 贯穿到下一个case
case 6:
    print("数字是5或6")
    // 不使用fallthrough，所以不会贯穿到default
default:
    print("数字是其他值")
}
// 输出:
// 数字是5
// 数字是5或6</code></pre>
        </div>
        
        <h3>3. 多个匹配</h3>
        <p>Swift允许在一个case中匹配多个值，使用逗号分隔：</p>
        
        <div class="example-container">
            <pre><code>// 一个case匹配多个值
let character: Character = "e"

switch character {
case "a", "e", "i", "o", "u":
    print("\(character) 是元音字母")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(character) 是辅音字母")
default:
    print("\(character) 不是英文字母")
}
// 输出: e 是元音字母</code></pre>
        </div>
    </div>
    
    <div class="card">
        <h2>区间匹配</h2>
        <p>Swift允许使用区间运算符在switch的case中匹配一系列值。</p>
        
        <div class="example-container">
            <pre><code>// 使用区间匹配
let score = 85

switch score {
case 0..<60:
    print("不及格") // 0到59分
case 60..<70:
    print("及格") // 60到69分
case 70..<80:
    print("中等") // 70到79分
case 80..<90:
    print("良好") // 80到89分
case 90...100:
    print("优秀") // 90到100分
default:
    print("无效分数")
}
// 输出: 良好</code></pre>
        </div>
        
        <div class="svg-container">
            <svg width="500" height="150" viewBox="0 0 500 150">
                <style>
                    .range-box { stroke-width: 2px; rx: 5; ry: 5; }
                    .range-text { font-family: "SF Pro Text", sans-serif; font-size: 12px; }
                    @media (prefers-color-scheme: dark) {
                        .range-box { stroke: #ffc107; fill: #3a3a3a; }
                        .range-text { fill: #e0e0e0; }
                    }
                    @media (prefers-color-scheme: light) {
                        .range-box { stroke: #ff9a52; fill: #fff; }
                        .range-text { fill: #333; }
                    }
                </style>
                <rect x="50" y="20" width="90" height="30" class="range-box" />
                <text x="95" y="40" text-anchor="middle" class="range-text">0..<60: 不及格</text>
                
                <rect x="150" y="20" width="70" height="30" class="range-box" />
                <text x="185" y="40" text-anchor="middle" class="range-text">60..<70: 及格</text>
                
                <rect x="230" y="20" width="70" height="30" class="range-box" />
                <text x="265" y="40" text-anchor="middle" class="range-text">70..<80: 中等</text>
                
                <rect x="310" y="20" width="70" height="30" class="range-box" />
                <text x="345" y="40" text-anchor="middle" class="range-text">80..<90: 良好</text>
                
                <rect x="390" y="20" width="80" height="30" class="range-box" />
                <text x="430" y="40" text-anchor="middle" class="range-text">90...100: 优秀</text>
                
                <!-- 数字轴 -->
                <line x1="50" y1="80" x2="470" y2="80" stroke-width="2" class="diagram-arrow" />
                <line x1="50" y1="75" x2="50" y2="85" stroke-width="2" class="diagram-arrow" />
                <text x="50" y="100" text-anchor="middle" class="range-text">0</text>
                
                <line x1="150" y1="75" x2="150" y2="85" stroke-width="2" class="diagram-arrow" />
                <text x="150" y="100" text-anchor="middle" class="range-text">60</text>
                
                <line x1="230" y1="75" x2="230" y2="85" stroke-width="2" class="diagram-arrow" />
                <text x="230" y="100" text-anchor="middle" class="range-text">70</text>
                
                <line x1="310" y1="75" x2="310" y2="85" stroke-width="2" class="diagram-arrow" />
                <text x="310" y="100" text-anchor="middle" class="range-text">80</text>
                
                <line x1="390" y1="75" x2="390" y2="85" stroke-width="2" class="diagram-arrow" />
                <text x="390" y="100" text-anchor="middle" class="range-text">90</text>
                
                <line x1="470" y1="75" x2="470" y2="85" stroke-width="2" class="diagram-arrow" />
                <text x="470" y="100" text-anchor="middle" class="range-text">100</text>
                
                <!-- 当前分数标记 -->
                <circle cx="345" cy="80" r="5" fill="#ff6b6b" />
                <text x="345" y="120" text-anchor="middle" class="range-text" fill="#ff6b6b">当前分数: 85</text>
            </svg>
        </div>
    </div>

    <div class="card">
        <h2>元组匹配</h2>
        <p>Swift的switch语句可以匹配元组中的多个值。可以使用下划线(_)忽略元组中的某些值。</p>
        
        <div class="example-container">
            <pre><code>// 元组匹配示例
let point = (2, 0)

switch point {
case (0, 0):
    print("原点")
case (_, 0):
    print("位于x轴上，x = \(point.0)")
case (0, _):
    print("位于y轴上，y = \(point.1)")
case (-2...2, -2...2):
    print("在中心区域内")
default:
    print("在其他位置")
}
// 输出: 位于x轴上，x = 2</code></pre>
        </div>
        
        <h3>值绑定</h3>
        <p>switch case可以将匹配的值绑定到临时常量或变量，供case内部使用：</p>
        
        <div class="example-container">
            <pre><code>// 值绑定示例
let anotherPoint = (2, 3)

switch anotherPoint {
case (let x, 0):
    print("位于x轴上，x = \(x)")
case (0, let y):
    print("位于y轴上，y = \(y)")
case let (x, y):
    print("位于点 (\(x), \(y))")
}
// 输出: 位于点 (2, 3)</code></pre>
        </div>
    </div>

    <div class="card">
        <h2>Where子句</h2>
        <p>Swift允许在case后使用where子句添加额外的条件。</p>
        
        <div class="example-container">
            <pre><code>// 使用where添加额外条件
let point = (1, -1)

switch point {
case let (x, y) where x == y:
    print("在对角线上，x = y")
case let (x, y) where x == -y:
    print("在反对角线上，x = -y")
case let (x, y):
    print("在其他位置: (\(x), \(y))")
}
// 输出: 在反对角线上，x = -y</code></pre>
        </div>
        
        <div class="svg-container">
            <svg width="300" height="300" viewBox="0 0 300 300">
                <style>
                    .grid-line { stroke-width: 0.5px; stroke-dasharray: 3,3; }
                    .axis-line { stroke-width: 1.5px; }
                    .point { fill: #ff6b6b; }
                    .diagonal { stroke-width: 1.5px; }
                    .diagonal-text { font-family: "SF Pro Text", sans-serif; font-size: 12px; }
                    @media (prefers-color-scheme: dark) {
                        .grid-line { stroke: #666; }
                        .axis-line { stroke: #aaa; }
                        .diagonal { stroke: #ffc107; }
                        .diagonal-text { fill: #e0e0e0; }
                    }
                    @media (prefers-color-scheme: light) {
                        .grid-line { stroke: #ccc; }
                        .axis-line { stroke: #333; }
                        .diagonal { stroke: #ff9a52; }
                        .diagonal-text { fill: #333; }
                    }
                </style>
                <!-- 网格线 -->
                <g>
                    <line x1="25" y1="50" x2="25" y2="250" class="grid-line" />
                    <line x1="75" y1="50" x2="75" y2="250" class="grid-line" />
                    <line x1="125" y1="50" x2="125" y2="250" class="grid-line" />
                    <line x1="175" y1="50" x2="175" y2="250" class="grid-line" />
                    <line x1="225" y1="50" x2="225" y2="250" class="grid-line" />
                    <line x1="275" y1="50" x2="275" y2="250" class="grid-line" />
                    
                    <line x1="25" y1="50" x2="275" y2="50" class="grid-line" />
                    <line x1="25" y1="100" x2="275" y2="100" class="grid-line" />
                    <line x1="25" y1="150" x2="275" y2="150" class="grid-line" />
                    <line x1="25" y1="200" x2="275" y2="200" class="grid-line" />
                    <line x1="25" y1="250" x2="275" y2="250" class="grid-line" />
                </g>
                
                <!-- 坐标轴 -->
                <line x1="25" y1="150" x2="275" y2="150" class="axis-line" />
                <line x1="150" y1="50" x2="150" y2="250" class="axis-line" />
                
                <!-- 对角线 -->
                <line x1="25" y1="250" x2="275" y2="50" class="diagonal" />
                <text x="40" y="240" class="diagonal-text">x = -y (反对角线)</text>
                
                <line x1="25" y1="50" x2="275" y2="250" class="diagonal" />
                <text x="40" y="70" class="diagonal-text">x = y (对角线)</text>
                
                <!-- 当前点 -->
                <circle cx="175" cy="200" r="5" class="point" />
                <text x="185" y="200" class="diagonal-text">点(1, -1)</text>
                
                <!-- 坐标标记 -->
                <text x="150" y="270" text-anchor="middle" class="diagonal-text">x轴</text>
                <text x="15" y="150" text-anchor="middle" class="diagonal-text">y轴</text>
            </svg>
        </div>
    </div>

    <div class="card">
        <h2>复合模式</h2>
        <p>Swift允许使用is和as模式匹配类型，还可以将多种模式合并为复合模式：</p>
        
        <div class="example-container">
            <pre><code>// 复合模式示例
let someValue: Any = 15

switch someValue {
case let value as Int where value > 10:
    print("大于10的整数: \(value)")
case is String:
    print("这是一个字符串")
case let value as Double where value < 0:
    print("负浮点数: \(value)")
default:
    print("其他类型的值")
}
// 输出: 大于10的整数: 15</code></pre>
        </div>
    </div>

    <div class="card">
        <h2>枚举类型与Switch</h2>
        <p>Swift的枚举与switch搭配使用非常强大，特别是对于关联值的枚举。</p>
        
        <div class="example-container">
            <pre><code>// 枚举与switch的结合
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

let productBarcode = Barcode.upc(8, 85909, 51226, 3)

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR码: \(productCode)")
}
// 输出: UPC: 8, 85909, 51226, 3</code></pre>
        </div>
        
        <h3>更简洁的值绑定语法</h3>
        <div class="example-container">
            <pre><code>// 简化的值绑定语法
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR码: \(productCode)")
}
// 输出: UPC: 8, 85909, 51226, 3</code></pre>
        </div>
    </div>

    <div class="card">
        <h2>Switch语句最佳实践</h2>
        <ol>
            <li><strong>保持case的简洁</strong>：每个case应该处理一个清晰的逻辑分支。</li>
            <li><strong>避免fallthrough的过度使用</strong>：虽然Swift提供了fallthrough关键字，但它会使代码逻辑更难理解。</li>
            <li><strong>利用where子句</strong>：使用where可以避免嵌套if语句，使代码更简洁。</li>
            <li><strong>使用值绑定</strong>：通过let和var将值绑定到变量，使处理更灵活。</li>
            <li><strong>考虑可读性</strong>：如果switch语句过于复杂，考虑重构为多个更小的switch或者使用函数。</li>
        </ol>
    </div>

    <div class="card">
        <h2>学习资源</h2>
        
        <div class="resources">
            <div class="resource-card">
                <h4>官方文档</h4>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html" target="_blank">Swift官方文档 - 控制流</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift" target="_blank">Apple开发者文档 - Swift</a></li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h4>优秀博客文章</h4>
                <ul>
                    <li><a href="https://www.hackingwithswift.com/articles/121/how-to-use-pattern-matching-with-switch-statements-in-swift" target="_blank">Hacking with Swift - Pattern Matching</a></li>
                    <li><a href="https://www.swiftbysundell.com/articles/switching-on-enums-in-swift/" target="_blank">Swift by Sundell - Switching on Enums</a></li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h4>推荐书籍</h4>
                <ul>
                    <li>《Swift编程权威指南》(The Swift Programming Language)</li>
                    <li>《Swift实战》(Swift in Depth) - Tjeerd in 't Veen</li>
                    <li>《Swift进阶》(Advanced Swift) - Chris Eidhof等</li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h4>视频教程</h4>
                <ul>
                    <li><a href="https://developer.apple.com/videos/wwdc" target="_blank">WWDC Sessions - Swift相关</a></li>
                    <li><a href="https://www.raywenderlich.com/ios/videos" target="_blank">raywenderlich.com Swift视频教程</a></li>
                </ul>
            </div>
            
            <div class="resource-card">
                <h4>开源项目</h4>
                <ul>
                    <li><a href="https://github.com/apple/swift" target="_blank">Swift语言开源项目</a></li>
                    <li><a href="https://github.com/raywenderlich/swift-algorithm-club" target="_blank">Swift算法俱乐部</a></li>
                    <li><a href="https://github.com/vsouza/awesome-ios" target="_blank">Awesome iOS (包含Swift示例)</a></li>
                </ul>
            </div>
        </div>
    </div>

    <footer style="text-align: center; margin-top: 50px; padding: 20px; border-top: 1px dashed var(--border-color);">
        <p>© 2023 Swift控制流学习指南 | 技术手册</p>
    </footer>

</body>
</html>
