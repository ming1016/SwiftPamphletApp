<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 控制流 - while 循环</title>
    <style>
        /* 设置基本样式和响应式布局 */
        :root {
            --text-color: #333;
            --bg-color: #f0f0f0;
            --code-bg: #e0e0e0;
            --title-color: #0a3d62;
            --border-color: #3498db;
            --accent-color: #2ecc71;
            --pixel-size: 2px;
            --grid-color: rgba(0, 0, 0, 0.1);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #e0e0e0;
                --bg-color: #121212;
                --code-bg: #2a2a2a;
                --title-color: #4fc3f7;
                --border-color: #3498db;
                --accent-color: #2ecc71;
                --grid-color: rgba(255, 255, 255, 0.1);
            }
        }

        * {
            box-sizing: border-box;
            image-rendering: pixelated;
        }

        body {
            font-family: 'Courier New', monospace;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-image: linear-gradient(var(--grid-color) 1px, transparent 1px),
                             linear-gradient(90deg, var(--grid-color) 1px, transparent 1px);
            background-size: 20px 20px;
        }

        .pixel-container {
            border: var(--pixel-size) solid var(--border-color);
            position: relative;
            padding: 20px;
            margin: 20px 0;
            overflow: hidden;
        }

        .pixel-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 8px;
            background: var(--accent-color);
        }

        h1, h2, h3 {
            color: var(--title-color);
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 5px;
        }

        h1 {
            font-size: 2em;
            text-align: center;
        }

        h2 {
            font-size: 1.5em;
        }

        h3 {
            font-size: 1.2em;
        }

        pre, code {
            font-family: 'Courier New', monospace;
            background-color: var(--code-bg);
            border-left: 4px solid var(--accent-color);
            padding: 15px;
            overflow-x: auto;
        }

        code {
            padding: 2px 4px;
        }

        pre code {
            border: none;
            padding: 0;
        }

        .example-box {
            border: var(--pixel-size) solid var(--border-color);
            padding: 15px;
            margin: 20px 0;
        }

        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .resource-card {
            border: var(--pixel-size) solid var(--border-color);
            padding: 15px;
        }

        .svg-container {
            max-width: 100%;
            margin: 20px auto;
            text-align: center;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .resources {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <h1>Swift 控制流 - while 循环</h1>

    <div class="pixel-container">
        <h2>概述</h2>
        <p>Swift 提供了两种 while 循环类型来重复执行代码块，直到条件变为 false：</p>
        <ul>
            <li><strong>while</strong> - 在循环开始之前评估条件</li>
            <li><strong>repeat-while</strong> - 在循环结束时评估条件（类似于其他语言中的 do-while）</li>
        </ul>
    </div>

    <div class="pixel-container">
        <h2>while 循环</h2>
        <p>while 循环在每次循环迭代开始之前检查条件。如果条件为真，执行循环体内的代码；如果条件为假，则停止循环。</p>

        <!-- SVG图表：while循环流程 -->
        <div class="svg-container">
            <svg width="400" height="300" viewBox="0 0 400 300">
                <style>
                    .box { fill: var(--code-bg); stroke: var(--accent-color); stroke-width: 2; }
                    .text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                    .arrow { fill: none; stroke: var(--border-color); stroke-width: 2; }
                </style>
                <!-- 开始框 -->
                <rect x="150" y="20" width="100" height="40" class="box" />
                <text x="200" y="45" text-anchor="middle" class="text">开始</text>

                <!-- 条件框 -->
                <rect x="150" y="100" width="100" height="40" rx="20" ry="20" class="box" />
                <text x="200" y="125" text-anchor="middle" class="text">条件为真?</text>

                <!-- 循环体框 -->
                <rect x="150" y="180" width="100" height="40" class="box" />
                <text x="200" y="205" text-anchor="middle" class="text">执行循环体</text>

                <!-- 结束框 -->
                <rect x="300" y="100" width="80" height="40" class="box" />
                <text x="340" y="125" text-anchor="middle" class="text">结束</text>

                <!-- 箭头 -->
                <path d="M200 60 L200 100" class="arrow" marker-end="url(#arrowhead)" />
                <path d="M200 140 L200 180" class="arrow" marker-end="url(#arrowhead)" />
                <path d="M200 220 L120 220 L120 120 L150 120" class="arrow" marker-end="url(#arrowhead)" />
                <path d="M250 120 L300 120" class="arrow" marker-end="url(#arrowhead)" />

                <!-- 箭头头部 -->
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--border-color)" />
                    </marker>
                </defs>

                <!-- 标签 -->
                <text x="180" y="90" class="text">初始条件</text>
                <text x="235" y="110" class="text">否</text>
                <text x="180" y="170" class="text">是</text>
                <text x="120" y="170" class="text">重新检查条件</text>
            </svg>
        </div>

        <h3>基本语法</h3>
        <pre><code>while 条件 {
    // 循环体代码
}</code></pre>

        <div class="example-box">
            <h3>示例 1: 基本 while 循环</h3>
            <pre><code>// 使用 while 循环计数
var counter = 0

while counter < 5 {
    print("当前计数: \(counter)")
    counter += 1
}

// 输出:
// 当前计数: 0
// 当前计数: 1
// 当前计数: 2
// 当前计数: 3
// 当前计数: 4</code></pre>
        </div>

        <div class="example-box">
            <h3>示例 2: 使用 while 处理数组</h3>
            <pre><code>// 使用 while 循环遍历数组
let fruits = ["苹果", "香蕉", "橙子", "葡萄"]
var index = 0

while index < fruits.count {
    print("第\(index+1)个水果是: \(fruits[index])")
    index += 1
}

// 输出:
// 第1个水果是: 苹果
// 第2个水果是: 香蕉
// 第3个水果是: 橙子
// 第4个水果是: 葡萄</code></pre>
        </div>
    </div>

    <div class="pixel-container">
        <h2>repeat-while 循环</h2>
        <p>repeat-while 循环先执行一次循环体代码，然后评估条件。如果条件为真，则继续执行循环；如果条件为假，则停止循环。这保证了循环体至少执行一次。</p>

        <!-- SVG图表：repeat-while循环流程 -->
        <div class="svg-container">
            <svg width="400" height="300" viewBox="0 0 400 300">
                <style>
                    .box { fill: var(--code-bg); stroke: var(--accent-color); stroke-width: 2; }
                    .text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                    .arrow { fill: none; stroke: var(--border-color); stroke-width: 2; }
                </style>
                <!-- 开始框 -->
                <rect x="150" y="20" width="100" height="40" class="box" />
                <text x="200" y="45" text-anchor="middle" class="text">开始</text>

                <!-- 循环体框 -->
                <rect x="150" y="100" width="100" height="40" class="box" />
                <text x="200" y="125" text-anchor="middle" class="text">执行循环体</text>

                <!-- 条件框 -->
                <rect x="150" y="180" width="100" height="40" rx="20" ry="20" class="box" />
                <text x="200" y="205" text-anchor="middle" class="text">条件为真?</text>

                <!-- 结束框 -->
                <rect x="300" y="180" width="80" height="40" class="box" />
                <text x="340" y="205" text-anchor="middle" class="text">结束</text>

                <!-- 箭头 -->
                <path d="M200 60 L200 100" class="arrow" marker-end="url(#arrowhead2)" />
                <path d="M200 140 L200 180" class="arrow" marker-end="url(#arrowhead2)" />
                <path d="M200 220 L120 220 L120 120 L150 120" class="arrow" marker-end="url(#arrowhead2)" />
                <path d="M250 200 L300 200" class="arrow" marker-end="url(#arrowhead2)" />

                <!-- 箭头头部 -->
                <defs>
                    <marker id="arrowhead2" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--border-color)" />
                    </marker>
                </defs>

                <!-- 标签 -->
                <text x="180" y="90" class="text">首次执行</text>
                <text x="235" y="190" class="text">否</text>
                <text x="180" y="250" class="text">是</text>
                <text x="120" y="170" class="text">重新执行循环体</text>
            </svg>
        </div>

        <h3>基本语法</h3>
        <pre><code>repeat {
    // 循环体代码
} while 条件</code></pre>

        <div class="example-box">
            <h3>示例 1: 基本 repeat-while 循环</h3>
            <pre><code>// 使用 repeat-while 循环计数
