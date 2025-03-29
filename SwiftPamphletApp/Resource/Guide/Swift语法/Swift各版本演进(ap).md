<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift语言版本演进</title>
    <style>
        :root {
            --primary-color: #b19cd9;
            --secondary-color: #f8bbd0;
            --accent-color: #a5d6d9;
            --mint-color: #c5e8d5;
            --text-color: #333;
            --bg-color: #fff;
            --code-bg: #f7f5fa;
            --card-bg: rgba(255, 255, 255, 0.8);
            --shadow-color: rgba(0, 0, 0, 0.05);
            --heading-color: #8a6bab;
            --link-color: #9370DB;
            --border-color: #e5dbf2;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-color: #9d86c3;
                --secondary-color: #d999b3;
                --accent-color: #87b8bb;
                --mint-color: #a5c8b5;
                --text-color: #e0e0e0;
                --bg-color: #121212;
                --code-bg: #282a36;
                --card-bg: rgba(30, 30, 30, 0.8);
                --shadow-color: rgba(0, 0, 0, 0.2);
                --heading-color: #c4a9e7;
                --link-color: #bb9cff;
                --border-color: #534868;
            }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            color: var(--text-color);
            background-color: var(--bg-color);
            line-height: 1.6;
            padding: 0;
            margin: 0;
            transition: background-color 0.3s ease;
            background-image:
                radial-gradient(circle at 10% 20%, rgba(177, 156, 217, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(197, 232, 213, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 50% 50%, rgba(165, 214, 217, 0.05) 0%, transparent 70%);
            background-attachment: fixed;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        header {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem 0;
            position: relative;
            overflow: hidden;
        }

        header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(177, 156, 217, 0.2), rgba(248, 187, 208, 0.2));
            z-index: -1;
            border-radius: 0 0 50% 50% / 15%;
        }

        h1 {
            font-size: 3rem;
            color: var(--heading-color);
            margin-bottom: 1rem;
            font-weight: 600;
            letter-spacing: 1px;
        }

        h2 {
            font-size: 2.2rem;
            color: var(--heading-color);
            margin: 2.5rem 0 1.5rem;
            font-weight: 500;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
        }

        h3 {
            font-size: 1.8rem;
            color: var(--heading-color);
            margin: 2rem 0 1rem;
            font-weight: 500;
        }

        p {
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dashed var(--link-color);
            transition: all 0.3s ease;
        }

        a:hover {
            color: var(--primary-color);
            border-bottom: 1px solid var(--primary-color);
        }

        .version-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 10px 30px var(--shadow-color);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(var(--primary-color), 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .version-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px var(--shadow-color);
        }

        .version-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .version-tag {
            background: var(--primary-color);
            color: white;
            border-radius: 20px;
            padding: 0.3rem 1rem;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .release-date {
            color: var(--text-color);
            opacity: 0.7;
            font-size: 0.9rem;
        }

        .feature-list {
            list-style-type: none;
            margin: 1.5rem 0;
            padding-left: 1rem;
        }

        .feature-list li {
            margin-bottom: 0.7rem;
            position: relative;
            padding-left: 1.5rem;
        }

        .feature-list li::before {
            content: "•";
            color: var(--accent-color);
            font-size: 1.5rem;
            position: absolute;
            left: 0;
            top: -0.1rem;
        }

        pre {
            background-color: var(--code-bg);
            border-radius: 10px;
            padding: 1.5rem;
            overflow-x: auto;
            margin: 1.5rem 0;
            border-left: 4px solid var(--primary-color);
            font-family: 'Menlo', 'Monaco', 'Courier New', monospace;
            font-size: 0.9rem;
            line-height: 1.5;
            position: relative;
        }

        code {
            font-family: 'Menlo', 'Monaco', 'Courier New', monospace;
            padding: 0.2rem 0.4rem;
            background: var(--code-bg);
            border-radius: 4px;
            font-size: 0.9rem;
        }

        pre code {
            background: transparent;
            padding: 0;
            border-radius: 0;
        }

        .code-title {
            position: absolute;
            top: 0;
            right: 1rem;
            background: var(--primary-color);
            color: white;
            padding: 0.2rem 0.7rem;
            border-radius: 0 0 5px 5px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .resources {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            margin-top: 3rem;
            box-shadow: 0 10px 30px var(--shadow-color);
            backdrop-filter: blur(10px);
        }

        .resource-group {
            margin-bottom: 2rem;
        }

        .resource-list {
            list-style-type: none;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            grid-gap: 1rem;
            margin-top: 1rem;
        }

        .resource-item {
            background: rgba(var(--bg-color), 0.5);
            border-radius: 10px;
            padding: 1rem;
            transition: transform 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .resource-item:hover {
            transform: translateY(-3px);
        }

        .svg-container {
            width: 100%;
            margin: 2rem 0;
            text-align: center;
        }

        .svg-container svg {
            max-width: 100%;
            height: auto;
        }

        .note {
            background: rgba(var(--accent-color), 0.1);
            border-left: 4px solid var(--accent-color);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 5px;
        }

        .note-title {
            font-weight: 600;
            color: var(--accent-color);
            margin-bottom: 0.5rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            h1 {
                font-size: 2.2rem;
            }

            h2 {
                font-size: 1.8rem;
            }

            h3 {
                font-size: 1.5rem;
            }

            .version-card {
                padding: 1.5rem;
            }

            .resource-list {
                grid-template-columns: 1fr;
            }
        }

        footer {
            text-align: center;
            margin-top: 4rem;
            padding: 2rem 0;
            color: var(--text-color);
            opacity: 0.7;
            font-size: 0.9rem;
            border-top: 1px solid var(--border-color);
        }

        .run-button {
            background: var(--accent-color);
            color: var(--bg-color);
            border: none;
            border-radius: 5px;
            padding: 0.4rem 1rem;
            cursor: pointer;
            font-weight: 500;
            margin-top: 0.5rem;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .run-button:hover {
            background: var(--primary-color);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Swift语言版本演进</h1>
            <p>从Swift 1.0到最新版本的完整演进历程</p>
        </header>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 1.0 - 初次亮相</h2>
                <span class="version-tag">Swift 1.0</span>
            </div>
            <div class="release-date">发布日期：2014年6月2日</div>

            <p>2014年，Apple在WWDC上首次发布Swift编程语言，为iOS和macOS开发提供了全新的现代编程语言选择。Swift旨在取代Objective-C，提供更安全、更快速的开发体验。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>类型安全和类型推断</li>
                <li>可选类型（Optionals）</li>
                <li>闭包（Closures）</li>
                <li>命名空间</li>
                <li>元组（Tuples）</li>
                <li>快速的编译期性能</li>
            </ul>

            <h3>代码示例：可选类型</h3>
            <pre><code>// Swift的可选类型示例
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // convertedNumber 的类型是 Int?

// 使用if let解包可选类型
if let actualNumber = convertedNumber {
    print("字符串转换为数字: \(actualNumber)")
} else {
    print("字符串不包含有效数字")
}

// 使用!强制解包（不安全）
let forcedNumber = convertedNumber! // 如果convertedNumber为nil，会引起运行时错误</code></pre>

            <div class="svg-container">
                <svg width="600" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
                    <rect x="50" y="80" width="500" height="40" rx="20" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="105" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">变量值</text>
                    <rect x="50" y="30" width="500" height="40" rx="20" fill="#fce4ec" stroke="#f8bbd0" stroke-width="2"/>
                    <text x="300" y="55" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">Optional&lt;T&gt;</text>
                    <path d="M300,70 L300,80" stroke="#333" stroke-width="2" stroke-dasharray="5,5"/>
                    <path d="M280,130 L280,170 L320,170 L320,130" stroke="#a5d6d9" stroke-width="2" fill="none"/>
                    <text x="300" y="190" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">nil 表示没有值</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 2.0 - 增强安全与性能</h2>
                <span class="version-tag">Swift 2.0</span>
            </div>
            <div class="release-date">发布日期：2015年6月8日</div>

            <p>Swift 2.0增强了安全特性，改进了错误处理，并增加了更多语言功能，使开发人员能够编写更加健壮的代码。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>新的错误处理模型（try/catch）</li>
                <li>guard语句</li>
                <li>协议扩展（Protocol Extensions）</li>
                <li>可用性检查（availability checking）</li>
                <li>模式匹配增强</li>
                <li>改进的编译器性能</li>
            </ul>

            <h3>代码示例：错误处理与Guard语句</h3>
            <pre><code>// Swift 2.0中的错误处理
enum PasswordError: Error {
    case tooShort
    case noUppercaseLetter
    case noSpecialCharacter
}

func validatePassword(_ password: String) throws -> Bool {
    // 使用guard语句进行早期返回
    guard password.count >= 8 else {
        throw PasswordError.tooShort
    }

    guard password.contains(where: { $0.isUppercase }) else {
        throw PasswordError.noUppercaseLetter
    }

    let specialCharacters = "!@#$%^&*()_-+=[]{}|:;'\"\\/?,.<>"
    guard password.contains(where: { specialCharacters.contains($0) }) else {
        throw PasswordError.noSpecialCharacter
    }

    return true
}

// 调用可能抛出错误的函数
do {
    let passwordIsValid = try validatePassword("password")
    print("密码有效")
} catch PasswordError.tooShort {
    print("密码太短")
} catch PasswordError.noUppercaseLetter {
    print("密码需要包含大写字母")
} catch PasswordError.noSpecialCharacter {
    print("密码需要包含特殊字符")
} catch {
    print("验证失败: \(error)")
}</code></pre>

            <div class="svg-container">
                <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                    <rect x="200" y="20" width="200" height="50" rx="10" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="50" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">函数开始</text>
                    <path d="M300,70 L300,90" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="200" y="90" width="200" height="50" rx="10" fill="#fce4ec" stroke="#f8bbd0" stroke-width="2"/>
                    <text x="300" y="120" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">guard 条件检查</text>
                    <path d="M400,115 L450,115 L450,180" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="470" y="140" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">条件不满足</text>

                    <path d="M300,140 L300,160" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="250" y="155" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">条件满足</text>

                    <rect x="200" y="160" width="200" height="50" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="300" y="190" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">继续执行</text>

                    <rect x="400" y="180" width="150" height="50" rx="10" fill="#ffcdd2" stroke="#ef9a9a" stroke-width="2"/>
                    <text x="475" y="210" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">抛出错误</text>

                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="#333"/>
                        </marker>
                    </defs>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 3.0 - API设计指南</h2>
                <span class="version-tag">Swift 3.0</span>
            </div>
            <div class="release-date">发布日期：2016年9月13日</div>

            <p>Swift 3.0是一个重大更新，破坏了向后兼容性，但带来了更一致的API设计。这个版本专注于建立Swift作为一种开源语言的基础，并统一了核心库和API设计。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>API命名规范大改（去掉了很多NS前缀）</li>
                <li>移除了C风格的for循环</li>
                <li>函数参数标签改进</li>
                <li>GCD和Core Graphics API现代化</li>
                <li>移除了++ 和 -- 操作符</li>
                <li>改进了泛型系统</li>
            </ul>

            <h3>代码示例：API命名变化</h3>
            <pre><code>// Swift 2.0 写法
let blue = UIColor.blueColor()
let min = CGRectGetMinX(rect)
dispatch_async(dispatch_get_main_queue()) {
    // 执行操作
}

// Swift 3.0 写法
let blue = UIColor.blue
let min = rect.minX
DispatchQueue.main.async {
    // 执行操作
}
</code></pre>

            <div class="svg-container">
                <svg width="600" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
                    <rect x="50" y="50" width="500" height="40" rx="10" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="120" y="75" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">Swift 2.0</text>
                    <text x="350" y="75" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">NSData.dataWithContentsOfURL(url)</text>

                    <path d="M300,90 L300,110" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="50" y="110" width="500" height="40" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="120" y="135" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">Swift 3.0</text>
                    <text x="350" y="135" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">Data(contentsOf: url)</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 4.0 - 源代码稳定性</h2>
                <span class="version-tag">Swift 4.0</span>
            </div>
            <div class="release-date">发布日期：2017年9月19日</div>

            <p>Swift 4.0主要致力于ABI稳定性（虽然尚未完全实现），增强了语言功能，改进了字符串实现，并添加了序列化能力。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>改进的String实现（重新成为Collection）</li>
                <li>新的Codable协议，用于JSON和PropertyList的编码和解码</li>
                <li>新的Dictionary和Set API</li>
                <li>多行字符串字面量</li>
                <li>私有访问权限修改（private和fileprivate的区分）</li>
                <li>Key Paths 和 Smart Key Paths</li>
            </ul>

            <h3>代码示例：Codable和多行字符串</h3>
            <pre><code>// Swift 4.0 中的 Codable 协议
struct Person: Codable {
    var name: String
    var age: Int
    var email: String
}

// 编码为JSON
let person = Person(name: "张三", age: 28, email: "zhangsan@example.com")
let encoder = JSONEncoder()
if let jsonData = try? encoder.encode(person) {
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString) // {"name":"张三","age":28,"email":"zhangsan@example.com"}
    }
}

// 多行字符串字面量
let poem = """
    春眠不觉晓，
    处处闻啼鸟。
    夜来风雨声，
    花落知多少。
    """
print(poem)</code></pre>

            <div class="svg-container">
                <svg width="600" height="260" viewBox="0 0 600 260" xmlns="http://www.w3.org/2000/svg">
                    <rect x="100" y="20" width="400" height="50" rx="10" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="50" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">Swift对象</text>

                    <path d="M300,70 L300,100" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="340" y="90" text-anchor="start" font-family="Arial" font-size="14" fill="#333">JSONEncoder</text>

                    <rect x="100" y="100" width="400" height="50" rx="10" fill="#fce4ec" stroke="#f8bbd0" stroke-width="2"/>
                    <text x="300" y="130" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">JSON数据</text>

                    <path d="M200,150 L200,180" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <path d="M400,150 L400,180" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="150" y="170" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">发送网络</text>
                    <text x="450" y="170" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">存储文件</text>

                    <rect x="100" y="180" width="200" height="50" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="200" y="210" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">API服务器</text>

                    <rect x="300" y="180" width="200" height="50" rx="10" fill="#c5e8d5" stroke="#a5c8b5" stroke-width="2"/>
                    <text x="400" y="210" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">本地存储</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.0 - ABI稳定性</h2>
                <span class="version-tag">Swift 5.0</span>
            </div>
            <div class="release-date">发布日期：2019年3月25日</div>

            <p>Swift 5.0是一个里程碑式的版本，实现了ABI稳定性，这意味着Swift运行时现在已经包含在了操作系统中，这大大减小了应用程序的体积。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>ABI稳定性</li>
                <li>新的String API</li>
                <li>Raw字符串（可以包含引号和反斜杠）</li>
                <li>动态可调用类型（dynamicCallable）</li>
                <li>Result类型</li>
                <li>性能优化</li>
                <li>新的Unicode支持</li>
            </ul>

            <h3>代码示例：Result类型和Raw字符串</h3>
            <pre><code>// Swift 5.0 中的 Result 类型
enum NetworkError: Error {
    case badURL
    case serverError(Int)
    case noData
}

func fetchData(from urlString: String, completion: @escaping (Result&lt;Data, NetworkError&gt;) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(.badURL))
        return
    }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            completion(.failure(.serverError(httpResponse.statusCode)))
            return
        }

        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(.noData))
        }
    }.resume()
}

