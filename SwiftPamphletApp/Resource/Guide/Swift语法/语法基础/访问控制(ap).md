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

        .access-level {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 1rem 0;
        }

        .level {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="grid">
        <!-- 访问等级 -->
        <div class="card">
            <h2>🔒 访问等级</h2>
            <div class="visual">
                <svg width="300" height="120">
                    <rect x="20" y="20" width="60" height="40" rx="6" fill="#34C759"/>
                    <text x="50" y="45" fill="var(--bg)">open</text>
                    
                    <rect x="90" y="20" width="60" height="40" rx="6" fill="#007AFF"/>
                    <text x="120" y="45" fill="var(--bg)">public</text>
                    
                    <rect x="160" y="20" width="60" height="40" rx="6" fill="#AF52DE"/>
                    <text x="190" y="45" fill="var(--bg)">internal</text>
                    
                    <rect x="60" y="70" width="60" height="40" rx="6" fill="#FF9500"/>
                    <text x="90" y="95" fill="var(--bg)">fileprivate</text>
                    
                    <rect x="140" y="70" width="60" height="40" rx="6" fill="#FF3B30"/>
                    <text x="170" y="95" fill="var(--bg)">private</text>
                </svg>
            </div>
            <pre><code>open class FrameworkClass {
    public var api: String
    internal var config: Data
    fileprivate var logger: Logger
    private var secret: String
}</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/" 
                   class="link">官方文档</a>
            </div>
        </div>

        <!-- 作用域 -->
        <div class="card">
            <h2>🌐 作用域规则</h2>
            <div class="visual">
                <svg width="280" height="160">
                    <circle cx="140" cy="80" r="70" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="140" cy="80" r="50" fill="none" stroke="var(--secondary)" stroke-width="2"/>
                    <circle cx="140" cy="80" r="30" fill="none" stroke="var(--accent)" stroke-width="2"/>
                    <text x="140" y="40" text-anchor="middle">模块</text>
                    <text x="140" y="100" text-anchor="middle">文件</text>
                    <text x="140" y="140" text-anchor="middle">类型</text>
                </svg>
            </div>
            <pre><code>public struct API {
    // 默认internal
    var endpoint: String
    
    // 文件内可见
    fileprivate func validate() {}
    
    // 类型内可见
    private func log() {}
}</code></pre>
        </div>

        <!-- 高级控制 -->
        <div class="card">
            <h2>💡 高级控制</h2>
            <div class="visual">
                <svg width="240" height="120">
                    <rect x="30" y="30" width="180" height="60" rx="10" 
                         stroke="var(--accent)" 
                         fill="none" 
                         stroke-width="2"/>
                    <text x="120" y="65" text-anchor="middle" fill="var(--text)">
                        @testable import
                    </text>
                </svg>
            </div>
            <pre><code>// 单元测试特殊访问
@testable import MyModule

// 属性包装器访问
@propertyWrapper
public struct Protected&lt;T&gt; {
    private var value: T
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
}</code></pre>
            <div class="links">
                <a href="https://www.swiftbysundell.com/articles/access-control-swift/" 
                   class="link">最佳实践</a>
            </div>
        </div>

        <!-- 特殊场景 -->
        <div class="card">
            <h2>⚠️ 特殊场景</h2>
            <div class="visual">
                <svg width="240" height="120">
                    <path d="M30 50 L100 30 L210 50 L140 90 Z" 
                         fill="var(--code-bg)"/>
                    <path d="M100 30 L140 90" stroke="var(--secondary)"/>
                </svg>
            </div>
            <pre><code>// 协议要求自动继承
public protocol DataService {
    var api: String { get }
}

internal struct Implementation: DataService {
    var api: String  // 自动internal
}

// SPM模块访问
// Package.swift
.target(name: "Core", dependencies: [], 
        publicHeadersPath: "Headers")</code></pre>
            <div class="links">
                <a href="https://nshipster.com/access-control/" 
                   class="link">NSHipter详解</a>
            </div>
        </div>
    </div>
</body>
</html>