var counter = 0

repeat {
    print("当前计数: \(counter)")
    counter += 1
} while counter < 5

// 输出:
// 当前计数: 0
// 当前计数: 1
// 当前计数: 2
// 当前计数: 3
// 当前计数: 4</code></pre>
        </div>

        <div class="example-box">
            <h3>示例 2: repeat-while 保证至少执行一次</h3>
            <pre><code>// 即使条件一开始就为 false，循环体也会执行一次
var number = 10

repeat {
    print("当前数字: \(number)")
    number += 1
} while number < 10

// 输出:
// 当前数字: 10
// (循环在执行一次后结束，因为条件现在为 false)</code></pre>
        </div>

        <div class="example-box">
            <h3>示例 3: 用户输入验证</h3>
            <pre><code>// 模拟用户输入验证场景
func simulateUserInput() -> String {
    // 在实际应用中，这会获取真实用户输入
    // 这里我们模拟一个输入
    return "有效输入"
}

var userInput: String
repeat {
    userInput = simulateUserInput()
    print("获取到输入: \(userInput)")

    // 在实际应用中，这里可能有验证逻辑
} while userInput.isEmpty

print("处理有效输入: \(userInput)")</code></pre>
        </div>
    </div>

    <div class="pixel-container">
        <h2>while 与 repeat-while 对比</h2>

        <table border="1" style="width:100%; border-collapse: collapse;">
            <tr>
                <th style="padding:10px;">特性</th>
                <th style="padding:10px;">while</th>
                <th style="padding:10px;">repeat-while</th>
            </tr>
            <tr>
                <td style="padding:10px;">条件检查时机</td>
                <td style="padding:10px;">循环开始前</td>
                <td style="padding:10px;">循环体执行后</td>
            </tr>
            <tr>
                <td style="padding:10px;">最小执行次数</td>
                <td style="padding:10px;">0次（如果条件初始为false）</td>
                <td style="padding:10px;">1次（即使条件初始为false）</td>
            </tr>
            <tr>
                <td style="padding:10px;">适用场景</td>
                <td style="padding:10px;">不确定是否需要执行循环体</td>
                <td style="padding:10px;">至少需要执行一次循环体</td>
            </tr>
        </table>

        <div class="example-box">
            <h3>示例: 两种循环的区别</h3>
            <pre><code>// 条件一开始就为 false 的情况

