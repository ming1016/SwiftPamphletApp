<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift类详解 - Apple开发者手册</title>
    <style>
        :root {
            --primary-color: #ffb6c1;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --bg-color: rgba(255, 255, 255, 0.85);
            --code-bg: #f5f5f5;
            --border-color: #ffb6c1;
            --shadow-color: rgba(0, 0, 0, 0.1);
            --link-color: #d81b60;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-color: #d81b60;
                --secondary-color: #2d2d2d;
                --text-color: #e0e0e0;
                --bg-color: rgba(30, 30, 30, 0.85);
                --code-bg: #252525;
                --border-color: #d81b60;
                --shadow-color: rgba(0, 0, 0, 0.3);
                --link-color: #ffb6c1;
            }
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            margin: 0;
            padding: 0;
            background-color: var(--secondary-color);
            background-image: radial-gradient(circle at 50% 50%, rgba(255, 182, 193, 0.1) 0%, transparent 80%);
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--bg-color);
            border-radius: 15px;
            box-shadow: 0 8px 30px var(--shadow-color);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 182, 193, 0.3);
        }

        h1, h2, h3, h4 {
            color: var(--primary-color);
            margin-top: 2rem;
            margin-bottom: 1rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        h1 {
            font-size: 2.5rem;
            text-align: center;
            margin-top: 0;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--primary-color);
            text-shadow: 0 2px 4px var(--shadow-color);
        }

        h2 {
            font-size: 1.8rem;
            border-left: 5px solid var(--primary-color);
            padding-left: 15px;
        }

        h3 {
            font-size: 1.4rem;
        }

        p, li {
            margin-bottom: 1rem;
            text-align: justify;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--link-color);
            transition: all 0.3s ease;
        }

        a:hover {
            border-bottom: 1px solid var(--link-color);
        }

        pre {
            background-color: var(--code-bg);
            border-radius: 10px;
            padding: 1rem;
            overflow-x: auto;
            margin: 1.5rem 0;
            border-left: 3px solid var(--primary-color);
            box-shadow: inset 0 0 10px var(--shadow-color);
        }

        code {
            font-family: "SF Mono", Monaco, Menlo, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9rem;
            background-color: var(--code-bg);
            padding: 2px 5px;
            border-radius: 3px;
        }

        .note {
            background-color: rgba(255, 182, 193, 0.1);
            padding: 1rem;
            border-radius: 10px;
            border-left: 4px solid var(--primary-color);
            margin: 1.5rem 0;
        }

        .resources {
            margin-top: 2rem;
            padding: 1.5rem;
            background-color: rgba(255, 182, 193, 0.1);
            border-radius: 10px;
            border: 1px solid var(--border-color);
        }

        .resource-group {
            margin-bottom: 1rem;
        }

        .diagram {
            display: flex;
            justify-content: center;
            margin: 2rem 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
            overflow-x: auto;
            display: block;
        }

        table, th, td {
            border: 1px solid var(--border-color);
        }

        th {
            background-color: rgba(255, 182, 193, 0.2);
            padding: 0.75rem;
            text-align: left;
        }

        td {
            padding: 0.75rem;
        }

        tr:nth-child(even) {
            background-color: rgba(255, 182, 193, 0.05);
        }

        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
                margin: 1rem;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Swift类详解</h1>

        <section id="introduction">
            <h2>1. 引言</h2>
            <p>类是Swift中最常用的引用类型之一，作为面向对象编程的核心，它允许我们创建复杂的数据结构并实现代码复用和继承。本章将深入探讨Swift中类的各个方面，从基本定义到高级特性。</p>

            <div class="diagram">
                <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="classGradient" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#ffb6c1;stop-opacity:0.8" />
                            <stop offset="100%" style="stop-color:#d81b60;stop-opacity:0.8" />
                        </linearGradient>
                    </defs>
                    <!-- 类的主要概念示意图 -->
                    <rect x="150" y="20" width="300" height="80" rx="10" fill="url(#classGradient)" />
                    <text x="300" y="65" text-anchor="middle" fill="white" font-weight="bold" font-size="20">类(Class)</text>

                    <!-- 特性连接 -->
                    <line x1="300" y1="100" x2="300" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="120" x2="150" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="120" x2="450" y2="120" stroke="#ffb6c1" stroke-width="2" />

                    <line x1="150" y1="120" x2="150" y2="150" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="120" x2="300" y2="150" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="450" y1="120" x2="450" y2="150" stroke="#ffb6c1" stroke-width="2" />

                    <!-- 特性方框 -->
                    <rect x="75" y="150" width="150" height="60" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="150" y="185" text-anchor="middle" fill="#333">引用类型</text>

                    <rect x="225" y="150" width="150" height="60" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="300" y="185" text-anchor="middle" fill="#333">支持继承</text>

                    <rect x="375" y="150" width="150" height="60" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="450" y="185" text-anchor="middle" fill="#333">引用计数</text>

                    <!-- 底部细节连接 -->
                    <line x1="150" y1="210" x2="150" y2="230" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="75" y="230" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="150" y="260" text-anchor="middle" fill="#333" font-size="12">多个变量指向同一实例</text>

                    <line x1="300" y1="210" x2="300" y2="230" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="225" y="230" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="300" y="260" text-anchor="middle" fill="#333" font-size="12">子类继承父类特性</text>

                    <line x1="450" y1="210" x2="450" y2="230" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="375" y="230" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="450" y="252" text-anchor="middle" fill="#333" font-size="12">ARC自动管理内存</text>
                    <text x="450" y="270" text-anchor="middle" fill="#333" font-size="12">(引用计数为0时释放)</text>
                </svg>
            </div>

            <div class="note">
                <p><strong>重要概念：</strong>Swift中的类是<strong>引用类型</strong>，而不是值类型。这意味着类的实例在传递时共享同一个引用，而不会被复制。</p>
            </div>
        </section>

        <section id="class-definition">
            <h2>2. 类的声明与初始化</h2>

            <h3>2.1 类的基本声明</h3>
            <p>在Swift中，类使用<code>class</code>关键字声明，并可以包含属性、方法、下标和初始化器等成员。</p>

            <pre><code>// 基本类声明
