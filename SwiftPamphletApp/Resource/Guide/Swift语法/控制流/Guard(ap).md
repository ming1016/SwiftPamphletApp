<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift - Guard 控制流</title>
    <style>
        :root {
            --deep-blue: #1d3c4c;
            --blue-green: #2d7a8a;
            --coral-red: #e15a41;
            --deep-red: #6d1a25;
            --light-pink: #f7d6cf;
            --background: #ffffff;
            --text-color: #1d3c4c;
            --code-background: #f5f5f5;
            --card-background: #fcfcfc;
            --border-color: #e0e0e0;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --deep-blue: #2d7a8a;
                --blue-green: #3a8a9a;
                --coral-red: #e15a41;
                --deep-red: #e77168;
                --light-pink: #543f4a;
                --background: #121212;
                --text-color: #e0e0e0;
                --code-background: #1e1e1e;
                --card-background: #1a1a1a;
                --border-color: #333333;
            }
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--background);
            color: var(--text-color);
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            margin-bottom: 40px;
            border-bottom: 2px solid var(--coral-red);
            padding-bottom: 20px;
        }

        h1 {
            font-size: 2.5rem;
            color: var(--deep-blue);
            margin-bottom: 10px;
        }

        h2 {
            font-size: 1.8rem;
            color: var(--blue-green);
            margin: 30px 0 15px;
            border-bottom: 1px solid var(--light-pink);
            padding-bottom: 8px;
        }

        h3 {
            font-size: 1.4rem;
            color: var(--coral-red);
            margin: 20px 0 10px;
        }

        p {
            margin-bottom: 15px;
            font-size: 1.05rem;
        }

        pre {
            background-color: var(--code-background);
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            margin: 20px 0;
            border-left: 4px solid var(--coral-red);
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9rem;
        }

        .code-comment {
            color: var(--blue-green);
            font-style: italic;
        }

        .card {
            background-color: var(--card-background);
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border-left: 4px solid var(--blue-green);
        }

        .resource-section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }

        .resource-card {
            background-color: var(--card-background);
            border-radius: 6px;
            padding: 15px;
            border-top: 3px solid var(--coral-red);
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }

        .resource-card h4 {
            color: var(--deep-blue);
            margin-bottom: 10px;
        }

        ul, ol {
            margin-left: 20px;
            margin-bottom: 20px;
        }

        li {
            margin-bottom: 8px;
        }

        a {
            color: var(--coral-red);
            text-decoration: none;
            border-bottom: 1px dotted var(--coral-red);
        }

        a:hover {
            color: var(--deep-red);
            border-bottom: 1px solid var(--deep-red);
        }

        .note {
            background-color: var(--light-pink);
            padding: 10px 15px;
            border-radius: 5px;
            margin: 20px 0;
        }

        .diagram {
            width: 100%;
            max-width: 700px;
            margin: 30px auto;
            display: block;
        }

        .example-title {
            font-weight: bold;
            margin-top: 20px;
            display: block;
            color: var(--blue-green);
        }

        .comparison-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .comparison-table th, .comparison-table td {
            padding: 10px;
            border: 1px solid var(--border-color);
            text-align: left;
        }

        .comparison-table th {
            background-color: var(--blue-green);
            color: white;
        }

        .comparison-table tr:nth-child(even) {
            background-color: var(--card-background);
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            h3 {
                font-size: 1.2rem;
            }

            .resource-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift 控制流：guard 语句详解</h1>
        <p>早期退出策略，让代码更加清晰优雅</p>
    </header>

    <main>
        <section>
            <h2>什么是 guard 语句？</h2>
            <p>Swift 中的 guard 语句是一种控制流语句，用于在满足特定条件时提前退出当前作用域。它的主要目的是提高代码的可读性，减少嵌套层级，使代码结构更加清晰。</p>

            <div class="card">
                <p>guard 语句必须使用 <code>else</code> 子句，并且在 else 子句中必须退出当前作用域。退出方式可以是：</p>
                <ul>
                    <li>return（从函数返回）</li>
                    <li>break（跳出循环）</li>
                    <li>continue（继续下一次循环）</li>
                    <li>throw（抛出错误）</li>
                    <li>调用不返回的函数，如 <code>fatalError()</code></li>
                </ul>
            </div>
        </section>

        <section>
            <h2>guard 语句的控制流</h2>

            <svg class="diagram" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                <!-- 控制流图 -->
                <rect x="50" y="30" width="500" height="240" fill="none" stroke="var(--border-color)" stroke-width="2" stroke-dasharray="5,5" rx="10" />
                <text x="280" y="20" text-anchor="middle" fill="var(--text-color)" font-weight="bold">函数作用域</text>

                <!-- 开始节点 -->
                <circle cx="150" cy="70" r="20" fill="var(--blue-green)" />
                <text x="150" y="75" text-anchor="middle" fill="white" font-size="12">开始</text>

                <!-- Guard语句 -->
                <path d="M150,90 L150,120" stroke="var(--text-color)" stroke-width="2" fill="none" marker-end="url(#arrow)" />
                <rect x="100" y="120" width="100" height="60" fill="var(--coral-red)" rx="10" />
                <text x="150" y="150" text-anchor="middle" fill="white" font-size="14">guard 条件</text>
                <text x="150" y="170" text-anchor="middle" fill="white" font-size="12">条件是否满足?</text>

                <!-- 路径分支 -->
                <path d="M200,150 L280,150" stroke="var(--text-color)" stroke-width="2" fill="none" marker-end="url(#arrow)" />
                <text x="240" y="140" text-anchor="middle" fill="var(--text-color)" font-size="12">否</text>

                <path d="M150,180 L150,220" stroke="var(--text-color)" stroke-width="2" fill="none" marker-end="url(#arrow)" />
                <text x="135" y="200" text-anchor="middle" fill="var(--text-color)" font-size="12">是</text>

                <!-- Else块 -->
                <rect x="280" y="120" width="120" height="60" fill="var(--deep-red)" rx="10" />
                <text x="340" y="150" text-anchor="middle" fill="white" font-size="14">else 块</text>
                <text x="340" y="170" text-anchor="middle" fill="white" font-size="12">提前退出</text>

                <!-- 路径结束 -->
                <path d="M340,180 L340,250 L450,250" stroke="var(--text-color)" stroke-width="2" fill="none" marker-end="url(#arrow)" stroke-dasharray="5,5" />

                <!-- 继续执行 -->
                <rect x="100" y="220" width="100" height="40" fill="var(--blue-green)" rx="10" />
                <text x="150" y="245" text-anchor="middle" fill="white" font-size="12">继续执行</text>

                <!-- 函数结束 -->
                <circle cx="470" cy="250" r="20" fill="var(--blue-green)" />
                <text x="470" y="255" text-anchor="middle" fill="white" font-size="12">结束</text>

                <!-- 箭头标记定义 -->
                <defs>
                    <marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5"
                        markerWidth="6" markerHeight="6" orient="auto">
                        <path d="M 0 0 L 10 5 L 0 10 z" fill="var(--text-color)" />
                    </marker>
                </defs>
            </svg>
        </section>

        <section>
            <h2>guard 与 if 语句的比较</h2>

            <table class="comparison-table">
                <thead>
                    <tr>
                        <th>特性</th>
                        <th>guard 语句</th>
                        <th>if 语句</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>主要用途</td>
                        <td>提前退出、前置条件验证</td>
                        <td>条件分支执行</td>
                    </tr>
                    <tr>
                        <td>代码嵌套</td>
                        <td>减少嵌套，使代码更扁平</td>
                        <td>可能导致多层嵌套</td>
                    </tr>
                    <tr>
                        <td>作用域</td>
                        <td>通过条件绑定的变量在 guard 后可用</td>
                        <td>通过条件绑定的变量仅在 if 块内可用</td>
                    </tr>
                    <tr>
                        <td>else 子句</td>
                        <td>必须存在且必须退出当前作用域</td>
                        <td>可选</td>
                    </tr>
                    <tr>
                        <td>代码流向</td>
                        <td>异常路径快速返回</td>
                        <td>正常与异常路径并列</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section>
            <h2>guard 语法与使用</h2>

            <h3>基本语法</h3>
            <pre><code>guard <span class="code-comment">/* 条件表达式 */</span> else {
    <span class="code-comment">/* 必须退出当前作用域的代码 */</span>
    return/break/continue/throw/fatalError()
}
<span class="code-comment">/* 条件满足时执行的代码 */</span></code></pre>

            <h3>示例 1：基本使用</h3>
            <span class="example-title">检查函数参数是否有效：</span>
            <pre><code>func processUserData(name: String?, age: Int?) {
    // 使用 guard 检查参数是否有效
    guard let name = name, let age = age else {
        print("无效的用户数据")
        return
    }

    // 此处 name 和 age 已经解包，可以直接使用
    print("处理用户: \(name), 年龄: \(age)")
}</code></pre>

            <h3>示例 2：条件绑定和变量作用域</h3>
            <span class="example-title">通过 guard 解包的变量在后续代码中可用：</span>
            <pre><code>func processJSON(data: [String: Any]?) {
    // 检查数据并解包
    guard let data = data else {
        print("数据为空")
        return
    }

    // 检查必需的字段
    guard let userId = data["id"] as? Int,
          let username = data["username"] as? String,
          let isActive = data["isActive"] as? Bool else {
        print("数据格式无效")
        return
    }

    // 这里可以直接使用解包后的变量
    if isActive {
        print("活跃用户: \(username), ID: \(userId)")
    } else {
        print("非活跃用户: \(username)")
    }
}</code></pre>

            <h3>示例 3：条件复合使用</h3>
            <span class="example-title">多条件组合检查：</span>
            <pre><code>func validateInput(text: String?) {
    guard let text = text else {
        print("文本为空")
        return
    }

    guard !text.isEmpty else {
        print("文本不能为空字符串")
        return
    }

    guard text.count >= 3 else {
        print("文本长度不能少于3个字符")
        return
    }

    guard text.count <= 100 else {
        print("文本长度不能超过100个字符")
        return
    }

    // 所有条件都满足
    print("文本有效: \(text)")
}</code></pre>

            <h3>示例 4：在循环中使用 guard</h3>
            <span class="example-title">在循环中提前跳过或终止：</span>
            <pre><code>func processItems(items: [String?]) {
    for (index, item) in items.enumerated() {
        guard let item = item else {
            print("跳过索引 \(index) 的空项")
            continue // 跳过当前循环
        }

        guard item.count > 2 else {
            print("项 '\(item)' 太短，停止处理")
            break // 终止整个循环
        }

        print("处理项: \(item)")
    }
}</code></pre>

            <div class="note">
                <p><strong>提示：</strong> guard 语句特别适合那些需要满足前置条件才能继续执行的场景。它让代码的"快乐路径"保持在主缩进级别，而异常情况则被优雅地处理掉。</p>
            </div>
        </section>

        <section>
            <h2>guard 的最佳实践</h2>
            <ul>
                <li><strong>提前验证：</strong> 在函数开始处使用 guard 验证所有参数</li>
                <li><strong>避免深度嵌套：</strong> 用 guard 代替深层嵌套的 if 语句</li>
                <li><strong>简化错误处理：</strong> 在 guard 语句中使用清晰的错误提示</li>
                <li><strong>保持简洁：</strong> 每个 guard 语句处理一个或相关的几个条件</li>
                <li><strong>合理命名：</strong> 通过 guard 解包的变量应该有描述性名称</li>
            </ul>

            <h3>示例 5：改进代码结构</h3>
            <span class="example-title">使用 guard 优化深层嵌套：</span>
            <pre><code>// 不推荐的写法 - 多层嵌套的 if 语句
func processUserInfo(dict: [String: Any]?) {
    if let dict = dict {
        if let name = dict["name"] as? String {
            if let age = dict["age"] as? Int {
                if age >= 18 {
                    print("\(name) 已成年")
                } else {
                    print("\(name) 未成年")
                }
            } else {
                print("年龄格式无效")
            }
        } else {
            print("姓名格式无效")
        }
    } else {
        print("用户信息为空")
    }
}

// 推荐的写法 - 使用 guard 语句
func processUserInfo(dict: [String: Any]?) {
    guard let dict = dict else {
        print("用户信息为空")
        return
    }

    guard let name = dict["name"] as? String else {
        print("姓名格式无效")
        return
    }

    guard let age = dict["age"] as? Int else {
        print("年龄格式无效")
        return
    }

    if age >= 18 {
        print("\(name) 已成年")
    } else {
        print("\(name) 未成年")
    }
}</code></pre>
        </section>

        <section>
            <h2>高级用法</h2>
            <h3>示例 6：结合 guard 和 where</h3>
            <span class="example-title">使用 where 子句增加条件约束：</span>
            <pre><code>func processPayment(amount: Double?, currency: String?) {
    guard let amount = amount, amount > 0, let currency = currency, currency.count == 3 else {
        print("支付信息无效")
        return
    }

    // 或者使用 where 子句进行更清晰的条件表达
    guard let paymentAmount = amount, let paymentCurrency = currency
        where paymentAmount > 0 && paymentCurrency.count == 3 else {
        print("支付信息无效")
        return
    }

    print("处理 \(paymentAmount) \(paymentCurrency) 的支付")
}</code></pre>

            <h3>示例 7：结合 guard 和自定义错误</h3>
            <span class="example-title">抛出具体的错误类型：</span>
            <pre><code>enum ValidationError: Error {
    case emptyInput
    case invalidFormat
    case insufficientLength
    case exceededMaxLength
}

func validateUsername(_ username: String?) throws -> String {
    guard let username = username else {
        throw ValidationError.emptyInput
    }

    guard !username.isEmpty else {
        throw ValidationError.emptyInput
    }

    guard username.count >= 4 else {
        throw ValidationError.insufficientLength
    }

    guard username.count <= 20 else {
        throw ValidationError.exceededMaxLength
    }

    // 只允许字母、数字和下划线
    guard username.range(of: "^[a-zA-Z0-9_]+$", options: .regularExpression) != nil else {
        throw ValidationError.invalidFormat
    }

    return username
}</code></pre>
        </section>

        <section id="resources">
            <h2>资源与进一步学习</h2>

            <div class="resource-section">
                <div class="resource-card">
                    <h4>官方文档</h4>
                    <ul>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html" target="_blank">Swift 控制流官方文档</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/swift_standard_library" target="_blank">Swift 标准库</a></li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h4>精选博客与文章</h4>
                    <ul>
                        <li><a href="https://www.swiftbysundell.com/articles/the-power-of-guard-let/" target="_blank">The power of guard let - Swift by Sundell</a></li>
                        <li><a href="https://www.hackingwithswift.com/new-syntax-swift-2-guard" target="_blank">Hacking with Swift: Guard 语句指南</a></li>
                        <li><a href="https://www.avanderlee.com/swift/guard-let-statement-optionals/" target="_blank">Guard 语句与可选值处理 - SwiftLee</a></li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h4>推荐书籍</h4>
                    <ul>
                        <li>《Swift 编程权威指南》(The Swift Programming Language) - Apple</li>
                        <li>《Swift 进阶》(Advanced Swift) - Chris Eidhof, Ole Begemann, and Airspeed Velocity</li>
                        <li>《Swift 实战编程》(Pro Swift) - Paul Hudson</li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h4>视频教程</h4>
                    <ul>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2015/106/" target="_blank">WWDC: Swift 中的新特性</a></li>
                        <li><a href="https://www.youtube.com/watch?v=mAU7BtTm_H0" target="_blank">Swift 编程教程：掌握 Guard 语句</a></li>
                        <li><a href="https://www.raywenderlich.com/videos" target="_blank">RayWenderlich Swift 视频教程系列</a></li>
                    </ul>
                </div>

                <div class="resource-card">
                    <h4>开源项目示例</h4>
                    <ul>
                        <li><a href="https://github.com/apple/swift" target="_blank">Swift 编程语言</a>（查看源码中的 guard 使用方式）</li>
                        <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a>（网络库中 guard 的应用）</li>
                        <li><a href="https://github.com/realm/SwiftLint" target="_blank">SwiftLint</a>（包含 guard 使用的最佳实践检查）</li>
                    </ul>
                </div>
            </div>
        </section>
    </main>

</body>
</html>
