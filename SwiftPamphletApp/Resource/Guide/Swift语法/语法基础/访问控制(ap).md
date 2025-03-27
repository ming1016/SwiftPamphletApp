<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 访问控制 - Apple 开发技术手册</title>
    <style>
        :root {
            --bg-color: #c5b396;
            --text-color: #2a2e33;
            --accent-color: #774936;
            --white: #ffffff;
            --code-bg: #f5f2ed;
            --border-color: #2a2e33;
            --link-color: #4a6741;
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --bg-color: #2a2e33;
                --text-color: #e8e0d4;
                --accent-color: #c5b396;
                --white: #333333;
                --code-bg: #3a3e43;
                --border-color: #c5b396;
                --link-color: #a4bc92;
            }
        }
        
        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
        }
        
        header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }
        
        h1 {
            font-family: 'Courier New', Courier, monospace;
            color: var(--text-color);
            font-size: 3rem;
            margin-bottom: 0;
            position: relative;
            display: inline-block;
            transform: rotate(-2deg);
            padding: 10px 30px;
            border: 3px solid var(--border-color);
            background-color: var(--white);
        }
        
        h2 {
            font-family: 'Courier New', Courier, monospace;
            color: var(--text-color);
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
            margin-top: 40px;
            position: relative;
            display: inline-block;
        }
        
        h3 {
            color: var(--accent-color);
            font-weight: bold;
            margin-top: 25px;
        }
        
        pre {
            background-color: var(--code-bg);
            border-left: 4px solid var(--accent-color);
            padding: 15px;
            border-radius: 4px;
            overflow-x: auto;
            margin: 20px 0;
        }
        
        code {
            font-family: 'Courier New', Courier, monospace;
            color: var(--accent-color);
            background-color: var(--code-bg);
            padding: 2px 4px;
            border-radius: 3px;
        }
        
        pre code {
            color: var(--text-color);
            background-color: transparent;
            padding: 0;
        }
        
        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dashed var(--link-color);
            transition: all 0.3s ease;
        }
        
        a:hover {
            color: var(--accent-color);
            transform: scale(1.05);
        }
        
        .resource-box {
            border: 2px solid var(--border-color);
            background-color: var(--white);
            padding: 15px;
            margin: 25px 0;
            border-radius: 4px;
            position: relative;
        }
        
        .resource-box h4 {
            margin-top: 0;
            color: var(--accent-color);
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 8px;
        }
        
        .resource-list {
            list-style-type: none;
            padding-left: 10px;
        }
        
        .resource-list li::before {
            content: "→ ";
            color: var(--accent-color);
        }
        
        .explorer-badge {
            position: absolute;
            top: -40px;
            right: 20px;
            width: 80px;
            height: 80px;
            background-color: var(--accent-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: bold;
            transform: rotate(15deg);
            border: 2px solid var(--border-color);
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.9rem;
            text-align: center;
            line-height: 1.2;
        }
        
        .table-container {
            overflow-x: auto;
            margin: 20px 0;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
        }
        
        th, td {
            border: 2px solid var(--border-color);
            padding: 10px;
            text-align: left;
        }
        
        th {
            background-color: var(--accent-color);
            color: var(--white);
        }
        
        .note {
            background-color: rgba(197, 179, 150, 0.3);
            border-left: 4px solid var(--accent-color);
            padding: 10px 15px;
            margin: 20px 0;
        }
        
        .note::before {
            content: "📝 注意：";
            font-weight: bold;
            color: var(--accent-color);
        }
        
        .example {
            margin: 25px 0;
            border: 2px solid var(--border-color);
            border-radius: 4px;
        }
        
        .example-title {
            background-color: var(--accent-color);
            color: var(--white);
            padding: 10px 15px;
            margin: 0;
            font-weight: bold;
        }
        
        .example-content {
            padding: 15px;
            background-color: var(--white);
        }
        
        footer {
            text-align: center;
            margin-top: 50px;
            padding: 20px;
            border-top: 2px solid var(--border-color);
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            pre {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="explorer-badge">SWIFT GUIDE</div>
            <h1>Swift 访问控制</h1>
        </header>
        
        <section id="introduction">
            <h2>访问控制简介</h2>
            <p>访问控制限制了从其他源文件和模块对代码的访问。这个特性可以让你隐藏代码的实现细节，并且指定一个偏好的接口通过其他代码进行交互。</p>
            
            <p>Swift提供了五种不同的访问级别来控制代码的可见性和可访问性。这种精细粒度的控制使得API设计更加灵活且安全。</p>
            
            <svg width="100%" height="300" viewBox="0 0 800 300">
                <style>
                    .box { stroke: var(--border-color); stroke-width: 2px; fill: var(--white); }
                    .arrow { stroke: var(--border-color); stroke-width: 2px; fill: none; }
                    .text { font-family: Arial; font-size: 14px; fill: var(--text-color); }
                    .label { font-family: Arial; font-size: 16px; font-weight: bold; fill: var(--accent-color); }
                </style>
                <rect x="50" y="50" width="700" height="200" rx="10" class="box" fill-opacity="0.3" />
                <text x="400" y="30" text-anchor="middle" class="label">Swift 访问控制层级（从左到右访问范围递减）</text>
                
                <rect x="100" y="100" width="100" height="100" rx="5" class="box" />
                <text x="150" y="155" text-anchor="middle" class="label">open</text>
                
                <rect x="230" y="100" width="100" height="100" rx="5" class="box" />
                <text x="280" y="155" text-anchor="middle" class="label">public</text>
                
                <rect x="360" y="100" width="100" height="100" rx="5" class="box" />
                <text x="410" y="155" text-anchor="middle" class="label">internal</text>
                
                <rect x="490" y="100" width="100" height="100" rx="5" class="box" />
                <text x="540" y="155" text-anchor="middle" class="label">fileprivate</text>
                
                <rect x="620" y="100" width="100" height="100" rx="5" class="box" />
                <text x="670" y="155" text-anchor="middle" class="label">private</text>
                
                <path d="M200 150 L230 150" class="arrow" marker-end="url(#arrowhead)" />
                <path d="M330 150 L360 150" class="arrow" marker-end="url(#arrowhead)" />
                <path d="M460 150 L490 150" class="arrow" marker-end="url(#arrowhead)" />
                <path d="M590 150 L620 150" class="arrow" marker-end="url(#arrowhead)" />
                
                <defs>
                    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--border-color)" />
                    </marker>
                </defs>
                
                <text x="170" y="270" text-anchor="middle" class="text">跨模块访问</text>
                <text x="280" y="270" text-anchor="middle" class="text">跨模块访问</text>
                <text x="410" y="270" text-anchor="middle" class="text">模块内访问</text>
                <text x="540" y="270" text-anchor="middle" class="text">文件内访问</text>
                <text x="670" y="270" text-anchor="middle" class="text">声明内访问</text>
                <text x="170" y="290" text-anchor="middle" class="text">可继承</text>
                <text x="280" y="290" text-anchor="middle" class="text">不可继承</text>
            </svg>
        </section>
        
        <section id="access-levels">
            <h2>访问级别详解</h2>
            
            <h3>Open 访问级别</h3>
            <p>这是最高（限制最少）的访问级别。只能应用于类和类成员：</p>
            <ul>
                <li>允许在定义模块外的任何模块中使用该类</li>
                <li>允许在其他模块中被继承</li>
                <li>允许在其他模块中被重写</li>
            </ul>
            
            <div class="example">
                <div class="example-title">Open 使用示例</div>
                <div class="example-content">
                    <pre><code>// 定义一个开放访问的类
open class Vehicle {
    // 开放访问的属性
    open var currentSpeed = 0.0
    
    // 开放访问的方法
    open func description() -> String {
        return "正以 \(currentSpeed) 公里/小时的速度行驶"
    }
    
    // 开放访问的初始化方法
    public init() {
        // 初始化代码
    }
}

// 在另一个模块中
class Car: Vehicle {
    // 可以继承并重写开放方法
    override func description() -> String {
        return "汽车\(super.description())"
    }
}</code></pre>
                </div>
            </div>
            
            <h3>Public 访问级别</h3>
            <p>允许定义实体在任何源文件中使用，只要导入了定义模块：</p>
            <ul>
                <li>允许在定义模块外的任何模块中使用</li>
                <li>与open不同，public类不能在其他模块中被继承和重写</li>
            </ul>
            
            <div class="example">
                <div class="example-title">Public 使用示例</div>
                <div class="example-content">
                    <pre><code>// 定义一个公共访问的类
public class NetworkManager {
    // 公共访问的属性
    public var timeout = 30.0
    
    // 公共方法
    public func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
        // 网络请求实现
    }
    
    public init() {
        // 初始化代码
    }
}</code></pre>
                </div>
            </div>
            
            <h3>Internal 访问级别</h3>
            <p>允许在定义模块内的任何源文件中使用，但不能从模块外部访问：</p>
            <ul>
                <li>Swift的默认访问级别</li>
                <li>用于隐藏模块内部实现细节</li>
            </ul>
            
            <div class="example">
                <div class="example-title">Internal 使用示例</div>
                <div class="example-content">
                    <pre><code>// internal 是默认的访问级别，可以省略不写
class DatabaseManager {
    // internal 属性
    var connection: Connection?
    
    // internal 方法
    func connect(to server: String) -> Bool {
        // 连接实现
        return true
    }
    
    // internal 初始化方法
    init() {
        // 初始化代码
    }
}</code></pre>
                </div>
            </div>
            
            <h3>Fileprivate 访问级别</h3>
            <p>限制实体只能在当前定义源文件内使用：</p>
            <ul>
                <li>用于隐藏同一文件中不同类型之间共享的功能实现细节</li>
            </ul>
            
            <div class="example">
                <div class="example-title">Fileprivate 使用示例</div>
                <div class="example-content">
                    <pre><code>// 文件内私有辅助函数
fileprivate func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}