class Person {
    // 属性
    var name: String
    var age: Int

    // 初始化方法
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    // 方法
    func introduce() {
        print("你好，我是\(name)，今年\(age)岁。")
    }
}</code></pre>

            <h3>2.2 类的初始化</h3>
            <p>类的初始化器负责确保所有非可选类型的属性都有初始值，Swift提供了指定初始化器和便利初始化器两种类型。</p>

            <div class="diagram">
                <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="initGradient" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#ffb6c1;stop-opacity:0.8" />
                            <stop offset="100%" style="stop-color:#d81b60;stop-opacity:0.8" />
                        </linearGradient>
                    </defs>
                    <!-- 初始化过程图 -->
                    <rect x="200" y="30" width="200" height="60" rx="10" fill="url(#initGradient)" />
                    <text x="300" y="65" text-anchor="middle" fill="white" font-size="16">类初始化过程</text>

                    <!-- 两种初始化器 -->
                    <line x1="300" y1="90" x2="300" y2="110" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="110" x2="200" y2="110" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="110" x2="400" y2="110" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="200" y1="110" x2="200" y2="130" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="400" y1="110" x2="400" y2="130" stroke="#ffb6c1" stroke-width="2" />

                    <rect x="100" y="130" width="200" height="50" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="200" y="160" text-anchor="middle" fill="#333" font-size="14">指定初始化器(Designated)</text>

                    <rect x="300" y="130" width="200" height="50" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="400" y="160" text-anchor="middle" fill="#333" font-size="14">便利初始化器(Convenience)</text>

                    <!-- 初始化步骤 -->
                    <line x1="200" y1="180" x2="200" y2="200" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="100" y="200" width="200" height="70" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="200" y="225" text-anchor="middle" fill="#333" font-size="12">1. 初始化所有存储属性</text>
                    <text x="200" y="245" text-anchor="middle" fill="#333" font-size="12">2. 调用父类初始化器</text>
                    <text x="200" y="265" text-anchor="middle" fill="#333" font-size="12">3. 自定义其他初始化逻辑</text>

                    <line x1="400" y1="180" x2="400" y2="200" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="300" y="200" width="200" height="70" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="400" y="225" text-anchor="middle" fill="#333" font-size="12">必须调用同一类中的</text>
                    <text x="400" y="245" text-anchor="middle" fill="#333" font-size="12">其他初始化器(指定或便利)</text>
                    <text x="400" y="265" text-anchor="middle" fill="#333" font-size="12">关键字: convenience</text>

                    <!-- 箭头连接 -->
                    <path d="M300 235 C320 235, 320 235, 340 235" fill="none" stroke="#ffb6c1" stroke-width="2" marker-end="url(#arrow)"/>
                    <defs>
                        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
                            <path d="M0,0 L0,6 L9,3 z" fill="#ffb6c1" />
                        </marker>
                    </defs>
                </svg>
            </div>

            <pre><code>class Vehicle {
    var numberOfWheels: Int
    var description: String

    // 指定初始化器
    init(wheels: Int, description: String) {
        self.numberOfWheels = wheels
        self.description = description
    }

    // 便利初始化器
    convenience init() {
        // 调用指定初始化器
        self.init(wheels: 4, description: "未知车辆")
    }
}</code></pre>

            <h3>2.3 两阶段初始化</h3>
            <p>Swift类的初始化过程分为两个阶段：</p>
            <ol>
                <li><strong>第一阶段</strong>：为类的每个存储属性分配初始值</li>
                <li><strong>第二阶段</strong>：在新实例可以使用之前进一步自定义存储属性</li>
            </ol>

            <pre><code>class Animal {
    var name: String

    init(name: String) {
        // 第一阶段：初始化存储属性
        self.name = name
        // 此时self可用，可以调用方法和访问属性
        self.customizeDetails()
    }

    func customizeDetails() {
        // 第二阶段：自定义其他逻辑
        print("\(name)已初始化")
    }
}</code></pre>
        </section>

        <section id="class-inheritance">
            <h2>3. 类的继承</h2>
            <p>继承是面向对象编程的核心特性之一，Swift中的类可以继承另一个类的方法、属性和其他特性。</p>

            <div class="diagram">
                <svg width="600" height="350" viewBox="0 0 600 350" xmlns="http://www.w3.org/2000/svg">
                    <!-- 继承层次结构图 -->
                    <rect x="200" y="30" width="200" height="60" rx="10" fill="url(#classGradient)" />
                    <text x="300" y="65" text-anchor="middle" fill="white" font-weight="bold" font-size="16">Animal (父类)</text>

                    <!-- 父类到子类连接 -->
                    <line x1="300" y1="90" x2="300" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="120" x2="150" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="120" x2="450" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="150" y1="120" x2="150" y2="150" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="300" y1="120" x2="300" y2="150" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="450" y1="120" x2="450" y2="150" stroke="#ffb6c1" stroke-width="2" />

                    <!-- 子类们 -->
                    <rect x="75" y="150" width="150" height="50" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="150" y="180" text-anchor="middle" fill="#333" font-size="14">Mammal (子类)</text>

                    <rect x="225" y="150" width="150" height="50" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="300" y="180" text-anchor="middle" fill="#333" font-size="14">Bird (子类)</text>

                    <rect x="375" y="150" width="150" height="50" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="450" y="180" text-anchor="middle" fill="#333" font-size="14">Fish (子类)</text>

                    <!-- 更深层次继承 -->
                    <line x1="150" y1="200" x2="150" y2="230" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="75" y="230" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="150" y="260" text-anchor="middle" fill="#333" font-size="14">Dog (孙类)</text>

                    <!-- 继承特性说明 -->
                    <rect x="100" y="300" width="400" height="30" rx="5" stroke="#ffb6c1" stroke-width="1" fill="none" />
                    <text x="300" y="320" text-anchor="middle" fill="var(--text-color)" font-size="12">子类继承父类的属性和方法，可以重写(override)或添加新成员</text>
                </svg>
            </div>

            <pre><code>// 父类定义
