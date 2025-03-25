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

        .regex-diagram {
            margin: 1.5rem 0;
            padding: 1rem;
            background: var(--bg);
            border-radius: 12px;
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

        .regex-part {
            display: inline-block;
            padding: 0.2rem 0.4rem;
            margin: 0 2px;
            border-radius: 4px;
            background: var(--primary);
            color: white;
        }
    </style>
</head>
<body>
    <div class="grid">
        <!-- 基础Regex -->
        <div class="card">
            <h2>🔍 基础Regex</h2>
            <div class="regex-diagram">
                <svg width="100%" height="80">
                    <text x="10" y="30" fill="var(--text)">匹配:</text>
                    <rect x="80" y="15" width="60" height="30" rx="4" fill="var(--secondary)"/>
                    <text x="110" y="35" fill="var(--bg)">\d+</text>
                    <text x="150" y="35" fill="var(--text)">→ 数字</text>
                </svg>
            </div>
            <pre><code>let regex = try! Regex(#"\b(\d{4})-(\d{2})-(\d{2})\b"#)
let dateStr = "2023-12-31"

if let match = dateStr.firstMatch(of: regex) {
    let (whole, year, month, day) = match.output
}</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/documentation/swift/regex" 
                   class="link">官方文档</a>
            </div>
        </div>

        <!-- RegexBuilder -->
        <div class="card">
            <h2>🏗️ RegexBuilder</h2>
            <div class="regex-diagram">
                <svg width="100%" height="100">
                    <rect x="20" y="20" width="40" height="40" rx="4" fill="var(--primary)"/>
                    <text x="40" y="45" fill="var(--bg)">One</text>
                    <rect x="80" y="20" width="60" height="40" rx="4" fill="var(--accent)"/>
                    <text x="110" y="45" fill="var(--bg)">OrMore</text>
                    <path d="M20 60 L160 60" stroke="var(--text)" stroke-dasharray="4"/>
                </svg>
            </div>
            <pre><code>import RegexBuilder

let regex = Regex {
    Capture { OneOrMore(.word) }
    "@"
    Capture {
        ChoiceOf {
            "gmail.com"
            "icloud.com"
        }
    }
}</code></pre>
        </div>

        <!-- 高级匹配 -->
        <div class="card">
            <h2>⚡ 高级匹配</h2>
            <div class="regex-diagram">
                <svg width="100%" height="120">
                    <rect x="20" y="20" width="80" height="30" rx="4" fill="var(--secondary)"/>
                    <text x="60" y="40" fill="var(--bg)">Lookahead</text>
                    <rect x="120" y="20" width="60" height="30" rx="4" fill="var(--primary)"/>
                    <text x="150" y="40" fill="var(--bg)">(?=)</text>
                    <rect x="20" y="70" width="100" height="30" rx="4" fill="var(--accent)"/>
                    <text x="70" y="90" fill="var(--bg)">Backreference</text>
                </svg>
            </div>
            <pre><code>// 正向预查
let passwordRegex = Regex {
    Anchor.startOfLine
    Lookahead { One(.anyOf("!@#$%^&*")) }
    Lookahead { One(.digit) }
    Lookahead { One(.lowercase) }
    Lookahead { One(.uppercase) }
    8...20
}

// 反向引用
let dupRegex = Regex {
    Capture(OneOrMore(.word))
    ZeroOrMore(.whitespace)
    \.1
}</code></pre>
        </div>

        <!-- 性能优化 -->
        <div class="card">
            <h2>🚀 性能优化</h2>
            <div class="regex-diagram">
                <svg width="100%" height="80">
                    <path d="M20 40 Q 100 10 180 40" 
                         stroke="var(--primary)" 
                         fill="none" 
                         stroke-width="2"/>
                    <text x="100" y="60" fill="var(--text)">编译时优化</text>
                </svg>
            </div>
            <pre><code>// 编译时正则（Swift 5.7+）
let compiledRegex = Regex {
    /(\d{2}):(\d{2})/
}.ignoresCase()

// 复用Regex实例
let hexRegex = /^#?([0-9a-fA-F]{3,8})$/

// 基准测试结果
// RegexBuilder vs NSRegularExpression
// 性能提升3-5倍</code></pre>
            <div class="links">
                <a href="https://www.swift.org/blog/swift-regex/" 
                   class="link">性能指南</a>
            </div>
        </div>
    </div>
</body>
</html>