// 同一文件中的类可以使用文件内私有函数
class EventManager {
    func displayEvent(on date: Date) -> String {
        // 可以访问同文件中的 fileprivate 函数
        return "活动日期: \(formatDate(date))"
    }
}</code></pre>
                </div>
            </div>
            
            <h3>Private 访问级别</h3>
            <p>限制实体只能在定义的声明中使用：</p>
            <ul>
                <li>最严格的访问级别</li>
                <li>用于隐藏仅在单个类型内部使用的实现细节</li>
            </ul>
            
            <div class="example">
                <div class="example-title">Private 使用示例</div>
                <div class="example-content">
                    <pre><code>class UserAuthentication {
    // 私有属性，只能在类内部访问
    private var encryptionKey = "sk_12345"
    
    // 私有方法
    private func encrypt(_ text: String) -> String {
        // 加密实现
        return text.reversed()
    }
    
    // 公共接口
    func authenticate(user: String, password: String) -> Bool {
        // 内部使用私有方法
        let encryptedPassword = encrypt(password)
        // 验证逻辑
        return encryptedPassword.count > 0
    }
}</code></pre>
                </div>
            </div>
            
            <div class="note">
                在Swift 4之后，private 访问级别允许在同一类型的扩展中访问，只要扩展在同一文件中。这种变化使得 private 访问级别更加灵活。
            </div>
        </section>
        
        <section id="default-access">
            <h2>默认访问级别</h2>
            <p>Swift中的默认访问级别是 <code>internal</code>。这意味着，如果你没有为代码显式指定访问级别，它将自动被设置为internal。</p>
            
            <div class="example">
                <div class="example-title">默认访问级别示例</div>
                <div class="example-content">
                    <pre><code>// 这两个声明是等价的