class Animal {
    var name: String

    init(name: String) {
        self.name = name
    }

    func makeSound() {
        print("动物发出声音")
    }
}

// 子类继承
class Dog: Animal {
    var breed: String

    init(name: String, breed: String) {
        self.breed = breed
        // 调用父类初始化器
        super.init(name: name)
    }

    // 重写父类方法
    override func makeSound() {
        print("汪汪汪！")
    }

    // 子类特有方法
    func fetch() {
        print("\(name)去捡回来了！")
    }
}</code></pre>

            <h3>3.1 方法重写</h3>
            <p>子类可以重写继承自父类的实例方法、类方法、实例属性、类属性或下标。重写时必须使用<code>override</code>关键字。</p>

            <pre><code>class Vehicle {
    var currentSpeed = 0.0

    func description() -> String {
        return "以\(currentSpeed)公里/小时的速度行驶"
    }
}

class Bicycle: Vehicle {
    var hasBasket = false

    // 重写方法
    override func description() -> String {
        // 调用父类方法获取基本描述
        let baseDescription = super.description()

        // 添加额外信息
        if hasBasket {
            return baseDescription + ", 带有一个篮子"
        } else {
            return baseDescription
        }
    }
}</code></pre>

            <h3>3.2 属性重写</h3>
            <p>子类可以通过提供自己的实现来重写继承的属性：</p>

            <pre><code>class Vehicle {
    var description: String {
        return "一个交通工具"
    }
}

class Car: Vehicle {
    var brand: String = ""

    // 重写计算属性
    override var description: String {
        return "一辆\(brand)汽车"
    }

    init(brand: String) {
        self.brand = brand
    }
}</code></pre>

            <h3>3.3 防止重写</h3>
            <p>使用<code>final</code>关键字可以防止类、方法、属性或下标被重写：</p>

            <pre><code>final class FinalClass {
    // 这个类不能被继承
}