// 使用Result类型
fetchData(from: "https://api.example.com/data") { result in
    switch result {
    case .success(let data):
        print("获取数据成功: \(data)")
    case .failure(let error):
        switch error {
        case .badURL:
            print("URL无效")
        case .serverError(let code):
            print("服务器错误: \(code)")
        case .noData:
            print("没有数据")
        }
    }
}

// Raw字符串
let regex = #"\\d{3}-\\d{2}-\\d{4}"#
print(regex) // 输出: \d{3}-\d{2}-\d{4}
</code></pre>

            <div class="svg-container">
                <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                    <rect x="150" y="30" width="300" height="60" rx="10" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="50" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">Result&lt;Success, Failure&gt;</text>
                    <line x1="150" y1="65" x2="450" y2="65" stroke="#b19cd9" stroke-width="1" />
                    <text x="300" y="80" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">一种表示成功或失败的枚举类型</text>

                    <path d="M225,90 L225,120" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <path d="M375,90 L375,120" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="100" y="120" width="200" height="50" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="200" y="150" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">.success(Value)</text>

                    <rect x="300" y="120" width="200" height="50" rx="10" fill="#fce4ec" stroke="#f8bbd0" stroke-width="2"/>
                    <text x="400" y="150" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">.failure(Error)</text>

                    <path d="M200,170 L200,200" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <path d="M400,170 L400,200" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="100" y="200" width="200" height="40" rx="10" fill="#c5e8d5" stroke="#a5c8b5" stroke-width="2"/>
                    <text x="200" y="225" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">处理成功结果</text>

                    <rect x="300" y="200" width="200" height="40" rx="10" fill="#ffcdd2" stroke="#ef9a9a" stroke-width="2"/>
                    <text x="400" y="225" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">处理错误情况</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.1 - 模块稳定性</h2>
                <span class="version-tag">Swift 5.1</span>
            </div>
            <div class="release-date">发布日期：2019年9月10日</div>

            <p>Swift 5.1引入了模块稳定性，为Swift包管理器（SPM）提供二进制框架分发的支持，并添加了一些重要的语法特性。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>模块稳定性</li>
                <li>函数返回的不透明类型（opaque return types）</li>
                <li>属性包装器（Property Wrappers）</li>
                <li>静态和类订阅（static and class subscripts）</li>
                <li>隐式返回表达式（单表达式函数可省略return）</li>
                <li>Universal Self</li>
            </ul>

            <h3>代码示例：属性包装器和隐式返回</h3>
            <pre><code>// Swift 5.1 属性包装器