// while 循环 - 不会执行循环体
var a = 5
while a < 5 {
    print("这段代码不会执行")
    a += 1
}
// 无输出

// repeat-while 循环 - 会执行一次循环体
var b = 5
repeat {
    print("即使条件为 false，这段代码也会执行一次")
    b += 1
} while b < 5
// 输出: "即使条件为 false，这段代码也会执行一次"</code></pre>
        </div>
    </div>

    <div class="pixel-container">
        <h2>实际应用场景</h2>

        <div class="example-box">
            <h3>场景 1: 游戏循环</h3>
            <pre><code>// 简单游戏循环示例
var gameRunning = true
var score = 0

// 处理游戏逻辑的函数
func processGameLogic() -> Bool {
    // 模拟游戏逻辑，分数达到100时游戏结束
    score += Int.random(in: 5...15)
    print("当前分数: \(score)")
    return score < 100
}

// 游戏主循环
while gameRunning {
    gameRunning = processGameLogic()
    // 模拟每回合间隔
    // 在实际游戏中，这里可能有帧率控制或等待用户输入
}

print("游戏结束！最终分数: \(score)")</code></pre>
        </div>

        <div class="example-box">
            <h3>场景 2: 数据处理</h3>
            <pre><code>// 模拟数据批处理
func fetchNextBatch() -> [Int]? {
    // 这个函数在实际应用中可能从数据库或API获取下一批数据
    // 这里我们用一个静态数组模拟
    static var batches = [
        [1, 2, 3, 4, 5],
        [6, 7, 8, 9, 10],
        [11, 12, 13, 14, 15]
    ]
    static var currentIndex = 0

    if currentIndex < batches.count {
        let batch = batches[currentIndex]
        currentIndex += 1
        return batch
    }
    return nil
}

