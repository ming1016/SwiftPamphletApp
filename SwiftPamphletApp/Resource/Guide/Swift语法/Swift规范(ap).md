<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 编程规范</title>
    <style>
        :root {
            --primary-color: #ffd1dc;
            --secondary-color: #a5d8ff;
            --accent-color: #ff7f7f;
            --mint-color: #c5f6e8;
            --text-color: #333;
            --background-color: #fff;
            --code-background: #f8f8f8;
            --border-color: #ffd1dc;
            --shadow-color: rgba(255, 209, 220, 0.2);
            --link-color: #4a86e8;
            --header-color: #ff7f7f;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-color: #522e34;
                --secondary-color: #254666;
                --accent-color: #803f3f;
                --mint-color: #2a5a4c;
                --text-color: #e1e1e1;
                --background-color: #222;
                --code-background: #333;
                --border-color: #522e34;
                --shadow-color: rgba(255, 209, 220, 0.1);
                --link-color: #7aafe8;
                --header-color: #ff9e9e;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            transition: background-color 0.3s ease;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        header {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 12px;
            box-shadow: 0 8px 30px var(--shadow-color);
        }

        h1 {
            font-size: 2.8rem;
            margin-bottom: 1rem;
            color: var(--header-color);
            font-weight: 700;
        }

        h2 {
            font-size: 2rem;
            margin-top: 2.5rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--border-color);
            color: var(--header-color);
        }

        h3 {
            font-size: 1.5rem;
            margin-top: 2rem;
            margin-bottom: 0.75rem;
            color: var(--header-color);
        }

        p {
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dashed var(--link-color);
            transition: all 0.2s ease;
        }

        a:hover {
            color: var(--accent-color);
            border-bottom: 1px solid var(--accent-color);
        }

        .section {
            background-color: var(--background-color);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 20px var(--shadow-color);
            border-left: 5px solid var(--accent-color);
        }

        code {
            font-family: "SF Mono", Menlo, Monaco, Consolas, monospace;
            background-color: var(--code-background);
            padding: 0.2em 0.4em;
            border-radius: 3px;
            font-size: 0.9em;
        }

        pre {
            background-color: var(--code-background);
            padding: 1.5rem;
            border-radius: 8px;
            overflow-x: auto;
            border-left: 5px solid var(--mint-color);
            margin: 1.5rem 0;
        }

        pre code {
            background-color: transparent;
            padding: 0;
        }

        .example {
            background-color: var(--background-color);
            border-left: 5px solid var(--secondary-color);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 8px;
            box-shadow: 0 3px 10px var(--shadow-color);
        }

        .tip {
            background-color: var(--mint-color);
            color: var(--text-color);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 8px;
        }

        .resources {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .resource-card {
            background: linear-gradient(135deg, var(--background-color), var(--background-color));
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 5px 15px var(--shadow-color);
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .resource-card:hover {
            transform: translateY(-5px);
        }

        .image-container {
            text-align: center;
            margin: 2rem 0;
        }

        .image-caption {
            font-size: 0.9rem;
            color: var(--header-color);
            margin-top: 0.5rem;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            header {
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            .section {
                padding: 1.5rem;
            }
        }

        /* 特殊装饰元素 */
        .decorator {
            position: absolute;
            z-index: -1;
            opacity: 0.1;
        }

        .decorator-1 {
            top: 10%;
            left: 5%;
            width: 150px;
            height: 150px;
            border: 3px solid var(--accent-color);
            border-radius: 50%;
        }

        .decorator-2 {
            bottom: 15%;
            right: 8%;
            width: 100px;
            height: 100px;
            background-color: var(--mint-color);
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <div class="decorator decorator-1"></div>
    <div class="decorator decorator-2"></div>

    <div class="container">
        <header>
            <h1>Swift 编程规范</h1>
            <p>优雅、简洁、安全的现代化编程语言</p>
        </header>

        <div class="section">
            <h2>1. Swift 规范概述</h2>
            <p>Swift 是 Apple 于2014年推出的强大而直观的编程语言，设计用于构建 iOS、macOS、watchOS 和 tvOS 应用程序。以下规范旨在帮助开发者编写清晰、一致且高质量的 Swift 代码。</p>

            <svg width="100%" height="200" viewBox="0 0 600 200" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="50" width="500" height="100" rx="20" ry="20" fill="none" stroke="var(--accent-color)" stroke-width="2"/>
                <text x="300" y="90" font-size="24" text-anchor="middle" fill="var(--accent-color)">Swift 核心理念</text>
                <text x="150" y="130" font-size="14" text-anchor="middle" fill="var(--text-color)">安全</text>
                <text x="250" y="130" font-size="14" text-anchor="middle" fill="var(--text-color)">简洁</text>
                <text x="350" y="130" font-size="14" text-anchor="middle" fill="var(--text-color)">表达力强</text>
                <text x="450" y="130" font-size="14" text-anchor="middle" fill="var(--text-color)">高性能</text>
            </svg>
            <div class="image-caption">Swift 核心设计理念</div>
        </div>

        <div class="section">
            <h2>2. 命名规范</h2>
            <p>良好的命名习惯可以提高代码的可读性和可维护性。Swift 中的命名应遵循以下规则：</p>

            <h3>2.1 变量和常量命名</h3>
            <ul>
                <li>使用驼峰式命名法</li>
                <li>变量、常量和函数名首字母小写</li>
                <li>类型名首字母大写</li>
            </ul>

            <div class="example">
                <h4>示例：命名规范</h4>
                <pre><code>// 变量使用驼峰式命名，首字母小写
let userAge = 25
var userName = "小明"

// 常量与变量同理
let maxRetryCount = 3
let deviceScreenWidth = UIScreen.main.bounds.width

// 类型名首字母大写
struct User {
    let id: String
    var name: String
}

// 函数名使用动词开头，清晰表意
func fetchUserData() {
    // 实现逻辑
}

// 布尔变量通常以 is, has, should 等开头
let isLoggedIn = true
let hasCompletedOnboarding = false</code></pre>
            </div>

            <h3>2.2 类型命名</h3>
            <p>类型名称（类、结构体、枚举、协议等）应使用大驼峰式命名法（即首字母大写）。</p>

            <svg width="100%" height="240" viewBox="0 0 600 240" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="20" width="500" height="200" rx="10" ry="10" fill="none" stroke="var(--secondary-color)" stroke-width="2"/>
                <text x="300" y="50" font-size="18" text-anchor="middle" fill="var(--header-color)">Swift 命名约定</text>

                <line x1="50" y1="70" x2="550" y2="70" stroke="var(--border-color)" stroke-width="1"/>

                <text x="150" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">类型</text>
                <text x="400" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">大驼峰命名法 (PascalCase)</text>

                <text x="150" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">变量/常量/函数</text>
                <text x="400" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">小驼峰命名法 (camelCase)</text>

                <text x="150" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">协议</text>
                <text x="400" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">大驼峰命名法 (通常以-able, -ible结尾)</text>
            </svg>

            <div class="example">
                <h4>示例：类型命名</h4>
                <pre><code>// 类使用名词，首字母大写
class NetworkManager {
    // 实现细节
}

// 结构体同样使用名词，首字母大写
struct UserProfile {
    // 属性和方法
}

// 枚举类型首字母大写，case 首字母小写
enum ConnectionState {
    case connecting
    case connected
    case disconnected
    case failed(Error)
}

// 协议名通常使用名词，有时以 -able, -ible 结尾
protocol Fetchable {
    func fetch() async throws
}</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>3. 代码格式规范</h2>
            <p>保持一致的代码格式有助于提高代码可读性和团队协作效率。</p>

            <h3>3.1 缩进和空格</h3>
            <ul>
                <li>使用4个空格作为一个缩进层级</li>
                <li>大括号起始位置与声明位于同一行</li>
                <li>方法之间使用一个空行分隔</li>
            </ul>

            <div class="example">
                <h4>示例：缩进和空格</h4>
                <pre><code>// 大括号与声明同行，缩进使用4个空格
func calculateTotal(items: [Item]) -> Double {
    var total = 0.0

    for item in items {
        total += item.price
    }

    return total
}

// 类或结构体中的方法之间用空行分隔
struct CartManager {
    var items: [Item] = []

    func addItem(_ item: Item) {
        items.append(item)
    }

    func removeItem(at index: Int) {
        guard index < items.count else { return }
        items.remove(at: index)
    }
}</code></pre>
            </div>

            <h3>3.2 行长度</h3>
            <p>代码行长度应合理控制，通常建议不超过100个字符。对于较长的行，应该适当换行以保持代码的可读性。</p>

            <div class="example">
                <h4>示例：长行的处理方式</h4>
                <pre><code>// 较长的函数调用可以换行
let result = veryLongFunctionNameWithManyParameters(
    firstParameter: value1,
    secondParameter: value2,
    thirdParameter: value3
)

// 多行字符串字面量
let longMessage = """
这是一个多行字符串示例。
在 Swift 中，我们可以使用三个双引号来创建多行字符串。
这样可以保持代码的可读性。
"""</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>4. Swift 语法最佳实践</h2>

            <h3>4.1 可选类型处理</h3>
            <p>Swift 的可选类型是防止空值错误的强大特性，应该正确使用它们。</p>

            <svg width="100%" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="20" width="500" height="200" rx="10" ry="10" fill="none" stroke="var(--accent-color)" stroke-width="2"/>
                <text x="300" y="50" font-size="18" text-anchor="middle" fill="var(--header-color)">可选类型处理方式</text>

                <line x1="50" y1="70" x2="550" y2="70" stroke="var(--border-color)" stroke-width="1"/>

                <text x="150" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">if let / guard let</text>
                <text x="400" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">安全解包</text>

                <text x="150" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">可选链</text>
                <text x="400" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">obj?.property?.method()</text>

                <text x="150" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">nil 合并运算符</text>
                <text x="400" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">value ?? defaultValue</text>
            </svg>

            <div class="example">
                <h4>示例：可选类型处理</h4>
                <pre><code>// if let 解包
if let name = user?.name {
    print("用户名称: \(name)")
}

// guard let 提前退出
func processUser(_ user: User?) {
    guard let user = user else {
        print("无效用户")
        return
    }

    // 此处 user 已经解包，可以安全使用
    print("处理用户: \(user.name)")
}

// 可选链
let userCity = user?.address?.city

// nil 合并运算符
let displayName = user?.name ?? "游客"

// 可选映射
let userNameLength = user?.name.map { $0.count }

// 强制解包（应谨慎使用）
let knownNonNilValue = definitelyNotNilValue!</code></pre>
            </div>

            <h3>4.2 类型推断与显式类型</h3>
            <p>Swift 拥有强大的类型推断能力，但在某些情况下显式声明类型更为清晰。</p>

            <div class="example">
                <h4>示例：类型推断与显式类型</h4>
                <pre><code>// 类型推断 - Swift 能自动推断类型
let score = 100 // Int
let name = "Alex" // String
let pi = 3.14 // Double

// 显式类型声明 - 增强可读性或指定特定类型
let specificInt: Int16 = 200
let price: Double = 9.99
let isEnabled: Bool = false

// 复杂类型时使用显式声明
let dictionary: [String: Any] = [
    "name": "小明",
    "age": 25,
    "scores": [98, 87, 95]
]

// 泛型或复杂返回类型时使用显式声明
func fetchItems<T: Decodable>(of type: T.Type) -> AnyPublisher<T, Error> {
    // 实现逻辑
}</code></pre>
            </div>

            <h3>4.3 属性包装器</h3>
            <p>Swift 的属性包装器提供了一种重用属性逻辑的强大方式。</p>

            <div class="example">
                <h4>示例：自定义属性包装器</h4>
                <pre><code>// 创建一个确保值在特定范围内的属性包装器
@propertyWrapper
struct Clamping&lt;Value: Comparable> {
    private var value: Value
    private let range: ClosedRange&lt;Value>

    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }

    init(wrappedValue: Value, range: ClosedRange&lt;Value>) {
        self.range = range
        self.value = min(max(range.lowerBound, wrappedValue), range.upperBound)
    }
}

// 使用自定义属性包装器
struct Player {
    @Clamping(range: 0...100)
    var health: Int = 100

    @Clamping(range: 0...999)
    var score: Int = 0
}

// SwiftUI 中的属性包装器示例
struct ContentView: View {
    @State private var text = ""
    @Binding var isEnabled: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TextField("输入文本", text: $text)
    }
}</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>5. 函数和闭包规范</h2>

            <h3>5.1 函数参数设计</h3>
            <p>良好的函数设计使代码更易于理解和维护。</p>

            <svg width="100%" height="280" viewBox="0 0 600 280" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="20" width="500" height="240" rx="10" ry="10" fill="none" stroke="var(--secondary-color)" stroke-width="2"/>
                <text x="300" y="50" font-size="18" text-anchor="middle" fill="var(--header-color)">函数设计最佳实践</text>

                <line x1="50" y1="70" x2="550" y2="70" stroke="var(--border-color)" stroke-width="1"/>

                <text x="150" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">明确参数标签</text>
                <text x="400" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">提高可读性</text>

                <text x="150" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">默认参数值</text>
                <text x="400" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">简化API调用</text>

                <text x="150" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">函数参数数量</text>
                <text x="400" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">保持在4个以内</text>

                <text x="150" y="220" font-size="16" text-anchor="middle" fill="var(--text-color)">纯函数设计</text>
                <text x="400" y="220" font-size="16" text-anchor="middle" fill="var(--text-color)">相同输入总是产生相同输出</text>
            </svg>

            <div class="example">
                <h4>示例：函数设计</h4>
                <pre><code>// 参数标签提高可读性
func calculateDistance(from source: Point, to destination: Point) -> Double {
    // 实现逻辑
    return 0.0
}

// 使用默认参数值
func fetchUsers(limit: Int = 20, offset: Int = 0) async throws -> [User] {
    // 实现逻辑
    return []
}

// 使用尾随闭包语法
func animateView(duration: TimeInterval, animations: () -> Void, completion: ((Bool) -> Void)? = nil) {
    // 实现逻辑
}

// 函数重载
func process(_ data: Data) { /* 处理二进制数据 */ }
func process(_ text: String) { /* 处理文本数据 */ }

// 使用例子
let distance = calculateDistance(from: point1, to: point2)
animateView(duration: 0.3) {
    view.alpha = 0
} completion: { finished in
    if finished {
        view.removeFromSuperview()
    }
}</code></pre>
            </div>

            <h3>5.2 闭包使用规范</h3>
            <p>闭包是 Swift 中的一等公民，正确使用闭包可以编写更加简洁、灵活的代码。</p>

            <div class="example">
                <h4>示例：闭包使用</h4>
                <pre><code>// 基本闭包用法
let numbers = [1, 2, 3, 4, 5]
let squared = numbers.map { $0 * $0 }

// 捕获列表 - 避免循环引用
class PhotoViewController {
    var downloadTask: Task&lt;Void, Error>?

    func loadImage() {
        downloadTask = Task { [weak self] in
            guard let self = self else { return }
            let image = try await self.downloadImage()
            await MainActor.run {
                self.imageView.image = image
            }
        }
    }

    func downloadImage() async throws -> UIImage {
        // 下载逻辑
        return UIImage()
    }
}

// 尾随闭包简化语法
let sortedNames = names.sorted { $0.localizedCaseInsensitiveCompare($0) == .orderedAscending }

// 多个闭包参数时的命名写法
URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data, error == nil else {
        // 错误处理
        return
    }
    // 处理数据
}.resume()</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>6. 错误处理规范</h2>
            <p>Swift 的错误处理机制允许你以结构化、类型安全的方式处理错误情况。</p>

            <h3>6.1 错误定义与处理</h3>

            <div class="example">
                <h4>示例：错误定义与处理</h4>
                <pre><code>// 定义错误类型
enum NetworkError: Error {
    case invalidURL
    case noConnection
    case serverError(statusCode: Int)
    case decodingFailed

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "无效的URL"
        case .noConnection:
            return "网络连接失败"
        case .serverError(let statusCode):
            return "服务器错误: \(statusCode)"
        case .decodingFailed:
            return "数据解析失败"
        }
    }
}

