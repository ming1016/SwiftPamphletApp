<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 基础 - Result 类型</title>
    <style>
        /* 响应式布局和暗黑模式适配 */
        :root {
            --bg-color: #f5f5f5;
            --text-color: #333;
            --code-bg: #f0f0f0;
            --title-color: #ff6b8b;
            --accent-color: #ff8c42;
            --secondary-bg: #2d4739;
            --border-color: #5a3921;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --bg-color: #1a1a1a;
                --text-color: #f0f0f0;
                --code-bg: #2d2d2d;
                --title-color: #ff6b8b;
                --accent-color: #ff8c42;
                --secondary-bg: #2d3a33;
                --border-color: #5a3921;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--bg-color);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='400' viewBox='0 0 800 800'%3E%3Cg fill='none' stroke='%23331f1a' stroke-width='1'%3E%3Cpath d='M769 229L1037 260.9M927 880L731 737 520 660 309 538 40 599 295 764 126.5 879.5 40 599-197 493 102 382-31 229 126.5 79.5-69-63'/%3E%3Cpath d='M-31 229L237 261 390 382 603 493 308.5 537.5 101.5 381.5M370 905L295 764'/%3E%3Cpath d='M520 660L578 842 731 737 840 599 603 493 520 660 295 764 309 538 390 382 539 269 769 229 577.5 41.5 370 105 295 -36 126.5 79.5 237 261 102 382 40 599 -69 737 127 880'/%3E%3Cpath d='M520-140L578.5 42.5 731-63M603 493L539 269 237 261 370 105M902 382L539 269M390 382L102 382'/%3E%3Cpath d='M-222 42L126.5 79.5 370 105 539 269 577.5 41.5 927 80 769 229 902 382 603 493 731 737M295-36L577.5 41.5M578 842L295 764M40-201L127 80M102 382L-261 269'/%3E%3C/g%3E%3Cg fill='%23ffffff'%3E%3Ccircle cx='769' cy='229' r='1'/%3E%3Ccircle cx='539' cy='269' r='1'/%3E%3Ccircle cx='603' cy='493' r='1'/%3E%3Ccircle cx='731' cy='737' r='1'/%3E%3Ccircle cx='520' cy='660' r='1'/%3E%3Ccircle cx='309' cy='538' r='1'/%3E%3Ccircle cx='295' cy='764' r='1'/%3E%3Ccircle cx='40' cy='599' r='1'/%3E%3Ccircle cx='102' cy='382' r='1'/%3E%3Ccircle cx='127' cy='80' r='1'/%3E%3Ccircle cx='370' cy='105' r='1'/%3E%3Ccircle cx='578' cy='42' r='1'/%3E%3Ccircle cx='237' cy='261' r='1'/%3E%3Ccircle cx='390' cy='382' r='1'/%3E%3C/g%3E%3C/svg%3E");
            padding: 0;
            margin: 0;
            max-width: 100%;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(26, 26, 26, 0.95);
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            border: 2px solid var(--border-color);
            overflow-x: hidden;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            padding: 20px;
            background-color: var(--secondary-bg);
            border-radius: 10px;
            border: 2px solid var(--accent-color);
            position: relative;
        }

        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 200 200'%3E%3Cdefs%3E%3Cpattern id='tribal' patternUnits='userSpaceOnUse' width='40' height='40'%3E%3Cpath fill='none' stroke='rgba(255,139,66,0.3)' stroke-width='2' d='M0 20 L40 20 M20 0 L20 40'/%3E%3C/pattern%3E%3C/defs%3E%3Crect width='100%25' height='100%25' fill='url(%23tribal)'/%3E%3C/svg%3E");
            z-index: 0;
            opacity: 0.2;
            border-radius: 8px;
            pointer-events: none;
        }

        h1 {
            color: var(--title-color);
            font-size: 2.5rem;
            margin: 0;
            position: relative;
            z-index: 1;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        h2 {
            color: var(--title-color);
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 10px;
            margin-top: 40px;
        }

        h3 {
            color: var(--accent-color);
            margin-top: 30px;
        }

        p {
            text-align: justify;
        }

        pre {
            background-color: var(--code-bg);
            padding: 15px;
            border-radius: 8px;
            overflow-x: auto;
            border-left: 4px solid var(--accent-color);
            margin: 20px 0;
            position: relative;
        }

        code {
            font-family: "SF Mono", "Menlo", "Monaco", "Courier New", monospace;
            font-size: 0.9rem;
            color: var(--accent-color);
        }

        pre code {
            color: inherit;
            white-space: pre;
            display: block;
            line-height: 1.5;
        }

        .code-title {
            position: absolute;
            top: -10px;
            right: 10px;
            background: var(--accent-color);
            padding: 2px 10px;
            border-radius: 4px;
            color: white;
            font-size: 0.8rem;
        }

        .note {
            background-color: var(--secondary-bg);
            border-left: 4px solid var(--title-color);
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
        }

        a {
            color: var(--accent-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--accent-color);
            transition: all 0.3s ease;
        }

        a:hover {
            color: var(--title-color);
            border-bottom: 1px solid var(--title-color);
        }

        .resources {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 30px;
        }

        .resource-category {
            flex: 1 1 300px;
            background-color: var(--secondary-bg);
            border-radius: 8px;
            padding: 15px;
            border: 1px solid var(--border-color);
        }

        .resource-category h4 {
            color: var(--title-color);
            margin-top: 0;
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 5px;
        }

        ul {
            padding-left: 20px;
        }

        li {
            margin-bottom: 10px;
        }

        .diagram {
            margin: 30px 0;
            text-align: center;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
                margin: 10px;
            }

            h1 {
                font-size: 1.8rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            pre {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Swift 基础 - Result 类型</h1>
        </div>

        <section>
            <h2>Result 类型概述</h2>
            <p>Result 是 Swift 5 中引入的一个枚举类型，用于表示可能成功（返回值）或失败（错误）的操作结果。它解决了以前处理错误时需要使用多个可选值或复杂状态管理的问题，使代码更加清晰和类型安全。</p>

            <div class="diagram">
                <svg width="580" height="250" viewBox="0 0 580 250" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .title { fill: #ff6b8b; font-weight: bold; font-size: 14px; font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
                        .code { fill: #ff8c42; font-family: "SF Mono", monospace; font-size: 12px; }
                        .desc { fill: #e0e0e0; font-family: -apple-system, BlinkMacSystemFont, sans-serif; font-size: 12px; }
                        .box { fill: #2d4739; stroke: #ff8c42; stroke-width: 2; rx: 10; opacity: 0.9; }
                        .arrow { stroke: #ff6b8b; stroke-width: 2; fill: none; marker-end: url(#arrowhead); }
                        .dashed { stroke-dasharray: 5,5; }
                    </style>
                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="#ff6b8b" />
                        </marker>
                    </defs>
                    <rect class="box" x="10" y="10" width="560" height="80" />
                    <text class="title" x="30" y="40">Result&lt;Success, Failure&gt; where Failure: Error</text>
                    <text class="desc" x="30" y="70">表示一个操作的两种可能结果：成功（携带关联值）或失败（携带错误）</text>

                    <rect class="box" x="50" y="130" width="200" height="80" />
                    <text class="title" x="70" y="160">case success(Success)</text>
                    <text class="desc" x="70" y="190">操作成功时的值</text>

                    <rect class="box" x="330" y="130" width="200" height="80" />
                    <text class="title" x="350" y="160">case failure(Failure)</text>
                    <text class="desc" x="350" y="190">操作失败时的错误</text>

                    <path class="arrow" d="M160 90 L120 130" />
                    <path class="arrow" d="M420 90 L430 130" />
                </svg>
            </div>

            <p>Result 类型是一个泛型枚举，定义如下：</p>

            <pre><code class="swift">enum Result&lt;Success, Failure: Error&gt; {
    case success(Success)
    case failure(Failure)
}</code></pre>

            <p>其中：</p>
            <ul>
                <li><strong>Success</strong>：操作成功时返回的值的类型</li>
                <li><strong>Failure</strong>：操作失败时返回的错误类型，必须遵循 Error 协议</li>
            </ul>
        </section>

        <section>
            <h2>基本用法</h2>

            <h3>创建 Result 实例</h3>

            <pre><code class="swift">// 创建一个成功的 Result
let successResult: Result&lt;Int, Error&gt; = .success(42)

// 创建一个失败的 Result
enum NetworkError: Error {
    case badConnection
    case serverError(code: Int)
}

let failureResult: Result&lt;String, NetworkError&gt; = .failure(.badConnection)</code></pre>

            <h3>使用 Result 处理可能失败的操作</h3>

            <pre><code class="swift">// 模拟网络请求函数
func fetchUserData(for userID: Int) -> Result&lt;User, NetworkError&gt; {
    // 假设这里进行网络请求
    if userID > 0 {
        // 请求成功
        return .success(User(id: userID, name: "User \(userID)"))
    } else {
        // 请求失败
        return .failure(.serverError(code: 404))
    }
}

// 定义用户模型
struct User {
    let id: Int
    let name: String
}</code></pre>

            <h3>处理 Result</h3>

            <pre><code class="swift">// 使用 switch 语句处理结果
let result = fetchUserData(for: 123)

switch result {
case .success(let user):
    print("获取用户成功: \(user.name)")
case .failure(let error):
    print("获取用户失败: \(error)")
}

// 使用便捷方法处理结果
if let user = try? result.get() {
    print("用户: \(user.name)")
} else {
    print("获取用户失败")
}</code></pre>
        </section>

        <section>
            <h2>Result 的实用方法</h2>

            <h3>get() 方法</h3>
            <p>从成功的 Result 中获取值，或抛出错误（如果 Result 为失败）：</p>

            <pre><code class="swift">let successResult: Result&lt;Int, Error&gt; = .success(42)

do {
    // 若 Result 是 success，返回关联值；若是 failure，抛出错误
    let value = try successResult.get()
    print("值是 \(value)")
} catch {
    print("错误: \(error)")
}</code></pre>

            <h3>map 和 flatMap 方法</h3>
            <p>类似于 Optional 的 map 和 flatMap 方法，可以对成功的结果进行转换：</p>

            <pre><code class="swift">// map: 将成功的值转换为其他类型
let stringResult = successResult.map { value in
    return "数字是: \(value)"
}
// stringResult 是 Result&lt;String, Error&gt;.success("数字是: 42")

// flatMap: 用于当转换返回另一个 Result 时
let doubledResult = successResult.flatMap { value -> Result&lt;Int, Error&gt; in
    // 如果值大于100，返回错误
    if value > 100 {
        return .failure(NetworkError.serverError(code: 500))
    } else {
        return .success(value * 2)
    }
}
// doubledResult 是 Result&lt;Int, Error&gt;.success(84)</code></pre>

            <h3>mapError 方法</h3>
            <p>允许转换错误类型：</p>

            <pre><code class="swift">// 定义一个应用错误类型
enum AppError: Error {
    case networkFailed(originalError: Error)
    case parseError
}

// 转换错误类型
let appResult = failureResult.mapError { networkError -> AppError in
    return .networkFailed(originalError: networkError)
}
// appResult 是 Result&lt;String, AppError&gt;.failure(.networkFailed(...))</code></pre>
        </section>

        <section>
            <h2>Result 与异步编程</h2>
            <p>Result 经常用于异步操作，比如网络请求的回调：</p>

            <pre><code class="swift">// 使用 Result 的异步网络请求函数
func fetchData(from url: URL, completion: @escaping (Result&lt;Data, NetworkError&gt;) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(.badConnection))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(.serverError(code: (response as? HTTPURLResponse)?.statusCode ?? 500)))
            return
        }

        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(.serverError(code: 404)))
        }
    }.resume()
}

// 使用这个函数
let url = URL(string: "https://api.example.com/data")!
fetchData(from: url) { result in
    switch result {
    case .success(let data):
        print("获取了 \(data.count) 字节的数据")
        // 处理数据...

    case .failure(let error):
        print("请求失败: \(error)")
        // 处理错误...
    }
}</code></pre>
        </section>

        <section>
            <h2>Result 与 throw/try</h2>
            <p>Result 可以与 Swift 的错误处理机制无缝集成：</p>

            <pre><code class="swift">// 将可能抛出异常的函数转换为返回 Result
func fetchUser(id: Int) throws -> User {
    if id <= 0 {
        throw NetworkError.serverError(code: 404)
    }
    return User(id: id, name: "User \(id)")
}

// 使用 Result 的 init(catching:) 初始化方法
let userResult = Result { try fetchUser(id: -1) }
// userResult 是 Result&lt;User, Error&gt;.failure(NetworkError.serverError)

// 使用 Result 处理可能失败的操作，并将结果转换为 Result
func processData() -> Result&lt;String, Error&gt; {
    do {
        let user = try fetchUser(id: 1)
        return .success("处理了用户: \(user.name)")
    } catch {
        return .failure(error)
    }
}</code></pre>
        </section>

        <section>
            <h2>Result 配合 Swift Concurrency</h2>
            <p>Swift 5.5 引入的并发特性可以与 Result 结合使用：</p>

            <pre><code class="swift">// 将基于回调的 API 转换为 async/await
func fetchDataAsync(from url: URL) async -> Result&lt;Data, NetworkError&gt; {
    return await withCheckedContinuation { continuation in
        fetchData(from: url) { result in
            continuation.resume(returning: result)
        }
    }
}

// 在异步上下文中使用
Task {
    let result = await fetchDataAsync(from: url)

    switch result {
    case .success(let data):
        // 处理数据
        print("异步获取了 \(data.count) 字节的数据")
    case .failure(let error):
        // 处理错误
        print("异步请求失败: \(error)")
    }
}</code></pre>
        </section>

        <section>
            <h2>实际应用场景</h2>

            <h3>网络请求处理</h3>
            <p>Result 最常见的用例之一是网络请求处理：</p>

            <pre><code class="swift">// 网络层的简单封装
struct NetworkService {
    // 定义网络错误类型
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(statusCode: Int)
        case noData
        case decodingFailed
    }

    // 泛型方法获取并解析数据
    func fetch&lt;T: Decodable&gt;(_ endpoint: String) async -> Result&lt;T, NetworkError&gt; {
        guard let url = URL(string: "https://api.example.com/\(endpoint)") else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.requestFailed(statusCode: 0))
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(.requestFailed(statusCode: httpResponse.statusCode))
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.decodingFailed)
            }
        } catch {
            return .failure(.requestFailed(statusCode: 0))
        }
    }
}

