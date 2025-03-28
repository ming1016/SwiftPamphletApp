<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift类和结构体中的继承</title>
    <style>
        :root {
            --background: #f8f5f0;
            --text: #333333;
            --accent1: #ffcdd2; /* 浅粉色 */
            --accent2: #c8e6c9; /* 薄荷绿 */
            --accent3: #b2dfdb; /* 蓝绿色 */
            --accent4: #ffe0b2; /* 杏黄色 */
            --accent5: #f5f5f5; /* 米白色 */
            --card-bg: rgba(255, 255, 255, 0.8);
            --code-bg: #f5f5f5;
            --shadow: rgba(0, 0, 0, 0.05);
        }
        
        @media (prefers-color-scheme: dark) {
            :root {
                --background: #292929;
                --text: #e0e0e0;
                --accent1: #964448; /* 深粉色 */
                --accent2: #55824f; /* 深薄荷绿 */
                --accent3: #458b83; /* 深蓝绿色 */
                --accent4: #b38048; /* 深杏黄色 */
                --accent5: #3d3d3d; /* 深灰色 */
                --card-bg: rgba(50, 50, 50, 0.8);
                --code-bg: #3a3a3a;
                --shadow: rgba(0, 0, 0, 0.2);
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
            color: var(--text);
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            transition: all 0.3s ease;
        }
        
        header {
            margin-bottom: 40px;
            text-align: center;
            position: relative;
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: var(--text);
            position: relative;
            display: inline-block;
        }
        
        h1:after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 10%;
            width: 80%;
            height: 4px;
            background: linear-gradient(90deg, var(--accent1), var(--accent3));
            border-radius: 2px;
        }
        
        h2 {
            font-size: 1.8rem;
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--accent3);
            color: var(--text);
        }
        
        h3 {
            font-size: 1.4rem;
            margin: 30px 0 15px;
            color: var(--text);
        }
        
        p {
            margin-bottom: 20px;
            font-size: 1.1rem;
        }
        
        .card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            margin: 25px 0;
            box-shadow: 0 8px 30px var(--shadow);
            backdrop-filter: blur(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px var(--shadow);
        }
        
        code {
            font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
            background-color: var(--code-bg);
            padding: 2px 5px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        
        pre {
            background-color: var(--code-bg);
            padding: 20px;
            border-radius: 10px;
            overflow-x: auto;
            margin: 20px 0;
            border-left: 4px solid var(--accent3);
        }
        
        pre code {
            background: none;
            padding: 0;
        }
        
        .image-container {
            text-align: center;
            margin: 30px 0;
        }
        
        img, svg {
            max-width: 100%;
            border-radius: 10px;
        }
        
        .reference {
            background-color: var(--card-bg);
            border-left: 4px solid var(--accent4);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 10px 10px 0;
        }
        
        .note {
            background-color: var(--card-bg);
            border-left: 4px solid var(--accent1);
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 10px 10px 0;
        }
        
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .grid-item {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px var(--shadow);
        }
        
        .tag {
            display: inline-block;
            background-color: var(--accent2);
            color: var(--text);
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            margin-right: 5px;
            margin-bottom: 5px;
        }
        
        a {
            color: var(--accent3);
            text-decoration: none;
            border-bottom: 1px dotted var(--accent3);
            transition: all 0.2s ease;
        }
        
        a:hover {
            color: var(--accent1);
            border-bottom-color: var(--accent1);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            border-radius: 10px;
            overflow: hidden;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--accent5);
        }
        
        th {
            background-color: var(--accent3);
            color: var(--text);
        }
        
        tr:nth-child(even) {
            background-color: var(--accent5);
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            h2 {
                font-size: 1.5rem;
            }
            
            .grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Swift类和结构体中的继承</h1>
        <p>深入理解Swift中类的继承机制以及与结构体的区别</p>
    </header>
    
    <section class="card">
        <h2>继承概述</h2>
        <p>继承是面向对象编程的核心概念之一，允许一个类从另一个类获取属性和方法。在Swift中，<strong>继承仅适用于类(Class)</strong>，结构体(Struct)不支持继承。</p>
        
        <div class="image-container">
            <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                <defs>
                    <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                        <stop offset="0%" style="stop-color:var(--accent1);stop-opacity:1" />
                        <stop offset="100%" style="stop-color:var(--accent3);stop-opacity:1" />
                    </linearGradient>
                    <linearGradient id="grad2" x1="0%" y1="0%" x2="100%" y2="0%">
                        <stop offset="0%" style="stop-color:var(--accent2);stop-opacity:1" />
                        <stop offset="100%" style="stop-color:var(--accent4);stop-opacity:1" />
                    </linearGradient>
                </defs>
                
                <!-- 基类 -->
                <rect x="200" y="30" width="200" height="80" rx="10" ry="10" fill="url(#grad1)" />
                <text x="300" y="60" text-anchor="middle" fill="var(--text)" font-weight="bold">基类 (Base Class)</text>
                <text x="300" y="90" text-anchor="middle" fill="var(--text)" font-size="14">属性和方法的初始定义</text>
                
                <!-- 连接线 -->
                <line x1="300" y1="110" x2="300" y2="140" stroke="var(--text)" stroke-width="2" />
                <polygon points="300,150 295,140 305,140" fill="var(--text)" />
                
                <!-- 子类 -->
                <rect x="200" y="150" width="200" height="80" rx="10" ry="10" fill="url(#grad2)" />
                <text x="300" y="180" text-anchor="middle" fill="var(--text)" font-weight="bold">子类 (Subclass)</text>
                <text x="300" y="210" text-anchor="middle" fill="var(--text)" font-size="14">继承基类的属性和方法</text>
                
                <!-- 结构体（不支持继承） -->
                <rect x="430" y="90" width="150" height="80" rx="10" ry="10" fill="#ccc" opacity="0.7" />
                <text x="505" y="120" text-anchor="middle" fill="var(--text)" font-weight="bold">结构体 (Struct)</text>
                <text x="505" y="150" text-anchor="middle" fill="var(--text)" font-size="14">不支持继承</text>
                <line x1="430" y1="130" x2="400" y2="130" stroke="var(--text)" stroke-width="2" stroke-dasharray="5,5" />
                <text x="415" y="110" text-anchor="middle" fill="var(--text)" font-style="italic" font-size="14">不支持</text>
            </svg>
        </div>
    </section>
    
    <section class="card">
        <h2>类的继承 (Class Inheritance)</h2>
        <p>在Swift中，一个类可以从另一个类"继承"方法、属性和其他特性。被继承的类称为"基类"或"父类"，继承的类称为"子类"。</p>
        
        <h3>基类定义</h3>
        <p>任何不从其他类继承的类都是基类：</p>
        <pre><code>class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "以每小时\(currentSpeed)公里行驶"
    }
    
    func makeNoise() {
        // 基类实现为空
        print("基础车辆无明显噪音")
    }
}</code></pre>

        <h3>子类定义</h3>
        <p>子类继承自基类，语法为在类名后添加冒号和父类名：</p>
        <pre><code>class Bicycle: Vehicle {
    var hasBasket = false
    
    // 不需要重新声明继承的属性和方法
    // 已自动拥有currentSpeed、description和makeNoise()
}</code></pre>

        <h3>使用继承的属性和方法</h3>
        <pre><code>let bicycle = Bicycle()