@propertyWrapper
struct UserDefaultsBacked&lt;T&gt; {
    let key: String
    let defaultValue: T
    let storage: UserDefaults

    init(wrappedValue defaultValue: T, key: String, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            storage.object(forKey: key) as? T ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key)
        }
    }
}

class Settings {
    @UserDefaultsBacked(key: "username", defaultValue: "")
    var username: String

    @UserDefaultsBacked(key: "isFirstLaunch", defaultValue: true)
    var isFirstLaunch: Bool
}

// Swift 5.1 隐式返回
// 之前
func square(number: Int) -> Int {
    return number * number
}

// Swift 5.1
func square(number: Int) -> Int {
    number * number  // 隐式返回
}</code></pre>

            <div class="svg-container">
                <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                    <rect x="150" y="20" width="300" height="60" rx="10" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="50" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">@propertyWrapper</text>
                    <text x="300" y="70" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">定义属性包装器</text>

                    <path d="M300,80 L300,110" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="150" y="110" width="300" height="60" rx="10" fill="#fce4ec" stroke="#f8bbd0" stroke-width="2"/>
                    <text x="300" y="135" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">struct UserDefaultsBacked&lt;T&gt;</text>
                    <text x="300" y="155" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">包含wrappedValue的读写逻辑</text>

                    <path d="M300,170 L300,200" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="150" y="200" width="300" height="40" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="300" y="225" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">@UserDefaultsBacked var username: String</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.5 - 异步编程</h2>
                <span class="version-tag">Swift 5.5</span>
            </div>
            <div class="release-date">发布日期：2021年9月20日</div>

            <p>Swift 5.5带来了期待已久的并发编程模型，引入了async/await语法，actor模型和结构化并发，彻底改变了Swift中的异步编程方式。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>async/await</li>
                <li>Actor模型</li>
                <li>结构化并发（TaskGroup）</li>
                <li>异步序列</li>
                <li>全局 actors</li>
                <li>@MainActor 属性包装器</li>
                <li>连续性委托</li>
            </ul>

            <h3>代码示例：async/await和Actor</h3>
            <pre><code>// Swift 5.5 中的 async/await