class BaseClass {
    // 这个方法不能被重写
    final func cannotBeOverridden() {
        print("此方法不能被重写")
    }
}</code></pre>
        </section>

        <section id="class-properties-methods">
            <h2>4. 类的属性与方法</h2>

            <h3>4.1 属性类型</h3>
            <p>Swift类可以包含多种类型的属性：</p>

            <table>
                <thead>
                    <tr>
                        <th>属性类型</th>
                        <th>描述</th>
                        <th>声明方式</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>存储属性</td>
                        <td>存储常量或变量作为类的实例一部分</td>
                        <td><code>var/let propertyName: Type</code></td>
                    </tr>
                    <tr>
                        <td>计算属性</td>
                        <td>通过计算提供值，不实际存储</td>
                        <td><code>var propertyName: Type { get {} set {} }</code></td>
                    </tr>
                    <tr>
                        <td>类型属性</td>
                        <td>属于类型本身，而不是实例</td>
                        <td><code>static var/let propertyName: Type</code></td>
                    </tr>
                    <tr>
                        <td>属性观察器</td>
                        <td>监控和响应属性值的变化</td>
                        <td><code>willSet{} didSet{}</code></td>
                    </tr>
                </tbody>
            </table>

            <pre><code>class Temperature {
    // 存储属性
    var celsius: Double = 0.0

    // 计算属性
    var fahrenheit: Double {
        get {
            return celsius * 9/5 + 32
        }
        set {
            celsius = (newValue - 32) * 5/9
        }
    }

    // 类型属性
    static let absoluteZeroCelsius = -273.15

    // 属性观察器
    var temperatureInKelvin: Double = 273.15 {
        willSet {
            print("温度将从 \(temperatureInKelvin)K 变为 \(newValue)K")
        }
        didSet {
            print("温度已从 \(oldValue)K 变为 \(temperatureInKelvin)K")
            // 更新摄氏度
            celsius = temperatureInKelvin - 273.15
        }
    }
}</code></pre>

            <h3>4.2 方法类型</h3>
            <p>Swift类中可以定义不同类型的方法：</p>

            <pre><code>class Counter {
    var count = 0

    // 实例方法
    func increment() {
        count += 1
    }

    func increment(by amount: Int) {
        count += amount
    }

    // 类型方法
    static func commonDescription() -> String {
        return "一个计数器类型"
    }

    // 可变类型方法(可被子类重写)
    class func overridableTypeMethod() {
        print("可以被子类重写的类型方法")
    }
}</code></pre>

            <h3>4.3 下标</h3>
            <p>类可以定义下标来通过索引访问集合、列表或序列的元素：</p>

            <pre><code>class Matrix {
    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }

    // 下标方法
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(row >= 0 && row < rows && column >= 0 && column < columns, "下标越界")
            return grid[(row * columns) + column]
        }
        set {
            assert(row >= 0 && row < rows && column >= 0 && column < columns, "下标越界")
            grid[(row * columns) + column] = newValue
        }
    }
}

// 使用下标
let matrix = Matrix(rows: 3, columns: 3)
matrix[0, 1] = 1.5  // 设置值
print(matrix[0, 1]) // 获取值</code></pre>
        </section>

        <section id="type-casting">
            <h2>5. 类型转换</h2>
            <p>Swift提供了类型检查和类型转换机制，使我们能够在运行时检查和解释实例的类型。</p>

            <div class="diagram">
                <svg width="500" height="250" viewBox="0 0 500 250" xmlns="http://www.w3.org/2000/svg">
                    <!-- 类型转换图 -->
                    <rect x="150" y="30" width="200" height="50" rx="8" fill="url(#classGradient)" />
                    <text x="250" y="60" text-anchor="middle" fill="white" font-size="16">类型转换操作</text>

                    <!-- 三种类型转换操作 -->
                    <line x1="250" y1="80" x2="250" y2="100" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="250" y1="100" x2="100" y2="100" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="250" y1="100" x2="250" y2="100" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="250" y1="100" x2="400" y2="100" stroke="#ffb6c1" stroke-width="2" />

                    <line x1="100" y1="100" x2="100" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="250" y1="100" x2="250" y2="120" stroke="#ffb6c1" stroke-width="2" />
                    <line x1="400" y1="100" x2="400" y2="120" stroke="#ffb6c1" stroke-width="2" />

                    <rect x="25" y="120" width="150" height="40" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="100" y="145" text-anchor="middle" fill="#333" font-size="14">is (类型检查)</text>

                    <rect x="175" y="120" width="150" height="40" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="250" y="145" text-anchor="middle" fill="#333" font-size="14">as? (条件转换)</text>

                    <rect x="325" y="120" width="150" height="40" rx="8" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="400" y="145" text-anchor="middle" fill="#333" font-size="14">as! (强制转换)</text>

                    <!-- 说明 -->
                    <line x1="100" y1="160" x2="100" y2="180" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="25" y="180" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="100" y="200" text-anchor="middle" fill="#333" font-size="12">检查实例是否为</text>
                    <text x="100" y="220" text-anchor="middle" fill="#333" font-size="12">特定类型，返回Bool</text>

                    <line x1="250" y1="160" x2="250" y2="180" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="175" y="180" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="250" y="200" text-anchor="middle" fill="#333" font-size="12">尝试转换，成功返回</text>
                    <text x="250" y="220" text-anchor="middle" fill="#333" font-size="12">可选值，失败返回nil</text>

                    <line x1="400" y1="160" x2="400" y2="180" stroke="#ffb6c1" stroke-width="2" />
                    <rect x="325" y="180" width="150" height="50" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="400" y="200" text-anchor="middle" fill="#333" font-size="12">强制转换，失败会</text>
                    <text x="400" y="220" text-anchor="middle" fill="#333" font-size="12">触发运行时错误</text>
                </svg>
            </div>

            <pre><code>// 继承关系
