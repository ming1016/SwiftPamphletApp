
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #007AFF;
            --secondary: #34C759;
            --accent: #FF9F0A;
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
        <!-- 闭包基础 -->
        <div class="card">
            <h2>📦 闭包基础</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="40" rx="8"
                         fill="var(--primary)" opacity="0.2"/>
                    <text x="100" y="55" text-anchor="middle" fill="var(--text)">
                        { (params) -> T in ... }
                    </text>
                </svg>
            </div>
            <pre><code>// 完整形式
let add = { (a: Int, b: Int) -> Int in
    return a + b
}

// 类型推断
let multiply = { (a: Int, b: Int) in a * b }</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/"
                   class="link">官方文档</a>
            </div>
        </div>

        <!-- 尾随闭包 -->
        <div class="card">
            <h2>🚀 尾随闭包</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="60" height="40" rx="6" fill="var(--secondary)"/>
                    <rect x="110" y="30" width="60" height="40" rx="6" fill="var(--primary)"/>
                    <path d="M90 40 L110 40" stroke="var(--text)"/>
                </svg>
            </div>
            <pre><code>// 尾闭包语法
UIView.animate(withDuration: 0.3) {
    view.alpha = 0
}

// 多闭包参数
UIView.animate(withDuration: 0.3, animations: {
    view.alpha = 0
}) { _ in
    view.removeFromSuperview()
}</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/swift/closures"
                   class="link">Apple文档</a>
            </div>
        </div>

        <!-- 捕获语义 -->
        <div class="card">
            <h2>🔗 捕获语义</h2>
            <div class="visual">
                <svg width="200" height="120">
                    <circle cx="100" cy="50" r="30" fill="var(--accent)" opacity="0.3"/>
                    <path d="M60 50 Q 100 20 140 50"
                          stroke="var(--secondary)"
                          fill="none"/>
                    <text x="100" y="90" text-anchor="middle" fill="var(--text)">
                        [weak self]
                    </text>
                </svg>
            </div>
            <pre><code>class Manager {
    var completion: (() -> Void)?
    
    func setup() {
        var counter = 0
        startTask { [weak self] in
            counter += 1
            self?.handleComplete()
        }
    }
}</code></pre>
            <div class="links">
                <a href="https://www.swiftbysundell.com/articles/capturing-objects-in-swift-closures/"
                   class="link">内存管理</a>
            </div>
        </div>

        <!-- 高级特性 -->
        <div class="card">
            <h2>💡 高级特性</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="40" rx="8"
                         stroke="var(--accent)"
                         fill="none"
                         stroke-width="2"/>
                    <text x="100" y="55" text-anchor="middle" fill="var(--text)">
                        @escaping @autoclosure
                    </text>
                </svg>
            </div>
            <pre><code>// 逃逸闭包
func fetchData(completion: @escaping (Result) -> Void) {
    DispatchQueue.global().async {
        completion(.success(data))
    }
}

// 自动闭包
func assert(_ condition: @autoclosure () -> Bool) {
    guard condition() else { return }
}</code></pre>
            <div class="links">
                <a href="https://nshipster.com/escaping/"
                   class="link">@escaping详解</a>
            </div>
        </div>
    </div>
</body>
</html>