func fetchUserData() async throws -> User {
    let url = URL(string: "https://api.example.com/user")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(User.self, from: data)
}

// 调用异步函数
Task {
    do {
        let user = try await fetchUserData()
        print("用户名: \(user.name)")
    } catch {
        print("获取用户数据失败: \(error)")
    }
}

// Swift 5.5 中的 Actor
actor BankAccount {
    private var balance: Double

    init(initialBalance: Double) {
        balance = initialBalance
    }

    func deposit(amount: Double) {
        balance += amount
    }

    func withdraw(amount: Double) -> Double {
        guard balance >= amount else {
            return 0
        }
        balance -= amount
        return amount
    }

    func checkBalance() -> Double {
        return balance
    }
}

// 使用Actor
func transferMoney() async {
    let account = BankAccount(initialBalance: 1000)

    // 并发访问是安全的
    async let deposit = account.deposit(amount: 100)
    async let withdrawal = account.withdraw(amount: 50)

    // 等待两个操作完成
    await deposit
    let amount = await withdrawal

    let finalBalance = await account.checkBalance()
    print("提取金额: \(amount), 最终余额: \(finalBalance)")
}</code></pre>

            <div class="svg-container">
                <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="#333"/>
                        </marker>
                    </defs>

                    <!-- Actor圆圈 -->
                    <circle cx="300" cy="120" r="80" fill="#f0e5ff" stroke="#b19cd9" stroke-width="3"/>
                    <text x="300" y="90" text-anchor="middle" font-family="Arial" font-size="18" font-weight="bold" fill="#333">Actor</text>
                    <text x="300" y="120" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">隔离状态</text>
                    <text x="300" y="145" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">顺序执行</text>

                    <!-- 消息队列 -->
                    <rect x="190" y="220" width="220" height="50" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="300" y="250" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">消息队列 (actor mailbox)</text>

                    <!-- 连接箭头 -->
                    <path d="M300,200 L300,220" stroke="#333" stroke-width="2" stroke-dasharray="5,3" marker-end="url(#arrowhead)"/>

                    <!-- 线程 -->
                    <path d="M100,50 L180,50" stroke="#fce4ec" stroke-width="3" marker-end="url(#arrowhead)"/>
                    <text x="130" y="40" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">线程1</text>

                    <path d="M100,100 L180,100" stroke="#c5e8d5" stroke-width="3" marker-end="url(#arrowhead)"/>
                    <text x="130" y="90" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">线程2</text>

                    <path d="M100,150 L180,150" stroke="#ffcdd2" stroke-width="3" marker-end="url(#arrowhead)"/>
                    <text x="130" y="140" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">线程3</text>

                    <!-- 出口 -->
                    <path d="M420,80 L500,80" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="460" y="70" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">异步响应</text>

                    <path d="M420,160 L500,160" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>
                    <text x="460" y="150" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">异步响应</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.6 - 增强开发体验</h2>
                <span class="version-tag">Swift 5.6</span>
            </div>
            <div class="release-date">发布日期：2022年3月14日</div>

            <p>Swift 5.6带来了多项改进，重点是提升开发者体验和性能，尤其在并发方面做了多项增强。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>任何类型存在性检查（any关键字）</li>
                <li>扩展的正则表达式文字</li>
                <li>增加对 Type Placeholders 的支持</li>
                <li>Swift包管理器命令插件</li>
                <li>新的 Swift-DocC 文档编译器功能</li>
                <li>改进的IDE诊断和崩溃消息</li>
            </ul>

            <h3>代码示例：Any关键字和类型占位符</h3>
            <pre><code>// Swift 5.6 中的 any 关键字
