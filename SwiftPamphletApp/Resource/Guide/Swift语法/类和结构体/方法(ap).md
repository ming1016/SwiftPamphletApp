<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift类和结构体中的方法 - Apple开发技术手册</title>
    <style>
        /* 基础样式和响应式布局 */
        :root {
            --primary-bg: #b71c1c;
            --secondary-bg: #790000;
            --text-color: #333;
            --code-bg: #f5f5f5;
            --accent-color-1: #ff9800;
            --accent-color-2: #009688;
            --accent-color-3: #ffd700;
            --card-bg: #ffffff;
            --shadow-color: rgba(0, 0, 0, 0.2);
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --primary-bg: #6d0000;
                --secondary-bg: #4a0000;
                --text-color: #e0e0e0;
                --code-bg: #2d2d2d;
                --card-bg: #1a1a1a;
                --shadow-color: rgba(0, 0, 0, 0.4);
            }
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background: var(--primary-bg);
            color: var(--text-color);
            line-height: 1.6;
            padding: 20px;
            background-image: linear-gradient(45deg, var(--primary-bg), var(--secondary-bg));
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 10px 30px var(--shadow-color);
            overflow: hidden;
            position: relative;
        }

        /* 剪纸风格效果 */
        .paper-cut-top {
            height: 30px;
            background-color: var(--accent-color-1);
            clip-path: polygon(0% 0%, 5% 100%, 10% 0%, 15% 100%, 20% 0%, 25% 100%, 30% 0%, 35% 100%, 40% 0%, 45% 100%, 50% 0%, 55% 100%, 60% 0%, 65% 100%, 70% 0%, 75% 100%, 80% 0%, 85% 100%, 90% 0%, 95% 100%, 100% 0%);
            margin-bottom: 20px;
        }

        .paper-cut-bottom {
            height: 30px;
            background-color: var(--accent-color-2);
            clip-path: polygon(0% 100%, 5% 0%, 10% 100%, 15% 0%, 20% 100%, 25% 0%, 30% 100%, 35% 0%, 40% 100%, 45% 0%, 50% 100%, 55% 0%, 60% 100%, 65% 0%, 70% 100%, 75% 0%, 80% 100%, 85% 0%, 90% 100%, 95% 0%, 100% 100%);
            margin-top: 20px;
        }

        .content {
            padding: 30px;
        }

        h1, h2, h3 {
            color: var(--primary-bg);
            margin-bottom: 20px;
            position: relative;
        }

        h1::after, h2::after {
            content: '';
            display: block;
            height: 3px;
            width: 100px;
            background-color: var(--accent-color-1);
            margin-top: 10px;
        }

        p {
            margin-bottom: 20px;
        }

        pre {
            background-color: var(--code-bg);
            padding: 15px;
            border-radius: 8px;
            overflow-x: auto;
            margin: 20px 0;
            border-left: 4px solid var(--accent-color-1);
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            color: var(--accent-color-2);
        }

        .card {
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 5px 15px var(--shadow-color);
            margin: 25px 0;
            padding: 20px;
            position: relative;
        }

        .card::before {
            content: '';
            position: absolute;
            top: -5px;
            left: 10px;
            right: 10px;
            height: 5px;
            background-color: var(--accent-color-3);
            border-radius: 5px 5px 0 0;
        }

        .resources {
            background-color: rgba(183, 28, 28, 0.05);
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
        }

        .resources h3 {
            color: var(--accent-color-2);
        }

        .resources ul {
            list-style-type: none;
            padding-left: 20px;
        }

        .resources li {
            margin-bottom: 10px;
            position: relative;
        }

        .resources li::before {
            content: '•';
            color: var(--accent-color-1);
            font-size: 1.5em;
            position: absolute;
            left: -20px;
            top: -8px;
        }

        a {
            color: var(--accent-color-2);
            text-decoration: none;
            border-bottom: 1px dashed;
            transition: color 0.3s;
        }

        a:hover {
            color: var(--accent-color-1);
        }

        .note {
            background-color: rgba(255, 152, 0, 0.1);
            border-left: 4px solid var(--accent-color-1);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 8px 8px 0;
        }

        @media (max-width: 768px) {
            .content {
                padding: 20px;
            }

            pre {
                padding: 10px;
            }
        }

        /* SVG样式 */
        .svg-container {
            display: flex;
            justify-content: center;
            margin: 30px 0;
        }

        svg {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="paper-cut-top"></div>
        <div class="content">
            <h1>Swift类和结构体中的方法</h1>

            <p>在Swift中，方法是与特定类型相关联的函数。类、结构体和枚举都可以定义实例方法和类型方法，使得这些类型不仅可以封装数据，还能封装操作数据的行为。本章节将详细介绍Swift中方法的定义、使用和特性。</p>

            <div class="card">
                <h2>方法的基本概念</h2>
                <p>方法是与特定类型相关联的函数。Swift中的方法分为两类：</p>
                <ul>
                    <li><strong>实例方法</strong>：属于类型的实例，用于访问和修改实例属性或提供与实例相关的功能</li>
                    <li><strong>类型方法</strong>：属于类型本身，而不是实例，类似于其他语言中的"静态方法"</li>
                </ul>
            </div>

            <div class="svg-container">
                <svg width="600" height="300" viewBox="0 0 600 300">
                    <defs>
                        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#b71c1c;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#f05545;stop-opacity:1" />
                        </linearGradient>
                        <linearGradient id="grad2" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#009688;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#4db6ac;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <!-- 类型框 -->
                    <rect x="50" y="30" width="500" height="220" rx="10" ry="10" fill="#f9f9f9" stroke="#ddd" stroke-width="2"/>
                    <text x="270" y="20" font-family="Arial" font-size="16" font-weight="bold" text-anchor="middle">类型定义</text>

                    <!-- 类型方法区域 -->
                    <rect x="70" y="50" width="460" height="60" rx="8" ry="8" fill="url(#grad1)" stroke="#b71c1c" stroke-width="2"/>
                    <text x="300" y="85" font-family="Arial" font-size="14" fill="white" text-anchor="middle">类型方法(static/class func)</text>

                    <!-- 实例区域 -->
                    <rect x="100" y="140" width="130" height="80" rx="8" ry="8" fill="url(#grad2)" stroke="#009688" stroke-width="2"/>
                    <text x="165" y="170" font-family="Arial" font-size="14" fill="white" text-anchor="middle">实例1</text>
                    <text x="165" y="190" font-family="Arial" font-size="12" fill="white" text-anchor="middle">实例方法</text>

                    <rect x="235" y="140" width="130" height="80" rx="8" ry="8" fill="url(#grad2)" stroke="#009688" stroke-width="2"/>
                    <text x="300" y="170" font-family="Arial" font-size="14" fill="white" text-anchor="middle">实例2</text>
                    <text x="300" y="190" font-family="Arial" font-size="12" fill="white" text-anchor="middle">实例方法</text>

                    <rect x="370" y="140" width="130" height="80" rx="8" ry="8" fill="url(#grad2)" stroke="#009688" stroke-width="2"/>
                    <text x="435" y="170" font-family="Arial" font-size="14" fill="white" text-anchor="middle">实例3</text>
                    <text x="435" y="190" font-family="Arial" font-size="12" fill="white" text-anchor="middle">实例方法</text>
                </svg>
            </div>

            <div class="card">
                <h2>实例方法</h2>
                <p>实例方法是属于特定类、结构体或枚举的实例的函数。它们支持实例的功能，可以访问和修改实例属性，也可以通过访问实例的其他方法来提供功能。</p>

                <pre><code>// 类中的实例方法示例
class Counter {
    // 实例属性
    var count = 0

    // 实例方法
    func increment() {
        count += 1
    }

    func increment(by amount: Int) {
        count += amount
    }

    func reset() {
        count = 0
    }
}

// 创建Counter类的实例
let counter = Counter()

// 调用实例方法
counter.increment()           // count现在是1
counter.increment(by: 5)      // count现在是6
counter.reset()               // count现在是0</code></pre>
            </div>

            <div class="card">
                <h2>self属性</h2>
                <p>每个实例在其实例方法中都有一个隐式的self属性，它指向该实例本身。主要用途：</p>
                <ul>
                    <li>区分方法参数和实例属性</li>
                    <li>在闭包中引用实例本身</li>
                </ul>

                <pre><code>class Person {
    var name: String

    init(name: String) {
        // 使用self区分参数和属性
        self.name = name
    }

    func updateName() {
        // 在闭包中使用self引用当前实例
        let closure = {
            print("My name is \(self.name)")
        }
        closure()
    }
}</code></pre>
            </div>

            <div class="card">
                <h2>在实例方法中修改值类型</h2>
                <p>结构体和枚举是值类型，默认情况下，它们的属性不能在实例方法中修改。如果需要在实例方法中修改值类型的属性，需要使用<code>mutating</code>关键字。</p>

                <div class="svg-container">
                    <svg width="600" height="200" viewBox="0 0 600 200">
                        <rect x="50" y="20" width="500" height="160" rx="10" ry="10" fill="#f9f9f9" stroke="#ddd" stroke-width="2"/>

                        <!-- 普通方法 -->
                        <rect x="70" y="40" width="220" height="120" rx="8" ry="8" fill="#f5f5f5" stroke="#ddd" stroke-width="1"/>
                        <text x="180" y="65" font-family="Arial" font-size="14" font-weight="bold" text-anchor="middle">非mutating方法</text>
                        <text x="180" y="100" font-family="Arial" font-size="12" text-anchor="middle">不能修改结构体/枚举的属性</text>
                        <text x="180" y="120" font-family="Arial" font-size="12" text-anchor="middle">不能修改self</text>
                        <text x="180" y="140" font-family="Arial" font-size="12" text-anchor="middle">不能分配新实例给self</text>

                        <!-- mutating方法 -->
                        <rect x="310" y="40" width="220" height="120" rx="8" ry="8" fill="#e3f2fd" stroke="#2196f3" stroke-width="1"/>
                        <text x="420" y="65" font-family="Arial" font-size="14" font-weight="bold" fill="#2196f3" text-anchor="middle">mutating方法</text>
                        <text x="420" y="100" font-family="Arial" font-size="12" text-anchor="middle">可以修改结构体/枚举的属性</text>
                        <text x="420" y="120" font-family="Arial" font-size="12" text-anchor="middle">可以修改self的值</text>
                        <text x="420" y="140" font-family="Arial" font-size="12" text-anchor="middle">可以分配新实例给self</text>
                    </svg>
                </div>

                <pre><code>struct Point {
    var x = 0, y = 0

    // 使用mutating关键字允许修改结构体属性
    mutating func moveBy(x deltaX: Int, y deltaY: Int) {
        // 修改结构体的属性
        x += deltaX
        y += deltaY
    }

    // 使用mutating关键字允许给self分配新的实例
    mutating func reset() {
        // 给self分配一个全新的实例
        self = Point() // 重置为原点(0,0)
    }
}

// 创建Point结构体的实例
var somePoint = Point(x: 1, y: 1)

// 调用mutating方法修改属性
somePoint.moveBy(x: 2, y: 3)  // 现在点的位置是(3,4)
print("位置: (\(somePoint.x), \(somePoint.y))")

// 调用mutating方法重置实例
somePoint.reset()  // 重置到原点(0,0)
print("重置后: (\(somePoint.x), \(somePoint.y))")</code></pre>

                <div class="note">
                    <p><strong>注意：</strong> 不能在常量结构体上调用mutating方法，因为常量结构体的属性不能修改，即使是通过mutating方法也不行。</p>
                </div>
            </div>

            <div class="card">
                <h2>枚举的mutating方法</h2>
                <p>枚举也可以定义mutating方法，用于切换枚举的case值。</p>

                <pre><code>enum TriStateSwitch {
    case off, low, high

    // 定义一个mutating方法用于切换状态
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

// 创建枚举实例并初始化为off状态
var ovenLight = TriStateSwitch.off

// 通过mutating方法改变状态
ovenLight.next()        // 现在是.low
print(ovenLight)        // 输出: low

ovenLight.next()        // 现在是.high
print(ovenLight)        // 输出: high

ovenLight.next()        // 现在是.off
print(ovenLight)        // 输出: off</code></pre>
            </div>

            <div class="card">
                <h2>类型方法</h2>
                <p>类型方法是属于类型本身的方法，而不是属于实例的方法。在Swift中，可以通过<code>static</code>关键字（适用于类、结构体和枚举）或<code>class</code>关键字（仅适用于类）来定义类型方法。</p>

                <div class="svg-container">
                    <svg width="600" height="250" viewBox="0 0 600 250">
                        <defs>
                            <linearGradient id="static-grad" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" style="stop-color:#673ab7;stop-opacity:1" />
                                <stop offset="100%" style="stop-color:#9c27b0;stop-opacity:1" />
                            </linearGradient>
                            <linearGradient id="class-grad" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" style="stop-color:#2196f3;stop-opacity:1" />
                                <stop offset="100%" style="stop-color:#03a9f4;stop-opacity:1" />
                            </linearGradient>
                        </defs>

                        <!-- 背景 -->
                        <rect x="50" y="20" width="500" height="210" rx="10" ry="10" fill="#f9f9f9" stroke="#ddd" stroke-width="2"/>

                        <!-- static方法 -->
                        <rect x="70" y="40" width="460" height="80" rx="8" ry="8" fill="url(#static-grad)" opacity="0.9" stroke="#673ab7" stroke-width="1"/>
                        <text x="300" y="70" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">static func (适用于: 类, 结构体, 枚举)</text>
                        <text x="300" y="100" font-family="Arial" font-size="12" fill="white" text-anchor="middle">不能被子类重写</text>

                        <!-- class方法 -->
                        <rect x="70" y="140" width="460" height="80" rx="8" ry="8" fill="url(#class-grad)" opacity="0.9" stroke="#2196f3" stroke-width="1"/>
                        <text x="300" y="170" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">class func (仅适用于: 类)</text>
                        <text x="300" y="200" font-family="Arial" font-size="12" fill="white" text-anchor="middle">允许子类重写</text>
                    </svg>
                </div>

                <pre><code>// 在结构体中使用static方法
struct SomeStructure {
    // 类型属性
    static var storedTypeProperty = "Some value."

    // 类型方法
    static func typeMethod() {
        print("这是一个类型方法，可以访问类型属性: \(storedTypeProperty)")
    }
}

// 直接通过类型调用类型方法
SomeStructure.typeMethod()

// 在类中使用static和class方法
class SomeClass {
    // 使用static关键字定义的类型方法不能被子类重写
    static func staticTypeMethod() {
        print("这是一个静态类型方法，不能被子类重写")
    }

    // 使用class关键字定义的类型方法可以被子类重写
    class func classTypeMethod() {
        print("这是一个类类型方法，可以被子类重写")
    }
}

// 子类可以重写父类的class方法
class SomeSubclass: SomeClass {
    // 重写父类的class方法
    override class func classTypeMethod() {
        print("子类重写了父类的类型方法")
    }

    // 不能重写父类的static方法
    // override static func staticTypeMethod() {} // 这会导致编译错误
}</code></pre>
            </div>

            <div class="card">
                <h2>在类型方法中使用self</h2>
                <p>在类型方法中，<code>self</code>指向类型本身，而不是类型的实例。这意味着你可以使用<code>self</code>来引用其他类型方法和类型属性。</p>

                <pre><code>class Math {
    static let pi = 3.1415926

    static func calculateCircumference(radius: Double) -> Double {
        // 使用self访问类型属性
        return 2 * self.pi * radius
    }

    static func calculateArea(radius: Double) -> Double {
        // 也可以不用self，直接访问类型属性和方法
        return pi * radius * radius
    }
}

let circumference = Math.calculateCircumference(radius: 2.0)
print("圆周长: \(circumference)")

let area = Math.calculateArea(radius: 2.0)
print("圆面积: \(area)")</code></pre>
            </div>

            <div class="card">
                <h2>实践案例：完整的计算器实现</h2>
                <p>下面是一个综合案例，展示了如何在实际项目中使用类和方法：</p>

                <pre><code>// 定义一个计算器类
class Calculator {
    // 实例属性
    private var accumulator: Double = 0

    // 实例方法
    func setAccumulator(_ value: Double) {
        accumulator = value
    }

    func add(_ value: Double) -> Double {
        accumulator += value
        return accumulator
    }

    func subtract(_ value: Double) -> Double {
        accumulator -= value
        return accumulator
    }

    func multiply(_ value: Double) -> Double {
        accumulator *= value
        return accumulator
    }

    func divide(_ value: Double) -> Double {
        guard value != 0 else {
            print("错误：除数不能为零")
            return accumulator
        }
        accumulator /= value
        return accumulator
    }

    func clear() -> Double {
        accumulator = 0
        return accumulator
    }

    // 类型方法，用于快速创建一个已经设置了初始值的计算器
    static func calculatorWithValue(_ initialValue: Double) -> Calculator {
        let calc = Calculator()
        calc.setAccumulator(initialValue)
        return calc
    }

    // 获取当前值
    func getValue() -> Double {
        return accumulator
    }
}

// 使用计算器
let myCalc = Calculator()
myCalc.setAccumulator(10)
print(myCalc.add(5))          // 输出: 15
print(myCalc.multiply(2))     // 输出: 30
print(myCalc.subtract(5))     // 输出: 25
print(myCalc.divide(5))       // 输出: 5

// 使用类型方法创建计算器
let anotherCalc = Calculator.calculatorWithValue(100)
print(anotherCalc.getValue()) // 输出: 100</code></pre>
            </div>

            <div class="card">
                <h2>高级方法特性</h2>
                <p>Swift的方法还有一些高级特性，可以使代码更加灵活和可复用。</p>

                <h3>方法参数标签和参数名称</h3>
                <pre><code>class Greeting {
    // 第一个参数没有参数标签，第二个参数有标签
    func sayHello(_ person: String, at time: String) {
        print("Hello \(person), the time is \(time)")
    }

    // 所有参数都有标签
    func sayGoodbye(to person: String, at time: String) {
        print("Goodbye \(person), see you next time. It's now \(time)")
    }
}

let greeting = Greeting()
greeting.sayHello("John", at: "10:00 AM")     // Hello John, the time is 10:00 AM
greeting.sayGoodbye(to: "Mary", at: "6:30 PM")  // Goodbye Mary, see you next time. It's now 6:30 PM</code></pre>

                <h3>可变参数方法</h3>
                <pre><code>class MathOperations {
    // 可变参数方法可以接受零个或多个指定类型的值
    func sum(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total
    }
}

let math = MathOperations()
print(math.sum(1, 2, 3, 4, 5))     // 输出: 15.0
print(math.sum(10, 20))            // 输出: 30.0
print(math.sum())                  // 输出: 0.0</code></pre>

                <h3>方法中的默认参数值</h3>
                <pre><code>class TextProcessor {
    func process(_ text: String, uppercase: Bool = false,
                 removeSpaces: Bool = false) -> String {
        var result = text

        if uppercase {
            result = result.uppercased()
        }

        if removeSpaces {
            result = result.replacingOccurrences(of: " ", with: "")
        }

        return result
    }
}

let processor = TextProcessor()
let text = "Hello Swift"

// 使用默认参数
print(processor.process(text))                                // 输出: Hello Swift
// 指定参数
print(processor.process(text, uppercase: true))               // 输出: HELLO SWIFT
print(processor.process(text, removeSpaces: true))            // 输出: HelloSwift
print(processor.process(text, uppercase: true, removeSpaces: true))  // 输出: HELLOSWIFT</code></pre>
            </div>

            <div class="card">
                <h2>方法的嵌套和闭包捕获</h2>
                <p>Swift允许在方法内部定义嵌套函数，这些嵌套函数可以访问外部函数的参数和变量。</p>

                <pre><code>class Counter {
    func countUpAndDown(to maximum: Int) {
        // 嵌套函数，可以访问外部函数的参数
        func countUp(current: Int) {
            if current <= maximum {
                print("计数上升: \(current)")
                countUp(current: current + 1)
            } else {
                countDown(current: current - 1)
            }
        }

        // 另一个嵌套函数
        func countDown(current: Int) {
            if current >= 0 {
                print("计数下降: \(current)")
                countDown(current: current - 1)
            }
        }

        // 开始计数过程
        countUp(current: 0)
    }
}

let counter = Counter()
counter.countUpAndDown(to: 3)
// 输出:
// 计数上升: 0
// 计数上升: 1
// 计数上升: 2
// 计数上升: 3
// 计数下降: 3
// 计数下降: 2
// 计数下降: 1
// 计数下降: 0</code></pre>
            </div>

            <div class="svg-container">
                <svg width="600" height="300" viewBox="0 0 600 300">
                    <defs>
                        <linearGradient id="method-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#f44336;stop-opacity:0.8" />
                            <stop offset="100%" style="stop-color:#ff9800;stop-opacity:0.8" />
                        </linearGradient>
                    </defs>

                    <!-- 背景 -->
                    <rect x="50" y="20" width="500" height="260" rx="10" ry="10" fill="#f9f9f9" stroke="#ddd" stroke-width="2"/>
                    <text x="300" y="45" font-family="Arial" font-size="16" font-weight="bold" text-anchor="middle">Swift 方法总结</text>

                    <!-- 实例方法vs类型方法 -->
                    <rect x="80" y="60" width="200" height="100" rx="8" ry="8" fill="url(#method-gradient)" opacity="0.8"/>
                    <text x="180" y="85" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">实例方法</text>
                    <text x="180" y="110" font-family="Arial" font-size="12" fill="white" text-anchor="middle">属于类型的实例</text>
                    <text x="180" y="130" font-family="Arial" font-size="12" fill="white" text-anchor="middle">通过实例调用</text>
                    <text x="180" y="150" font-family="Arial" font-size="12" fill="white" text-anchor="middle">可访问实例属性和方法</text>

                    <rect x="320" y="60" width="200" height="100" rx="8" ry="8" fill="url(#method-gradient)" opacity="0.8"/>
                    <text x="420" y="85" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">类型方法</text>
                    <text x="420" y="110" font-family="Arial" font-size="12" fill="white" text-anchor="middle">属于类型本身</text>
                    <text x="420" y="130" font-family="Arial" font-size="12" fill="white" text-anchor="middle">通过类型调用</text>
                    <text x="420" y="150" font-family="Arial" font-size="12" fill="white" text-anchor="middle">可访问类型属性和方法</text>

                    <!-- mutating -->
                    <rect x="150" y="180" width="300" height="80" rx="8" ry="8" fill="#e3f2fd" stroke="#2196f3" stroke-width="1"/>
                    <text x="300" y="205" font-family="Arial" font-size="14" font-weight="bold" fill="#2196f3" text-anchor="middle">mutating方法</text>
                    <text x="300" y="230" font-family="Arial" font-size="12" fill="#333" text-anchor="middle">仅用于结构体和枚举的实例方法</text>
                    <text x="300" y="250" font-family="Arial" font-size="12" fill="#333" text-anchor="middle">允许修改值类型的实例属性</text>
                </svg>
            </div>

            <div class="card">
                <h2>实际应用案例：文件管理器</h2>
                <p>下面是一个更复杂的例子，展示了如何在实际应用中组合使用各种方法特性：</p>

                <pre><code>class FileManager {
    // 存储属性
    private var basePath: String
    private var currentFiles: [String] = []

    // 类型属性
    static let shared = FileManager(basePath: "/Documents")

    // 初始化方法
    init(basePath: String) {
        self.basePath = basePath
        self.currentFiles = []
        scanFiles()
    }

    // 私有方法 - 扫描文件
    private func scanFiles() {
        // 模拟扫描文件操作
        print("扫描路径: \(basePath)中的文件")
        // 在实际应用中，这里会读取真实的文件系统
        currentFiles = ["file1.txt", "file2.jpg", "file3.pdf"]
    }

    // 实例方法 - 创建文件
    func createFile(name: String, type: String) -> Bool {
        let fileName = "\(name).\(type)"

        // 检查文件是否已存在
        if currentFiles.contains(fileName) {
            print("错误：文件 \(fileName) 已存在")
            return false
        }

        // 模拟创建文件
        currentFiles.append(fileName)
        print("创建文件: \(fileName)")
        return true
    }

    // 实例方法 - 删除文件
    func deleteFile(name: String) -> Bool {
        if let index = currentFiles.firstIndex(of: name) {
            currentFiles.remove(at: index)
            print("删除文件: \(name)")
            return true
        } else {
            print("错误：文件 \(name) 不存在")
            return false
        }
    }

    // 实例方法 - 列出所有文件
    func listFiles() -> [String] {
        return currentFiles
    }

    // 类型方法 - 创建临时文件管理器
    static func temporaryManager() -> FileManager {
        return FileManager(basePath: "/Temp")
    }

    // 实例方法 - 改变基本路径
    func changeBasePath(to newPath: String) {
        basePath = newPath
        scanFiles()  // 更新文件列表
    }
}

// 使用单例访问
let manager = FileManager.shared
print("当前文件: \(manager.listFiles())")

// 创建文件
manager.createFile(name: "document", type: "docx")
print("当前文件: \(manager.listFiles())")

// 删除文件
manager.deleteFile(name: "file2.jpg")
print("当前文件: \(manager.listFiles())")

// 使用类型方法创建临时管理器
let tempManager = FileManager.temporaryManager()
print("临时管理器文件: \(tempManager.listFiles())")</code></pre>
            </div>

            <div class="resources">
                <h2>参考资源</h2>

                <h3>官方文档和学习资源</h3>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Methods.html" target="_blank">Swift官方文档 - 方法</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift" target="_blank">Apple开发者文档 - Swift</a></li>
                    <li><a href="https://www.swift.org/documentation/" target="_blank">Swift.org文档中心</a></li>
                </ul>

                <h3>推荐博客和文章</h3>
                <ul>
                    <li><a href="https://www.swiftbysundell.com/articles/the-power-of-type-based-design/" target="_blank">Swift by Sundell - 基于类型的设计的力量</a></li>
                    <li><a href="https://www.hackingwithswift.com/articles/117/mutating-methods-in-swift" target="_blank">Hacking with Swift - Swift中的Mutating方法</a></li>
                    <li><a href="https://medium.com/swift-programming/swift-instance-methods-vs-type-methods-af3c0da57430" target="_blank">Medium - Swift实例方法与类型方法比较</a></li>
                </ul>

                <h3>推荐书籍</h3>
                <ul>
                    <li>《Swift编程(第六版)》- Apple官方Swift编程语言指南</li>
                    <li>《Swift进阶》- 王巍(onevcat)著，探索Swift高级特性</li>
                    <li>《函数式Swift》- 介绍如何在Swift中应用函数式编程概念</li>
                    <li>《Swift设计模式》- 学习如何在Swift中应用设计模式</li>
                </ul>

                <h3>推荐视频教程</h3>
                <ul>
                    <li><a href="https://developer.apple.com/videos/play/wwdc2020/10170/" target="_blank">WWDC 2020 - 利用Swift类型系统编写更好的代码</a></li>
                    <li><a href="https://www.raywenderlich.com/5429634-protocol-oriented-programming-tutorial-in-swift-5-1-getting-started" target="_blank">Ray Wenderlich - Swift 协议导向编程教程</a></li>
                    <li><a href="https://www.udemy.com/course/ios-13-app-development-bootcamp/" target="_blank">Udemy - iOS应用开发训练营(包含Swift方法深入讲解)</a></li>
                </ul>

                <h3>相关开源项目</h3>
                <ul>
                    <li><a href="https://github.com/apple/swift-algorithms" target="_blank">Swift Algorithms</a> - 苹果官方Swift算法集合</li>
                    <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a> - Swift HTTP网络库，学习如何使用类和方法进行网络操作</li>
                    <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - Swift响应式编程框架，可以学习如何设计复杂的方法系统</li>
                    <li><a href="https://github.com/pointfreeco/swift-composable-architecture" target="_blank">Swift Composable Architecture</a> - 一种构建应用程序的方法，展示了Swift方法的高级用法</li>
                </ul>
            </div>

            <div class="note">
                <p><strong>小结：</strong> Swift中的方法提供了强大而灵活的方式来组织和封装类型行为。通过正确使用实例方法和类型方法，结合mutating关键字和其他Swift特性，可以设计出清晰、安全且高效的代码。掌握这些概念对于编写高质量的Swift应用程序至关重要。</p>
            </div>
        </div>
        <div class="paper-cut-bottom"></div>
    </div>
</body>
</html>