bicycle.currentSpeed = 15.0  // 访问继承的属性
print(bicycle.description)   // 访问继承的计算属性
// 输出: "以每小时15.0公里行驶"

bicycle.hasBasket = true     // 访问子类自己的属性</code></pre>
    </section>
    
    <section class="card">
        <h2>方法重写 (Method Overriding)</h2>
        <p>子类可以提供对继承方法的自定义实现，这称为方法重写。使用<code>override</code>关键字标记重写的方法。</p>
        
        <pre><code>class Train: Vehicle {
    override func makeNoise() {
        // 重写父类方法
        print("呜呜呜！")
    }
}

let train = Train()
train.makeNoise()  // 输出: "呜呜呜！"</code></pre>

        <div class="note">
            <p><strong>重要提示：</strong> 如果要重写基类方法，必须使用<code>override</code>关键字，否则会导致编译错误。这有助于防止意外重写方法。</p>
        </div>
        
        <h3>访问超类方法</h3>
        <p>在重写方法内部，可以使用<code>super</code>关键字调用父类的实现：</p>
        
        <pre><code>class Car: Vehicle {
    var gear = 1
    
    override func makeNoise() {
        super.makeNoise()  // 调用父类方法
        print("引擎轰鸣声！")
    }
}</code></pre>
    </section>

    <section class="card">
        <h2>属性重写 (Property Overriding)</h2>
        <p>子类可以重写继承的属性，包括存储属性和计算属性：</p>
        
        <pre><code>class SportsCar: Car {
    override var description: String {
        return super.description + "，当前挡位：\(gear)"
    }
    
    // 你也可以将继承的只读属性重写为读写属性
    // 但不能将读写属性重写为只读属性
}</code></pre>

        <h3>属性观察器重写</h3>
        <p>可以为继承的属性添加属性观察器：</p>
        
        <pre><code>class RaceCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 25.0) + 1
        }
    }
}</code></pre>

        <div class="note">
            <p><strong>注意：</strong> 你不能为常量存储属性或只读计算属性添加属性观察器。</p>
        </div>
    </section>
    
    <section class="card">
        <h2>防止重写</h2>
        <p>如果不希望某个类、方法或属性被进一步继承或重写，可以使用<code>final</code>关键字：</p>
        
        <pre><code>final class SuperCar: Car {
    // 这个类不能被继承
}