// 之前的写法
protocol Drawable {
    func draw()
}

// 旧语法
let shapes: [Drawable] = [Circle(), Rectangle(), Triangle()]

// Swift 5.6新语法
let shapes: [any Drawable] = [Circle(), Rectangle(), Triangle()]

// Type Placeholders
let tuple = (4, "Hello", true)
// 使用占位符提取第一个元素类型
let _: _ = tuple.0 // 编译器推断类型为Int
</code></pre>

            <div class="note">
                <div class="note-title">关于any关键字</div>
                <p>在Swift 5.6中，any关键字是为了更明确地表示使用了类型擦除。这增加了代码的可读性，并为将来的语言发展准备了基础。在Swift演进过程中，越来越强调类型信息的显式声明。</p>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.7 - 泛型和并发增强</h2>
                <span class="version-tag">Swift 5.7</span>
            </div>
            <div class="release-date">发布日期：2022年9月12日</div>

            <p>Swift 5.7引入了新的语法特性，提高了类型检查速度，并进一步增强了并发模型，尤其是把分布式actors作为实验性功能引入。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>正则表达式字面量</li>
                <li>if-let可选绑定语法简化</li>
                <li>Clock协议和计时API</li>
                <li>实例一致性检查（instance member lookup）</li>
                <li>Sendable和@Sendable类型</li>
                <li>类型推断改进</li>
                <li>多类型关联约束</li>
            </ul>

            <h3>代码示例：正则表达式和简化的if-let语法</h3>
            <pre><code>// Swift 5.7 中的正则表达式字面量