// 使用 while 处理批次数据
var batchNumber = 1
var currentBatch = fetchNextBatch()

while let batch = currentBatch {
    print("处理批次 \(batchNumber):")

    // 处理当前批次的每个数据项
    for item in batch {
        print("  处理数据项: \(item)")
    }

    batchNumber += 1
    currentBatch = fetchNextBatch()
}

print("所有数据处理完成")</code></pre>
        </div>

        <div class="example-box">
            <h3>场景 3: 用户交互</h3>
            <pre><code>// 模拟命令行菜单
func showMenu() {
    print("\n===== 主菜单 =====")
    print("1. 查看信息")
    print("2. 更新数据")
    print("3. 设置")
    print("0. 退出")
    print("=================")
}

func getUserChoice() -> Int {
    // 在实际应用中，这会获取用户输入
    // 这里我们模拟几次输入后选择退出
    static var calls = 0
    calls += 1
    return calls >= 3 ? 0 : Int.random(in: 1...3)
}

func processChoice(_ choice: Int) {
    switch choice {
    case 0:
        print("正在退出程序...")
    case 1:
        print("显示信息...")
    case 2:
        print("更新数据...")
    case 3:
        print("打开设置...")
    default:
        print("无效选择")
    }
}

// 交互式菜单循环
var userChoice: Int
repeat {
    showMenu()
    userChoice = getUserChoice()
    print("您选择了: \(userChoice)")
    processChoice(userChoice)
} while userChoice != 0

print("程序已结束")</code></pre>
        </div>
    </div>

    <div class="pixel-container">
        <h2>进阶技巧</h2>

        <div class="example-box">
            <h3>技巧 1: 无限循环与 break</h3>
            <pre><code>// 使用无限循环，直到满足特定条件
var attempts = 0
let targetNumber = Int.random(in: 1...100)
var found = false

while true {
    attempts += 1
    let guess = Int.random(in: 1...100)  // 模拟猜测

    print("猜测: \(guess), 目标: \(targetNumber)")

    if guess == targetNumber {
        found = true
        break  // 找到目标时跳出循环
    }

    if attempts >= 10 {
        print("达到最大尝试次数")
        break  // 达到尝试上限时跳出循环
    }
}

if found {
    print("经过 \(attempts) 次尝试后找到目标数字")
} else {
    print("未找到目标数字")
}</code></pre>
        </div>

        <div class="example-box">
            <h3>技巧 2: continue 语句</h3>
            <pre><code>// 使用 continue 跳过某些迭代
var i = 0
while i < 10 {
    i += 1

    // 跳过偶数
    if i % 2 == 0 {
        continue
    }

    print("处理奇数: \(i)")
}

// 输出:
// 处理奇数: 1
// 处理奇数: 3
// 处理奇数: 5
// 处理奇数: 7
// 处理奇数: 9</code></pre>
        </div>

        <div class="example-box">
            <h3>技巧 3: where 子句过滤</h3>
            <pre><code>// 使用高级匹配来处理操作
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var index = 0

while let num = numbers.indices.contains(index) ? numbers[index] : nil,
      index < numbers.count {

    // 只处理大于5的偶数
    if num > 5 && num % 2 == 0 {
        print("找到符合条件的数: \(num)")
    }

    index += 1
}

// 输出:
// 找到符合条件的数: 6
// 找到符合条件的数: 8
// 找到符合条件的数: 10</code></pre>
        </div>
    </div>

    <div class="pixel-container">
        <h2>陷阱与最佳实践</h2>

        <h3>常见陷阱</h3>
        <ol>
            <li>
                <strong>无限循环</strong>
                <pre><code>// 错误示例: 无限循环
