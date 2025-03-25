
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #007AFF;
            --secondary: #34C759;
            --accent: #BF5AF2;
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
            position: relative;
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
        <!-- 基础注释 -->
        <div class="card">
            <h2>📌 基础注释</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <path d="M30 40 L170 40" stroke="var(--primary)" stroke-width="2"
                          stroke-dasharray="4 4"/>
                    <text x="100" y="65" text-anchor="middle" fill="var(--text)">
                        // 单行注释
                    </text>
                </svg>
            </div>
            <pre><code>// 单行注释
/* 多行注释
   支持嵌套 */

/// 文档注释
func calculate() { /* ... */ }</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#Comments"
                   class="link">官方文档</a>
            </div>
        </div>

        <!-- 文档注释 -->
        <div class="card">
            <h2>📚 文档注释</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="30" y="30" width="140" height="60" rx="10"
                          fill="var(--secondary)" opacity="0.3"/>
                    <text x="100" y="50" text-anchor="middle" fill="var(--text)">
                        Parameters:
                    </text>
                    <text x="100" y="70" text-anchor="middle" fill="var(--text)">
                        Returns:
                    </text>
                </svg>
            </div>
            <pre><code>/// 计算两个数的和
/// - Parameters:
///   - a: 第一个操作数
///   - b: 第二个操作数
/// - Returns: 两数之和
/// - Note: 支持整数和浮点数
func add(_ a: Any, _ b: Any) -> Any { ... }</code></pre>
            <div class="links">
                <a href="https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/"
                   class="link">Markdown语法</a>
            </div>
        </div>

        <!-- 条件编译 -->
        <div class="card">
            <h2>⚙️ 条件编译</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <path d="M30 50 L100 50 Q 120 50 120 30"
                          stroke="var(--accent)" fill="none"/>
                    <path d="M30 50 L100 50 Q 120 50 120 70"
                          stroke="var(--primary)" fill="none"/>
                </svg>
            </div>
            <pre><code>#if DEBUG
print("调试模式")
#elseif os(macOS)
print("macOS平台")
#endif</code></pre>
            <div class="links">
                <a href="https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Conditional-Compilation-Block"
                   class="link">编译指令</a>
            </div>
        </div>

        <!-- 高级用法 -->
        <div class="card">
            <h2>💡 高级技巧</h2>
            <div class="visual">
                <svg width="200" height="100">
                    <rect x="40" y="30" width="120" height="40" rx="8"
                          fill="var(--code-bg)"/>
                    <text x="100" y="55" text-anchor="middle"
                          fill="var(--text)">// MARK: -</text>
                </svg>
            </div>
            <pre><code>// MARK: - 生命周期方法
// TODO: 需要优化性能
// FIXME: 内存泄漏问题

#if canImport(UIKit)
import UIKit
#endif</code></pre>
            <div class="links">
                <a href="https://nshipster.com/swift-documentation/"
                   class="link">最佳实践</a>
                <a href="https://swiftbysundell.com/articles/the-power-of-comments-in-swift/"
                   class="link">技巧指南</a>
            </div>
        </div>
    </div>
</body>
</html>
