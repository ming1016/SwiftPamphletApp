<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift基础 - 不透明类型</title>
    <style>
        :root {
            --background: #f9f5f0;
            --text-color: #333;
            --code-bg: #f5f5f5;
            --code-color: #333;
            --accent-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --tertiary-color: #ffd166;
            --border-color: #ddd;
            --link-color: #1e88e5;
            --card-bg: #ffffff;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --background: #1c1c1e;
                --text-color: #f0f0f0;
                --code-bg: #2d2d30;
                --code-color: #e6e6e6;
                --accent-color: #ff7979;
                --secondary-color: #5ddbd3;
                --tertiary-color: #ffda85;
                --border-color: #444;
                --link-color: #64b5f6;
                --card-bg: #2c2c2e;
            }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--background);
            color: var(--text-color);
            line-height: 1.6;
            padding: 20px;
            max-width: 1000px;
            margin: 0 auto;
            transition: background-color 0.3s, color 0.3s;
        }

        h1, h2, h3, h4 {
            color: var(--accent-color);
            margin: 1.5rem 0 1rem 0;
            font-weight: 700;
            border-bottom: 2px solid var(--tertiary-color);
            padding-bottom: 0.5rem;
            display: inline-block;
        }

        h1 {
            font-size: 2.5rem;
            text-align: center;
            display: block;
            margin-bottom: 2rem;
            border: none;
            position: relative;
        }

        h1::after {
            content: "";
            display: block;
            width: 100px;
            height: 5px;
            background: var(--tertiary-color);
            margin: 0.5rem auto;
            border-radius: 5px;
        }

        h2 {
            font-size: 2rem;
            margin-top: 2.5rem;
        }

        h3 {
            font-size: 1.5rem;
            color: var(--secondary-color);
        }

        p {
            margin-bottom: 1.2rem;
            text-align: justify;
        }

        pre {
            background: var(--code-bg);
            border-radius: 10px;
            padding: 15px;
            overflow-x: auto;
            margin: 1.5rem 0;
            border: 2px solid var(--border-color);
        }

        code {
            font-family: "SF Mono", SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace;
            color: var(--code-color);
            font-size: 0.9rem;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--link-color);
            transition: all 0.2s;
        }

        a:hover {
            color: var(--accent-color);
            border-bottom: 1px solid var(--accent-color);
        }

        ul, ol {
            margin: 1rem 0 1rem 2rem;
        }

        li {
            margin-bottom: 0.5rem;
        }

        .card {
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border-left: 4px solid var(--accent-color);
        }

        .note {
            background-color: rgba(77, 208, 225, 0.1);
            border-left: 4px solid var(--secondary-color);
        }

        .warning {
            background-color: rgba(255, 209, 102, 0.1);
            border-left: 4px solid var(--tertiary-color);
        }

        .resource-section {
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
        }

        .resource-group {
            margin-bottom: 20px;
        }

        .resource-group h4 {
            border: none;
            color: var(--secondary-color);
        }

        .example-container {
            border: 2px solid var(--tertiary-color);
            border-radius: 10px;
            margin: 20px 0;
            overflow: hidden;
        }

        .example-title {
            background-color: var(--tertiary-color);
            color: #333;
            padding: 10px 15px;
            font-weight: bold;
        }

        .example-content {
            padding: 15px;
        }

        .concept-diagram {
            display: block;
            margin: 2rem auto;
            max-width: 100%;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.6rem;
            }

            pre {
                padding: 10px;
            }
        }

        .comparison-table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
        }

        .comparison-table th,
        .comparison-table td {
            border: 1px solid var(--border-color);
            padding: 12px;
            text-align: left;
        }

        .comparison-table th {
            background-color: var(--tertiary-color);
            color: #333;
        }

        .comparison-table tr:nth-child(even) {
            background-color: rgba(0,0,0,0.05);
        }

        @media (prefers-color-scheme: dark) {
            .comparison-table tr:nth-child(even) {
                background-color: rgba(255,255,255,0.05);
            }

            .example-title {
                color: #222;
            }
        }
    </style>