class MediaItem {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String

    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String

    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 创建混合类型的数组
let library = [
    Movie(name: "星际穿越", director: "克里斯托弗·诺兰"),
    Song(name: "Shape of You", artist: "艾德·希兰"),
    Movie(name: "黑客帝国", director: "沃卓斯基姐妹"),
    Song(name: "Despacito", artist: "Luis Fonsi")
]

// 类型检查
var movieCount = 0
var songCount = 0

for item in library {
    // 使用is运算符检查类型
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("媒体库包含 \(movieCount) 部电影和 \(songCount) 首歌")

// 向下转型
for item in library {
    // 使用as?条件转型
    if let movie = item as? Movie {
        print("电影: \(movie.name), 导演: \(movie.director)")
    } else if let song = item as? Song {
        print("歌曲: \(song.name), 艺术家: \(song.artist)")
    }
}</code></pre>

            <div class="note">
                <p><strong>安全提示：</strong>尽量使用<code>as?</code>进行条件转换，而不是<code>as!</code>强制转换，以避免运行时崩溃。只有在确定转换一定会成功的情况下才使用强制转换。</p>
            </div>
        </section>

        <section id="deinit">
            <h2>6. 析构过程</h2>
            <p>析构器在类实例被释放前自动调用，用于执行任何自定义的清理工作。每个类最多只能有一个析构器。</p>

            <pre><code>class DBConnection {
    var connection: String

    init(connection: String) {
        self.connection = connection
        print("创建数据库连接: \(connection)")
    }

    // 析构器
    deinit {
        print("关闭数据库连接: \(connection)")
        // 执行清理工作，如关闭连接、释放资源等
    }

    func query(_ sql: String) {
        print("执行查询: \(sql)")
    }
}

// 创建一个作用域来演示析构器的调用
func useDatabase() {
    let db = DBConnection(connection: "mysql://localhost:3306/mydb")
    db.query("SELECT * FROM users")

    // 当函数结束时，db变量超出作用域，
    // 其引用计数变为0，自动调用deinit
}

useDatabase()
// 输出:
// 创建数据库连接: mysql://localhost:3306/mydb
// 执行查询: SELECT * FROM users
// 关闭数据库连接: mysql://localhost:3306/mydb</code></pre>
        </section>

        <section id="class-vs-struct">
            <h2>7. 类与结构体的比较</h2>
            <p>在Swift中，类和结构体有许多相似之处，但也有重要区别。</p>

            <div class="diagram">
                <svg width="600" height="400" viewBox="0 0 600 400" xmlns="http://www.w3.org/2000/svg">
                    <!-- 类vs结构体比较图 -->
                    <rect x="50" y="30" width="200" height="60" rx="10" fill="url(#classGradient)" />
                    <text x="150" y="65" text-anchor="middle" fill="white" font-weight="bold" font-size="18">类(Class)</text>

                    <rect x="350" y="30" width="200" height="60" rx="10" fill="#4db6ac" />
                    <text x="450" y="65" text-anchor="middle" fill="white" font-weight="bold" font-size="18">结构体(Struct)</text>

                    <!-- 特征对比 -->
                    <!-- 引用vs值 -->
                    <rect x="25" y="110" width="250" height="40" rx="5" fill="rgba(255, 182, 193, 0.4)" />
                    <text x="150" y="135" text-anchor="middle" fill="#333" font-size="14">引用类型</text>

                    <rect x="325" y="110" width="250" height="40" rx="5" fill="rgba(77, 182, 172, 0.4)" />
                    <text x="450" y="135" text-anchor="middle" fill="#333" font-size="14">值类型</text>

                    <!-- 继承 -->
                    <rect x="25" y="160" width="250" height="40" rx="5" fill="rgba(255, 182, 193, 0.4)" />
                    <text x="150" y="185" text-anchor="middle" fill="#333" font-size="14">支持继承</text>

                    <rect x="325" y="160" width="250" height="40" rx="5" fill="rgba(77, 182, 172, 0.4)" />
                    <text x="450" y="185" text-anchor="middle" fill="#333" font-size="14">不支持继承</text>

                    <!-- 析构 -->
                    <rect x="25" y="210" width="250" height="40" rx="5" fill="rgba(255, 182, 193, 0.4)" />
                    <text x="150" y="235" text-anchor="middle" fill="#333" font-size="14">有析构器(deinit)</text>

                    <rect x="325" y="210" width="250" height="40" rx="5" fill="rgba(77, 182, 172, 0.4)" />
                    <text x="450" y="235" text-anchor="middle" fill="#333" font-size="14">无析构器</text>

                    <!-- 引用计数 -->
                    <rect x="25" y="260" width="250" height="40" rx="5" fill="rgba(255, 182, 193, 0.4)" />
                    <text x="150" y="285" text-anchor="middle" fill="#333" font-size="14">使用ARC内存管理</text>

                    <rect x="325" y="260" width="250" height="40" rx="5" fill="rgba(77, 182, 172, 0.4)" />
                    <text x="450" y="285" text-anchor="middle" fill="#333" font-size="14">不使用引用计数</text>

                    <!-- 类型转换 -->
                    <rect x="25" y="310" width="250" height="40" rx="5" fill="rgba(255, 182, 193, 0.4)" />
                    <text x="150" y="335" text-anchor="middle" fill="#333" font-size="14">支持运行时类型转换</text>

                    <rect x="325" y="310" width="250" height="40" rx="5" fill="rgba(77, 182, 172, 0.4)" />
                    <text x="450" y="335" text-anchor="middle" fill="#333" font-size="14">不支持运行时类型转换</text>

                    <!-- 建议使用场景 -->
                    <rect x="25" y="360" width="250" height="40" rx="5" stroke="#ffb6c1" stroke-width="2" fill="none" />
                    <text x="150" y="385" text-anchor="middle" fill="var(--text-color)" font-size="12">适用于：需要身份，继承或引用语义</text>

                    <rect x="325" y="360" width="250" height="40" rx="5" stroke="#4db6ac" stroke-width="2" fill="none" />
                    <text x="450" y="385" text-anchor="middle" fill="var(--text-color)" font-size="12">适用于：封装数据，值语义或无需继承</text>
                </svg>
            </div>

            <pre><code>// 类示例
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func celebrateBirthday() {
        age += 1
        print("\(name) 现在 \(age) 岁了!")
    }
}

// 引用类型示例
func demonstrateClassReference() {
    let person1 = Person(name: "张三", age: 30)
    let person2 = person1  // person2与person1指向同一实例

    person2.name = "李四"  // 修改person2也会影响person1

    print("person1.name: \(person1.name)")  // 输出: person1.name: 李四
    print("person2.name: \(person2.name)")  // 输出: person2.name: 李四
}

// 结构体示例
struct Point {
    var x: Double
    var y: Double

    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

// 值类型示例
func demonstrateStructValue() {
    var point1 = Point(x: 10, y: 10)
    var point2 = point1  // point2是point1的副本

    point2.moveBy(x: 5, y: 5)  // 只修改point2

    print("point1: (\(point1.x), \(point1.y))")  // 输出: point1: (10.0, 10.0)
    print("point2: (\(point2.x), \(point2.y))")  // 输出: point2: (15.0, 15.0)
}</code></pre>

