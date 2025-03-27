<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 注释全面指南</title>
    <style>
        :root {
            --primary: #6200ee;
            --secondary: #03dac6;
            --accent: #ffb300;
            --success: #4caf50;
            --text-primary: #000000;
            --text-secondary: #888888;
            --background: #ffffff;
            --card-background: #ffffff;
            --code-background: #f5f5f5;
            --border: #e0e0e0;
            --shadow: rgba(0, 0, 0, 0.1);
            --radius: 14px;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary: #bb86fc;
                --secondary: #03dac6;
                --accent: #ffb300;
                --success: #4caf50;
                --text-primary: #ffffff;
                --text-secondary: #bbbbbb;
                --background: #121212;
                --card-background: #1e1e1e;
                --code-background: #2d2d2d;
                --border: #333333;
                --shadow: rgba(0, 0, 0, 0.3);
            }
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background-color: var(--background);
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        h1, h2, h3, h4, h5, h6 {
            margin: 1.5rem 0 1rem;
            color: var(--text-primary);
            font-weight: 600;
            line-height: 1.2;
        }

        h1 {
            font-size: 2.5rem;
            margin-top: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--primary);
            color: var(--primary);
        }

        h2 {
            font-size: 1.8rem;
            margin-top: 2rem;
            padding-bottom: 0.3rem;
            border-bottom: 1px solid var(--border);
        }

        h3 {
            font-size: 1.5rem;
            color: var(--primary);
        }

        p {
            margin: 1rem 0;
            color: var(--text-primary);
        }

        a {
            color: var(--primary);
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            text-decoration: underline;
            color: var(--secondary);
        }

        .card {
            background-color: var(--card-background);
            border-radius: var(--radius);
            padding: 1.5rem;
            margin: 1.5rem 0;
            box-shadow: 0 4px 12px var(--shadow);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 16px var(--shadow);
        }

        code {
            font-family: 'SF Mono', Menlo, Monaco, Consolas, 'Liberation Mono', monospace;
            background-color: var(--code-background);
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-size: 0.9em;
            color: var(--primary);
        }

        pre {
            background-color: var(--code-background);
            border-radius: var(--radius);
            padding: 1rem;
            overflow-x: auto;
            margin: 1rem 0;
            border: 1px solid var(--border);
        }

        pre code {
            padding: 0;
            background-color: transparent;
            color: var(--text-primary);
            display: block;
        }

        .comment-highlight {
            color: var(--secondary);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .resource-card {
            display: flex;
            flex-direction: column;
            border-left: 4px solid var(--accent);
        }
        
        .resource-card h4 {
            color: var(--accent);
        }

        .tip {
            background-color: rgba(76, 175, 80, 0.1);
            border-left: 4px solid var(--success);
            padding: 1rem;
            margin: 1rem 0;
            border-radius: var(--radius);
        }

        .tip strong {
            color: var(--success);
        }

        .toc {
            background-color: var(--card-background);
            border-radius: var(--radius);
            padding: 1.5rem;
            margin: 1.5rem 0;
            box-shadow: 0 4px 12px var(--shadow);
            position: sticky;
            top: 20px;
        }

        .toc ul {
            list-style-type: none;
            padding-left: 1rem;
        }

        .toc li {
            margin: 0.5rem 0;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 3fr;
            gap: 2rem;
        }

        .content {
            min-width: 0;
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
        }

        .code-explanation {
            display: flex;
            margin: 1.5rem 0;
            gap: 1rem;
            flex-direction: column;
        }

        @media (min-width: 768px) {
            .code-explanation {
                flex-direction: row;
            }
            
            .code-part {
                flex: 1;
            }
            
            .explanation-part {
                flex: 1;
            }
        }

        .tag {
            display: inline-block;
            background-color: var(--primary);
            color: white;
            padding: 0.2rem 0.6rem;
            border-radius: 1rem;
            font-size: 0.8rem;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <h1>Swift 注释全面指南</h1>
    
    <div class="container">
        <aside>
            <div class="toc">
                <h3>目录</h3>
                <ul>
                    <li><a href="#intro">简介</a></li>
                    <li><a href="#single-line">单行注释</a></li>
                    <li><a href="#multi-line">多行注释</a></li>
                    <li><a href="#nested">嵌套注释</a></li>
                    <li><a href="#documentation">文档注释</a></li>
                    <li><a href="#markdown">Markdown 支持</a></li>
                    <li><a href="#special">特殊注释标记</a></li>
                    <li><a href="#best-practices">最佳实践</a></li>
                    <li><a href="#resources">相关资源</a></li>
                </ul>
            </div>
        </aside>
        
        <main class="content">
            <section id="intro" class="card">
                <h2>简介</h2>
                <p>注释是代码中不会被编译器执行的文本，主要用于解释代码的功能、提供额外的上下文或标记需要改进的地方。Swift 提供了多种注释方式，从简单的单行注释到功能丰富的文档注释。高质量的注释能让代码更易于理解和维护，特别是在团队协作环境中。</p>
                
                <svg width="100%" height="200" viewBox="0 0 800 200">
                    <rect x="50" y="30" width="700" height="140" rx="10" ry="10" fill="#f5f5f5" stroke="#6200ee" stroke-width="2"/>
                    <text x="400" y="80" text-anchor="middle" font-size="20" fill="#6200ee">Swift 注释的主要目的</text>
                    <line x1="200" y1="100" x2="600" y2="100" stroke="#6200ee" stroke-width="2"/>
                    
                    <text x="150" y="130" text-anchor="middle" fill="#000">解释代码</text>
                    <text x="300" y="130" text-anchor="middle" fill="#000">文档生成</text>
                    <text x="450" y="130" text-anchor="middle" fill="#000">代码导航</text>
                    <text x="600" y="130" text-anchor="middle" fill="#000">任务标记</text>
                </svg>
            </section>
            
            <section id="single-line" class="card">
                <h2>单行注释</h2>
                <p>单行注释以两个斜杠 <code>//</code> 开始，一直延续到行尾。这是在代码中添加简短说明的最常用方式。</p>
                
                <div class="code-explanation">
                    <div class="code-part">
                        <pre><code>// 这是一个单行注释
let name = "Swift"  // 这是行尾注释

// 多个单行注释可以连续使用
// 形成多行解释
// 但每行都需要加上 //
let version = 5.5</code></pre>
                    </div>
                    <div class="explanation-part">
                        <h4>说明：</h4>
                        <ul>
                            <li>单行注释可以独占一行</li>
                            <li>也可以放在代码的同一行末尾</li>
                            <li>连续的单行注释常用于简洁的多行说明</li>
                            <li>编译器会完全忽略注释内容</li>
                        </ul>
                    </div>
                </div>
                
                <div class="tip">
                    <strong>提示：</strong> 使用 Xcode 时，可以通过 <code>⌘ + /</code> 快捷键快速添加或删除单行注释。
                </div>
            </section>
            
            <section id="multi-line" class="card">
                <h2>多行注释</h2>
                <p>多行注释以 <code>/*</code> 开始，以 <code>*/</code> 结束。在这两个标记之间的所有内容都被视为注释，不管跨越多少行。</p>
                
                <div class="code-explanation">
                    <div class="code-part">
                        <pre><code>/* 
 * 这是多行注释的示例
 * 可以跨越多行
 * 星号是可选的，只是为了提高可读性
 */
func calculateArea(width: Double, height: Double) -> Double {
    return width * height
}</code></pre>
                    </div>
                    <div class="explanation-part">
                        <h4>多行注释的特点：</h4>
                        <ul>
                            <li>适合较长的解释文本</li>
                            <li>内部的星号 (*) 是可选的</li>
                            <li>通常用于函数或类的详细说明</li>
                            <li>可以临时注释掉大块代码</li>
                        </ul>
                    </div>
                </div>
            </section>
            
            <section id="nested" class="card">
                <h2>嵌套注释</h2>
                <p>Swift 允许注释嵌套，这意味着你可以在一个多行注释内部放置另一个多行注释。</p>
                
                <pre><code>/*
 外部注释的开始
 /*
    这是嵌套的内部注释
 */
 外部注释的结束
*/</code></pre>
                
                <p>嵌套注释在临时禁用包含注释的代码块时特别有用：</p>
                
                <pre><code>func processData() {
    /* 临时禁用这部分计算
    let result = calculateComplexFormula()
    /* 
       即使这里有注释也不会导致问题
       因为Swift支持嵌套注释
    */
    updateUI(with: result)
    */
    
    // 使用备选方案
    let result = simplifiedCalculation()
    updateUI(with: result)
}</code></pre>
                
                <div class="tip">
                    <strong>注意：</strong> 虽然Swift支持无限嵌套注释，但为了代码可读性，建议嵌套层级不要太深。
                </div>
            </section>
            
            <section id="documentation" class="card">
                <h2>文档注释</h2>
                <p>Swift 支持文档注释，这种注释不仅说明代码功能，还能被Xcode解析并显示为Quick Help文档。有两种格式的文档注释：</p>
                
                <h3>1. 三斜杠文档注释 (///)</h3>
                <pre><code>/// 计算矩形的面积
/// - Parameters:
///   - width: 矩形的宽度
///   - height: 矩形的高度
/// - Returns: 矩形的面积
func calculateArea(width: Double, height: Double) -> Double {
    return width * height
}</code></pre>
                
                <h3>2. 多行文档注释 (/** */)</h3>
                <pre><code>/**
 计算矩形的面积
 
 使用宽度和高度计算矩形的面积
 
 - Parameters:
   - width: 矩形的宽度
   - height: 矩形的高度
 - Returns: 矩形的面积
 - Throws: 如果宽度或高度为负值，抛出`GeometryError.invalidDimension`
 - Note: 所有单位均为米
 */
func calculateArea(width: Double, height: Double) throws -> Double {
    guard width >= 0 && height >= 0 else {
        throw GeometryError.invalidDimension
    }
    return width * height
}</code></pre>

                <h3>文档注释的效果</h3>
                <p>当你在Xcode中Option+点击一个使用文档注释的方法时，会显示类似下面的Quick Help：</p>
                
                <svg width="100%" height="250" viewBox="0 0 600 250">
                    <rect x="50" y="30" width="500" height="200" rx="10" ry="10" fill="#f5f5f5" stroke="#888888" stroke-width="2"/>
                    <text x="70" y="60" font-size="16" font-weight="bold" fill="#6200ee">calculateArea(width:height:)</text>
                    <line x1="70" y1="70" x2="530" y2="70" stroke="#888888" stroke-width="1"/>
                    <text x="70" y="90" font-size="14" fill="#000000">计算矩形的面积</text>
                    <text x="70" y="120" font-size="14" fill="#000000">Parameters:</text>
                    <text x="90" y="140" font-size="14" fill="#000000">- width: 矩形的宽度</text>
                    <text x="90" y="160" font-size="14" fill="#000000">- height: 矩形的高度</text>
                    <text x="70" y="190" font-size="14" fill="#000000">Returns: 矩形的面积</text>
                    <text x="70" y="210" font-size="14" fill="#000000">Throws: 如果宽度或高度为负值，抛出GeometryError.invalidDimension</text>
                </svg>
            </section>
            
            <section id="markdown" class="card">
                <h2>Markdown 支持</h2>
                <p>Swift 文档注释支持 Markdown 格式，让你的文档更加丰富和结构化：</p>
                
                <pre><code>/**
 # 地理计算工具
 
 提供各种几何图形的计算功能。
 
 ## 示例用法
 
 ```swift
 let area = try calculateArea(width: 10.0, height: 5.0)
 print(area) // 输出: 50.0
 ```
 
 ## 支持的形状
 
 * 矩形
 * 圆形
 * 三角形
 
 > 注意: 所有尺寸必须使用相同的度量单位。
 
 [查看更多信息](https://example.com/geometry)
 */
struct GeometryCalculator {
    // 实现...
}</code></pre>
                
                <h3>常用 Markdown 元素</h3>
                <div class="grid">
                    <div class="card">
                        <h4>格式化文本</h4>
                        <ul>
                            <li><code>**粗体**</code> 或 <code>__粗体__</code></li>
                            <li><code>*斜体*</code> 或 <code>_斜体_</code></li>
                            <li><code>`代码`</code></li>
                        </ul>
                    </div>
                    
                    <div class="card">
                        <h4>列表</h4>
                        <ul>
                            <li><code>* 无序列表项</code> 或 <code>- 无序列表项</code></li>
                            <li><code>1. 有序列表项</code></li>
                        </ul>
                    </div>
                    
                    <div class="card">
                        <h4>链接和图像</h4>
                        <ul>
                            <li><code>[链接文本](URL)</code></li>
                            <li><code>![图片描述](图片URL)</code></li>
                        </ul>
                    </div>
                    
                    <div class="card">
                        <h4>标题和引用</h4>
                        <ul>
                            <li><code># 一级标题</code> 到 <code>###### 六级标题</code></li>
                            <li><code>> 引用文本</code></li>
                        </ul>
                    </div>
                </div>
            </section>
            
            <section id="special" class="card">
                <h2>特殊注释标记</h2>
                <p>Swift 在 Xcode 中支持一些特殊注释标记，这些标记可以帮助组织代码并提高导航效率：</p>
                
                <div class="grid">
                    <div class="card">
                        <h4>MARK:</h4>
                        <p>用于在代码导航栏中添加标记，分隔不同的代码部分。</p>
                        <pre><code>// MARK: - 生命周期方法

override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
}

// MARK: - 私有方法

private func setupUI() {
    // UI 设置代码
}</code></pre>
                    </div>
                    
                    <div class="card">
                        <h4>TODO:</h4>
                        <p>标记需要完成的任务。</p>
                        <pre><code>// TODO: 实现缓存机制提高性能

func fetchData() {
    // 目前直接从网络加载
    networkManager.request(url: dataURL)
}</code></pre>
                    </div>
                    
                    <div class="card">
                        <h4>FIXME:</h4>
                        <p>标记需要修复的问题或错误。</p>
                        <pre><code>// FIXME: 在大数据集上有性能问题

func processItems(_ items: [Item]) {
    for item in items {
        // 低效的处理方法
        updateDatabase(with: item)
    }
}</code></pre>
                    </div>
                </div>
                
                <p>这些标记在 Xcode 的跳转菜单中显示为分隔符和条目：</p>
                
                <svg width="100%" height="200" viewBox="0 0 300 200">
                    <rect x="50" y="10" width="200" height="180" rx="5" ry="5" fill="#f5f5f5" stroke="#888888" stroke-width="1"/>
                    <rect x="50" y="10" width="200" height="25" rx="5" ry="5" fill="#e0e0e0" stroke="#888888" stroke-width="1"/>
                    <text x="150" y="27" text-anchor="middle" font-size="14" fill="#000000">跳转菜单</text>
                    
                    <line x1="50" y1="60" x2="250" y2="60" stroke="#888888" stroke-width="1"/>
                    <text x="60" y="50" font-size="12" fill="#888888">// MARK: - 生命周期方法</text>
                    <text x="70" y="75" font-size="12" fill="#000000">viewDidLoad()</text>
                    
                    <line x1="50" y1="100" x2="250" y2="100" stroke="#888888" stroke-width="1"/>
                    <text x="60" y="90" font-size="12" fill="#888888">// MARK: - 私有方法</text>
                    <text x="70" y="115" font-size="12" fill="#000000">setupUI()</text>
                    
                    <text x="70" y="140" font-size="12" fill="#FFB300">// TODO: 实现缓存机制</text>
                    <text x="70" y="165" font-size="12" fill="#F44336">// FIXME: 性能问题</text>
                </svg>
            </section>
            
            <section id="best-practices" class="card">
                <h2>注释最佳实践</h2>
                
                <div class="grid">
                    <div class="card">
                        <h4>什么时候使用注释</h4>
                        <ul>
                            <li>解释复杂的算法或业务逻辑</li>
                            <li>说明为什么选择特定实现方式</li>
                            <li>记录API用法和参数要求</li>
                            <li>标记临时解决方案和已知问题</li>
                        </ul>
                    </div>
                    
                    <div class="card">
                        <h4>什么时候避免注释</h4>
                        <ul>
                            <li>解释显而易见的代码</li>
                            <li>重复代码已经表达的内容</li>
                            <li>过时或不准确的信息</li>
                            <li>作为低质量代码的借口</li>
                        </ul>
                    </div>
                </div>
                
                <div class="tip">
                    <strong>原则：</strong> 优先使用自解释的代码，用注释解释"为什么"，而不是"是什么"。好的代码应该能够自我解释是做什么的，注释则应该解释为什么这样做或提供额外上下文。
                </div>
                
                <h3>示例：注释演进</h3>
                
                <div class="code-explanation">
                    <div class="code-part">
                        <pre><code>// 坏的注释
// 计算年龄
func calculateAge(birthDate: Date) -> Int {
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year],
                                              from: birthDate,
                                              to: Date())
    return ageComponents.year ?? 0
}