let regex = /\d{3}-\d{4}/
let text = "电话: 123-4567"

if let match = text.firstMatch(of: regex) {
    print("找到电话号码: \(match.0)")
}

// 简化的可选绑定语法
// 之前的写法
if let username = user.username {
    print("用户名是: \(username)")
}

// Swift 5.7简化语法
if let username = user.username {
    print("用户名是: \(username)")
}

// 多个可选绑定
// 之前的写法
if let firstName = person.firstName,
   let lastName = person.lastName {
    print("姓名: \(firstName) \(lastName)")
}

// Swift 5.7简化语法
if let firstName = person.firstName,
   let lastName = person.lastName {
    print("姓名: \(firstName) \(lastName)")
}

// 使用Clock协议
struct MyTask {
    static func wait() async throws {
        try await Task.sleep(for: .seconds(2))
        print("等待2秒完成")
    }
}
</code></pre>

            <div class="svg-container">
                <svg width="600" height="220" viewBox="0 0 600 220" xmlns="http://www.w3.org/2000/svg">
                    <rect x="50" y="20" width="500" height="180" rx="10" fill="#f7f7f7" stroke="#ddd" stroke-width="1"/>

                    <rect x="80" y="50" width="440" height="50" rx="8" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="80" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">let regex = /\d{3}-\d{4}/</text>

                    <path d="M300,100 L300,130" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="80" y="130" width="440" height="50" rx="8" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="300" y="160" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">if let match = text.firstMatch(of: regex) { ... }</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.8 - 语言改进与优化</h2>
                <span class="version-tag">Swift 5.8</span>
            </div>
            <div class="release-date">发布日期：2023年3月30日</div>

            <p>Swift 5.8主要关注于语言的改进和稳定性，带来了若干性能优化和语法便利。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>改进的隐式成员引用</li>
                <li>可发送闭包改进</li>
                <li>非孤立表达式的类型检查</li>
                <li>自动引入的命名空间访问控制</li>
                <li>字符串处理改进</li>
                <li>编译速度优化</li>
            </ul>

            <h3>代码示例：隐式成员引用语法</h3>
            <pre><code>// Swift 5.8 中的隐式成员引用改进
enum Direction {
    case north, south, east, west
}

// Swift 5.7及之前
let directions: [Direction] = [.north, .south, .east, .west]

// Swift 5.8: 可以在集合字面量中省略元素类型
let directions: [Direction] = [.north, .south, .east, .west]

// 适用于各种集合类型和嵌套集合
let nestedDirections: [[Direction]] = [[.north, .south], [.east, .west]]

// 对于字典也同样适用
enum HTTPMethod: String {
    case get, post, put, delete
}

let methods: [HTTPMethod: String] = [
    .get: "获取数据",
    .post: "创建数据",
    .put: "更新数据",
    .delete: "删除数据"
]
</code></pre>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.9 - 宏和泛型增强</h2>
                <span class="version-tag">Swift 5.9</span>
            </div>
            <div class="release-date">发布日期：2023年9月18日</div>

            <p>Swift 5.9引入了强大的宏系统，使开发者能够编写更加简洁和表达力强的代码，同时还改进了泛型系统和值参数处理。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>宏系统（Macros）</li>
                <li>if和switch中的值绑定</li>
                <li>隐式self的结构化并发检查</li>
                <li>泛型关联类型推断扩展</li>
                <li>非逃逸闭包使用规则改进</li>
                <li>更新的字符串处理能力</li>
            </ul>

            <h3>代码示例：宏和if中的值绑定</h3>
            <pre><code>// Swift 5.9 宏示例