            <div class="note">
                <p><strong>选择指南：</strong>当需要通过引用共享数据、需要继承能力、希望类型被转型为其他类型或需要析构器时，选择类。而当需要值语义、希望数据被复制而非共享或不需要继承时，选择结构体。</p>
            </div>
        </section>

        <section id="memory-management">
            <h2>8. 内存管理与引用计数</h2>
            <p>Swift使用自动引用计数（ARC）来管理类实例的内存。</p>

            <div class="diagram">
                <svg width="600" height="350" viewBox="0 0 600 350" xmlns="http://www.w3.org/2000/svg">
                    <!-- ARC工作原理图 -->
                    <rect x="200" y="30" width="200" height="50" rx="8" fill="url(#classGradient)" />
                    <text x="300" y="60" text-anchor="middle" fill="white" font-size="16">ARC工作原理</text>

                    <!-- 中心实例 -->
                    <circle cx="300" cy="150" r="40" fill="rgba(255, 182, 193, 0.6)" />
                    <text x="300" y="155" text-anchor="middle" fill="#333" font-size="14">实例</text>

                    <!-- 引用箭头 -->
                    <line x1="200" y="100" x2="270" y2="130" stroke="#d81b60" stroke-width="2" marker-end="url(#arrow)" />
                    <line x1="400" y="100" x2="330" y2="130" stroke="#d81b60" stroke-width="2" marker-end="url(#arrow)" />
                    <line x1="200" y="200" x2="270" y2="170" stroke="#d81b60" stroke-width="2" marker-end="url(#arrow)" />
                    <line x1="400" y="200" x2="330" y2="170" stroke="#d81b60" stroke-width="2" marker-end="url(#arrow)" />