class SomeClass {
    var someProperty = 0
}

// 显式指定与上面等价
internal class SomeClass {
    internal var someProperty = 0
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="access-control-syntax">
            <h2>访问控制语法</h2>
            
            <p>在Swift中，访问控制关键字通常放在声明的开头：</p>
            
            <div class="example">
                <div class="example-title">访问控制语法示例</div>
                <div class="example-content">
                    <pre><code>// 类型的访问控制
public class PublicClass {}
internal class InternalClass {}
fileprivate class FilePrivateClass {}
private class PrivateClass {}

// 属性、方法、初始化器的访问控制
public class AccessExample {
    // 属性
    public var publicProperty = 0
    internal var internalProperty = 0
    fileprivate var filePrivateProperty = 0
    private var privateProperty = 0
    
    // 方法
    public func publicMethod() {}
    internal func internalMethod() {}
    fileprivate func filePrivateMethod() {}
    private func privateMethod() {}
    
    // 初始化器
    public init() {}
}</code></pre>
                </div>
            </div>
            
            <h3>元组类型</h3>
            <p>元组类型的访问级别是其中最严格的访问级别：</p>
            
            <div class="example">
                <div class="example-title">元组类型访问控制</div>
                <div class="example-content">
                    <pre><code>// 假设有以下声明
public class A {}
internal class B {}

// 元组的访问级别将是 internal
// (因为 B 是 internal，是最严格的级别)
let pair: (A, B) = (A(), B())</code></pre>
                </div>
            </div>
            
            <h3>函数类型</h3>
            <p>函数类型的访问级别是参数类型和返回类型中最严格的级别：</p>
            