while true {
    print("这是一个无限循环!")
    // 没有 break 条件
}

// 正确示例: 包含退出条件的循环
var i = 0
while true {
    print("循环 #\(i)")
    i += 1
    if i >= 5 {
        break // 提供退出机制
    }
}</code></pre>
            </li>
            <li>
                <strong>循环条件不更新</strong>
                <pre><code>// 错误示例: 循环条件不更新
var counter = 0
while counter < 5 {
    print("当前值: \(counter)")
    // 忘记更新 counter，导致无限循环
}

// 正确示例: 正确更新循环条件
var counter = 0
while counter < 5 {
    print("当前值: \(counter)")
    counter += 1 // 更新循环条件
}</code></pre>
            </li>
        </ol>

        <h3>最佳实践</h3>
        <ol>
            <li>
                <strong>选择正确的循环类型</strong>
                <ul>
                    <li>当不确定是否需要执行循环时使用 while</li>
                    <li>当需要至少执行一次时使用 repeat-while</li>
                    <li>当知道确切迭代次数时，考虑使用 for-in 而不是 while</li>
                </ul>
            </li>
            <li>
                <strong>避免复杂的循环条件</strong>
                <pre><code>// 不推荐: 复杂的循环条件
while index < array.count && array[index] != target && !shouldStop {
    // 循环体
}

// 推荐: 将复杂条件分解
var found = false
var shouldContinue = true

while index < array.count && shouldContinue {
    if array[index] == target {
        found = true
        shouldContinue = false
    }
    if shouldStop {
        shouldContinue = false
    }
    index += 1
}</code></pre>
            </li>
            <li>
                <strong>注意性能问题</strong>
                <pre><code>// 不高效: 在循环中进行昂贵的计算
while index < someExpensiveComputation() {
    // 每次迭代都会重新计算
    index += 1
}

// 更高效: 将昂贵计算移至循环外
let limit = someExpensiveComputation()
while index < limit {
    // 循环体
    index += 1
}</code></pre>
            </li>
        </ol>
    </div>

    <div class="pixel-container">
        <h2>资源与参考</h2>

        <div class="resources">
            <div class="resource-card">
                <h3>官方文档</h3>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html">Swift 控制流官方文档</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift/swift_standard_library/control_flow">Swift 标准库控制流</a></li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>优秀博客文章</h3>
                <ul>
                    <li><a href="https://www.hackingwithswift.com/articles/223/swift-loops-explained-for-while-and-repeat">Swift 循环详解</a> - Hacking with Swift</li>
                    <li><a href="https://www.swiftbysundell.com/basics/loops/">掌握 Swift 循环</a> - Swift by Sundell</li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>相关书籍</h3>
                <ul>
                    <li>"Swift 实战编程（第四版）" - Chris Eidhof, Florian Kugler & Wouter Swierstra</li>
                    <li>"Swift 进阶" - Paul Hudson</li>
                    <li>"精通 Swift" - Jon Hoffman</li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>视频教程</h3>
                <ul>
                    <li><a href="https://developer.apple.com/videos/play/wwdc2022/110355/">WWDC: Swift 新特性和最佳实践</a></li>
                    <li>Stanford CS193p - iOS开发课程</li>
                </ul>
            </div>

            <div class="resource-card">
                <h3>相关开源项目</h3>
                <ul>
                    <li><a href="https://github.com/apple/swift-algorithms">Swift Algorithms</a> - Swift 标准库算法扩展</li>
                    <li><a href="https://github.com/raywenderlich/swift-algorithm-club">Swift Algorithm Club</a> - Swift 算法与数据结构实现</li>
                    <li><a href="https://github.com/vsouza/awesome-ios">Awesome iOS</a> - 优秀 iOS 库与资源列表</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="pixel-container">
        <h2>练习题</h2>

        <div class="example-box">
            <h3>练习 1: 猜数字游戏</h3>
            <p>创建一个简单的猜数字游戏，使用 while 循环让用户一直猜，直到猜对为止。</p>
            <pre><code>import Foundation