// 抛出错误
func fetchData(from urlString: String) throws -> Data {
    guard let url = URL(string: urlString) else {
        throw NetworkError.invalidURL
    }

    // 实现逻辑
    return Data()
}

// 捕获和处理错误
func loadUserProfile() {
    do {
        let data = try fetchData(from: "https://api.example.com/profile")
        let profile = try JSONDecoder().decode(UserProfile.self, from: data)
        updateUI(with: profile)
    } catch NetworkError.invalidURL {
        showError("URL格式不正确")
    } catch NetworkError.serverError(let code) {
        showError("服务器返回错误: \(code)")
    } catch {
        showError("发生未知错误: \(error.localizedDescription)")
    }
}

// 使用 try? 和 try! (谨慎使用)
let data = try? fetchData(from: someURL)
let definitelyValidData = try! fetchData(from: guaranteedValidURL)</code></pre>
            </div>

            <h3>6.2 Result 类型</h3>
            <p>Result 类型提供了一种优雅的方式来处理可能成功或失败的操作。</p>

            <div class="example">
                <h4>示例：使用 Result 类型</h4>
                <pre><code>// 使用 Result 类型的函数
func fetchUser(id: String, completion: @escaping (Result&lt;User, NetworkError>) -> Void) {
    guard let url = URL(string: "https://api.example.com/users/\(id)") else {
        completion(.failure(.invalidURL))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(.noConnection))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            completion(.failure(.serverError(statusCode: statusCode)))
            return
        }

        guard let data = data else {
            completion(.failure(.decodingFailed))
            return
        }

        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            completion(.success(user))
        } catch {
            completion(.failure(.decodingFailed))
        }
    }.resume()
}

