<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #007AFF;
            --secondary: #34C759;
            --accent: #FF2D55;
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
            font-family: -apple-system, system-ui, "SF Pro Display";
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background: var(--bg);
            color: var(--text);
            transition: all 0.3s ease;
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
            transform: translateY(-5px);
        }

        h2 {
            margin: 0 0 1rem;
            font-size: 1.5rem;
            color: var(--primary);
        }

        code {
            font-family: "SF Mono", Menlo;
            background: var(--code-bg);
            padding: 0.2em 0.4em;
            border-radius: 6px;
        }

        pre {
            background: var(--code-bg);
            padding: 1rem;
            border-radius: 12px;
            overflow-x: auto;
            margin: 1rem 0;
        }

        .visual {
            margin: 1.5rem 0;
            text-align: center;
        }

        .links {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
        }

        .link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary);
            text-decoration: none;
            padding: 0.5rem 0;
        }

        .link svg {
            width: 16px;
            height: 16px;
            fill: currentColor;
        }
    </style>
</head>
<body>
    <div class="grid">
        <!-- 变量声明 -->
        <div class="card">
            <h2>🚀 变量与常量</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="20" y="30" width="80" height="40" fill="var(--primary)" rx="8"/>
                    <text x="60" y="55" fill="var(--bg)" text-anchor="middle" font-weight="600">var</text>
                    <rect x="120" y="30" width="80" height="40" fill="var(--secondary)" rx="8"/>
                    <text x="160" y="55" fill="var(--bg)" text-anchor="middle" font-weight="600">let</text>
                </svg>
            </div>
            <pre><code>var count = 10     // 可变
let maxCount = 100 // 不可变</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Constants-and-Variables" class="link">
                    <svg><!-- 省略SVG图标代码 --></svg>
                    官方文档
                </a>
                <a href="https://www.avanderlee.com/swift/constants-variables-swift/" class="link">
                    <svg><!-- 省略SVG图标代码 --></svg>
                    最佳实践
                </a>
            </div>
        </div>

        <!-- 类型系统 -->
        <div class="card">
            <h2>🎯 类型系统</h2>
            <div class="visual">
                <svg width="200" height="100"><!-- 类型推导流程图 --></svg>
            </div>
            <pre><code>let name = "Tim"        // 类型推断
let age: Int = 40      // 类型注解
var scores = [90.5]    // 数组类型推导</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/" class="link">类型文档</a>
            </div>
        </div>

        <!-- 可选类型 -->
        <div class="card">
            <h2>🔍 可选类型</h2>
            <div class="visual">
                <svg width="180" height="120"><!-- Optional解包示意图 --></svg>
            </div>
            <pre><code>var nickname: String? = "Buddy"
nickname?.uppercased()  // 可选链
nickname ?? "Anonymous" // 空合并</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/swift/optional" class="link">Optional API</a>
            </div>
        </div>

        <!-- 高级特性 -->
        <div class="card">
            <h2>💡 高级特性</h2>
            <div class="visual">
                <svg width="220" height="140"><!-- 属性观察器流程图 --></svg>
            </div>
            <pre><code>// 属性包装器
@propertyWrapper
struct Trimmed {
    private var value = ""
    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmed() }
    }
}</code></pre>
            <div class="links">
                <a href="https://github.com/apple/swift-evolution/blob/main/proposals/0258-property-wrappers.md" class="link">SE-0258</a>
            </div>
        </div>
    </div>
</body>
</html>
