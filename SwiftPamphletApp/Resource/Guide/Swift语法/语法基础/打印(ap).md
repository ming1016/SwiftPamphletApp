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
        <!-- 基础输出 -->
        <div class="card">
            <h2>📝 基础输出</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <path d="M20 20 L180 20 L190 50 L180 80 L20 80 L10 50 Z"
                          fill="var(--code-bg)"
                          stroke="var(--text)"/>
                    <text x="100" y="50" text-anchor="middle" fill="var(--text)">
                        print("Hello")
                    </text>
                </svg>
            </div>
            <pre><code>print(1...5)       // 输出区间
print(1, 2, 3, separator: " | ")
print("Error", to: &errStream)</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/swift/print(_:separator:terminator:)"
                   class="link">Apple Documentation</a>
            </div>
        </div>

        <!-- 字符串插值 -->
        <div class="card">
            <h2>🧩 字符串插值</h2>
            <div class="visual">
                <svg width="240" height="120">
                    <rect x="30" y="40" width="180" height="40" rx="8" fill="var(--secondary)"/>
                    <text x="120" y="65" fill="var(--bg)" text-anchor="middle">
                        "结果: \(value)"
                    </text>
                </svg>
            </div>
            <pre><code>let price = 9.99
print("价格: \(price, specifier: "%.2f")¥")
// 输出：价格: 9.99¥</code></pre>
            <div class="links">
                <a href="https://www.swiftbysundell.com/articles/string-interpolation-in-swift/"
                   class="link">Advanced Techniques</a>
            </div>
        </div>

        <!-- 调试输出 -->
        <div class="card">
            <h2>🐞 调试工具</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <path d="M20 30 Q 100 0 180 30 L160 70 Q 100 100 40 70 Z"
                          fill="var(--accent)"
                          opacity="0.8"/>
                    <text x="100" y="50" text-anchor="middle" fill="var(--bg)">
                        debugPrint
                    </text>
                </svg>
            </div>
            <pre><code>struct User {
    let id: Int
    let name: String
}

debugPrint(User(id: 1, name: "Alice"))
// 输出完整类型信息</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/swift/debugprint(_:separator:terminator:)"
                   class="link">Debug Methods</a>
            </div>
        </div>

        <!-- 高级日志 -->
        <div class="card">
            <h2>🔧 高级日志</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <circle cx="100" cy="50" r="40" fill="var(--primary)"/>
                    <text x="100" y="55" text-anchor="middle" fill="var(--bg)">
                        OSLog
                    </text>
                </svg>
            </div>
            <pre><code>import os.log

let logger = Logger(subsystem: "com.app.example",
                    category: "ui")

logger.log(level: .debug, "View loaded")</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/os/logging"
                   class="link">Logging Framework</a>
            </div>
        </div>
    </div>
</body>
</html>