// 使用 Result 类型的函数
fetchUser(id: "123") { result in
    switch result {
    case .success(let user):
        print("获取用户成功: \(user.name)")
    case .failure(let error):
        print("获取用户失败: \(error.localizedDescription)")
    }
}

// 使用 Result 的 map 和 flatMap 方法
fetchUser(id: "123") { result in
    let username = result
        .map { $0.name }
        .map { "用户: \($0)" }
        .mapError { error -> NetworkError in
            print("处理错误: \(error)")
            return error
        }
}</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>7. 并发编程规范</h2>
            <p>Swift 5.5 引入了现代化的并发模型，使用 async/await、Actor 和结构化并发。</p>

            <svg width="100%" height="280" viewBox="0 0 600 280" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="20" width="500" height="240" rx="10" ry="10" fill="none" stroke="var(--accent-color)" stroke-width="2"/>
                <text x="300" y="50" font-size="18" text-anchor="middle" fill="var(--header-color)">Swift 并发模型</text>

                <line x1="50" y1="70" x2="550" y2="70" stroke="var(--border-color)" stroke-width="1"/>

                <text x="150" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">async/await</text>
                <text x="400" y="100" font-size="16" text-anchor="middle" fill="var(--text-color)">简化异步代码</text>

                <text x="150" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">Actor</text>
                <text x="400" y="140" font-size="16" text-anchor="middle" fill="var(--text-color)">安全共享可变状态</text>

                <text x="150" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">Task</text>
                <text x="400" y="180" font-size="16" text-anchor="middle" fill="var(--text-color)">结构化并发单位</text>

                <text x="150" y="220" font-size="16" text-anchor="middle" fill="var(--text-color)">TaskGroup</text>
                <text x="400" y="220" font-size="16" text-anchor="middle" fill="var(--text-color)">并行执行多个任务</text>
            </svg>

            <div class="example">
                <h4>示例：现代 Swift 并发</h4>
                <pre><code>// 异步函数