func guessingGame() {
    let targetNumber = Int.random(in: 1...100)
    var attempts = 0
    var hasGuessedCorrectly = false

    print("欢迎来到猜数字游戏！")
    print("我已经想好了一个1到100之间的数字。")

    while !hasGuessedCorrectly {
        print("请猜一个数字: ", terminator: "")

        // 在实际应用中获取用户输入
        guard let input = readLine(), let guess = Int(input) else {
            print("无效输入，请输入一个数字。")
            continue
        }

        attempts += 1

        if guess < targetNumber {
            print("猜小了，再试试！")
        } else if guess > targetNumber {
            print("猜大了，再试试！")
        } else {
            hasGuessedCorrectly = true
            print("恭喜！你在第\(attempts)次猜中了数字\(targetNumber)！")
        }
    }
}

// 调用函数开始游戏
// guessingGame()</code></pre>
        </div>

        <div class="example-box">
            <h3>练习 2: 使用 repeat-while 验证用户输入</h3>
            <p>编写一段代码，使用 repeat-while 循环验证用户输入的密码是否符合要求。</p>
            <pre><code>func validatePassword() {
    var isValid = false
    var password: String

    repeat {
        print("请输入一个包含至少8个字符、一个大写字母和一个数字的密码: ", terminator: "")

        // 在实际应用中获取用户输入
        password = readLine() ?? ""

        // 验证密码规则
        let hasMinLength = password.count >= 8
        let hasUppercase = password.contains { $0.isUppercase }
        let hasNumber = password.contains { $0.isNumber }

        isValid = hasMinLength && hasUppercase && hasNumber

        if !isValid {
            print("密码不符合要求，请重试。")

            // 提供详细的错误信息
            if !hasMinLength { print("- 密码长度必须至少为8个字符") }
            if !hasUppercase { print("- 密码必须包含至少一个大写字母") }
            if !hasNumber { print("- 密码必须包含至少一个数字") }
        }
    } while !isValid

    print("密码已设置成功！")
}

// 调用函数开始验证
// validatePassword()</code></pre>
        </div>
    </div>

    <div class="pixel-container">
        <h2>总结</h2>

        <p>在 Swift 中，while 循环是控制流的重要组成部分，它允许根据条件重复执行代码块：</p>

        <ul>
            <li><strong>while</strong> 循环在开始时检查条件，适用于不确定是否需要执行循环的情况。</li>
            <li><strong>repeat-while</strong> 循环在执行循环体后检查条件，确保循环体至少执行一次。</li>
        </ul>

        <p>掌握 while 循环的使用可以帮助你：</p>

        <ul>
            <li>处理不确定次数的重复任务</li>
            <li>实现用户交互界面</li>
            <li>处理数据流或批处理任务</li>
            <li>实现游戏循环和其他需要条件控制的场景</li>
        </ul>

        <p>记住在使用 while 循环时，始终确保有合适的退出条件，避免出现无限循环。同时，根据具体场景选择最合适的循环类型，可以使你的代码更加高效和可读。</p>

        <div class="svg-container">
            <svg width="400" height="200" viewBox="0 0 400 200">
                <style>
                    .summary-box { fill: var(--code-bg); stroke: var(--accent-color); stroke-width: 2; rx: 5; ry: 5; }
                    .summary-text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                </style>

                <rect x="50" y="30" width="300" height="40" class="summary-box" />
                <text x="200" y="55" text-anchor="middle" class="summary-text">while 循环: 先检查条件，再执行循环体</text>

                <rect x="50" y="100" width="300" height="40" class="summary-box" />
                <text x="200" y="125" text-anchor="middle" class="summary-text">repeat-while: 先执行循环体，再检查条件</text>

                <line x1="50" y1="160" x2="350" y2="160" stroke="var(--accent-color)" stroke-width="2" stroke-dasharray="5,5" />
                <text x="200" y="180" text-anchor="middle" class="summary-text">选择正确的循环类型，避免无限循环</text>
            </svg>
        </div>
    </div>

</body>
</html>
