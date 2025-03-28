<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swift类型转换 - Apple开发技术手册</title>
    <style>
        :root {
            --bg-primary: linear-gradient(135deg, #e0f7fa 0%, #80deea 100%);
            --text-primary: #333;
            --code-bg: rgba(255, 255, 255, 0.8);
            --card-bg: rgba(255, 255, 255, 0.9);
            --accent-color: #ff9800;
            --title-color: #f9a825;
            --shadow-color: rgba(0, 0, 0, 0.1);
            --link-color: #0277bd;
            --border-color: #b3e5fc;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --bg-primary: linear-gradient(135deg, #01579b 0%, #0277bd 100%);
                --text-primary: #e0f7fa;
                --code-bg: rgba(0, 30, 60, 0.8);
                --card-bg: rgba(13, 71, 161, 0.6);
                --accent-color: #ffd180;
                --title-color: #ffecb3;
                --shadow-color: rgba(0, 0, 0, 0.3);
                --link-color: #80d8ff;
                --border-color: #0288d1;
            }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            padding: 0;
            margin: 0;
            min-height: 100vh;
            font-size: 16px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        .paper-layer {
            position: relative;
            padding: 2.5rem;
            margin-bottom: 3rem;
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow:
                0 10px 15px -3px var(--shadow-color),
                0 4px 6px -2px var(--shadow-color);
            overflow: hidden;
        }

        .paper-layer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 10px;
            background: var(--accent-color);
            border-radius: 6px 6px 0 0;
        }

        h1, h2, h3 {
            color: var(--title-color);
            margin: 1.5rem 0 1rem;
            position: relative;
            font-weight: 700;
            text-shadow: 1px 1px 3px var(--shadow-color);
            padding-left: 15px;
        }

        h1 {
            font-size: 2.5rem;
            border-bottom: 3px solid var(--accent-color);
            padding-bottom: 0.5rem;
            text-align: center;
            padding-left: 0;
        }

        h2::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 6px;
            background: var(--accent-color);
            border-radius: 3px;
        }

        h3 {
            font-size: 1.5rem;
        }

        p {
            margin-bottom: 1.2rem;
            text-align: justify;
        }

        pre {
            background: var(--code-bg);
            color: var(--text-primary);
            padding: 1.5rem;
            border-radius: 8px;
            overflow-x: auto;
            margin: 1.5rem 0;
            box-shadow: 0 4px 6px var(--shadow-color);
            border-left: 5px solid var(--accent-color);
        }

        code {
            font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 0.9rem;
            padding: 0.2rem 0.4rem;
            border-radius: 3px;
            background: var(--code-bg);
        }

        pre code {
            background: transparent;
            padding: 0;
            white-space: pre-wrap;
        }

        .example-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
            box-shadow:
                0 4px 8px var(--shadow-color),
                0 2px 4px var(--shadow-color);
            border: 1px solid var(--border-color);
        }

        .example-title {
            font-weight: bold;
            color: var(--accent-color);
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        a {
            color: var(--link-color);
            text-decoration: none;
            border-bottom: 1px dotted var(--link-color);
        }

        a:hover {
            color: var(--accent-color);
            border-bottom: 1px solid var(--accent-color);
        }

        .resources {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
        }

        .resources h3 {
            margin-top: 0;
        }

        ul, ol {
            padding-left: 2rem;
            margin: 1rem 0;
        }

        li {
            margin-bottom: 0.5rem;
        }

        .note {
            background: rgba(255, 221, 87, 0.2);
            border-left: 5px solid #ffdd57;
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 4px;
        }

        .note p:last-child {
            margin-bottom: 0;
        }

        .diagram {
            display: flex;
            justify-content: center;
            margin: 2rem 0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .paper-layer {
                padding: 1.5rem;
            }

            h1 {
                font-size: 2rem;
            }

            pre {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="paper-layer">
            <h1>Swift 类型转换</h1>

            <p>类型转换是一种检查实例类型或将实例视为其他父类或子类类型的方法。在Swift中，类型转换使用<code>is</code>和<code>as</code>操作符实现，它们提供了一种简单、安全的方式来处理类型之间的转换。</p>

            <div class="diagram">
                <svg width="500" height="220" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#4fc3f7;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#0288d1;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <rect x="50" y="20" width="400" height="50" rx="8" fill="url(#grad1)" />
                    <rect x="100" y="100" width="150" height="50" rx="8" fill="#ff9800" />
                    <rect x="280" y="100" width="150" height="50" rx="8" fill="#ff9800" />
                    <rect x="100" y="170" width="150" height="50" rx="8" fill="#4caf50" />

                    <line x1="250" y1="45" x2="170" y2="100" stroke="#333" stroke-width="2" />
                    <line x1="250" y1="45" x2="330" y2="100" stroke="#333" stroke-width="2" />
                    <line x1="170" y1="150" x2="170" y2="170" stroke="#333" stroke-width="2" />

                    <text x="250" y="50" font-size="16" fill="white" text-anchor="middle">父类 (SuperClass)</text>
                    <text x="175" y="130" font-size="14" fill="white" text-anchor="middle">子类A (SubA)</text>
                    <text x="355" y="130" font-size="14" fill="white" text-anchor="middle">子类B (SubB)</text>
                    <text x="175" y="200" font-size="14" fill="white" text-anchor="middle">孙类 (GrandChild)</text>

                    <path d="M350,70 L390,90 L350,110 Z" fill="#e91e63" />
                    <text x="410" y="90" font-size="12" fill="#333">向下转型</text>

                    <path d="M100,70 L60,90 L100,110 Z" fill="#9c27b0" />
                    <text x="40" y="90" font-size="12" fill="#333">向上转型</text>
                </svg>
            </div>

            <h2>类型检查与类型转换基础</h2>

            <p>Swift提供了两种类型转换操作符：</p>
            <ul>
                <li><code>is</code>：用于检查一个实例是否属于某个特定的类型</li>
                <li><code>as</code>：用于将一个实例转换为另一个类型</li>
            </ul>

            <div class="example-card">
                <div class="example-title">示例：类型检查的基本使用</div>
<pre><code>// 定义一个基类
class MediaItem {
    var name: String

    init(name: String) {
        self.name = name
    }
}

// 定义两个子类
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

// 创建一个包含不同类型的数组
let library = [
    Movie(name: "黑客帝国", director: "沃卓斯基姐妹"),
    Song(name: "年少有为", artist: "李荣浩"),
    Movie(name: "复仇者联盟", director: "乔斯·韦登"),
    Song(name: "Imagine", artist: "John Lennon")
]

// 使用类型检查
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("媒体库中包含 \(movieCount) 部电影和 \(songCount) 首歌")
// 输出: 媒体库中包含 2 部电影和 2 首歌</code></pre>
            </div>

            <h2>向下转型 (Downcasting)</h2>

            <p>当你确定一个类的实例实际上属于某个子类类型时，你可以使用向下转型操作符（<code>as?</code>或<code>as!</code>）将父类类型转换为子类类型。</p>

            <ul>
                <li><code>as?</code>：条件形式，如果转换失败则返回 <code>nil</code></li>
                <li><code>as!</code>：强制形式，如果转换失败则触发运行时错误</li>
            </ul>

            <div class="diagram">
                <svg width="450" height="180" xmlns="http://www.w3.org/2000/svg">
                    <rect x="50" y="30" width="350" height="60" rx="8" fill="#0288d1" />
                    <rect x="70" y="100" width="140" height="60" rx="8" fill="#4caf50" />
                    <rect x="240" y="100" width="140" height="60" rx="8" fill="#4caf50" />

                    <path d="M140,90 L140,100 M130,90 L140,100 L150,90" stroke="#333" stroke-width="2" fill="none" />
                    <path d="M310,90 L310,100 M300,90 L310,100 L320,90" stroke="#333" stroke-width="2" fill="none" />

                    <text x="225" y="65" text-anchor="middle" fill="white" font-size="14">MediaItem</text>
                    <text x="140" y="135" text-anchor="middle" fill="white" font-size="14">Movie</text>
                    <text x="310" y="135" text-anchor="middle" fill="white" font-size="14">Song</text>

                    <path d="M170,50 Q225,15 280,50" stroke="#e91e63" stroke-width="2" stroke-dasharray="5,3" fill="none" />
                    <text x="225" y="25" text-anchor="middle" fill="#e91e63" font-size="12">as? / as!</text>
                </svg>
            </div>

            <div class="example-card">
                <div class="example-title">示例：使用向下转型访问子类特有的属性</div>
<pre><code>// 继续使用上面的MediaItem、Movie和Song类

for item in library {
    // 条件形式的向下转型 (as?)
    if let movie = item as? Movie {
        print("电影：\(movie.name)，导演：\(movie.director)")
    } else if let song = item as? Song {
        print("歌曲：\(song.name)，艺术家：\(song.artist)")
    }
}

// 输出:
// 电影：黑客帝国，导演：沃卓斯基姐妹
// 歌曲：年少有为，艺术家：李荣浩
// 电影：复仇者联盟，导演：乔斯·韦登
// 歌曲：Imagine，艺术家：John Lennon

// 强制形式的向下转型示例 (as!)
// 注意：仅在确定转型一定会成功时使用，否则会导致运行时错误
let firstItem = library[0]
let firstMovie = firstItem as! Movie  // 安全，因为我们知道第一项是Movie
print("第一部电影是：\(firstMovie.name)")</code></pre>
            </div>

            <div class="note">
                <p><strong>注意</strong>：尽量使用条件形式的向下转型（<code>as?</code>），这样更安全。只有在绝对确定转换会成功的情况下才使用强制形式（<code>as!</code>）。</p>
            </div>

            <h2>Any 和 AnyObject</h2>

            <p>Swift提供了两种特殊的类型：</p>
            <ul>
                <li><code>Any</code>：可以表示任何类型的实例，包括函数类型</li>
                <li><code>AnyObject</code>：可以表示任何类类型的实例</li>
            </ul>

            <div class="example-card">
                <div class="example-title">示例：使用 Any 和 AnyObject</div>
<pre><code>// 使用Any类型存储混合类型
var anyArray: [Any] = []
anyArray.append(42)                          // Int
anyArray.append(3.14159)                     // Double
anyArray.append("Hello, Swift")              // String
anyArray.append((3.0, 5.0))                  // 元组 (Double, Double)
anyArray.append(Movie(name: "星际穿越", director: "克里斯托弗·诺兰"))
anyArray.append({ (name: String) -> String in "Hello, \(name)" })  // 闭包

// 使用AnyObject类型存储类实例
let objectArray: [AnyObject] = [
    Movie(name: "盗梦空间", director: "克里斯托弗·诺兰"),
    Song(name: "Shape of You", artist: "Ed Sheeran")
]

// 从Any数组中提取值
for item in anyArray {
    switch item {
    case let someInt as Int:
        print("整数值: \(someInt)")
    case let someDouble as Double:
        print("浮点值: \(someDouble)")
    case let someString as String:
        print("字符串值: \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("坐标点: (\(x), \(y))")
    case let movie as Movie:
        print("电影: \(movie.name), 导演: \(movie.director)")
    case let stringConverter as (String) -> String:
        print("函数返回结果: \(stringConverter("Swift"))")
    default:
        print("未知类型")
    }
}

// 输出:
// 整数值: 42
// 浮点值: 3.14159
// 字符串值: "Hello, Swift"
// 坐标点: (3.0, 5.0)
// 电影: 星际穿越, 导演: 克里斯托弗·诺兰
// 函数返回结果: Hello, Swift</code></pre>
            </div>

            <h2>类型别名 (Type Alias)</h2>

            <p>类型别名为现有类型定义了一个替代名称，使用<code>typealias</code>关键字定义。</p>

            <div class="example-card">
                <div class="example-title">示例：使用类型别名</div>
<pre><code>// 为Int类型定义一个别名
typealias AudioSample = UInt16

// 使用类型别名
var maxAmplitude = AudioSample.max  // 等同于UInt16.max
print("音频采样的最大振幅值为: \(maxAmplitude)")  // 65535

// 为复杂类型定义别名
typealias Point = (x: Double, y: Double)
typealias PlayerScores = [String: Int]

// 使用复杂类型的别名
let myLocation: Point = (x: 10.5, y: 20.3)
print("当前位置: (\(myLocation.x), \(myLocation.y))")

let gameScores: PlayerScores = ["Alice": 42, "Bob": 38, "Charlie": 45]
print("Bob的得分: \(gameScores["Bob"] ?? 0)")

// 为闭包类型定义别名
typealias Transformer = (Int) -> Int
let doubler: Transformer = { $0 * 2 }
print("将5加倍: \(doubler(5))")  // 10</code></pre>
            </div>

            <div class="resources">
                <h3>参考资源</h3>

                <h4>官方文档</h4>
                <ul>
                    <li><a href="https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html" target="_blank">Swift官方文档 - 类型转换</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift/any" target="_blank">Apple开发者文档 - Any</a></li>
                    <li><a href="https://developer.apple.com/documentation/swift/anyobject" target="_blank">Apple开发者文档 - AnyObject</a></li>
                </ul>

                <h4>博客文章</h4>
                <ul>
                    <li><a href="https://www.swiftbysundell.com/articles/type-erasure-using-type-conversions-in-swift/" target="_blank">Swift by Sundell - 使用类型转换进行类型擦除</a></li>
                    <li><a href="https://www.hackingwithswift.com/sixty/10/1/creating-your-own-classes" target="_blank">Hacking with Swift - Swift中的类和继承</a></li>
                    <li><a href="https://www.raywenderlich.com/9222-object-oriented-programming-in-swift" target="_blank">Ray Wenderlich - Swift中的面向对象编程</a></li>
                </ul>

                <h4>相关书籍</h4>
                <ul>
                    <li>《Swift编程语言》- Apple官方教程</li>
                    <li>《Swift进阶》- 王巍(onevcat)</li>
                    <li>《Pro Swift》- Paul Hudson</li>
                    <li>《Swift实战》- Chris Eidhof, Florian Kugler, Wouter Swierstra</li>
                </ul>

                <h4>视频资源</h4>
                <ul>
                    <li><a href="https://developer.apple.com/videos/play/wwdc2020/10170/" target="_blank">WWDC 2020 - Embrace Swift Type Inference</a></li>
                    <li><a href="https://www.youtube.com/watch?v=6lHhrGMqQJI" target="_blank">Stanford CS193p - Swift类型系统</a></li>
                </ul>

                <h4>开源项目</h4>
                <ul>
                    <li><a href="https://github.com/apple/swift" target="_blank">Swift - 苹果官方Swift语言仓库</a></li>
                    <li><a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift - Swift中的响应式编程框架</a></li>
                    <li><a href="https://github.com/Alamofire/Alamofire" target="_blank">Alamofire - Swift网络请求库</a></li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