func fetchData() async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: someURL)
    return data
}

// 调用异步函数
func loadProfilePicture() async throws -> UIImage {
    let data = try await fetchData()
    guard let image = UIImage(data: data) else {
        throw ImageError.invalidData
    }
    return image
}

// 使用 Task 在非异步上下文中调用异步函数
func updateUserInterface() {
    Task {
        do {
            let image = try await loadProfilePicture()

            // 在主线程更新 UI
            await MainActor.run {
                profileImageView.image = image
            }
        } catch {
            print("加载图片失败: \(error)")
        }
    }
}

// 使用 Actor 安全共享可变状态
actor ImageCache {
    private var cache = [URL: UIImage]()

    func image(for url: URL) -> UIImage? {
        return cache[url]
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache[url] = image
    }

    func clear() {
        cache.removeAll()
    }
}

// 使用 TaskGroup 并行执行任务
func loadImages(urls: [URL]) async throws -> [UIImage] {
    try await withThrowingTaskGroup(of: (Int, UIImage).self) { group in
        var images = [UIImage?](repeating: nil, count: urls.count)

        for (index, url) in urls.enumerated() {
            group.addTask {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else {
                    throw ImageError.invalidData
                }
                return (index, image)
            }
        }

        // 收集结果
        for try await (index, image) in group {
            images[index] = image
        }

        return images.compactMap { $0 }
    }
}</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>8. 内存管理规范</h2>
            <p>Swift 使用自动引用计数 (ARC) 来管理内存，但开发者仍需了解和避免内存问题。</p>

            <h3>8.1 解决循环引用问题</h3>

            <div class="example">
                <h4>示例：捕获列表和弱引用</h4>
                <pre><code>// 类之间的循环引用
