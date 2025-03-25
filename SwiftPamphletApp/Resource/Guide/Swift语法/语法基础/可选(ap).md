<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #007AFF;
            --secondary: #34C759;
            --accent: #FF453A;
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
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
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
        <!-- 可选声明 -->
        <div class="card">
            <h2>📦 可选声明</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="40" rx="8"
                         fill="var(--primary)" opacity="0.2"/>
                    <text x="100" y="55" text-anchor="middle" fill="var(--text)">
                        String?
                    </text>
                </svg>
            </div>
            <pre><code>var name: String? = nil
var age: Int? = 25
let numbers: [Int]? = [1,2,3]</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Optionals"
                   class="link">官方文档</a>
            </div>
        </div>

        <!-- 解包方式 -->
        <div class="card">
            <h2>🔓 安全解包</h2>
            <div class="visual">
                <svg width="200" height="120">
                    <path d="M30 30 L80 80 L170 30"
                         stroke="var(--secondary)"
                         fill="none"
                         stroke-width="2"/>
                    <circle cx="100" cy="80" r="8" fill="var(--accent)"/>
                </svg>
            </div>
            <pre><code>// 可选绑定
if let safeName = name {
    print(safeName)
}

// guard解包
guard let safeAge = age else {
    return
}

// 强制解包（慎用）
let forcedValue = name!</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/swift/optional"
                   class="link">Optional API</a>
            </div>
        </div>

        <!-- 高级操作 -->
        <div class="card">
            <h2>⚡ 高级操作</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="40" width="60" height="40" rx="6" fill="var(--primary)"/>
                    <rect x="110" y="40" width="60" height="40" rx="6" fill="var(--secondary)"/>
                    <path d="M90 50 L110 50" stroke="var(--text)"/>
                </svg>
            </div>
            <pre><code>// 空合并运算符
let validName = name ?? "Anonymous"

// 可选链
let count = numbers?.count

// 类型转换
let value = input as? Int</code></pre>
            <div class="links">
                <a href="https://www.swiftbysundell.com/articles/optionals-in-swift/"
                   class="link">高级技巧</a>
            </div>
        </div>

        <!-- 特殊类型 -->
        <div class="card">
            <h2>⚠️ 特殊类型</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="40" rx="8"
                         stroke="var(--accent)"
                         fill="none"
                         stroke-width="2"/>
                    <text x="100" y="55" text-anchor="middle" fill="var(--text)">
                        String!
                    </text>
                </svg>
            </div>
            <pre><code>// 隐式解包可选
var outlet: UILabel!

// 协议可选要求
@objc protocol DataSource {
    @objc optional var count: Int { get }
}

// 可选泛型
struct Box<T> {
    let value: T?
}</code></pre>
            <div class="links">
                <a href="https://nshipster.com/swift-optional-protocol-methods/"
                   class="link">协议可选方法</a>
            </div>
        </div>
    </div>
</body>
</html>