// 使用示例
struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
}

// 在异步函数中使用
Task {
    let networkService = NetworkService()
    let result: Result<[Post], NetworkService.NetworkError> = await networkService.fetch("posts")
    
    switch result {
    case .success(let posts):
        print("获取到 \(posts.count) 篇文章")
        posts.forEach { post in
            print("- \(post.title)")
        }
    case .failure(let error):
        print("获取文章失败: \(error)")
    }
}</code></pre>
            
            <h3>用户认证流程</h3>
            <p>在处理用户认证时，Result 可以清晰地表示不同的认证状态和错误：</p>
            
            <pre><code class="swift">struct AuthService {
    enum AuthError: Error {
        case invalidCredentials
        case networkError
        case accountLocked
        case tooManyAttempts
    }
    
    struct User {
        let id: String
        let name: String
        let token: String
    }
    
    func login(email: String, password: String) async -> Result&lt;User, AuthError&gt; {
        // 模拟登录过程
        if email.isEmpty || password.isEmpty {
            return .failure(.invalidCredentials)
        }
        
        if email == "test@example.com" && password == "password" {
            return .success(User(id: "123", name: "测试用户", token: "abc-xyz-token"))
        } else {
            return .failure(.invalidCredentials)
        }
    }
    
    func validateToken(_ token: String) async -> Result&lt;Bool, AuthError&gt; {
        // 模拟令牌验证
        if token.count > 5 {
            return .success(true)
        } else {
            return .failure(.invalidCredentials)
        }
    }
}