class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) { self.name = name }

    deinit { print("\(name) 被释放") }
}

class Apartment {
    let number: Int
    // 使用 weak 避免循环引用
    weak var tenant: Person?

    init(number: Int) { self.number = number }

    deinit { print("公寓 #\(number) 被释放") }
}

// 使用示例
do {
    let john = Person(name: "John")
    let apt = Apartment(number: 123)

    john.apartment = apt
    apt.tenant = john

    // 退出作用域后，两个对象都会被释放
}

// 闭包中的循环引用
class NetworkManager {
    var onComplete: (() -> Void)?

    func fetchData() {
        // 使用 [weak self] 避免循环引用
        URLSession.shared.dataTask(with: someURL) { [weak self] data, _, _ in
            guard let self = self else { return }
            self.processData(data)
            self.onComplete?()
        }.resume()
    }

    func processData(_ data: Data?) {
        // 处理数据
    }

    deinit {
        print("NetworkManager 被释放")
    }
}</code></pre>
            </div>

            <h3>8.2 值类型与引用类型</h3>
            <p>理解值类型和引用类型的区别，以及何时使用每种类型对内存管理至关重要。</p>

            <svg width="100%" height="280" viewBox="0 0 600 280" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="20" width="500" height="240" rx="10" ry="10" fill="none" stroke="var(--secondary-color)" stroke-width="2"/>
                <text x="300" y="50" font-size="18" text-anchor="middle" fill="var(--header-color)">值类型 vs 引用类型</text>
                
                <line x1="50" y1="70" x2="550" y2="70" stroke="var(--border-color)" stroke-width="1"/>
                
                <line x1="300" y1="70" x2="300" y2="260" stroke="var(--border-color)" stroke-width="1"/>
                
                <text x="175" y="95" font-size="16" text-anchor="middle" fill="var(--header-color)">值类型</text>
                <text x="425" y="95" font-size="16" text-anchor="middle" fill="var(--header-color)">引用类型</text>
                
                <text x="175" y="130" font-size="14" text-anchor="middle" fill="var(--text-color)">struct, enum, tuple</text>
                <text x="425" y="130" font-size="14" text-anchor="middle" fill="var(--text-color)">class, closure</text>
                
                <text x="175" y="165" font-size="14" text-anchor="middle" fill="var(--text-color)">复制时创建新副本</text>
                <text x="425" y="165" font-size="14" text-anchor="middle" fill="var(--text-color)">复制时共享引用</text>
                
                <text x="175" y="200" font-size="14" text-anchor="middle" fill="var(--text-color)">线程安全</text>
                <text x="425" y="200" font-size="14" text-anchor="middle" fill="var(--text-color)">需要同步机制</text>
                
                <text x="175" y="235" font-size="14" text-anchor="middle" fill="var(--text-color)">适用于数据模型</text>
                <text x="425" y="235" font-size="14" text-anchor="middle" fill="var(--text-color)">适用于共享资源</text>
            </svg>

            <div class="example">
                <h4>示例：值类型与引用类型</h4>
                <pre><code>// 值类型示例（结构体）
