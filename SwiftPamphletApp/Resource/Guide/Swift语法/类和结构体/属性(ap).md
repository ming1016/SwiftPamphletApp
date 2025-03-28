<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift 类和结构体中的属性</title>
    <style>
        :root {
            --primary-text: #1a3a4a;
            --secondary-text: #2c5a6b;
            --background: #f9fcfc;
            --code-background: #eef8f8;
            --accent-color: #5ecdb1;
            --accent-secondary: #ff9a8b;
            --card-background: rgba(255, 255, 255, 0.85);
            --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-text: #e0f0f0;
                --secondary-text: #aed3e0;
                --background: #1a2a34;
                --code-background: #253540;
                --accent-color: #3cad91;
                --accent-secondary: #e5857a;
                --card-background: rgba(30, 45, 55, 0.9);
                --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--background);
            color: var(--primary-text);
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25' viewBox='0 0 800 800'%3E%3Cg %3E%3Ccircle fill='%23f9fcfc' cx='400' cy='400' r='600'/%3E%3Ccircle fill='%23e8f6f0' cx='400' cy='400' r='500'/%3E%3Ccircle fill='%23d9f1e6' cx='400' cy='400' r='400'/%3E%3Ccircle fill='%23caeadc' cx='400' cy='400' r='300'/%3E%3Ccircle fill='%23b8e3d2' cx='400' cy='400' r='200'/%3E%3Ccircle fill='%23a7dbc8' cx='400' cy='400' r='100'/%3E%3C/g%3E%3C/svg%3E");
            background-attachment: fixed;
            background-size: cover;
        }

        @media (prefers-color-scheme: dark) {
            body {
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100%25' height='100%25' viewBox='0 0 800 800'%3E%3Cg %3E%3Ccircle fill='%231a2a34' cx='400' cy='400' r='600'/%3E%3Ccircle fill='%231e2f39' cx='400' cy='400' r='500'/%3E%3Ccircle fill='%2322343e' cx='400' cy='400' r='400'/%3E%3Ccircle fill='%23273943' cx='400' cy='400' r='300'/%3E%3Ccircle fill='%232b3e48' cx='400' cy='400' r='200'/%3E%3Ccircle fill='%2330444e' cx='400' cy='400' r='100'/%3E%3C/g%3E%3C/svg%3E");
            }
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
        }

        header {
            text-align: center;
            margin-bottom: 3rem;
        }

        h1 {
            color: var(--accent-color);
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        h2 {
            color: var(--accent-color);
            font-size: 2rem;
            margin-top: 2.5rem;
            margin-bottom: 1rem;
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 0.5rem;
        }

        h3 {
            color: var(--secondary-text);
            font-size: 1.5rem;
            margin-top: 2rem;
            margin-bottom: 0.5rem;
        }

        p {
            margin-bottom: 1.5rem;
        }

        .card {
            background-color: var(--card-background);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
            backdrop-filter: blur(8px);
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            background-color: var(--code-background);
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-size: 0.9rem;
        }

        pre {
            background-color: var(--code-background);
            padding: 1.5rem;
            border-radius: 8px;
            overflow-x: auto;
            margin-bottom: 1.5rem;
        }

        pre code {
            background-color: transparent;
            padding: 0;
            font-size: 0.95rem;
            color: var(--primary-text);
            display: block;
        }

        .note {
            background-color: rgba(94, 205, 177, 0.15);
            border-left: 4px solid var(--accent-color);
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 0 8px 8px 0;
        }

        .warning {
            background-color: rgba(255, 154, 139, 0.15);
            border-left: 4px solid var(--accent-secondary);
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 0 8px 8px 0;
        }

        .resource-section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .resource-card {
            background-color: var(--card-background);
            border-radius: 12px;
            padding: 1.2rem;
            box-shadow: var(--box-shadow);
        }

        .resource-card h4 {
            margin-top: 0;
            color: var(--accent-color);
        }

        a {
            color: var(--accent-color);
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .example-section {
            margin-top: 1.5rem;
            margin-bottom: 2rem;
        }

        .diagram {
            text-align: center;
            margin: 2rem 0;
        }
        
        .code-explanation {
            margin-top: 0.5rem;
            font-style: italic;
            color: var(--secondary-text);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Swift 类和结构体中的属性</h1>
            <p>属性是 Swift 中类和结构体的重要组成部分，它们用于关联具体的值</p>
        </header>

        <div class="card">
            <h2>属性概述</h2>
            <p>属性是将值关联到特定类、结构体或枚举的一种方式。Swift 中的属性可分为存储属性和计算属性：</p>
            
            <div class="diagram">
                <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="gradientPrimary" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#5ecdb1;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#3cad91;stop-opacity:1" />
                        </linearGradient>
                        <linearGradient id="gradientSecondary" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#ff9a8b;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#e5857a;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    
                    <!-- 属性主框 -->
                    <rect x="200" y="20" width="200" height="60" rx="10" fill="url(#gradientPrimary)" />
                    <text x="300" y="55" text-anchor="middle" fill="white" font-weight="bold" font-size="18">Swift 属性</text>
                    
                    <!-- 连接线 -->
                    <line x1="300" y1="80" x2="300" y2="100" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="300" y1="100" x2="150" y2="100" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="300" y1="100" x2="450" y2="100" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="150" y1="100" x2="150" y2="130" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="450" y1="100" x2="450" y2="130" stroke="#5ecdb1" stroke-width="2" />
                    
                    <!-- 存储属性 -->
                    <rect x="50" y="130" width="200" height="50" rx="10" fill="url(#gradientPrimary)" />
                    <text x="150" y="160" text-anchor="middle" fill="white" font-weight="bold" font-size="16">存储属性</text>
                    
                    <!-- 计算属性 -->
                    <rect x="350" y="130" width="200" height="50" rx="10" fill="url(#gradientSecondary)" />
                    <text x="450" y="160" text-anchor="middle" fill="white" font-weight="bold" font-size="16">计算属性</text>
                    
                    <!-- 存储属性的子分类 -->
                    <line x1="150" y1="180" x2="150" y2="200" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="150" y1="200" x2="75" y2="200" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="150" y1="200" x2="225" y2="200" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="75" y1="200" x2="75" y2="220" stroke="#5ecdb1" stroke-width="2" />
                    <line x1="225" y1="200" x2="225" y2="220" stroke="#5ecdb1" stroke-width="2" />
                    
                    <rect x="25" y="220" width="100" height="40" rx="8" fill="url(#gradientPrimary)" opacity="0.8" />
                    <text x="75" y="245" text-anchor="middle" fill="white" font-size="12">常量存储属性</text>
                    
                    <rect x="175" y="220" width="100" height="40" rx="8" fill="url(#gradientPrimary)" opacity="0.8" />
                    <text x="225" y="245" text-anchor="middle" fill="white" font-size="12">变量存储属性</text>
                    
                    <!-- 计算属性的子分类 -->
                    <line x1="450" y1="180" x2="450" y2="200" stroke="#ff9a8b" stroke-width="2" />
                    <line x1="450" y1="200" x2="375" y2="200" stroke="#ff9a8b" stroke-width="2" />
                    <line x1="450" y1="200" x2="525" y2="200" stroke="#ff9a8b" stroke-width="2" />
                    <line x1="375" y1="200" x2="375" y2="220" stroke="#ff9a8b" stroke-width="2" />
                    <line x1="525" y1="200" x2="525" y2="220" stroke="#ff9a8b" stroke-width="2" />
                    
                    <rect x="325" y="220" width="100" height="40" rx="8" fill="url(#gradientSecondary)" opacity="0.8" />
                    <text x="375" y="245" text-anchor="middle" fill="white" font-size="12">只读计算属性</text>
                    
                    <rect x="475" y="220" width="100" height="40" rx="8" fill="url(#gradientSecondary)" opacity="0.8" />
                    <text x="525" y="245" text-anchor="middle" fill="white" font-size="12">读写计算属性</text>
                </svg>
            </div>
        </div>

        <div class="card">
            <h2>存储属性</h2>
            <p>存储属性是作为特定类或结构体实例的一部分而存储的常量或变量。可以在定义存储属性时为其提供默认值，或者在初始化过程中进行赋值。</p>

            <h3>基本语法</h3>
            <pre><code>class SomeClass {
    var variableProperty: Int = 10    // 变量存储属性
    let constantProperty: String       // 常量存储属性
}

struct SomeStruct {
    var variableProperty: Int = 10    // 变量存储属性
    let constantProperty: String = "Hello" // 常量存储属性
}</code></pre>

            <h3>示例：存储属性基础</h3>
            <div class="example-section">
                <pre><code>// 创建一个表示矩形的结构体
struct Rectangle {
    var width: Double   // 变量存储属性
    var height: Double  // 变量存储属性
    
    // 计算面积的方法
    func area() -> Double {
        return width * height
    }
}

// 使用存储属性创建实例
var rect = Rectangle(width: 10.0, height: 5.0)
print("矩形面积: \(rect.area())")  // 输出: 矩形面积: 50.0

// 修改存储属性
rect.width = 12.0
print("修改后的矩形面积: \(rect.area())")  // 输出: 修改后的矩形面积: 60.0</code></pre>
                <p class="code-explanation">这个示例展示了存储属性的基本用法，定义了一个表示矩形的结构体，包含两个存储属性 width 和 height。</p>
            </div>

            <h3>延迟存储属性 (Lazy Stored Properties)</h3>
            <p>延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 <code>lazy</code> 修饰符来表示一个延迟存储属性。</p>

            <div class="note">
                <p><strong>注意：</strong> 延迟存储属性必须被声明为变量（使用 <code>var</code> 关键字），因为它的初始值可能在实例初始化完成之后才会被获取。而常量属性必须在实例初始化完成之前就拥有值。</p>
            </div>

            <div class="example-section">
                <pre><code>class DataManager {
    // 这个数据处理器可能消耗大量内存
    lazy var dataProcessor = DataProcessor()
    
    // 其他属性和方法...
}

class DataProcessor {
    init() {
        print("DataProcessor 被初始化")
        // 这里可能进行一些耗资源的初始化操作
    }
    
    func process() {
        print("处理数据...")
    }
}

// 创建 DataManager 实例
let manager = DataManager()
print("DataManager 已创建，但 DataProcessor 尚未初始化")

// 首次访问 dataProcessor 属性时，DataProcessor 才会被初始化
manager.dataProcessor.process()</code></pre>
                <p class="code-explanation">在这个示例中，只有当首次访问 <code>dataProcessor</code> 属性时，<code>DataProcessor</code> 实例才会被创建。这在资源消耗较大的情况下非常有用。</p>
            </div>
        </div>

        <div class="card">
            <h2>计算属性</h2>
            <p>计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或值。</p>

            <div class="diagram">
                <svg width="600" height="250" viewBox="0 0 600 250" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="gradientComputed" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#ff9a8b;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#e5857a;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    
                    <!-- 主体框 -->
                    <rect x="50" y="20" width="500" height="210" rx="12" fill="rgba(255,255,255,0.1)" stroke="#e5857a" stroke-width="2" stroke-dasharray="5,5" />
                    <text x="300" y="50" text-anchor="middle" fill="#e5857a" font-weight="bold" font-size="18">计算属性工作原理</text>
                    
                    <!-- 存储属性 -->
                    <rect x="100" y="80" width="120" height="40" rx="8" fill="url(#gradientPrimary)" opacity="0.8" />
                    <text x="160" y="105" text-anchor="middle" fill="white" font-size="14">存储属性</text>
                    
                    <!-- 计算属性 -->
                    <rect x="380" y="80" width="120" height="40" rx="8" fill="url(#gradientComputed)" />
                    <text x="440" y="105" text-anchor="middle" fill="white" font-size="14">计算属性</text>
                    
                    <!-- Getter 和 Setter -->
                    <rect x="230" y="140" width="140" height="60" rx="8" fill="rgba(255,255,255,0.2)" stroke="#e5857a" stroke-width="2" />
                    <text x="300" y="165" text-anchor="middle" fill="#e5857a" font-weight="bold" font-size="14">Getter</text>
                    <text x="300" y="185" text-anchor="middle" fill="#e5857a" font-weight="bold" font-size="14">Setter（可选）</text>
                    
                    <!-- 箭头 -->
                    <path d="M220 100 L 370 100" stroke="#e5857a" stroke-width="2" fill="none" />
                    <path d="M365 95 L 370 100 L 365 105" stroke="#e5857a" stroke-width="2" fill="none" />
                    
                    <path d="M380 120 L 300 140" stroke="#e5857a" stroke-width="2" fill="none" />
                    <path d="M300 200 L 220 120" stroke="#e5857a" stroke-width="2" fill="none" />
                </svg>
            </div>

            <h3>基本语法</h3>
            <pre><code>struct SomeStruct {
    // 存储属性
    var firstValue = 10
    var secondValue = 20
    
    // 计算属性
    var computedProperty: Int {
        get {
            // 返回一个基于其他属性计算的值
            return firstValue + secondValue
        }
        set(newValue) {
            // 基于新值来更新其他属性
            firstValue = newValue / 2
            secondValue = newValue / 2
        }
    }
    
    // 只读计算属性 (只有 getter 没有 setter)
    var readOnlyProperty: Int {
        return firstValue * secondValue
    }
}</code></pre>

            <h3>示例：计算属性实践</h3>
            <div class="example-section">
                <pre><code>struct Circle {
    // 存储属性
    var radius: Double
    
    // 计算属性 - 圆的直径
    var diameter: Double {
        get {
            return radius * 2
        }
        set {
            // 通过设置直径来更新半径
            radius = newValue / 2
        }
    }
    
    // 只读计算属性 - 圆的面积
    var area: Double {
        return Double.pi * radius * radius
    }
    
    // 只读计算属性 - 圆的周长
    var perimeter: Double {
        return 2 * Double.pi * radius
    }
}

var circle = Circle(radius: 5.0)
print("半径: \(circle.radius)")        // 输出: 半径: 5.0
print("直径: \(circle.diameter)")      // 输出: 直径: 10.0
print("面积: \(circle.area)")          // 输出: 面积: 78.53981633974483
print("周长: \(circle.perimeter)")      // 输出: 周长: 31.41592653589793

// 通过计算属性更新存储属性
circle.diameter = 14.0
print("更新后的半径: \(circle.radius)")  // 输出: 更新后的半径: 7.0
print("更新后的面积: \(circle.area)")    // 输出: 更新后的面积: 153.93804002589985</code></pre>
                <p class="code-explanation">在这个示例中，我们创建了一个表示圆的结构体，其中包含一个存储属性（半径）和多个计算属性（直径、面积、周长）。直径是一个可读写的计算属性，而面积和周长是只读计算属性。</p>
            </div>
        </div>

        <div class="card">
            <h2>属性观察器</h2>
            <p>属性观察器监控和响应属性值的变化，在属性值被设置时调用，即使新值与当前值相同。</p>

            <h3>两种属性观察器</h3>
            <ul>
                <li><code>willSet</code> - 在值被存储前调用</li>
                <li><code>didSet</code> - 在新值被存储后立即调用</li>
            </ul>

            <div class="example-section">
                <pre><code>class StepCounter {
    // 定义一个带有属性观察器的属性
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("将步数从 \(totalSteps) 更新为 \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
    }
}

let stepCounter = StepCounter()

// 更新步数，触发属性观察器
stepCounter.totalSteps = 200
// 输出: 将步数从 0 更新为 200
// 输出: 增加了 200 步

// 再次更新步数
stepCounter.totalSteps = 360
// 输出: 将步数从 200 更新为 360
// 输出: 增加了 160 步</code></pre>
                <p class="code-explanation">在这个示例中，我们定义了一个 <code>StepCounter</code> 类来跟踪用户步数。属性观察器被用来在步数变化时提供反馈。</p>
            </div>

            <div class="warning">
                <p><strong>注意：</strong> 属性观察器不会在初始化过程中被调用。此外，如果在属性自身的 <code>willSet</code> 或 <code>didSet</code> 观察器中设置属性值，这些观察器也不会被调用。</p>
            </div>
        </div>

        <div class="card">
            <h2>类型属性</h2>
            <p>类型属性是属于类型本身的属性，而不是属于该类型的实例。无论创建了多少个实例，都只存在一个类型属性的副本。</p>

            <h3>语法</h3>
            <p>使用 <code>static</code> 关键字来定义类型属性。对于类类型的计算类型属性，可以使用 <code>class</code> 关键字来允许子类重写。</p>

            <div class="example-section">
                <pre><code>struct SomeStructure {
    // 存储类型属性
    static var storedTypeProperty = "Some value."
    
    // 计算类型属性
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    // 存储类型属性
    static var storedTypeProperty = "Some value."
    
    // 计算类型属性
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    // 存储类型属性
    static var storedTypeProperty = "Some value."
    
    // 计算类型属性
    static var computedTypeProperty: Int {
        return 27
    }
    
    // 类类型可以使用 class 关键字使计算属性可被子类重写
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}</code></pre>
            </div>

            <h3>实际示例：类型属性的应用</h3>
            <div class="example-section">
                <pre><code>struct AudioChannel {
    // 静态属性，所有实例共享
    static let maxVolume = 10
    static var currentMaxVolume = 0
    
    // 实例属性
    var volume: Int = 0 {
        didSet {
            // 确保音量不超过允许的最大值
            if volume > AudioChannel.maxVolume {
                volume = AudioChannel.maxVolume
            }
            
            // 追踪音量的历史最大值
            if volume > AudioChannel.currentMaxVolume {
                AudioChannel.currentMaxVolume = volume
            }
        }
    }
}

// 创建两个AudioChannel实例
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

// 设置左声道音量
leftChannel.volume = 7
print("左声道音量: \(leftChannel.volume)")
print("历史最大音量: \(AudioChannel.currentMaxVolume)")

// 设置右声道音量
rightChannel.volume = 11  // 超过最大值，会被限制为10
print("右声道音量: \(rightChannel.volume)")
print("历史最大音量: \(AudioChannel.currentMaxVolume)")

// 输出:
// 左声道音量: 7
// 历史最大音量: 7
// 右声道音量: 10
// 历史最大音量: 10</code></pre>
                <p class="code-explanation">这个示例展示了如何使用类型属性来跟踪多个实例之间共享的信息。</p>
            </div>
        </div>

        <div class="card">
            <h2>属性包装器 (Property Wrappers)</h2>
            <p>属性包装器在管理属性如何存储和定义属性的代码之间添加了一层分离。它可以在多个属性之间重用相同的管理代码。</p>

            <div class="example-section">
                <pre><code>// 定义一个确保值在特定范围内的属性包装器
@propertyWrapper
struct Clamped&lt;T: Comparable> {
    private var value: T
    private let range: ClosedRange&lt;T>
    
    // 初始化方法
    init(wrappedValue: T, range: ClosedRange&lt;T>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
    
    // 包装值
    var wrappedValue: T {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
    
    // 投影值 - 提供额外功能
    var projectedValue: ClosedRange&lt;T> {
        return range
    }
}

// 使用属性包装器
struct Player {
    // 使用属性包装器限制血量在0到100之间
    @Clamped(range: 0...100) var health = 100
    
    // 使用属性包装器限制能量在0到50之间
    @Clamped(range: 0...50) var energy = 50
    
    func printStats() {
        print("生命值: \(health)/100, 能量: \(energy)/50")
        print("生命值范围: \($health)") // 访问投影值
    }
}

var player = Player()
player.printStats() // 输出: 生命值: 100/100, 能量: 50/50

// 尝试设置超出范围的值
player.health = 150
player.energy = -10
player.printStats() // 输出: 生命值: 100/100, 能量: 0/50</code></pre>
                <p class="code-explanation">这个示例展示了如何使用属性包装器来确保属性值在特定范围内，避免重复编写限制逻辑。</p>
            </div>
        </div>

        <div class="card">
            <h2>属性的最佳实践</h2>
            <ul>
                <li>使用存储属性来存储需要保留的数据</li>
                <li>使用计算属性来提供派生的值，避免数据冗余</li>
                <li>使用属性观察器来响应属性值的变化</li>
                <li>使用类型属性来管理类型级别的数据</li>
                <li>使用延迟属性来延迟资源密集型操作，直到真正需要时才执行</li>
                <li>使用属性包装器来重用属性验证和处理逻辑</li>
            </ul>
        </div>

        <div class="card">
            <h2>学习资源</h2>
            <div class="resource-section">
                <div class="resource-card">
                    <h4>官方文档</h4>
                    <ul>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Properties.html" target="_blank">Swift 官方文档 - 属性</a></li>
                        <li><a href="https://developer.apple.com/documentation/swift/declaring-a-property-with-a-wrapper" target="_blank">Apple 开发者文档 - 属性包装器</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>推荐书籍</h4>
                    <ul>
                        <li>《Swift 编程权威指南》（The Swift Programming Language）</li>
                        <li>《Swift 进阶》 - 王巍</li>
                        <li>《Pro Swift》 - Paul Hudson</li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>视频教程</h4>
                    <ul>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2019/415/" target="_blank">WWDC 2019 - Modern Swift API Design</a></li>
                        <li>SwiftUI 和 Combine 教程 - Hacking with Swift</li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>开源项目</h4>
                    <ul>
                        <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Swift Composable Architecture</a></li>
                        <li><a href="https://github.com/SwifterSwift/SwifterSwift" target="_blank">SwifterSwift</a></li>
                    </ul>
                </div>
                
                <div class="resource-card">
                    <h4>博客文章</h4>
                    <ul>
                        <li><a href="https://www.swiftbysundell.com/articles/property-wrappers-in-swift/" target="_blank">Swift by Sundell - 属性包装器详解</a></li>
                        <li><a href="https://www.hackingwithswift.com/quick-start/swiftui/what-is-a-property-wrapper" target="_blank">Hacking with Swift - 什么是属性包装器</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
