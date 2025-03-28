<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift控制流 - if语句</title>
    <style>
        :root {
            --background: #2a1b3d;
            --text-color: #e0e0ff;
            --code-bg: #1d1429;
            --heading-color: #a991ff;
            --border-color: #7b52ab;
            --link-color: #ff8fa3;
            --box-shadow: 0 4px 0 #160d21;
        }
        
        @media (prefers-color-scheme: light) {
            :root {
                --background: #e6deff;
                --text-color: #2a1b3d;
                --code-bg: #d1c2ff;
                --heading-color: #4a2b7b;
                --border-color: #7b52ab;
                --link-color: #b73655;
                --box-shadow: 0 4px 0 #c9b6ff;
            }
        }
        
        * {
            box-sizing: border-box;
            image-rendering: pixelated;
        }
        
        body {
            background-color: var(--background);
            color: var(--text-color);
            font-family: 'Courier New', monospace;
            line-height: 1.6;
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem 1rem;
            font-size: 16px;
        }
        
        header {
            border-bottom: 4px solid var(--border-color);
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            text-align: center;
        }
        
        h1, h2, h3, h4 {
            color: var(--heading-color);
            font-family: 'Courier New', monospace;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 2rem;
            border-left: 8px solid var(--border-color);
            padding-left: 1rem;
        }
        
        h1 {
            font-size: 2.5rem;
            text-align: center;
            border: 4px solid var(--border-color);
            padding: 1rem;
            box-shadow: var(--box-shadow);
        }
        
        section {
            margin-bottom: 3rem;
            border: 4px solid var(--border-color);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
        }
        
        pre, code {
            font-family: 'Courier New', monospace;
            background-color: var(--code-bg);
            border-radius: 0;
            border: 2px solid var(--border-color);
        }
        
        code {
            padding: 0.2rem 0.4rem;
        }
        
        pre {
            padding: 1.5rem;
            overflow-x: auto;
            margin: 1.5rem 0;
        }
        
        pre code {
            border: none;
            padding: 0;
            background-color: transparent;
        }
        
        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 2px dashed var(--link-color);
            padding-bottom: 2px;
            transition: all 0.3s;
        }
        
        a:hover {
            border-bottom: 2px solid var(--link-color);
        }
        
        .resource-item {
            margin-bottom: 1rem;
            padding-left: 1rem;
            border-left: 4px solid var(--border-color);
        }
        
        .svg-container {
            display: flex;
            justify-content: center;
            margin: 2rem 0;
        }
        
        .code-description {
            margin-top: -1rem;
            margin-bottom: 1rem;
            font-style: italic;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
                font-size: 14px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            pre {
                padding: 1rem;
            }
            
            .svg-container svg {
                max-width: 100%;
                height: auto;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>SWIFT 控制流：IF 语句</h1>
        <p>掌握Swift条件执行的艺术</p>
    </header>
    
    <section>
        <h2>IF语句简介</h2>
        <p>Swift中的if语句允许我们根据特定条件执行不同的代码块。这是程序逻辑控制的基础，让代码能够根据不同情况做出相应的反应。</p>
        
        <div class="svg-container">
            <svg width="500" height="200" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .flowchart-text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                    .flowchart-box { fill: var(--code-bg); stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-line { stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-decision { fill: #5c3e7d; stroke: var(--border-color); stroke-width: 3; }
                </style>
                
                <!-- 开始节点 -->
                <rect class="flowchart-box" x="200" y="10" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="250" y="35" text-anchor="middle">开始</text>
                
                <!-- 条件判断 -->
                <polygon class="flowchart-decision" points="250,80 300,120 250,160 200,120"/>
                <text class="flowchart-text" x="250" y="125" text-anchor="middle">条件?</text>
                
                <!-- 箭头 -->
                <line class="flowchart-line" x1="250" y1="50" x2="250" y2="80"/>
                <line class="flowchart-line" x1="300" y1="120" x2="350" y2="120"/>
                <line class="flowchart-line" x1="200" y1="120" x2="150" y2="120"/>
                
                <!-- 是/否标签 -->
                <text class="flowchart-text" x="325" y="110" text-anchor="middle">是</text>
                <text class="flowchart-text" x="175" y="110" text-anchor="middle">否</text>
                
                <!-- 执行框 -->
                <rect class="flowchart-box" x="350" y="100" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="400" y="125" text-anchor="middle">执行代码</text>
                
                <!-- 跳过框 -->
                <rect class="flowchart-box" x="50" y="100" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="100" y="125" text-anchor="middle">跳过</text>
            </svg>
        </div>
    </section>
    
    <section>
        <h2>单分支 IF</h2>
        <p>最基本的if语句只在条件为true时执行代码块。如果条件是false，代码块会被跳过。</p>
        
        <div class="svg-container">
            <svg width="300" height="240" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .flowchart-text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                    .flowchart-box { fill: var(--code-bg); stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-line { stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-decision { fill: #5c3e7d; stroke: var(--border-color); stroke-width: 3; }
                </style>
                
                <!-- 条件判断 -->
                <polygon class="flowchart-decision" points="150,40 200,80 150,120 100,80"/>
                <text class="flowchart-text" x="150" y="85" text-anchor="middle">条件?</text>
                
                <!-- 箭头 -->
                <line class="flowchart-line" x1="150" y1="10" x2="150" y2="40"/>
                <line class="flowchart-line" x1="150" y1="120" x2="150" y2="150"/>
                <line class="flowchart-line" x1="200" y1="80" x2="240" y2="80"/>
                <line class="flowchart-line" x1="240" y1="80" x2="240" y2="150"/>
                <line class="flowchart-line" x1="240" y1="150" x2="150" y2="150"/>
                
                <!-- 执行框 -->
                <rect class="flowchart-box" x="100" y="150" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="150" y="175" text-anchor="middle">执行代码</text>
                
                <!-- 是/否标签 -->
                <text class="flowchart-text" x="225" y="70" text-anchor="middle">是</text>
                <text class="flowchart-text" x="125" y="135" text-anchor="middle">否</text>
                
                <!-- 继续 -->
                <line class="flowchart-line" x1="150" y1="190" x2="150" y2="220"/>
                <text class="flowchart-text" x="150" y="235" text-anchor="middle">继续</text>
            </svg>
        </div>
        
        <pre><code>// 单分支if语句
let temperature = 25

if temperature > 20 {
    // 只有当temperature大于20时，这段代码才会执行
    print("今天天气不错，可以出去走走")
}

print("程序继续执行") // 无论if条件是否成立，这行代码都会执行</code></pre>
        
        <p class="code-description">在这个例子中，当温度大于20度时，会打印出提示信息。</p>
    </section>
    
    <section>
        <h2>IF-ELSE 语句</h2>
        <p>if-else语句提供了两个分支，当条件为true时执行一个代码块，为false时执行另一个代码块。</p>
        
        <div class="svg-container">
            <svg width="400" height="280" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .flowchart-text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                    .flowchart-box { fill: var(--code-bg); stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-line { stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-decision { fill: #5c3e7d; stroke: var(--border-color); stroke-width: 3; }
                </style>
                
                <!-- 条件判断 -->
                <polygon class="flowchart-decision" points="200,40 250,80 200,120 150,80"/>
                <text class="flowchart-text" x="200" y="85" text-anchor="middle">条件?</text>
                
                <!-- 箭头 -->
                <line class="flowchart-line" x1="200" y1="10" x2="200" y2="40"/>
                <line class="flowchart-line" x1="250" y1="80" x2="300" y2="80"/>
                <line class="flowchart-line" x1="150" y1="80" x2="100" y2="80"/>
                
                <!-- 是/否标签 -->
                <text class="flowchart-text" x="275" y="70" text-anchor="middle">是</text>
                <text class="flowchart-text" x="125" y="70" text-anchor="middle">否</text>
                
                <!-- 执行框 -->
                <rect class="flowchart-box" x="300" y="60" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="350" y="85" text-anchor="middle">if代码块</text>
                
                <!-- else框 -->
                <rect class="flowchart-box" x="0" y="60" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="50" y="85" text-anchor="middle">else代码块</text>
                
                <!-- 合并路径 -->
                <line class="flowchart-line" x1="350" y1="100" x2="350" y2="150"/>
                <line class="flowchart-line" x1="50" y1="100" x2="50" y2="150"/>
                <line class="flowchart-line" x1="50" y1="150" x2="200" y2="150"/>
                <line class="flowchart-line" x1="350" y1="150" x2="200" y2="150"/>
                
                <!-- 继续 -->
                <line class="flowchart-line" x1="200" y1="150" x2="200" y2="180"/>
                <rect class="flowchart-box" x="150" y="180" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="200" y="205" text-anchor="middle">继续执行</text>
            </svg>
        </div>
        
        <pre><code>// if-else语句
let hour = 20

if hour < 12 {
    // 当hour小于12时执行
    print("上午好！")
} else {
    // 当hour大于等于12时执行
    print("下午好或晚上好！")
}

// 输出将是"下午好或晚上好！"，因为hour是20</code></pre>
        
        <p class="code-description">在这个例子中，根据当前小时数判断是上午还是下午/晚上，并打印相应的问候语。</p>
    </section>
    
    <section>
        <h2>多分支 IF-ELSE IF-ELSE</h2>
        <p>当需要检查多个条件时，可以使用if-else if-else结构。条件会按照顺序检查，一旦某个条件满足，相应的代码块会执行，然后跳过其余条件。</p>
        
        <div class="svg-container">
            <svg width="500" height="380" xmlns="http://www.w3.org/2000/svg">
                <style>
                    .flowchart-text { fill: var(--text-color); font-family: 'Courier New', monospace; font-size: 14px; }
                    .flowchart-box { fill: var(--code-bg); stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-line { stroke: var(--border-color); stroke-width: 3; }
                    .flowchart-decision { fill: #5c3e7d; stroke: var(--border-color); stroke-width: 3; }
                </style>
                
                <!-- 第一个条件 -->
                <polygon class="flowchart-decision" points="250,40 300,70 250,100 200,70"/>
                <text class="flowchart-text" x="250" y="75" text-anchor="middle">条件1?</text>
                
                <!-- 第二个条件 -->
                <polygon class="flowchart-decision" points="250,140 300,170 250,200 200,170"/>
                <text class="flowchart-text" x="250" y="175" text-anchor="middle">条件2?</text>
                
                <!-- 箭头 -->
                <line class="flowchart-line" x1="250" y1="10" x2="250" y2="40"/>
                <line class="flowchart-line" x1="300" y1="70" x2="350" y2="70"/>
                <line class="flowchart-line" x1="250" y1="100" x2="250" y2="140"/>
                <line class="flowchart-line" x1="300" y1="170" x2="350" y2="170"/>
                <line class="flowchart-line" x1="250" y1="200" x2="250" y2="240"/>
                
                <!-- 是/否标签 -->
                <text class="flowchart-text" x="325" y="60" text-anchor="middle">是</text>
                <text class="flowchart-text" x="260" y="120" text-anchor="middle">否</text>
                <text class="flowchart-text" x="325" y="160" text-anchor="middle">是</text>
                <text class="flowchart-text" x="260" y="220" text-anchor="middle">否</text>
                
                <!-- 执行框 -->
                <rect class="flowchart-box" x="350" y="50" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="400" y="75" text-anchor="middle">if代码块</text>
                
                <!-- else if框 -->
                <rect class="flowchart-box" x="350" y="150" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="400" y="175" text-anchor="middle">else if代码块</text>
                
                <!-- else框 -->
                <rect class="flowchart-box" x="200" y="240" width="100" height="40" rx="0" ry="0"/>
                <text class="flowchart-text" x="250" y="265" text-anchor="middle">else代码块</text>
                
                <!-- 合并路径 -->
                <line class="flowchart-line" x1="400" y1="90" x2="400" y2="300"/>
                <line class="flowchart-line" x1="400" y1="190" x2="400" y2="300"/>
                <line class="flowchart-line" x1="250" y1="280" x2="250" y2="300"/>
                <line class="flowchart-line" x1="250" y1="300" x2="400" y2="300"/>
                
                <!-- 继续 -->
                <line class="flowchart-line" x1="250" y1="300" x2="250" y2="330"/>
                <text class="flowchart-text" x="250" y="345" text-anchor="middle">继续</text>
            </svg>
        </div>
        
        <pre><code>// 多分支if-else if-else结构
let score = 85

if score >= 90 {
    // 当score大于等于90时执行
    print("优秀！A等级")
} else if score >= 80 {
    // 当score大于等于80且小于90时执行
    print("良好！B等级")
} else if score >= 70 {
    // 当score大于等于70且小于80时执行
    print("中等！C等级")
} else if score >= 60 {
    // 当score大于等于60且小于70时执行
    print("及格！D等级")
} else {
    // 当score小于60时执行
    print("不及格！F等级")
}

// 输出将是"良好！B等级"，因为score是85</code></pre>
        
        <p class="code-description">在这个例子中，根据分数的不同范围，程序会判断并输出相应的等级评价。</p>
    </section>
    
    <section>
        <h2>嵌套 IF 语句</h2>
        <p>if语句可以嵌套在另一个if或else代码块中，创建更复杂的条件逻辑。</p>
        
        <pre><code>// 嵌套if语句
let age = 25
let hasLicense = true

if age >= 18 {
    // 外部if：检查年龄是否达到驾驶要求
    print("年龄符合驾驶要求")
    
    if hasLicense {
        // 内部if：检查是否有驾照
        print("您可以驾驶车辆")
    } else {
        print("您需要先获取驾照")
    }
} else {
    print("您年龄不符合驾驶要求")
}

// 输出将是：
// 年龄符合驾驶要求
// 您可以驾驶车辆</code></pre>
        
        <p class="code-description">这个例子使用嵌套if语句，先检查是否满足年龄要求，然后再检查是否拥有驾照，从而判断一个人是否可以合法驾驶。</p>
    </section>
    
    <section>
        <h2>条件运算符</h2>
        <p>Swift提供了条件运算符（三元运算符）作为if-else语句的简洁替代，格式为：<code>条件 ? 表达式1 : 表达式2</code></p>
        
        <pre><code>// 条件运算符（三元运算符）
let age = 20
let status = age >= 18 ? "成年人" : "未成年人"

// 等价于：
// let status: String
// if age >= 18 {
//     status = "成年人"
// } else {
//     status = "未成年人"
// }

print(status) // 输出："成年人"</code></pre>
        
        <p class="code-description">条件运算符提供了一种简洁的方式来根据条件赋值。在这个例子中，如果年龄大于等于18，则status为"成年人"，否则为"未成年人"。</p>
    </section>
    
    <section>
        <h2>结合 Guard 语句</h2>
        <p>Swift的guard语句是if语句的一种补充，它可以提早退出函数或循环，帮助减少嵌套和提高代码可读性。</p>
        
        <pre><code>// guard语句与if的对比
func processUser(name: String?, age: Int?) {
    // 使用guard进行早期返回
    guard let name = name else {
        print("名字不能为空")
        return
    }
    
    guard let age = age, age >= 18 else {
        print("用户必须年满18岁")
        return
    }
    
    print("欢迎 \(name)，您已通过验证")
    
    // 这里可以安全地使用name和age，因为它们已经被解包并验证
}

// 使用示例
processUser(name: "张三", age: 25)  // 输出：欢迎 张三，您已通过验证
processUser(name: nil, age: 20)    // 输出：名字不能为空
processUser(name: "李四", age: 16)  // 输出：用户必须年满18岁</code></pre>
        
        <p class="code-description">guard语句检查条件是否为false，如果为false则执行else块中的代码（通常包含return、break或continue语句）。如果条件为true，则继续执行guard语句后的代码。</p>
    </section>
    
    <section>
        <h2>实际应用示例</h2>
        
        <pre><code>// 用户登录验证
func validateLogin(username: String?, password: String?) -> Bool {
    // 检查用户名是否为空
    if username == nil || username!.isEmpty {
        print("错误：用户名不能为空")
        return false
    }
    
    // 检查密码是否为空
    if password == nil || password!.isEmpty {
        print("错误：密码不能为空")
        return false
    }
    
    // 检查用户名长度
    if username!.count < 4 {
        print("错误：用户名长度不能少于4个字符")
        return false
    }
    
    // 检查密码长度
    if password!.count < 8 {
        print("错误：密码长度不能少于8个字符")
        return false
    }
    
    // 检查密码是否包含数字和字母（简化版）
    let containsNumber = password!.contains { $0.isNumber }
    let containsLetter = password!.contains { $0.isLetter }
    
    if !containsNumber || !containsLetter {
        print("错误：密码必须包含数字和字母")
        return false
    }
    
    // 所有验证通过
    print("登录验证成功")
    return true
}

// 使用示例
validateLogin(username: "user", password: "password123")  // 成功
validateLogin(username: "abc", password: "password123")  // 失败：用户名长度不足
validateLogin(username: "user", password: "12345")  // 失败：密码长度不足</code></pre>
        
        <p class="code-description">这个例子展示了如何使用if语句进行用户登录时的各种验证，包括检查字段是否为空、长度是否符合要求以及密码复杂度是否满足标准。</p>
    </section>
    
    <section>
        <h2>参考资源</h2>
        
        <h3>官方文档</h3>
        <div class="resource-item">
            <a href="https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html" target="_blank">Swift官方文档：控制流</a>
            <p>Apple官方Swift编程语言指南中关于控制流的详细说明。</p>
        </div>
        
        <h3>博客文章</h3>
        <div class="resource-item">
            <a href="https://www.hackingwithswift.com/read/0/9/conditional-statements" target="_blank">Hacking with Swift: 条件语句</a>
            <p>Paul Hudson撰写的关于Swift条件语句的详细教程。</p>
        </div>
        <div class="resource-item">
            <a href="https://www.swiftbysundell.com/articles/the-power-of-if-let-and-guard-let/" target="_blank">Swift by Sundell: if-let和guard-let的力量</a>
            <p>探索Swift中if-let和guard-let条件绑定的使用与比较。</p>
        </div>
        
        <h3>相关书籍</h3>
        <div class="resource-item">
            <p><strong>Swift编程（第二版）</strong> - 作者：Chris Lattner</p>
            <p>Swift语言创造者撰写的权威指南，包含详细的控制流讲解。</p>
        </div>
        <div class="resource-item">
            <p><strong>iOS编程（第7版）</strong> - 作者：Christian Keur, Aaron Hillegass</p>
            <p>包含Swift控制流和iOS开发实践的综合教程。</p>
        </div>
        
        <h3>视频教程</h3>
        <div class="resource-item">
            <a href="https://www.youtube.com/watch?v=nF8dZR1znHU" target="_blank">Stanford CS193p: Swift控制流</a>
            <p>斯坦福大学iOS开发课程中关于Swift控制流的讲座。</p>
        </div>
        <div class="resource-item">
            <a href="https://www.raywenderlich.com/courses" target="_blank">raywenderlich.com Swift视频教程</a>
            <p>包含详细Swift控制流讲解的高质量视频系列。</p>
        </div>
        
        <h3>开源项目示例</h3>
        <div class="resource-item">
            <a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms</a>
            <p>苹果官方Swift算法库，包含许多if语句和控制流的实际应用。</p>
        </div>
        <div class="resource-item">
            <a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a>
            <p>流行的Swift网络库，其中包含大量条件控制流的实际应用。</p>
        </div>
    </section>

</body>
</html>