struct Point {
    var x: Double
    var y: Double
}

var point1 = Point(x: 10, y: 20)
var point2 = point1     // 创建副本
point2.x = 15           // 只修改 point2，不影响 point1
print(point1.x)         // 输出：10
print(point2.x)         // 输出：15

// 引用类型示例（类）
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let person1 = Person(name: "张三")
let person2 = person1     // 共享同一个引用
person2.name = "李四"     // 修改会影响 person1
print(person1.name)       // 输出："李四"
print(person2.name)       // 输出："李四"

// 内存优化 - 使用 Copy-on-Write
// 标准库中的集合类型（如Array、Dictionary）使用此技术
var array1 = [1, 2, 3]
var array2 = array1     // 此时并未复制内存
array2.append(4)        // 修改时才创建新副本</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>9. 代码文档规范</h2>
            <p>良好的代码文档能够提高代码的可维护性，Swift 支持标准的 Markdown 文档注释。</p>

            <h3>9.1 文档注释</h3>
            
            <div class="example">
                <h4>示例：文档注释</h4>
                <pre><code>/// 表示用户的结构体
///
/// `User` 包含用户的基本信息以及身份验证所需的数据。
/// 这是一个值类型，推荐在传递用户数据时使用。
///
/// ## 使用示例
///
/// ```swift
/// let user = User(id: "12345", name: "小明", email: "xiaoming@example.com")
/// print(user.displayName) // 输出用户的显示名称
/// ```
struct User {
    /// 用户的唯一标识符
    let id: String
    
    /// 用户的名称
    var name: String
    
    /// 用户的电子邮件地址
    var email: String
    
    /// 用户的显示名称
    ///
    /// 如果用户有名称，则返回名称；否则返回邮箱的前缀部分。
    var displayName: String {
        return name.isEmpty ? email.components(separatedBy: "@").first ?? email : name
    }
    