// 使用示例
Task {
    let authService = AuthService()
    let loginResult = await authService.login(email: "test@example.com", password: "password")
    
    switch loginResult {
    case .success(let user):
        print("登录成功：欢迎 \(user.name)")
        
        // 验证令牌
        let tokenResult = await authService.validateToken(user.token)
        if case .success = tokenResult {
            print("令牌有效")
        }
        
    case .failure(let error):
        switch error {
        case .invalidCredentials:
            print("邮箱或密码错误")
        case .accountLocked:
            print("账号已锁定")
        case .tooManyAttempts:
            print("尝试次数过多，请稍后重试")
        case .networkError:
            print("网络连接错误")
        }
    }
}</code></pre>
            
            <h3>数据处理和转换</h3>
            <p>使用 Result 处理复杂的数据转换流程：</p>
            
            <pre><code class="swift">enum DataProcessingError: Error {
    case invalidInput
    case processingFailed(reason: String)
    case outputGenerationFailed
}

func processUserData(_ data: [String: Any]) -> Result&lt;User, DataProcessingError&gt; {
    // 验证输入
    guard let name = data["name"] as? String, !name.isEmpty,
          let ageString = data["age"] as? String,
          let age = Int(ageString) else {
        return .failure(.invalidInput)
    }
    
    // 处理数据
    if age < 0 || age > 120 {
        return .failure(.processingFailed(reason: "年龄超出有效范围"))
    }
    
    // 创建输出
    do {
        let user = User(id: UUID().uuidString, name: name, age: age)
        return .success(user)
    } catch {
        return .failure(.outputGenerationFailed)
    }
}