class LuxuryCar: Car {
    final var luxury = true  // 这个属性不能被重写
    
    final func activateLuxuryMode() {  // 这个方法不能被重写
        print("豪华模式已激活")
    }
}</code></pre>
    </section>
    
    <section class="card">
        <h2>结构体与类的区别</h2>
        <p>Swift中结构体和类的一个主要区别是<strong>结构体不支持继承</strong>。</p>
        
        <div class="image-container">
            <svg width="600" height="350" viewBox="0 0 600 350" xmlns="http://www.w3.org/2000/svg">
                <rect x="50" y="50" width="240" height="250" rx="15" ry="15" fill="var(--accent3)" opacity="0.7" />
                <text x="170" y="85" text-anchor="middle" fill="var(--text)" font-weight="bold" font-size="18">Class (类)</text>
                <text x="170" y="125" text-anchor="middle" fill="var(--text)" font-size="14">• 支持继承</text>
                <text x="170" y="155" text-anchor="middle" fill="var(--text)" font-size="14">• 引用类型</text>
                <text x="170" y="185" text-anchor="middle" fill="var(--text)" font-size="14">• 支持类型转换</text>
                <text x="170" y="215" text-anchor="middle" fill="var(--text)" font-size="14">• 有析构方法</text>
                <text x="170" y="245" text-anchor="middle" fill="var(--text)" font-size="14">• 内存在堆上分配</text>
                <text x="170" y="275" text-anchor="middle" fill="var(--text)" font-size="14">• 引用计数管理内存</text>
                
                <rect x="310" y="50" width="240" height="250" rx="15" ry="15" fill="var(--accent1)" opacity="0.7" />
                <text x="430" y="85" text-anchor="middle" fill="var(--text)" font-weight="bold" font-size="18">Struct (结构体)</text>
                <text x="430" y="125" text-anchor="middle" fill="var(--text)" font-size="14">• 不支持继承</text>
                <text x="430" y="155" text-anchor="middle" fill="var(--text)" font-size="14">• 值类型</text>
                <text x="430" y="185" text-anchor="middle" fill="var(--text)" font-size="14">• 不支持类型转换</text>
                <text x="430" y="215" text-anchor="middle" fill="var(--text)" font-size="14">• 没有析构方法</text>
                <text x="430" y="245" text-anchor="middle" fill="var(--text)" font-size="14">• 内存在栈上分配</text>
                <text x="430" y="275" text-anchor="middle" fill="var(--text)" font-size="14">• 自动管理内存</text>
            </svg>
        </div>

        <h3>结构体的组合模式</h3>
        <p>虽然结构体不支持继承，但可以通过组合实现代码重用：</p>
        
        <pre><code>struct Point {
    var x: Double
    var y: Double
}