    /// 创建一个新用户
    /// - Parameters:
    ///   - id: 用户唯一标识符
    ///   - name: 用户名称
    ///   - email: 用户电子邮件地址
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    /// 更新用户信息
    /// - Parameter newName: 新的用户名称
    /// - Returns: 更新后的用户对象
    func updated(with newName: String) -> User {
        return User(id: self.id, name: newName, email: self.email)
    }
}</code></pre>
            </div>

            <h3>9.2 TODO 和 FIXME 标记</h3>
            <p>使用标准化的标记可以帮助团队追踪需要完成或修复的代码。</p>
            
            <div class="example">
                <h4>示例：标记注释</h4>
                <pre><code>// TODO: 实现缓存机制提高查询效率
func fetchUserData(for id: String) async throws -> User {
    let data = try await networkService.fetchData(endpoint: "users/\(id)")
    return try JSONDecoder().decode(User.self, from: data)
}

// FIXME: 这里可能会有内存泄漏，需要重新检查闭包引用
class DataProcessor {
    var onDataProcessed: ((Result<Data, Error>) -> Void)?
    
    func processData() {
        // 处理逻辑...
        onDataProcessed?(.success(processedData))
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 处理选择逻辑
    }
}</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>10. 性能优化最佳实践</h2>
            <p>Swift 代码的性能优化涉及理解 Swift 的工作原理以及编译器优化。</p>

            <h3>10.1 关键性能优化技巧</h3>
            
            <div class="example">
                <h4>示例：性能优化</h4>
                <pre><code>// 1. 避免可选链过长
// 不推荐
let userName = user?.profile?.settings?.displayName?.uppercased()

// 推荐
if let user = user, 
   let profile = user.profile,
   let settings = profile.settings,
   let displayName = settings.displayName {
    let userName = displayName.uppercased()
}

// 2. 重用计算复杂的值
// 不推荐
for item in items {
    if complexCalculation() > threshold {
        // 每次循环都重复计算
    }
}

// 推荐
let calculatedValue = complexCalculation()
for item in items {
    if calculatedValue > threshold {
        // 只计算一次
    }
}

// 3. 使用惰性属性延迟初始化昂贵资源
class ImageProcessor {
    lazy var heavyResourceManager: ResourceManager = {
        let manager = ResourceManager()
        manager.configure()
        return manager
    }()
}

// 4. 优化集合操作
// 预分配容量
var names = [String]()
names.reserveCapacity(1000)  // 减少重新分配

// 使用 filter + first 替代 first(where:)
// 不推荐 - 需要遍历整个数组
let found = array.first(where: { complexCheck($0) })

// 推荐 - 找到后立即停止
let found = array.lazy.filter { complexCheck($0) }.first

// 5. 使用 final 关键字避免动态派发
final class OptimizedClass {
    func performOperation() {
        // 方法不会被重写，可以静态派发
    }
}

// 6. 使用 `@inlinable` 和 `@inline(__always)` 进行内联优化
extension Array {
    @inlinable
    func fastOperation() -> Element? {
        // 实现逻辑
    }
}</code></pre>
            </div>

            <h3>10.2 测量和分析性能</h3>
            
            <div class="example">
                <h4>示例：性能测量</h4>
                <pre><code>// 使用 CFAbsoluteTimeGetCurrent() 测量性能
func measureExecutionTime(operation: () -> Void) -> TimeInterval {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let endTime = CFAbsoluteTimeGetCurrent()
    return endTime - startTime
}

// 使用示例
let executionTime = measureExecutionTime {
    // 需要测量的代码
    for _ in 0...1000 {
        let _ = complexOperation()
    }
}
print("执行时间: \(executionTime) 秒")

// 使用 os_signpost 进行性能记录 (iOS 12+ / macOS 10.14+)
import os.signpost

let log = OSLog(subsystem: "com.example.app", category: "Performance")

