<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #007AFF;
            --secondary: #34C759;
            --accent: #FF375F;
            --text: #1D1D1F;
            --bg: #FFFFFF;
            --card-bg: #F5F5F7;
            --code-bg: #E5E5EA;
            --border: rgba(0,0,0,0.1);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --text: #FFFFFF;
                --bg: #000000;
                --card-bg: #1C1C1E;
                --code-bg: #2C2C2E;
                --border: rgba(255,255,255,0.1);
            }
        }

        body {
            font-family: -apple-system, system-ui;
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background: var(--bg);
            color: var(--text);
        }

        .grid {
            display: grid;
            gap: 1.5rem;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        }

        .card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 1.5rem;
            border: 1px solid var(--border);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        .visual {
            margin: 1.5rem 0;
            text-align: center;
        }

        pre {
            background: var(--code-bg);
            padding: 1rem;
            border-radius: 12px;
            overflow-x: auto;
        }

        .links {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
        }

        .link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary);
            text-decoration: none;
            padding: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="grid">
        <!-- 基础函数 -->
        <div class="card">
            <h2>📦 基础函数</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <path d="M30 50 L80 30 L170 50 L120 70 Z"
                          fill="var(--primary)"
                          opacity="0.2"/>
                    <path d="M30 50 L80 30 L170 50 M80 30 L120 70"
                          stroke="var(--text)"/>
                </svg>
            </div>
            <pre><code>// 无参数无返回值
func greet() {
    print("Hello!")
}

// 带类型注解
func sum(a: Int, b: Int) -> Int {
    return a + b
}</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/"
                   class="link">官方文档</a>
            </div>
        </div>

        <!-- 参数标签 -->
        <div class="card">
            <h2>🏷️ 参数标签</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="60" height="40" rx="6" fill="var(--secondary)"/>
                    <rect x="110" y="30" width="60" height="40" rx="6" fill="var(--primary)"/>
                    <path d="M90 40 L110 40" stroke="var(--text)"/>
                    <text x="60" y="65" text-anchor="middle">外部</text>
                    <text x="140" y="65" text-anchor="middle">内部</text>
                </svg>
            </div>
            <pre><code>// 默认参数标签
func move(from start: Point, to end: Point)

// 省略标签
func calculate(_ a: Int, _ b: Int) -> Int

// 默认参数
func connect(timeout: TimeInterval = 10)</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/#Function-Parameter-Names"
                   class="link">参数规范</a>
            </div>
        </div>

        <!-- 高阶函数 -->
        <div class="card">
            <h2>🚀 高阶函数</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="40" rx="8"
                         stroke="var(--accent)"
                         fill="none"/>
                    <path d="M30 50 L60 30 L170 50"
                          stroke="var(--secondary)"/>
                </svg>
            </div>
            <pre><code>// 函数作为参数
func filter(_ numbers: [Int],
           using condition: (Int) -> Bool) -> [Int] {
    return numbers.filter(condition)
}

// 函数作为返回值
func makeCounter() -> () -> Int {
    var count = 0
    return { count += 1; return count }
}</code></pre>
            <div class="links">
                <a href="https://www.swiftbysundell.com/articles/first-class-functions-in-swift/"
                   class="link">高阶用法</a>
            </div>
        </div>

        <!-- 高级特性 -->
        <div class="card">
            <h2>💡 高级特性</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="40" rx="8"
                         fill="var(--code-bg)"/>
                    <text x="100" y="55" text-anchor="middle"
                          fill="var(--text)">inout</text>
                </svg>
            </div>
            <pre><code>// inout参数
func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

// 泛型函数
func findIndex<T: Equatable>(of value: T, in array: [T]) -> Int? {
    return array.firstIndex(of: value)
}

// @discardableResult
@discardableResult
func log(message: String) -> Bool {
    print(message)
    return true
}</code></pre>
            <div class="links">
                <a href="https://nshipster.com/swift-generic-parameters/"
                   class="link">泛型文档</a>
            </div>
        </div>
    </div>
</body>
</html>