struct Size {
    var width: Double
    var height: Double
}

struct Rectangle {
    // 组合其他结构体而非继承
    var origin: Point
    var size: Size
    
    // 计算矩形面积
    var area: Double {
        return size.width * size.height
    }
}</code></pre>
    </section>
    
    <section class="card">
        <h2>初始化器继承</h2>
        <p>Swift中的初始化器继承规则较为复杂，主要遵循两个安全检查原则：</p>
        
        <h3>指定初始化器和便捷初始化器</h3>
        <pre><code>class Food {
    var name: String
    
    // 指定初始化器
    init(name: String) {
        self.name = name
    }
    
    // 便捷初始化器
    convenience init() {
        self.init(name: "[未命名]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)  // 调用父类的指定初始化器
    }
    
    // 重写父类的指定初始化器
    override init(name: String) {
        self.quantity = 1
        super.init(name: name)
    }
    
    // 父类的便捷初始化器会被自动继承，因为所有的指定初始化器都被覆盖了
}</code></pre>

        <h3>初始化器的委托规则</h3>
        <ol>
            <li>指定初始化器必须调用其直接父类的指定初始化器</li>
            <li>便捷初始化器必须调用同类中的另一个初始化器</li>
            <li>便捷初始化器最终必须调用一个指定初始化器</li>
        </ol>

        <div class="image-container">
            <svg width="600" height="300" viewBox="0 0 600 300" xmlns="http://www.w3.org/2000/svg">
                <!-- 基类初始化器 -->
                <rect x="200" y="30" width="200" height="50" rx="10" ry="10" fill="var(--accent1)" />
                <text x="300" y="60" text-anchor="middle" fill="var(--text)" font-weight="bold">基类指定初始化器</text>
                
                <circle cx="150" y="55" r="30" fill="var(--accent2)" />
                <text x="150" y="60" text-anchor="middle" fill="var(--text)" font-size="12">基类便捷</text>
                <text x="150" y="75" text-anchor="middle" fill="var(--text)" font-size="12">初始化器</text>
                
                <line x1="180" y1="55" x2="200" y2="55" stroke="var(--text)" stroke-width="2" />
                <polygon points="200,55 190,50 190,60" fill="var(--text)" />
                
                <!-- 子类初始化器 -->
                <line x1="300" y1="80" x2="300" y2="130" stroke="var(--text)" stroke-width="2" />
                <polygon points="300,130 295,120 305,120" fill="var(--text)" />
                
                <rect x="200" y="130" width="200" height="50" rx="10" ry="10" fill="var(--accent3)" />
                <text x="300" y="160" text-anchor="middle" fill="var(--text)" font-weight="bold">子类指定初始化器</text>
                
                <circle cx="150" y="155" r="30" fill="var(--accent4)" />
                <text x="150" y="160" text-anchor="middle" fill="var(--text)" font-size="12">子类便捷</text>
                <text x="150" y="175" text-anchor="middle" fill="var(--text)" font-size="12">初始化器</text>
                
                <line x1="180" y1="155" x2="200" y2="155" stroke="var(--text)" stroke-width="2" />
                <polygon points="200,155 190,150 190,160" fill="var(--text)" />
            </svg>
        </div>
    </section>
    
    <section class="card">
        <h2>类型转换</h2>
        <p>继承创建的类层次结构支持使用<code>is</code>和<code>as</code>关键字进行类型检查和类型转换：</p>
        
        <pre><code>class MediaItem {
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

// 创建一个混合媒体项目数组
let library = [
    Movie(name: "星际穿越", director: "克里斯托弗·诺兰"),
    Song(name: "蒲公英的约定", artist: "周杰伦"),
    Movie(name: "盗梦空间", director: "克里斯托弗·诺兰"),
    Song(name: "七里香", artist: "周杰伦")
]

// 类型检查
for item in library {
    if item is Movie {
        print("\(item.name) 是一部电影")
    } else if item is Song {
        print("\(item.name) 是一首歌")
    }
}

// 类型转换
for item in library {
    if let movie = item as? Movie {
        print("电影: \(movie.name), 导演: \(movie.director)")
    } else if let song = item as? Song {
        print("歌曲: \(song.name), 艺术家: \(song.artist)")
    }
}</code></pre>
    </section>
    
    <section class="card">
        <h2>Any 和 AnyObject</h2>
        <p>Swift提供两种特殊类型用于处理非特定类型：</p>
        <ul>
            <li><code>Any</code>：可以表示任何类型的实例，包括函数类型</li>
            <li><code>AnyObject</code>：可以表示任何类类型的实例（仅限类，不包括结构体）</li>
        </ul>
        
        <pre><code>var things: [Any] = []
things.append(0)
things.append(0.0)
things.append("Hello")
things.append(Movie(name: "星际穿越", director: "诺兰"))

for thing in things {
    switch thing {
    case let someInt as Int:
        print("整数值: \(someInt)")
    case let someDouble as Double:
        print("浮点值: \(someDouble)")
    case let someString as String:
        print("字符串值: \(someString)")
    case let someMovie as Movie:
        print("电影: \(someMovie.name), 导演: \(someMovie.director)")
    default:
        print("未知类型")
    }
}</code></pre>
    </section>
    
    <section class="card">
        <h2>实践建议</h2>
        
        <div class="grid">
            <div class="grid-item">
                <h3>何时使用类</h3>
                <ul>
                    <li>需要继承时</li>
                    <li>需要引用语义时</li>
                    <li>生命周期需要管理时</li>
                    <li>数据可能会被多个实体共享时</li>
                </ul>
            </div>
            
            <div class="grid-item">
                <h3>何时使用结构体</h3>
                <ul>
                    <li>封装简单数据值时</li>
                    <li>拷贝比引用更合适时</li>
                    <li>属性也应该是值类型时</li>
                    <li>不需要继承时</li>
                </ul>
            </div>
        </div>
    </section>
    
    <section class="card">
        <h2>参考资料</h2>
        
        <h3>官方文档</h3>
        <div class="reference">
            <ul>
                <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html" target="_blank">Swift官方文档 - 继承</a></li>
                <li><a href="https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes" target="_blank">Apple开发者文档 - 在结构体和类之间选择</a></li>
            </ul>
        </div>
        
        <h3>推荐书籍</h3>
        <div class="reference">
            <ul>
                <li>《Swift编程语言》- Apple官方</li>
                <li>《Swift进阶》- 王巍 (onevcat)</li>
                <li>《Pro Swift》- Paul Hudson</li>
                <li>《Swift设计模式》- Jon Hoffman</li>
            </ul>
        </div>
        
        <h3>优秀博客与视频</h3>
        <div class="reference">
            <ul>
                <li><a href="https://www.hackingwithswift.com/articles/145/how-to-use-inheritance-in-swift" target="_blank">Hacking with Swift - 如何在Swift中使用继承</a></li>
                <li><a href="https://www.swiftbysundell.com/articles/structures-vs-classes-in-swift/" target="_blank">Swift by Sundell - 结构体vs类</a></li>
                <li><a href="https://www.youtube.com/watch?v=hJJJmT8dhYU" target="_blank">WWDC视频 - 理解Swift性能</a></li>
                <li><a href="https://www.objc.io/issues/16-swift/swift-classes-vs-structs/" target="_blank">objc.io - Swift中的类与结构体</a></li>
            </ul>
        </div>
        
        <h3>开源项目</h3>
        <div class="reference">
            <ul>
                <li><a href="https://github.com/apple/swift" target="_blank">Swift</a> - Swift语言本身是开源的，可以研究其源码实现</li>
                <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire</a> - 网络库中有很多继承的优秀例子</li>
                <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a> - 反应式编程库，包含丰富的类层次结构</li>
                <li><a href="https://github.com/danielgindi/Charts" target="_blank">Charts</a> - 图表库，展示了继承在图表组件设计中的应用</li>
            </ul>
        </div>
    </section>

</body>
</html>