                    <!-- 引用变量 -->
                    <rect x="150" y="70" width="100" height="40" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="200" y="95" text-anchor="middle" fill="#333" font-size="14">变量A</text>

                    <rect x="350" y="70" width="100" height="40" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="400" y="95" text-anchor="middle" fill="#333" font-size="14">变量B</text>

                    <rect x="150" y="190" width="100" height="40" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="200" y="215" text-anchor="middle" fill="#333" font-size="14">变量C</text>

                    <rect x="350" y="190" width="100" height="40" rx="8" fill="rgba(216, 27, 96, 0.2)" />
                    <text x="400" y="215" text-anchor="middle" fill="#333" font-size="14">变量D</text>

                    <!-- 引用计数 -->
                    <rect x="270" y="190" width="60" height="30" rx="5" fill="white" stroke="#d81b60" />
                    <text x="300" y="210" text-anchor="middle" fill="#333" font-size="14">RC: 4</text>

                    <!-- 说明文字 -->
                    <rect x="100" y="250" width="400" height="80" rx="8" fill="none" stroke="#ffb6c1" stroke-dasharray="3,3" />
                    <text x="300" y="275" text-anchor="middle" fill="var(--text-color)" font-size="12">引用计数(RC)表示指向实例的引用数量</text>
                    <text x="300" y="295" text-anchor="middle" fill="var(--text-color)" font-size="12">当计数变为0时，实例被释放</text>
                    <text x="300" y="315" text-anchor="middle" fill="var(--text-color)" font-size="12">强引用会增加计数，弱引用(weak)或无主引用(unowned)不会</text>
                </svg>
            </div>

            <h3>8.1 强引用循环</h3>
            <p>强引用循环是指两个或多个类实例相互持有对方的强引用，导致它们永远不会被释放，从而造成内存泄漏。</p>

            <pre><code>class Person {
    let name: String

    // 强引用
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) 被初始化")
    }

    deinit {
        print("\(name) 被释放")
    }
}

class Apartment {
    let unit: String

    // 强引用 - 会导致循环引用
    var tenant: Person?

    init(unit: String) {
        self.unit = unit
        print("公寓 \(unit) 被初始化")
    }

    deinit {
        print("公寓 \(unit) 被释放")
    }
}

// 创建强引用循环
func createReferenceLoop() {
    let john = Person(name: "张三")
    let unit4A = Apartment(unit: "4A")

    // 创建循环引用
    john.apartment = unit4A
    unit4A.tenant = john

    // 函数结束后，即使john和unit4A变量不再使用
    // 它们指向的实例仍然相互引用，不会被释放，导致内存泄漏
}

createReferenceLoop()
// 输出:
// 张三 被初始化
// 公寓 4A 被初始化
// 没有输出 "张三 被释放" 或 "公寓 4A 被释放"</code></pre>

            <h3>8.2 解决强引用循环</h3>
            <p>Swift提供两种方式解决强引用循环：弱引用(weak)和无主引用(unowned)。</p>

            <pre><code>class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) 被初始化")
    }

    deinit {
        print("\(name) 被释放")
    }
}

class Apartment {
    let unit: String

    // 使用弱引用，避免循环引用
    weak var tenant: Person?

    init(unit: String) {
        self.unit = unit
        print("公寓 \(unit) 被初始化")
    }

    deinit {
        print("公寓 \(unit) 被释放")
    }
}

// 使用弱引用避免循环引用
func avoidReferenceLoop() {
    let john = Person(name: "张三")
    let unit4A = Apartment(unit: "4A")

    john.apartment = unit4A
    unit4A.tenant = john

    // 函数结束后，john和unit4A变量不再使用
    // 由于使用了weak引用，循环被打破，两个实例都能被正确释放
}