func performComplexTask() {
    let signpostID = OSSignpostID(log: log)
    os_signpost(.begin, log: log, name: "ComplexTask", signpostID: signpostID)
    
    // 执行复杂任务...
    
    os_signpost(.end, log: log, name: "ComplexTask", signpostID: signpostID)
}</code></pre>
            </div>
        </div>

        <div class="section">
            <h2>11. Swift 生态资源</h2>
            
            <h3>11.1 官方资源</h3>
            <div class="resources">
                <div class="resource-card">
                    <h4>Swift 官方文档</h4>
                    <p>Swift 编程语言的官方文档和指南</p>
                    <a href="https://swift.org/documentation/" target="_blank">访问资源</a>
                </div>
                
                <div class="resource-card">
                    <h4>Apple 开发者文档</h4>
                    <p>包含 Swift 和 Apple 平台开发的全面文档</p>
                    <a href="https://developer.apple.com/documentation/swift" target="_blank">访问资源</a>
                </div>
                
                <div class="resource-card">
                    <h4>Swift 标准库源码</h4>
                    <p>了解 Swift 标准库的实现</p>
                    <a href="https://github.com/apple/swift" target="_blank">访问资源</a>
                </div>
            </div>

            <h3>11.2 推荐书籍</h3>
            <div class="resources">
                <div class="resource-card">
                    <h4>Swift 编程权威指南</h4>
                    <p>作者：王巍 (喵神)</p>
                    <p>中文社区最受欢迎的 Swift 教程之一</p>
                </div>
                
                <div class="resource-card">
                    <h4>Swift 进阶</h4>
                    <p>作者：王巍 (喵神)</p>
                    <p>深入探讨 Swift 高级特性的优秀著作</p>
                </div>
                
                <div class="resource-card">
                    <h4>Swift Programming: The Big Nerd Ranch Guide</h4>
                    <p>全面介绍 Swift 编程的英文经典书籍</p>
                </div>
                
                <div class="resource-card">
                    <h4>Advanced Swift</h4>
                    <p>作者：Chris Eidhof 等</p>
                    <p>深入讲解 Swift 高级特性和技巧</p>
                </div>
            </div>

            <h3>11.3 优秀开源项目</h3>
            <div class="resources">
                <div class="resource-card">
                    <h4>Alamofire</h4>
                    <p>优雅的 Swift 网络请求库</p>
                    <a href="https://github.com/Alamofire/Alamofire" target="_blank">GitHub 仓库</a>
                </div>
                
                <div class="resource-card">
                    <h4>SwiftyJSON</h4>
                    <p>Swift 中处理 JSON 的简单方法</p>
                    <a href="https://github.com/SwiftyJSON/SwiftyJSON" target="_blank">GitHub 仓库</a>
                </div>
                
                <div class="resource-card">
                    <h4>RxSwift</h4>
                    <p>Swift 的响应式编程框架</p>
                    <a href="https://github.com/ReactiveX/RxSwift" target="_blank">GitHub 仓库</a>
                </div>
                
                <div class="resource-card">
                    <h4>Kingfisher</h4>
                    <p>强大的图片下载和缓存库</p>
                    <a href="https://github.com/onevcat/Kingfisher" target="_blank">GitHub 仓库</a>
                </div>
            </div>

            <h3>11.4 学习视频和课程</h3>
            <div class="resources">
                <div class="resource-card">
                    <h4>Stanford CS193p</h4>
                    <p>斯坦福大学的 iOS 开发课程</p>
                    <a href="https://cs193p.sites.stanford.edu/" target="_blank">访问课程</a>
                </div>
                
                <div class="resource-card">
                    <h4>WWDC 视频</h4>
                    <p>Apple 开发者大会的技术讲座</p>
                    <a href="https://developer.apple.com/videos/" target="_blank">访问资源</a>
                </div>
                
                <div class="resource-card">
                    <h4>Swift 中文社区视频教程</h4>
                    <p>中文 Swift 教学视频和教程</p>
                    <a href="https://swiftgg.gitbook.io/swift/" target="_blank">访问资源</a>
                </div>
            </div>

            <h3>11.5 Swift 博客</h3>
            <div class="resources">
                <div class="resource-card">
                    <h4>Swift by Sundell</h4>
                    <p>有关 Swift 开发的深度文章和教程</p>
                    <a href="https://www.swiftbysundell.com/" target="_blank">访问博客</a>
                </div>
                
                <div class="resource-card">
                    <h4>喵神 - 王巍的博客</h4>
                    <p>中文 Swift 社区领军人物的博客</p>
                    <a href="https://onevcat.com/" target="_blank">访问博客</a>
                </div>
                
                <div class="resource-card">
                    <h4>NSHipster</h4>
                    <p>关注被忽视的 Swift、Objective-C 和 Cocoa 特性</p>
                    <a href="https://nshipster.com/" target="_blank">访问博客</a>
                </div>
                
                <div class="resource-card">
                    <h4>Swift Talk</h4>
                    <p>来自 objc.io 的 Swift 视频系列</p>
                    <a href="https://talk.objc.io/" target="_blank">访问资源</a>
                </div>
            </div>
        </div>


    </div>

    <script>
        // 检测系统颜色模式变化
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
            document.body.classList.toggle('dark-mode', e.matches);
        });
    </script>
</body>
</html>