</head>
<body>
    <h1>Swift中的不透明类型(Opaque Types)</h1>

    <div class="card">
        <p>不透明类型是Swift 5.1中引入的一个重要特性，它允许函数隐藏返回值的具体类型，同时仍然保留类型信息。不透明类型使用<code>some</code>关键字来表示，它与泛型协同工作，为代码提供了更好的封装和抽象能力。</p>
    </div>

    <h2>什么是不透明类型?</h2>

    <p>不透明类型让函数可以隐藏其返回值的确切类型，只暴露出符合特定协议或约束的类型。这与返回协议类型不同，因为返回的是一个具体类型，而不是一个可能是多种类型的协议类型。</p>

    <svg class="concept-diagram" width="600" height="300" viewBox="0 0 600 300">
        <style>
            .box { fill: var(--card-bg); stroke: var(--accent-color); stroke-width: 3; rx: 15; ry: 15; }
            .arrow { fill: none; stroke: var(--tertiary-color); stroke-width: 3; marker-end: url(#arrowhead); }
            .label { font-family: -apple-system, BlinkMacSystemFont, sans-serif; font-size: 14px; fill: var(--text-color); }
            .title { font-weight: bold; font-size: 16px; fill: var(--accent-color); }
        </style>
        <defs>
            <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
                <polygon points="0 0, 10 3.5, 0 7" fill="var(--tertiary-color)" />
            </marker>
        </defs>
        <rect x="50" y="50" width="200" height="80" class="box" />
        <text x="150" y="85" text-anchor="middle" class="title">函数返回具体类型</text>
        <text x="150" y="115" text-anchor="middle" class="label">外部知道确切类型</text>

        <rect x="50" y="170" width="200" height="80" class="box" />
        <text x="150" y="205" text-anchor="middle" class="title">函数返回协议类型</text>
        <text x="150" y="235" text-anchor="middle" class="label">外部只知道它符合协议</text>

        <rect x="350" y="110" width="200" height="80" class="box" />
        <text x="450" y="145" text-anchor="middle" class="title">函数返回不透明类型</text>
        <text x="450" y="175" text-anchor="middle" class="label">外部知道它是特定的一种类型</text>

        <path d="M250 90 C300 90, 300 150, 350 150" class="arrow" />
        <path d="M250 210 C300 210, 300 150, 350 150" class="arrow" />
    </svg>

    <h2>不透明类型的核心特点</h2>

    <ul>
        <li><strong>类型标识保留</strong>：虽然类型被隐藏，但编译器知道它是具体的单一类型</li>
        <li><strong>反向泛型</strong>：泛型让调用者选择类型，不透明类型让实现者选择类型</li>
        <li><strong>类型抽象</strong>：隐藏具体实现，同时保留类型信息</li>
        <li><strong>保留Self类型</strong>：可以与Self类型一起使用，这是返回协议类型无法做到的</li>
    </ul>

    <h2>不透明类型与协议类型的对比</h2>

    <table class="comparison-table">
        <tr>
            <th>特性</th>
            <th>不透明类型 (some Protocol)</th>
            <th>协议类型 (Protocol)</th>
        </tr>
        <tr>
            <td>返回类型</td>
            <td>单一具体类型</td>
            <td>任何符合协议的类型</td>
        </tr>
        <tr>
            <td>类型保留</td>
            <td>是(编译时)</td>
            <td>否(仅接口)</td>
        </tr>
        <tr>
            <td>使用Self</td>
            <td>支持</td>
            <td>不支持</td>
        </tr>
        <tr>
            <td>调用同一函数返回相同类型</td>
            <td>是，必须返回相同的底层类型</td>
            <td>否，可以返回不同的底层类型</td>
        </tr>
    </table>

    <h2>使用不透明类型的场景</h2>

    <div class="card note">
        <h3>适合使用不透明类型的情况</h3>
        <ul>
            <li>需要隐藏具体实现但保留类型信息</li>
            <li>函数返回的类型需要使用Self或关联类型</li>
            <li>实现模块化设计和抽象</li>
            <li>SwiftUI视图构建</li>
        </ul>
    </div>

    <h2>代码示例</h2>

    <div class="example-container">
        <div class="example-title">示例1：基本的不透明类型</div>
        <div class="example-content">
            <pre><code>import Foundation

// 定义一个简单的协议
protocol Shape {
    func draw() -> String
}

// 实现几个符合Shape协议的类型
struct Circle: Shape {
    func draw() -> String {
        return "○"
    }
}

struct Square: Shape {
    func draw() -> String {
        return "□"
    }
}

// 不使用不透明类型，返回协议类型
func makeShape(isCircle: Bool) -> Shape {
    if isCircle {
        return Circle()
    } else {
        return Square()
    }
}

// 使用不透明类型
func makeShapeOpaque(isCircle: Bool) -> some Shape {
    // 错误：不能在一个函数体中返回不同的具体类型
    // if isCircle {
    //     return Circle()
    // } else {
    //     return Square()
    // }

    // 正确：一个函数只能返回一种具体类型
    return Circle()
}

let shape1 = makeShape(isCircle: true)
print(shape1.draw()) // 输出: ○

let shape2 = makeShapeOpaque(isCircle: true)
print(shape2.draw()) // 输出: ○</code></pre>
        </div>
    </div>

    <div class="example-container">
        <div class="example-title">示例2：不透明类型与泛型</div>
        <div class="example-content">
            <pre><code>import Foundation

// 泛型与不透明类型结合
protocol Collection {
    associatedtype Element
    var count: Int { get }
    subscript(index: Int) -> Element { get }
}

// 一个简单的数组封装
struct ArrayWrapper&lt;T&gt;: Collection {
    private var items: [T]

    init(_ items: [T]) {
        self.items = items
    }

    var count: Int {
        return items.count
    }

    subscript(index: Int) -> T {
        return items[index]
    }
}

// 返回不透明的集合类型
func createCollection&lt;T&gt;(items: [T]) -> some Collection where T: Comparable {
    return ArrayWrapper(items)
}

let numbers = createCollection(items: [1, 2, 3, 4, 5])
print("集合中元素个数: \(numbers.count)")
print("第一个元素: \(numbers[0])")</code></pre>
        </div>
    </div>

    <div class="example-container">
        <div class="example-title">示例3：SwiftUI中的不透明类型</div>
        <div class="example-content">
            <pre><code>import SwiftUI

// SwiftUI大量使用不透明类型
struct ContentView: View {
    var body: some View {  // 返回不透明类型
        VStack {
            Text("Hello, 不透明类型!")
                .font(.largeTitle)

            Button("点击我") {
                print("按钮点击")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// 自定义修饰符
extension View {
    func customRoundedStyle() -> some View {
        self.padding()
            .background(Color.green)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}</code></pre>
        </div>
    </div>

    <div class="example-container">
        <div class="example-title">示例4：使用不透明类型保留Self类型</div>
        <div class="example-content">
            <pre><code>import Foundation

// 定义一个使用Self的协议
protocol Duplicatable {
    func duplicate() -> Self
}

// 实现符合协议的结构体
struct Message: Duplicatable {
    var content: String

    func duplicate() -> Self {
        return Message(content: self.content + " (复制)")
    }
}

// 使用不透明类型来保留Self
func createAndDuplicate() -> some Duplicatable {
    let original = Message(content: "原始消息")
    return original
}

let item = createAndDuplicate()
let duplicated = item.duplicate()
// 如果返回协议类型(Duplicatable)而不是不透明类型(some Duplicatable)，
// duplicate()方法将无法正常工作，因为Self类型信息会丢失</code></pre>
        </div>
    </div>

    <h2>不透明类型与泛型的关系</h2>

    <p>不透明类型可以被视为"反向泛型"。在泛型中，<strong>调用者</strong>决定具体类型。而使用不透明类型时，<strong>实现者</strong>决定具体类型。</p>

    <svg class="concept-diagram" width="600" height="300" viewBox="0 0 600 300">
        <rect x="100" y="50" width="400" height="100" rx="20" ry="20" fill="var(--card-bg)" stroke="var(--accent-color)" stroke-width="3"/>
        <text x="300" y="90" text-anchor="middle" font-size="18" font-weight="bold" fill="var(--accent-color)">泛型函数</text>
        <text x="300" y="120" text-anchor="middle" font-size="14" fill="var(--text-color)">func process&lt;T&gt;(value: T) { ... }</text>
        <text x="300" y="145" text-anchor="middle" font-size="12" fill="var(--tertiary-color)">调用者决定T的类型</text>

        <rect x="100" y="180" width="400" height="100" rx="20" ry="20" fill="var(--card-bg)" stroke="var(--secondary-color)" stroke-width="3"/>
        <text x="300" y="220" text-anchor="middle" font-size="18" font-weight="bold" fill="var(--secondary-color)">不透明类型函数</text>
        <text x="300" y="250" text-anchor="middle" font-size="14" fill="var(--text-color)">func create() -> some Protocol { ... }</text>
        <text x="300" y="275" text-anchor="middle" font-size="12" fill="var(--tertiary-color)">实现者决定返回的具体类型</text>

        <path d="M300 150 L300 180" stroke="var(--tertiary-color)" stroke-width="3" marker-end="url(#arrowhead)"/>
    </svg>

    <h2>不透明类型的限制</h2>

    <div class="card warning">
        <h3>使用不透明类型时需注意</h3>
        <ul>
            <li>一个函数只能返回一种具体类型，不能根据条件返回不同类型</li>
            <li>返回类型必须始终是同一个具体类型，即使它被隐藏</li>
            <li>如果需要返回多种可能的类型，应使用协议类型或枚举</li>
        </ul>
    </div>

    <h2>适用场景示例</h2>

    <div class="example-container">
        <div class="example-title">示例5：构建可组合的数据转换管道</div>
        <div class="example-content">
            <pre><code>import Foundation

// 定义一个转换器协议
protocol DataTransformer {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}

// 实现各种转换器
struct StringToIntTransformer: DataTransformer {
    func transform(_ input: String) -> Int? {
        return Int(input)
    }
}

struct IntToDoubleTransformer: DataTransformer {
    func transform(_ input: Int) -> Double {
        return Double(input)
    }
}

// 转换器组合器
struct TransformerPipeline&lt;First: DataTransformer, Second: DataTransformer&gt;: DataTransformer
where First.Output == Second.Input {
    let first: First
    let second: Second

    func transform(_ input: First.Input) -> Second.Output {
        let intermediate = first.transform(input)
        return second.transform(intermediate)
    }
}

// 使用不透明类型创建转换器
func createStringToDoubleTransformer() -> some DataTransformer
where String == DataTransformer.Input, Double == DataTransformer.Output {

    let stringToInt = StringToIntTransformer()
    let intToDouble = IntToDoubleTransformer()

    // 返回一个合成的转换器，但对外隐藏其实现细节
    return TransformerPipeline(first: stringToInt, second: intToDouble)
}

// 使用转换器
let transformer = createStringToDoubleTransformer()
if let result = transformer.transform("42") {
    print("转换结果: \(result)") // 输出: 42.0
}</code></pre>
        </div>
    </div>

    <h2>与协议关联类型结合使用</h2>

    <p>不透明类型解决了使用含有关联类型的协议作为返回类型的限制，让API更灵活、更封装。</p>

    <div class="example-container">
        <div class="example-title">示例6：结合关联类型的协议</div>
        <div class="example-content">
            <pre><code>import Foundation

// 定义含有关联类型的协议
protocol Parser {
    associatedtype Input
    associatedtype Output

    func parse(_ input: Input) -> Output
}

// 具体解析器实现
struct JSONParser: Parser {
    typealias Input = String
    typealias Output = [String: Any]?

    func parse(_ input: String) -> [String: Any]? {
        guard let data = input.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
}

struct XMLParser: Parser {
    func parse(_ input: String) -> Any? {
        // 简化的XML解析
        return ["xml": "内容"]
    }
}

// 不使用不透明类型，无法直接返回Parser
// 错误: Protocol 'Parser' can only be used as a generic constraint because it has Self or associated type requirements
// func createParser() -> Parser { ... }

// 使用不透明类型解决
func createJSONParser() -> some Parser {
    return JSONParser()
}

// 使用
let parser = createJSONParser()
if let result = parser.parse("{\"name\": \"Swift\"}") as? [String: Any] {
    print("解析结果: \(result)")
}</code></pre>
        </div>
    </div>

    <h2>不透明类型与Swift UI</h2>

    <p>SwiftUI大量使用不透明类型来构建声明式的用户界面，并提供高度的类型安全和优化潜力。</p>

    <div class="example-container">
        <div class="example-title">示例7：SwiftUI中的实际应用</div>
        <div class="example-content">
            <pre><code>import SwiftUI

// 视图模型
class UserViewModel: ObservableObject {
    @Published var username: String = "Swift开发者"
    @Published var isLoggedIn: Bool = false
}

// 使用不透明类型构建视图组件
struct UserProfileView: View {
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        // 返回不透明类型 some View
        VStack {
            if viewModel.isLoggedIn {
                loggedInView
            } else {
                loginView
            }
        }
        .padding()
    }

    // 组件化视图，使用不透明类型
    private var loginView: some View {
        Button("登录") {
            self.viewModel.isLoggedIn = true
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }

    private var loggedInView: some View {
        VStack {
            Text("欢迎回来，\(viewModel.username)！")
                .font(.title)

            Button("登出") {
                self.viewModel.isLoggedIn = false
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}</code></pre>
        </div>
    </div>

    <h2>不透明返回类型的性能优势</h2>

    <p>不透明类型可以让编译器保留类型信息，从而进行更多优化，包括：</p>

    <ul>
        <li>静态派发替代动态派发</li>
        <li>内联优化</li>
        <li>编译时类型检查</li>
    </ul>

    <h2>相关资源</h2>

    <div class="resource-section">
        <div class="resource-group">
            <h4>官方文档</h4>
            <ul>
                <li><a href="https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html" target="_blank">Swift官方文档 - 不透明类型</a></li>
                <li><a href="https://developer.apple.com/documentation/swift/opaque_types" target="_blank">Apple Developer - Opaque Types</a></li>
            </ul>
        </div>

        <div class="resource-group">
            <h4>优秀博客文章</h4>
            <ul>
                <li><a href="https://www.swiftbysundell.com/articles/opaque-return-types-in-swift/" target="_blank">Swift by Sundell - Opaque return types in Swift</a></li>
                <li><a href="https://www.hackingwithswift.com/articles/187/how-to-use-opaque-return-types-in-swift" target="_blank">Hacking with Swift - How to use opaque return types in Swift</a></li>
                <li><a href="https://medium.com/@alfianlosari/understanding-some-and-opaque-return-type-in-swift-5-1-and-swiftui-1fd290321831" target="_blank">Medium - Understanding 'some' and Opaque Return Type in Swift 5.1 and SwiftUI</a></li>
            </ul>
        </div>

        <div class="resource-group">
            <h4>相关书籍</h4>
            <ul>
                <li>"Swift进阶" by Chris Eidhof, Ole Begemann, 和 Airspeed Velocity</li>
                <li>"SwiftUI by Tutorials" by raywenderlich.com</li>
                <li>"Pro Swift" by Paul Hudson</li>
            </ul>
        </div>

        <div class="resource-group">
            <h4>视频教程</h4>
            <ul>
                <li><a href="https://developer.apple.com/videos/play/wwdc2019/416/" target="_blank">WWDC 2019 - Modern Swift API Design</a></li>
                <li><a href="https://www.youtube.com/watch?v=SxJPQ5qXisw" target="_blank">Swift Language User Group - Opaque Types in Swift</a></li>
            </ul>
        </div>

        <div class="resource-group">
            <h4>开源项目</h4>
            <ul>
                <li><a href="https://github.com/apple/swift" target="_blank">Swift语言</a> - 查看Swift语言实现中不透明类型的应用</li>
                <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Composable Architecture</a> - 使用不透明类型构建的复杂状态管理框架</li>
                <li><a href="https://github.com/pointfreeco/swiftui-navigation" target="_blank">SwiftUI Navigation</a> - 扩展SwiftUI导航系统的库，大量使用不透明类型</li>
            </ul>
        </div>
    </div>

    <div class="card" style="margin-top: 40px;">
        <h3>总结</h3>
        <p>不透明类型是Swift中一个强大的类型系统功能，让您可以隐藏实现细节同时保留类型信息。它们在与关联类型协议配合、SwiftUI视图构建和模块化设计中特别有用。与协议类型相比，不透明类型可以保留Self类型引用，并让编译器进行更多的优化。</p>
        <p>不透明类型的要点在于：它们提供了一种"反向泛型"机制，由实现者而不是调用者决定具体类型，同时保持了类型安全和编译时检查的优势。</p>
    </div>
</body>
</html>