// 好的注释
/// 根据出生日期计算年龄（整数年）
/// - Parameter birthDate: 用户的出生日期
/// - Returns: 用户的年龄（周岁）
/// - Note: 只考虑已经过去的完整年数，不考虑月份和天数
func calculateAge(birthDate: Date) -> Int {
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year],
                                              from: birthDate,
                                              to: Date())
    return ageComponents.year ?? 0
}</code></pre>
                    </div>
                    <div class="explanation-part">
                        <h4>不良注释的问题：</h4>
                        <ul>
                            <li>仅重复了函数名称已经表达的信息</li>
                            <li>没有提供任何额外价值</li>
                            <li>缺乏参数和返回值的说明</li>
                        </ul>
                        
                        <h4>良好注释的优点：</h4>
                        <ul>
                            <li>使用文档注释格式（支持Quick Help）</li>
                            <li>明确说明参数和返回值</li>
                            <li>提供计算方式的额外信息</li>
                            <li>说明了可能的限制（只计算整数年份）</li>
                        </ul>
                    </div>
                </div>
            </section>
            
            <section id="resources" class="card">
                <h2>相关资源</h2>
                
                <h3>官方文档</h3>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html" target="_blank">Swift 官方编程指南</a></li>
                    <li><a href="https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/" target="_blank">Xcode 标记格式参考</a></li>
                    <li><a href="https://github.com/apple/swift/blob/main/docs/DocumentationComments.md" target="_blank">Swift 文档注释指南</a></li>
                </ul>
                
                <h3>推荐书籍</h3>
                <div class="grid">
                    <div class="resource-card card">
                        <h4>Swift 实战编程 (第三版)</h4>
                        <p>作者: Jon Hoffman</p>
                        <p>包含深入的Swift代码风格和文档化实践</p>
                    </div>
                    
                    <div class="resource-card card">
                        <h4>Swift 代码整洁之道</h4>
                        <p>作者: Robert C. Martin</p>
                        <p>探讨如何编写可维护的Swift代码，包括注释最佳实践</p>
                    </div>
                    
                    <div class="resource-card card">
                        <h4>Swift 进阶</h4>
                        <p>作者: Chris Eidhof, Ole Begemann</p>
                        <p>深入探讨Swift编程技巧和良好实践</p>
                    </div>
                </div>
                
                <h3>优秀博客和文章</h3>
                <ul>
                    <li><a href="https://nshipster.com/swift-documentation/" target="_blank">NSHipster: Swift 文档</a></li>
                    <li><a href="https://www.hackingwithswift.com/articles/148/xcode-power-user-tips-and-tricks" target="_blank">Hacking with Swift: Xcode注释技巧</a></li>
                    <li><a href="https://www.swiftbysundell.com/articles/documenting-swift-code/" target="_blank">Swift by Sundell: 文档化Swift代码</a></li>
                </ul>
                
                <h3>相关开源项目</h3>
                <div class="grid">
                    <div class="resource-card card">
                        <h4>Jazzy</h4>
                        <p><a href="https://github.com/realm/jazzy" target="_blank">GitHub 链接</a></p>
                        <p>从Swift代码和注释生成漂亮的文档网站</p>
                    </div>
                    
                    <div class="resource-card card">
                        <h4>SwiftLint</h4>
                        <p><a href="https://github.com/realm/SwiftLint" target="_blank">GitHub 链接</a></p>
                        <p>包含对注释格式和规范的检查规则</p>
                    </div>
                    
                    <div class="resource-card card">
                        <h4>Swift-DocC</h4>
                        <p><a href="https://github.com/apple/swift-docc" target="_blank">GitHub 链接</a></p>
                        <p>Apple官方的Swift和Objective-C文档编译器</p>
                    </div>
                </div>
            </section>
        </main>
    </div>

</body>
</html>