avoidReferenceLoop()
// 输出:
// 张三 被初始化
// 公寓 4A 被初始化
// 张三 被释放
// 公寓 4A 被释放</code></pre>

            <div class="note">
                <p><strong>weak vs unowned:</strong> 使用<code>weak</code>引用时，引用的对象可能在某个时刻变为<code>nil</code>。而<code>unowned</code>引用假设引用的对象总是存在，如果引用的对象被释放，访问无主引用会触发运行时错误。</p>
            </div>
        </section>

        <section id="best-practices">
            <h2>9. 最佳实践和设计模式</h2>
            <p>以下是使用Swift类时的一些最佳实践：</p>
            <ul>
                <li>遵循单一职责原则，每个类应该只有一个职责</li>
                <li>适当使用访问控制限制对类内部实现的访问</li>
                <li>利用协议和扩展增强类的功能</li>
                <li>谨慎处理强引用循环问题</li>
                <li>选择适当的初始化器模式</li>
                <li>使用值类型(结构体)和引用类型(类)的组合</li>
            </ul>

            <h3>9.1 富有表现力的初始化</h3>
            <pre><code>// 优良的初始化器设计
class BankAccount {
    let accountNumber: String
    let owner: String
    private(set) var balance: Double

    // 指定初始化器
    init(accountNumber: String, owner: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        self.owner = owner
        self.balance = initialBalance
    }

    // 便利初始化器 - 零余额账户
    convenience init(accountNumber: String, owner: String) {
        self.init(accountNumber: accountNumber, owner: owner, initialBalance: 0)
    }

    // 静态工厂方法 - 提供更具表现力的创建方式
    static func openSavingsAccount(for owner: String) -> BankAccount {
        // 生成账号
        let accountNumber = "SAV-" + UUID().uuidString.prefix(8).lowercased()
        return BankAccount(accountNumber: accountNumber, owner: owner, initialBalance: 0)
    }

    static func openPremiumAccount(for owner: String, initialDeposit: Double) -> BankAccount? {
        // 验证最低开户金额
        guard initialDeposit >= 10000 else {
            print("开设高级账户需要最低10000元首次存款")
            return nil
        }

        let accountNumber = "PREM-" + UUID().uuidString.prefix(8).lowercased()
        return BankAccount(accountNumber: accountNumber, owner: owner, initialBalance: initialDeposit)
    }

    // 账户操作方法
    func deposit(_ amount: Double) {
        balance += amount
    }

    func withdraw(_ amount: Double) -> Bool {
        guard amount <= balance else {
            return false
        }
        balance -= amount
        return true
    }
}</code></pre>

            <h3>9.2 使用访问控制</h3>
            <pre><code>class MediaPlayer {
    // 公开API
    public var currentTrack: String? {
        return _currentTrack
    }

    public var isPlaying: Bool {
        return _isPlaying
    }

    // 内部实现细节
    private var _currentTrack: String?
    private var _isPlaying = false
    private var audioEngine: AudioEngine

    // 初始化器
    init() {
        self.audioEngine = AudioEngine()
    }

    // 公开方法
    public func play(track: String) {
        preparePlayback(for: track)
        startPlayback()
        _currentTrack = track
        _isPlaying = true
    }

    public func stop() {
        audioEngine.stop()
        _isPlaying = false
    }

    // 私有辅助方法
    private func preparePlayback(for track: String) {
        audioEngine.load(trackName: track)
    }

    private func startPlayback() {
        audioEngine.start()
    }
}

// 模拟的音频引擎类
private class AudioEngine {
    func load(trackName: String) {
        print("加载音轨: \(trackName)")
    }

    func start() {
        print("开始播放")
    }

    func stop() {
        print("停止播放")
    }
}</code></pre>
        </section>

        <section id="resources">
            <h2>10. 参考资源</h2>
            <div class="resources">
                <div class="resource-group">
                    <h3>官方文档</h3>
                    <ul>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html" target="_blank">Swift官方文档 - 类和结构体</a></li>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html" target="_blank">Swift官方文档 - 继承</a></li>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Initialization.html" target="_blank">Swift官方文档 - 初始化</a></li>
                        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html" target="_blank">Swift官方文档 - 自动引用计数</a></li>
                    </ul>
                </div>

                <div class="resource-group">
                    <h3>学习资源</h3>
                    <ul>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2022/110352" target="_blank">WWDC - Swift中的内存安全</a></li>
                        <li><a href="https://developer.apple.com/videos/play/wwdc2022/110353" target="_blank">WWDC - Swift中的并发编程</a></li>
                        <li><a href="https://www.raywenderlich.com/books/swift-apprentice" target="_blank">Swift Apprentice（Ray Wenderlich）</a></li>
                    </ul>
                </div>

                <div class="resource-group">
                    <h3>社区资源</h3>
                    <ul>
                        <li><a href="https://stackoverflow.com/questions/tagged/swift" target="_blank">Stack Overflow - Swift标签</a></li>
                        <li><a href="https://forums.swift.org/" target="_blank">Swift论坛</a></li>
                        <li><a href="https://github.com/apple/swift" target="_blank">Swift开源代码库</a></li>
                    </ul>
                </div>
            </div>
        </section>


    </div>
</body>
</html>