            <div class="example">
                <div class="example-title">函数类型访问控制</div>
                <div class="example-content">
                    <pre><code>// 假设有以下声明
public class PublicClass {}
private class PrivateClass {}

// 函数类型将是 private (因为 PrivateClass 是 private)
func someFunction() -> PrivateClass {
    return PrivateClass()
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="custom-types">
            <h2>自定义类型与访问控制</h2>
            
            <h3>类型成员</h3>
            <p>类型的成员（属性、方法等）默认继承类型的访问级别，但无法超过其包含类型的访问级别：</p>
            
            <div class="example">
                <div class="example-title">类型成员访问控制</div>
                <div class="example-content">
                    <pre><code>internal class Vehicle {
    // 默认为 internal
    var currentSpeed = 0.0
    
    // 显式声明为 private
    private var engineType = "V8"
    
    // 错误：属性不能比包含类型级别更高
    // public var manufacturer = ""  // 编译错误
}</code></pre>
                </div>
            </div>
            
            <h3>嵌套类型</h3>
            <p>嵌套类型自动接收其外部类型的访问级别，除非显式指定：</p>
            
            <div class="example">
                <div class="example-title">嵌套类型访问控制</div>
                <div class="example-content">
                    <pre><code>public class Vehicle {
    // 嵌套类型自动接收外部类型的访问级别 (public)
    class Door {
        var isLocked = false
    }
    
    // 可以显式指定更严格的访问级别
    private class Engine {
        var horsePower = 250
    }
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="subclassing">
            <h2>子类化与访问控制</h2>
            
            <p>子类不能高于父类的访问级别，但可以低于父类的访问级别：</p>
            
            <div class="example">
                <div class="example-title">子类访问控制</div>
                <div class="example-content">
                    <pre><code>public class Vehicle {
    public var currentSpeed = 0.0
}

// 正确：子类访问级别可以等于父类
public class Bicycle: Vehicle {
    public var hasBell = false
}

// 正确：子类访问级别可以低于父类
internal class Car: Vehicle {
    internal var gear = 1
}

// 错误：子类访问级别不能高于父类
// public class Motorcycle: internal Vehicle {} // 如果Vehicle是internal，这会编译错误</code></pre>
                </div>
            </div>
            
            <h3>重写</h3>
            <p>子类可以将继承的类成员重写为更高的访问级别：</p>
            
            <div class="example">
                <div class="example-title">成员重写与访问控制</div>
                <div class="example-content">
                    <pre><code>public class Vehicle {
    // internal 方法
    func description() -> String {
        return "一个交通工具"
    }
}

public class Car: Vehicle {
    // 可以将inherited方法重写为更高访问级别
    public override func description() -> String {
        return "一辆汽车"
    }
}</code></pre>
                </div>
            </div>
            
            <h3>Open vs Public</h3>
            <p>Open与Public的关键区别在于跨模块继承和重写能力：</p>
            
            <svg width="100%" height="400" viewBox="0 0 800 400">
                <style>
                    .box { stroke: var(--border-color); stroke-width: 2px; fill: var(--white); }
                    .text { font-family: Arial; font-size: 14px; fill: var(--text-color); }
                    .label { font-family: Arial; font-size: 16px; font-weight: bold; fill: var(--accent-color); }
                    .highlight { fill: rgba(197, 179, 150, 0.3); }
                </style>
                <rect x="50" y="50" width="700" height="300" class="box" fill-opacity="0.1" />
                <text x="400" y="30" text-anchor="middle" class="label">Open vs Public 比较</text>
                
                <rect x="100" y="80" width="250" height="250" class="box" />
                <rect x="450" y="80" width="250" height="250" class="box" />
                
                <text x="225" y="110" text-anchor="middle" class="label">Open</text>
                <text x="575" y="110" text-anchor="middle" class="label">Public</text>
                
                <rect x="120" y="130" width="210" height="30" class="highlight" rx="5" />
                <text x="225" y="150" text-anchor="middle" class="text">可在任何模块中访问</text>
                
                <rect x="120" y="170" width="210" height="30" class="highlight" rx="5" />
                <text x="225" y="190" text-anchor="middle" class="text">可在其他模块中被继承</text>
                
                <rect x="120" y="210" width="210" height="30" class="highlight" rx="5" />
                <text x="225" y="230" text-anchor="middle" class="text">可在其他模块中被重写</text>
                
                <rect x="120" y="250" width="210" height="30" class="highlight" rx="5" />
                <text x="225" y="270" text-anchor="middle" class="text">可在声明模块中被继承</text>
                
                <rect x="120" y="290" width="210" height="30" class="highlight" rx="5" />
                <text x="225" y="310" text-anchor="middle" class="text">可在声明模块中被重写</text>
                
                <rect x="470" y="130" width="210" height="30" class="highlight" rx="5" />
                <text x="575" y="150" text-anchor="middle" class="text">可在任何模块中访问</text>
                
                <rect x="470" y="170" width="210" height="30" rx="5" fill="none" />
                <text x="575" y="190" text-anchor="middle" class="text" fill="#999">不可在其他模块中被继承</text>
                
                <rect x="470" y="210" width="210" height="30" rx="5" fill="none" />
                <text x="575" y="230" text-anchor="middle" class="text" fill="#999">不可在其他模块中被重写</text>
                
                <rect x="470" y="250" width="210" height="30" class="highlight" rx="5" />
                <text x="575" y="270" text-anchor="middle" class="text">可在声明模块中被继承</text>
                
                <rect x="470" y="290" width="210" height="30" class="highlight" rx="5" />
                <text x="575" y="310" text-anchor="middle" class="text">可在声明模块中被重写</text>
            </svg>
            
            <div class="example">
                <div class="example-title">Open vs Public 示例</div>
                <div class="example-content">
                    <pre><code>// 在 ModuleA 中：
open class OpenVehicle {
    open func accelerate() { /* 实现 */ }
    public func brake() { /* 实现 */ }
}

public class PublicVehicle {
    public func accelerate() { /* 实现 */ }
}

// 在 ModuleB 中：
import ModuleA

// 可以继承和重写开放类和方法
class SportsCar: OpenVehicle {
    override func accelerate() { /* 新实现 */ }
    // 注意：不能重写 brake() 因为它不是 open
}

// 错误：不能继承 PublicVehicle，因为它不是 open
// class Truck: PublicVehicle { } // 编译错误</code></pre>
                </div>
            </div>
        </section>
        
        <section id="getters-setters">
            <h2>Getter 与 Setter</h2>
            <p>在Swift中，可以为属性的getter和setter指定不同的访问级别，但setter访问级别不能高于getter：</p>
            
            <div class="example">
                <div class="example-title">Getter 与 Setter 访问控制</div>
                <div class="example-content">
                    <pre><code>class TrackedString {
    // 属性可以公开读取，但只能在内部修改
    private(set) public var numberOfEdits = 0
    
    // 存储的实际值
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

let tracked = TrackedString()
tracked.value = "Hello"  // 可以修改 value
print(tracked.numberOfEdits)  // 可以读取 numberOfEdits (输出: 1)
// tracked.numberOfEdits = 0  // 错误: 不能直接修改 numberOfEdits</code></pre>
                </div>
            </div>
            
            <p>更复杂的getter和setter访问控制：</p>
            
            <div class="example">
                <div class="example-title">复杂 Getter/Setter 访问控制</div>
                <div class="example-content">
                    <pre><code>public class DataManager {
    // 属性整体是 public，但 setter 是 internal
    public internal(set) var serverURL: URL?
    
    // 属性整体是 internal (默认)，但 setter 是 private
    private(set) var apiKey: String?
    
    // 计算属性也可以控制 setter 访问级别
    public private(set) var isConnected: Bool {
        get {
            return serverURL != nil && apiKey != nil
        }
        set {
            // 只有类内部可以设置
            if newValue == false {
                serverURL = nil
                apiKey = nil
            }
        }
    }
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="initializers">
            <h2>初始化器访问控制</h2>
            
            <h3>默认初始化器</h3>
            <p>如果类型所有存储属性有默认值且没有自定义初始化器，Swift会提供默认初始化器，其访问级别与类型相同：</p>
            
            <div class="example">
                <div class="example-title">默认初始化器访问控制</div>
                <div class="example-content">
                    <pre><code>public class AutoVehicle {
    // 所有属性有默认值
    public var manufacturer = "Unknown"
    public var model = "Generic"
    
    // Swift会提供一个public默认初始化器
    // 等同于: public init() {}
}

// 可以使用默认初始化器
let vehicle = AutoVehicle()</code></pre>
                </div>
            </div>
            
            <h3>必要初始化器</h3>
            <p>使用<code>required</code>标记的初始化器在子类中也必须实现，遵循相同访问级别规则：</p>
            
            <div class="example">
                <div class="example-title">必要初始化器访问控制</div>
                <div class="example-content">
                    <pre><code>public class Vehicle {
    public var name: String
    
    // 必要的初始化器
    public required init(name: String) {
        self.name = name
    }
}

public class Car: Vehicle {
    public var model: String
    
    // 必须实现父类的必要初始化器
    public required init(name: String) {
        self.model = "Unknown"
        super.init(name: name)
    }
    
    // 自定义初始化器
    public init(name: String, model: String) {
        self.model = model
        super.init(name: name)
    }
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="protocols">
            <h2>协议与访问控制</h2>
            <p>协议本身可以指定访问级别，协议要求必须具有与协议相同的访问级别：</p>
            
            <div class="example">
                <div class="example-title">协议访问控制</div>
                <div class="example-content">
                    <pre><code>// 公共协议
public protocol Drivable {
    // 协议要求自动具有与协议相同的访问级别 (public)
    var speed: Double { get set }
    func accelerate()
    func brake()
}

// 实现协议
public class Car: Drivable {
    // 实现必须至少具有与协议要求相同的访问级别
    public var speed: Double = 0.0
    
    public func accelerate() {
        speed += 10.0
    }
    
    public func brake() {
        speed = max(0, speed - 10.0)
    }
}</code></pre>
                </div>
            </div>
            
            <h3>协议继承</h3>
            <p>派生协议不能具有比其继承的协议更高的访问级别：</p>
            
            <div class="example">
                <div class="example-title">协议继承与访问控制</div>
                <div class="example-content">
                    <pre><code>internal protocol Vehicle {
    var wheels: Int { get }
}

// 正确：访问级别可以相同
internal protocol Car: Vehicle {
    var seats: Int { get }
}

// 正确：访问级别可以更严格
private protocol SportsCar: Car {
    var topSpeed: Double { get }
}

// 错误：访问级别不能比继承的协议更宽松
// public protocol Truck: Vehicle { } // 编译错误</code></pre>
                </div>
            </div>
        </section>
        
        <section id="extensions">
            <h2>扩展与访问控制</h2>
            <p>扩展可以为现有类型添加新功能，并且遵循类似的访问控制规则：</p>
            
            <div class="example">
                <div class="example-title">扩展访问控制</div>
                <div class="example-content">
                    <pre><code>// 内部类
internal class Vehicle {
    internal var currentSpeed = 0.0
}

// 不指定访问级别的扩展继承原类型的访问级别
extension Vehicle {
    // 这些成员默认为 internal
    func accelerate() {
        currentSpeed += 5.0
    }
}

// 可以显式指定扩展中成员的访问级别
extension Vehicle {
    // 公共方法（但受限于类型的访问级别）
    public func description() -> String {
        return "Vehicle at \(currentSpeed) km/h"
    }
    
    // 私有方法
    private func resetSpeed() {
        currentSpeed = 0.0
    }
}</code></pre>
                </div>
            </div>
            
            <h3>私有成员在扩展中的访问</h3>
            <p>在Swift 4及以后版本中，同一文件中的扩展可以访问类型的私有成员：</p>
            
            <div class="example">
                <div class="example-title">扩展中访问私有成员</div>
                <div class="example-content">
                    <pre><code>class Vehicle {
    // 私有属性
    private var engineType = "V8"
    
    func start() {
        print("启动 \(engineType) 引擎")
    }
}

// 在Swift 4及以后，同文件的扩展可以访问私有成员
extension Vehicle {
    func showEngineDetails() {
        // 可以访问私有属性 engineType
        print("引擎类型: \(engineType)")
    }
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="generics">
            <h2>泛型与访问控制</h2>
            <p>泛型类型或函数的访问级别受到类型参数和约束的影响：</p>
            
            <div class="example">
                <div class="example-title">泛型访问控制</div>
                <div class="example-content">
                    <pre><code>// 公共泛型类
public class Container<T> {
    // 公共属性
    public var items = [T]()
    
    // 公共方法
    public func append(_ item: T) {
        items.append(item)
    }
    
    public init() {}
}

// 泛型类型参数的约束会影响整体访问级别
public class RestrictedContainer<T: Vehicle> {
    // 如果 Vehicle 是 internal,
    // RestrictedContainer 的有效访问级别也会变为 internal
    public var items = [T]()
    
    public func append(_ item: T) {
        items.append(item)
    }
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="best-practices">
            <h2>访问控制最佳实践</h2>
            
            <h3>API 设计原则</h3>
            <p>设计API时应遵循以下访问控制原则：</p>
            <ul>
                <li>只公开必要的API（最小暴露原则）</li>
                <li>使用 private(set) 允许读取但防止修改</li>
                <li>使用 open 谨慎，因为它允许外部模块重写行为</li>
                <li>为框架类提供清晰文档说明哪些部分可供扩展</li>
            </ul>
            
            <svg width="100%" height="300" viewBox="0 0 800 300">
                <style>
                    .block { stroke: var(--border-color); stroke-width: 2px; rx: 5; }
                    .arrow { stroke: var(--border-color); stroke-width: 2px; marker-end: url(#arrow); fill: none; }
                    .text { font-family: Arial; font-size: 14px; fill: var(--text-color); }
                </style>
                
                <rect x="50" y="50" width="700" height="200" fill="none" stroke="var(--border-color)" stroke-width="2" rx="10" />
                <text x="400" y="30" text-anchor="middle" font-weight="bold" fill="var(--accent-color)" font-size="16">访问控制最佳实践</text>
                
                <rect x="100" y="100" width="150" height="60" class="block" fill="#e8e0d4" />
                <text x="175" y="135" text-anchor="middle" class="text">公共 API</text>
                <text x="175" y="155" text-anchor="middle" font-size="12" fill="var(--accent-color)">open / public</text>
                
                <rect x="325" y="100" width="150" height="60" class="block" fill="#d1cab2" />
                <text x="400" y="135" text-anchor="middle" class="text">内部实现</text>
                <text x="400" y="155" text-anchor="middle" font-size="12" fill="var(--accent-color)">internal</text>
                
                <rect x="550" y="100" width="150" height="60" class="block" fill="#beb297" />
                <text x="625" y="135" text-anchor="middle" class="text">私有细节</text>
                <text x="625" y="155" text-anchor="middle" font-size="12" fill="var(--accent-color)">fileprivate / private</text>
                
                <path d="M100 200 Q400 250 700 200" class="arrow" />
                <text x="400" y="240" text-anchor="middle" font-size="14" font-weight="bold" fill="var(--accent-color)">访问限制逐渐增强</text>
                
                <defs>
                    <marker id="arrow" markerWidth="10" markerHeight="7" refX="7" refY="3.5" orient="auto">
                        <polygon points="0 0, 10 3.5, 0 7" fill="var(--border-color)" />
                    </marker>
                </defs>
            </svg>
            
            <h3>框架与应用程序的区别</h3>
            <p>根据项目类型选择合适的访问级别：</p>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>项目类型</th>
                            <th>推荐访问级别</th>
                            <th>原因</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>框架</td>
                            <td>open/public 用于公共 API<br>internal 用于内部实现<br>private 用于隐藏细节</td>
                            <td>框架需要公开接口供其他模块使用，同时保护内部实现</td>
                        </tr>
                        <tr>
                            <td>应用程序</td>
                            <td>主要使用 internal (默认)<br>private 用于隐藏实现细节</td>
                            <td>应用程序通常不需要为外部模块公开其类型，更关注内部组件间的隔离</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>
        
        <section id="unit-testing">
            <h2>单元测试与访问控制</h2>
            <p>单元测试对访问控制有特殊要求。在Swift中，使用 <code>@testable import</code> 可以让测试target访问被测试模块的internal成员：</p>
            
            <div class="example">
                <div class="example-title">可测试模块</div>
                <div class="example-content">
                    <pre><code>// 在 MyApp 模块中:
class DataProcessor {
    // internal 方法通常不能被外部模块访问
    func process(_ data: Data) -> String {
        // 实现
        return String(data: data, encoding: .utf8) ?? ""
    }
}

// 在测试模块中:
import XCTest
@testable import MyApp  // 允许访问 MyApp 的 internal 成员

class DataProcessorTests: XCTestCase {
    func testProcess() {
        let processor = DataProcessor()
        let testData = Data("Hello".utf8)
        
        // 可以访问 internal 方法
        let result = processor.process(testData)
        
        XCTAssertEqual(result, "Hello")
    }
}</code></pre>
                </div>
            </div>
            
            <div class="note">
                使用 <code>@testable import</code> 要求在构建被测试模块时启用测试设置（通常是在 Debug 配置下自动启用的）。
            </div>
        </section>
        
        <section id="real-world-examples">
            <h2>实际案例分析</h2>
            
            <h3>模块化应用架构</h3>
            <div class="example">
                <div class="example-title">模块化应用访问控制示例</div>
                <div class="example-content">
                    <pre><code>// NetworkModule.swift - 网络模块
public protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

// 对外提供的接口
public class NetworkService: NetworkServiceProtocol {
    // 内部可设置的私有变量
    private(set) public var baseURL: URL
    private var session: URLSession
    private let decoder: JSONDecoder
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession.shared
        self.decoder = JSONDecoder()
    }
    
    public func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        // 内部调用
        performRequest(url: url, completion: completion)
    }
    
    // 私有方法，仅模块内使用
    private func performRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let result = try self.decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}</code></pre>
                </div>
            </div>
            
            <h3>框架设计</h3>
            <div class="example">
                <div class="example-title">框架设计访问控制示例</div>
                <div class="example-content">
                    <pre><code>// 公共协议，允许外部实现
public protocol DataStorable {
    func save<T: Encodable>(_ object: T, forKey key: String) throws
    func retrieve<T: Decodable>(forKey key: String) throws -> T?
}

// 开放基类，允许外部继承和覆盖
open class BaseStorage: DataStorable {
    // 公共共享单例
    public static let shared = BaseStorage()
    
    // 允许覆盖
    open func save<T: Encodable>(_ object: T, forKey key: String) throws {
        // 基本实现
        let data = try JSONEncoder().encode(object)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    // 允许覆盖
    open func retrieve<T: Decodable>(forKey key: String) throws -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // 公共初始化器
    public init() {}
    
    // 允许覆盖但不允许外部直接调用
    open func clearStorage() {
        performClear()
    }
    
    // 私有方法，不能被覆盖
    private func performClear() {
        // 实现细节
    }
}

// 公共具体存储实现，不允许进一步继承
public final class SecureStorage: BaseStorage {
    private let encryptionKey: String
    
    public init(encryptionKey: String) {
        self.encryptionKey = encryptionKey
        super.init()
    }
    
    // 覆盖基类方法
    public override func save<T: Encodable>(_ object: T, forKey key: String) throws {
        // 加密后存储
        let data = try JSONEncoder().encode(object)
        let encryptedData = encrypt(data, with: encryptionKey)
        UserDefaults.standard.setValue(encryptedData, forKey: key)
    }
    
    // 覆盖基类方法
    public override func retrieve<T: Decodable>(forKey key: String) throws -> T? {
        guard let encryptedData = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        let data = decrypt(encryptedData, with: encryptionKey)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // 私有加密方法
    private func encrypt(_ data: Data, with key: String) -> Data {
        // 加密实现，此处简化
        return data
    }
    
    // 私有解密方法
    private func decrypt(_ data: Data, with key: String) -> Data {
        // 解密实现，此处简化
        return data
    }
}</code></pre>
                </div>
            </div>
        </section>
        
        <section id="resources">
            <h2>参考资源</h2>
            
            <div class="resource-box">
                <h4>官方文档</h4>
                <ul class="resource-list">
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html" target="_blank">Swift 语言指南: 访问控制</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift/controlling-access-to-parts-of-your-code" target="_blank">Apple 开发者文档: 控制代码的访问</a></li>
                </ul>
            </div>
            
            <div class="resource-box">
                <h4>推荐书籍</h4>
                <ul class="resource-list">
                    <li>《Swift 编程语言》- Apple Inc.</li>
                    <li>《Swift 进阶》- 王巍</li>
                    <li>《Pro Swift》- Paul Hudson</li>
                    <li>《Advanced Swift》- Chris Eidhof, Ole Begemann, and Airspeed Velocity</li>
                </ul>
            </div>
            
            <div class="resource-box">
                <h4>优秀博客与文章</h4>
                <ul class="resource-list">
                    <li><a href="https://www.swiftbysundell.com/articles/public-private-internal-access-modifiers-in-swift/" target="_blank">Swift by Sundell: Public, Private, and Internal Access Modifiers in Swift</a></li>
                    <li><a href="https://www.hackingwithswift.com/articles/44/apple-s-internal-and-open-access-modifiers" target="_blank">Hacking with Swift: Apple's internal and open access modifiers</a></li>
                    <li><a href="https://medium.com/@jrogel/access-control-in-swift-5c1ca67548f6" target="_blank">Medium: Access Control in Swift</a></li>
                    <li><a href="https://www.avanderlee.com/swift/access-levels-private-fileprivate-public/" target="_blank">SwiftLee: Access levels in Swift explained</a></li>
                </ul>
            </div>
            
            <div class="resource-box">
                <h4>视频教程</h4>
                <ul class="resource-list">
                    <li><a href="https://www.raywenderlich.com/4075-access-control-in-swift" target="_blank">raywenderlich.com: Access Control in Swift</a></li>
                    <li><a href="https://www.youtube.com/watch?v=3cy3ASEgLj8" target="_blank">YouTube: Swift Access Control Explained</a></li>
                    <li><a href="https://www.udemy.com/course/ios-13-app-development-bootcamp/" target="_blank">Udemy: iOS App Development Bootcamp (包含访问控制章节)</a></li>
                </ul>
            </div>
            
            <div class="resource-box">
                <h4>相关开源项目</h4>
                <ul class="resource-list">
                    <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a> - 学习如何在网络库中正确使用访问控制</li>
                    <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 复杂框架中的访问控制实践</li>
                    <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Swift Composable Architecture</a> - 模块化应用程序架构示例</li>
                    <li><a href="https://github.com/danielgindi/Charts" target="_blank">Charts</a> - 优秀的Swift库访问控制设计</li>
                </ul>
            </div>
        </section>

    </div>

    <script>
        // 可以添加一些交互性脚本，如折叠/展开代码示例等
        document.addEventListener('DOMContentLoaded', function() {
            // 示例代码块的折叠/展开功能可以在这里实现
        });
    </script>
</body>
</html>