// 使用示例
let userData: [String: Any] = ["name": "张三", "age": "28"]
let processingResult = processUserData(userData)

// 使用 Result 的链式处理
let displayResult = processingResult
    .map { user in
        return "用户 \(user.name), 年龄 \(user.age)"
    }
    .mapError { error in
        switch error {
        case .invalidInput:
            return DataProcessingError.processingFailed(reason: "输入数据格式不正确")
        default:
            return error
        }
    }

switch displayResult {
case .success(let message):
    print(message)
case .failure(let error):
    if case .processingFailed(let reason) = error {
        print("处理错误: \(reason)")
    } else {
        print("未知错误")
    }
}</code></pre>
        </section>
        
        <section>
            <h2>Result 的最佳实践</h2>
            
            <h3>使用场景的选择</h3>
            <div class="note">
                <p>什么时候使用 Result，什么时候使用 throw/try：</p>
                <ul>
                    <li>当需要异步处理错误时，使用 Result 是合适的</li>
                    <li>对于同步代码，如果错误处理就在附近，throw/try 通常更简洁</li>
                    <li>如果需要在多个组件间传递成功/失败状态，Result 更适合</li>
                </ul>
            </div>
            
            <div class="diagram">
                <svg width="580" height="300" viewBox="0 0 580 300" xmlns="http://www.w3.org/2000/svg">
                    <style>
                        .title { fill: #ff6b8b; font-weight: bold; font-size: 14px; font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
                        .desc { fill: #e0e0e0; font-family: -apple-system, BlinkMacSystemFont, sans-serif; font-size: 12px; }
                        .box { fill: #2d4739; stroke: #ff8c42; stroke-width: 2; rx: 10; opacity: 0.9; }
                        .arrow { stroke: #ff6b8b; stroke-width: 2; fill: none; marker-end: url(#arrowhead); }
                    </style>
                    <defs>
                        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                            <polygon points="0 0, 10 3.5, 0 7" fill="#ff6b8b" />
                        </marker>
                    </defs>
                    
                    <rect class="box" x="20" y="20" width="250" height="100" />
                    <text class="title" x="40" y="50">使用 throw/try</text>
                    <text class="desc" x="40" y="80">• 同步代码</text>
                    <text class="desc" x="40" y="100">• 错误处理就在附近</text>
                    
                    <rect class="box" x="310" y="20" width="250" height="100" />
                    <text class="title" x="330" y="50">使用 Result</text>
                    <text class="desc" x="330" y="80">• 异步代码 (回调函数)</text>
                    <text class="desc" x="330" y="100">• 跨组件传递错误状态</text>
                    
                    <rect class="box" x="20" y="170" width="540" height="100" />
                    <text class="title" x="40" y="200">Swift 5.5+ Async/Await</text>
                    <text class="desc" x="40" y="230">• 使用 throw/try 处理异步错误，简化代码</text>
                    <text class="desc" x="40" y="250">• 有时仍然需要 Result 作为中间状态或与旧 API 兼容</text>
                </svg>
            </div>
            
            <h3>自定义 Result 扩展</h3>
            <p>可以扩展 Result 类型以增加更多实用功能：</p>
            
            <pre><code class="swift">extension Result {
    // 提供一个默认值，在失败时使用
    func valueOrDefault(_ defaultValue: Success) -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return defaultValue
        }
    }
    
    // 处理副作用
    func onSuccess(_ action: (Success) -> Void) -> Result {
        if case .success(let value) = self {
            action(value)
        }
        return self
    }
    
    func onFailure(_ action: (Failure) -> Void) -> Result {
        if case .failure(let error) = self {
            action(error)
        }
        return self
    }
}

// 使用示例
fetchUserData(for: 42)
    .onSuccess { user in
        print("成功获取用户: \(user.name)")
    }
    .onFailure { error in
        print("获取用户失败: \(error)")
    }

// 使用默认值
let user = fetchUserData(for: -1)
    .valueOrDefault(User(id: 0, name: "访客用户"))</code></pre>
            
            <h3>结合 Swift 的 defer 机制</h3>
            <p>使用 defer 确保资源清理，同时返回 Result：</p>
            
            <pre><code class="swift">func processFile(at path: String) -> Result&lt;String, Error&gt; {
    guard let fileHandle = try? FileHandle(forReadingFrom: URL(fileURLWithPath: path)) else {
        return .failure(NSError(domain: "FileError", code: 1, userInfo: [NSLocalizedDescriptionKey: "无法打开文件"]))
    }
    
    defer {
        try? fileHandle.close() // 确保文件最终被关闭
    }
    
    do {
        let data = try fileHandle.readToEnd() ?? Data()
        if let content = String(data: data, encoding: .utf8) {
            return .success(content)
        } else {
            return .failure(NSError(domain: "FileError", code: 2, userInfo: [NSLocalizedDescriptionKey: "无法解码文件内容"]))
        }
    } catch {
        return .failure(error)
    }
}</code></pre>
        </section>
        
        <section>
            <h2>与其他语言的比较</h2>
            
            <div class="note">
                <p>Swift 的 Result 类型与其他语言中的类似概念：</p>
                <ul>
                    <li><strong>Rust</strong>: Result&lt;T, E&gt; 是 Rust 的核心类型，与 Swift 的 Result 非常类似</li>
                    <li><strong>Kotlin</strong>: 使用 sealed class 如 Result&lt;T&gt; 包含 Success 和 Failure</li>
                    <li><strong>TypeScript</strong>: 库如 fp-ts 提供了 Either 类型，类似于 Result</li>
                </ul>
            </div>
            
            <p>Swift 的 Result 实现相较于其他语言，充分利用了 Swift 的类型系统和错误处理机制，使错误处理更加类型安全和表达力强。</p>
        </section>
        
        <section>
            <h2>相关资源</h2>
            
            <div class="resources">
                <div class="resource-category">
                    <h4>官方文档</h4>
                    <ul>
                        <li><a href="https://developer.apple.com/documentation/swift/result" target="_blank">Swift Result 类型文档</a></li>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html" target="_blank">Swift 错误处理指南</a></li>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2019/401/" target="_blank">WWDC 2019: Swift 中的现代错误处理</a></li>
                    </ul>
                </div>
                
                <div class="resource-category">
                    <h4>博客文章</h4>
                    <ul>
                        <li><a href="https://www.swiftbysundell.com/articles/handling-errors-and-results-in-swift/" target="_blank">Swift by Sundell: 在 Swift 中处理错误和 Result</a></li>
                        <li><a href="https://www.hackingwithswift.com/articles/161/how-to-use-result-in-swift" target="_blank">Hacking with Swift: 如何使用 Result</a></li>
                        <li><a href="https://www.avanderlee.com/swift/result-enum-type/" target="_blank">SwiftLee: Result 类型的完整指南</a></li>
                    </ul>
                </div>
                
                <div class="resource-category">
                    <h4>书籍和课程</h4>
                    <ul>
                        <li><a href="https://www.raywenderlich.com/books/advanced-swift" target="_blank">Advanced Swift</a> - Chris Eidhof, Ole Begemann 等著</li>
                        <li><a href="https://www.objc.io/books/thinking-in-swiftui/" target="_blank">Thinking in SwiftUI</a> - 包含使用 Result 的高级模式</li>
                        <li><a href="https://www.pointfree.co/collections/error-handling" target="_blank">Point-Free: 错误处理系列</a></li>
                    </ul>
                </div>
                
                <div class="resource-category">
                    <h4>开源项目</h4>
                    <ul>
                        <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a> - 广泛使用 Result 的 HTTP 网络库</li>
                        <li><a href="https://github.com/antitypical/Result" target="_blank">antitypical/Result</a> - 在 Swift 标准库包含 Result 前流行的实现</li>
                        <li><a href="https://github.com/ReactiveCocoa/ReactiveSwift" target="_blank">ReactiveSwift</a> - 函数式响应式编程框架，广泛使用 Result</li>
                    </ul>
                </div>
            </div>
        </section>
        
        <section>
            <h2>总结</h2>
            <p>Swift 的 Result 类型是处理可能失败的操作的强大工具，它提供了以下优势：</p>
            <ul>
                <li>使用枚举明确表示成功和失败</li>
                <li>类型安全，编译时就能检测错误处理逻辑</li>
                <li>通过 map、flatMap 等方法提供了函数式编程风格</li>
                <li>与 Swift 的错误处理机制无缝集成</li>
                <li>特别适合异步代码和跨组件通信</li>
            </ul>
            
            <p>虽然 Swift 5.5 引入的 async/await 为错误处理提供了新的方式，但 Result 类型在许多场景下仍然是不可或缺的工具，尤其是在处理复杂的错误状态、与旧 API 集成，以及需要保留错误信息的情况下。</p>
        </section>
    </div>
    
    <!-- 页面顶部悬浮导航按钮 -->
    <div id="top-button" style="position: fixed; bottom: 20px; right: 20px; background-color: var(--accent-color); color: white; width: 50px; height: 50px; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; box-shadow: 0 2px 10px rgba(0,0,0,0.3); opacity: 0; transition: opacity 0.3s ease;">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M18 15l-6-6-6 6"/>
        </svg>
    </div>
    
    <script>
        // 显示/隐藏顶部按钮
        window.onscroll = function() {
            var button = document.getElementById('top-button');
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                button.style.opacity = '1';
            } else {
                button.style.opacity = '0';
            }
        };
        
        // 点击返回顶部
        document.getElementById('top-button').onclick = function() {
            document.body.scrollTop = 0; // Safari
            document.documentElement.scrollTop = 0; // Chrome, Firefox, IE, Opera
        };
    </script>
</body>
</html>