import SwiftUI

// 使用@Observable宏简化SwiftUI状态管理
@Observable
class UserViewModel {
    var name: String = "张三"
    var age: Int = 30

    func incrementAge() {
        age += 1
    }
}

struct UserView: View {
    var viewModel = UserViewModel()

    var body: some View {
        VStack {
            Text("姓名: \(viewModel.name)")
            Text("年龄: \(viewModel.age)")
            Button("生日+1") {
                viewModel.incrementAge()
            }
        }
    }
}

// Swift 5.9 中的值绑定
let result = calculateResult()

// 之前的写法
if case .success(let value) = result {
    print("成功: \(value)")
}

// Swift 5.9
if case .success(let value) = result {
    print("成功: \(value)")
}

// 对于switch语句也有类似改进
switch result {
case .success(let value):
    print("成功: \(value)")
case .failure(let error):
    print("失败: \(error)")
}
</code></pre>

            <div class="svg-container">
                <svg width="600" height="280" viewBox="0 0 600 280" xmlns="http://www.w3.org/2000/svg">
                    <rect x="100" y="20" width="400" height="60" rx="10" fill="#f0e5ff" stroke="#b19cd9" stroke-width="2"/>
                    <text x="300" y="55" text-anchor="middle" font-family="Arial" font-size="18" fill="#333">@Observable 宏</text>

                    <path d="M300,80 L300,100" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="100" y="100" width="400" height="60" rx="10" fill="#e0f7fa" stroke="#a5d6d9" stroke-width="2"/>
                    <text x="300" y="135" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">编译时代码生成和转换</text>

                    <path d="M300,160 L300,180" stroke="#333" stroke-width="2" marker-end="url(#arrowhead)"/>

                    <rect x="50" y="180" width="240" height="80" rx="10" fill="#fce4ec" stroke="#f8bbd0" stroke-width="2"/>
                    <text x="170" y="210" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">实现属性观察</text>
                    <text x="170" y="235" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">willSet/didSet</text>

                    <rect x="310" y="180" width="240" height="80" rx="10" fill="#c5e8d5" stroke="#a5c8b5" stroke-width="2"/>
                    <text x="430" y="210" text-anchor="middle" font-family="Arial" font-size="16" fill="#333">自动UI更新</text>
                    <text x="430" y="235" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">SwiftUI视图刷新</text>
                </svg>
            </div>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift 5.10 - 更多语言改进</h2>
                <span class="version-tag">Swift 5.10</span>
            </div>
            <div class="release-date">发布日期：2024年3月</div>

            <p>Swift 5.10带来了更多的语言改进，包括对异步编程、类型系统和编译器性能的增强。</p>

            <h3>主要特性</h3>
            <ul class="feature-list">
                <li>主角参数标签支持</li>
                <li>宏扩展</li>
                <li>额外的属性包装器能力</li>
                <li>初始化器参数细化</li>
                <li>async let绑定创建隐式TaskGroup</li>
                <li>存储属性在协议扩展中的默认值</li>
                <li>改进的泛型参数接口</li>
            </ul>
        </div>

        <div class="resources">
            <h2>Swift学习资源</h2>

            <div class="resource-group">
                <h3>官方文档</h3>
                <ul class="resource-list">
                    <li class="resource-item"><a href="https://www.swift.org/documentation/" target="_blank">Swift官方文档</a></li>
                    <li class="resource-item"><a href="https://docs.swift.org/swift-book/" target="_blank">Swift编程语言(官方书籍)</a></li>
                    <li class="resource-item"><a href="https://developer.apple.com/documentation/swift" target="_blank">Apple开发者文档 - Swift</a></li>
                    <li class="resource-item"><a href="https://www.swift.org/getting-started/" target="_blank">Swift.org入门指南</a></li>
                </ul>
            </div>

            <div class="resource-group">
                <h3>博客文章和技术网站</h3>
                <ul class="resource-list">
                    <li class="resource-item"><a href="https://www.swiftbysundell.com/" target="_blank">Swift by Sundell</a></li>
                    <li class="resource-item"><a href="https://www.hackingwithswift.com/" target="_blank">Hacking with Swift</a></li>
                    <li class="resource-item"><a href="https://www.objc.io/" target="_blank">objc.io</a></li>
                    <li class="resource-item"><a href="https://nshipster.com/" target="_blank">NSHipster</a></li>
                    <li class="resource-item"><a href="https://www.raywenderlich.com/ios/swift" target="_blank">raywenderlich.com</a></li>
                    <li class="resource-item"><a href="https://swiftrocks.com/" target="_blank">Swift Rocks</a></li>
                </ul>
            </div>

            <div class="resource-group">
                <h3>书籍推荐</h3>
                <ul class="resource-list">
                    <li class="resource-item">《Swift进阶》 - 王巍（onevcat）</li>
                    <li class="resource-item">《Swift编程权威指南》- Chris Lattner等</li>
                    <li class="resource-item">《Functional Swift》- Chris Eidhof等</li>
                    <li class="resource-item">《Advanced Swift》- Chris Eidhof, Ole Begemann等</li>
                    <li class="resource-item">《Design Patterns in Swift》- Factory Method, Builder等</li>
                    <li class="resource-item">《iOS编程（第7版）》- Christian Keur, Aaron Hillegass</li>
                </ul>
            </div>

            <div class="resource-group">
                <h3>视频教程</h3>
                <ul class="resource-list">
                    <li class="resource-item"><a href="https://developer.apple.com/videos/swift" target="_blank">Apple WWDC视频 - Swift相关</a></li>
                    <li class="resource-item"><a href="https://www.youtube.com/c/SeanAllen" target="_blank">Sean Allen - YouTube</a></li>
                    <li class="resource-item"><a href="https://www.youtube.com/c/PaulHudson" target="_blank">Paul Hudson - YouTube</a></li>
                    <li class="resource-item"><a href="https://www.youtube.com/c/SwiftfulThinking" target="_blank">Swiftful Thinking</a></li>
                    <li class="resource-item"><a href="https://www.pointfree.co/" target="_blank">Point-Free</a></li>
                </ul>
            </div>

            <div class="resource-group">
                <h3>开源项目</h3>
                <ul class="resource-list">
                    <li class="resource-item"><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire - 网络库</a></li>
                    <li class="resource-item"><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift - 响应式编程</a></li>
                    <li class="resource-item"><a href="https://github.com/SwiftyJSON/SwiftyJSON" target="_blank">SwiftyJSON - JSON处理</a></li>
                    <li class="resource-item"><a href="https://github.com/realm/realm-swift" target="_blank">Realm - 移动数据库</a></li>
                    <li class="resource-item"><a href="https://github.com/danielgindi/Charts" target="_blank">Charts - 图表库</a></li>
                    <li class="resource-item"><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Swift Composable Architecture</a></li>
                </ul>
            </div>

            <div class="resource-group">
                <h3>Swift工具与环境</h3>
                <ul class="resource-list">
                    <li class="resource-item"><a href="https://swiftpm.co/" target="_blank">Swift Package Manager</a></li>
                    <li class="resource-item"><a href="https://github.com/realm/SwiftLint" target="_blank">SwiftLint - 代码规范工具</a></li>
                    <li class="resource-item"><a href="https://github.com/nicklockwood/SwiftFormat" target="_blank">SwiftFormat - 代码格式化工具</a></li>
                    <li class="resource-item"><a href="https://swiftplayground.run/" target="_blank">Swift Playground Online</a></li>
                </ul>
            </div>
        </div>

        <div class="note">
            <div class="note-title">Swift的未来发展</div>
            <p>Swift语言仍在快速发展中。未来的版本将继续关注性能优化、开发体验改进以及跨平台能力的增强。关注<a href="https://www.swift.org/blog/" target="_blank">Swift官方博客</a>和<a href="https://forums.swift.org/" target="_blank">Swift论坛</a>以获取最新动态。</p>
        </div>

        <div class="version-card">
            <div class="version-header">
                <h2>Swift跨平台发展</h2>
                <span class="version-tag">跨平台</span>
            </div>

            <p>虽然Swift最初是为Apple平台设计的，但它已经扩展到其他平台。Swift现已支持Linux、Windows，并通过Swift for TensorFlow等项目进入了人工智能和机器学习领域。</p>

            <h3>Swift的跨平台应用</h3>
            <ul class="feature-list">
                <li>服务器端Swift (Vapor, Kitura, Perfect等框架)</li>
                <li>Swift for TensorFlow (机器学习)</li>
                <li>Swift在Linux上的应用</li>
                <li>Swift在Windows上的应用</li>
                <li>与其他语言的互操作性</li>
            </ul>

            <h3>代码示例：Vapor服务器端框架</h3>
            <pre><code>// Swift服务器端代码示例 (使用Vapor框架)
import Vapor

struct Todo: Content {
    var id: UUID?
    var title: String
    var completed: Bool = false
}

func routes(_ app: Application) throws {
    app.get("todos") { req in
        return [
            Todo(id: UUID(), title: "完成Swift演进文档", completed: true),
            Todo(id: UUID(), title: "学习Swift并发编程", completed: false),
            Todo(id: UUID(), title: "研究Swift宏系统", completed: false)
        ]
    }

    app.post("todos") { req -> Todo in
        let todo = try req.content.decode(Todo.self)
        return todo
    }
}

// 启动服务器
let app = Application()
try routes(app)
try app.run()</code></pre>
        </div>
    </div>

</body>
</html>
