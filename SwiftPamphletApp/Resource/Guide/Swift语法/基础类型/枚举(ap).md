<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Swift 基础 - 枚举</title>
  <style>
    :root {
      --background-color: #f0e6d2;
      --text-color: #2d3e50;
      --accent-color: #e85d3d;
      --accent-color-dark: #d14b2b;
      --accent-color-light: #f7934c;
      --secondary-color: #2d3e50;
      --line-color: #a9a9a9;
      --code-background: rgba(45, 62, 80, 0.05);
      --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      --section-border: 2px solid var(--accent-color-light);
    }

    @media (prefers-color-scheme: dark) {
      :root {
        --background-color: #2d3e50;
        --text-color: #f0e6d2;
        --accent-color: #f7934c;
        --accent-color-dark: #e85d3d;
        --accent-color-light: #ffa767;
        --secondary-color: #f0e6d2;
        --line-color: #6a6a6a;
        --code-background: rgba(240, 230, 210, 0.1);
      }
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
      background-color: var(--background-color);
      color: var(--text-color);
      line-height: 1.6;
      max-width: 1200px;
      margin: 0 auto;
      padding: 2rem 1rem;
      position: relative;
      overflow-x: hidden;
    }

    /* 几何图案背景装饰 */
    body::before {
      content: "";
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: 
        linear-gradient(30deg, var(--line-color) 1px, transparent 1px),
        linear-gradient(150deg, var(--line-color) 1px, transparent 1px);
      background-size: 40px 40px;
      opacity: 0.05;
      z-index: -1;
    }

    header {
      text-align: center;
      margin-bottom: 3rem;
      position: relative;
    }

    header::after {
      content: "";
      display: block;
      width: 80%;
      height: 4px;
      background: linear-gradient(90deg, transparent, var(--accent-color), transparent);
      margin: 1rem auto 0;
    }

    h1 {
      font-size: 3rem;
      color: var(--accent-color);
      margin-bottom: 1rem;
      font-weight: 700;
      letter-spacing: 1px;
    }

    h2 {
      font-size: 2rem;
      color: var(--accent-color);
      margin: 2rem 0 1rem;
      padding-bottom: 0.5rem;
      border-bottom: 2px solid var(--accent-color-light);
    }

    h3 {
      font-size: 1.5rem;
      color: var(--accent-color-dark);
      margin: 1.5rem 0 1rem;
    }

    p {
      margin-bottom: 1rem;
    }

    a {
      color: var(--accent-color);
      text-decoration: none;
      transition: color 0.3s;
    }

    a:hover {
      color: var(--accent-color-light);
      text-decoration: underline;
    }

    .container {
      background-color: var(--background-color);
      border-radius: 8px;
      padding: 2rem;
      margin-bottom: 2rem;
    }

    .section {
      margin: 3rem 0;
      padding: 2rem;
      background-color: rgba(255, 255, 255, 0.03);
      border-radius: 8px;
      box-shadow: var(--card-shadow);
      border-left: var(--section-border);
    }

    .note {
      background-color: rgba(247, 147, 76, 0.1);
      border-left: 4px solid var(--accent-color-light);
      padding: 1rem;
      margin: 1rem 0;
      border-radius: 0 4px 4px 0;
    }

    .warning {
      background-color: rgba(232, 93, 61, 0.1);
      border-left: 4px solid var(--accent-color);
      padding: 1rem;
      margin: 1rem 0;
      border-radius: 0 4px 4px 0;
    }

    code {
      font-family: 'SF Mono', SFMono-Regular, Consolas, 'Liberation Mono', Menlo, monospace;
      background-color: var(--code-background);
      padding: 0.2em 0.4em;
      border-radius: 3px;
      font-size: 0.9em;
    }

    pre {
      background-color: var(--code-background);
      padding: 1rem;
      border-radius: 8px;
      overflow-x: auto;
      margin: 1rem 0;
      border-left: 3px solid var(--accent-color);
    }

    pre code {
      background-color: transparent;
      padding: 0;
      font-size: 0.95rem;
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin: 2rem 0;
    }

    .card {
      background-color: rgba(255, 255, 255, 0.05);
      border-radius: 8px;
      padding: 1.5rem;
      box-shadow: var(--card-shadow);
      transition: transform 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
    }

    .example-container {
      margin: 2rem 0;
      border: 1px solid var(--line-color);
      border-radius: 8px;
      overflow: hidden;
    }

    .example-title {
      background-color: var(--accent-color);
      color: white;
      padding: 0.5rem 1rem;
      font-weight: bold;
    }

    .example-content {
      padding: 1rem;
    }

    .references {
      background-color: rgba(255, 255, 255, 0.05);
      border-radius: 8px;
      padding: 1.5rem;
      margin-top: 3rem;
    }

    .references ul {
      list-style-type: square;
      padding-left: 2rem;
    }

    .references li {
      margin-bottom: 0.5rem;
    }

    svg {
      max-width: 100%;
      height: auto;
      margin: 2rem auto;
      display: block;
    }

    @media (max-width: 768px) {
      h1 {
        font-size: 2.2rem;
      }
      
      h2 {
        font-size: 1.5rem;
      }
      
      .section {
        padding: 1.5rem;
      }
      
      .grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <header>
    <h1>Swift 基础 - 枚举</h1>
    <p>探索 Swift 语言中强大而灵活的枚举类型</p>
  </header>

  <div class="container">
    <section class="section">
      <h2>枚举概述</h2>
      <p>枚举（Enumeration）是 Swift 中一种强大的数据类型，用于定义一组相关的值，让你以类型安全的方式处理这些值。与 C 和 Objective-C 中的枚举相比，Swift 的枚举更加灵活和强大。</p>

      <p>Swift 枚举的核心特性包括：</p>
      <ul>
        <li>可以包含方法和计算属性</li>
        <li>可以定义构造函数</li>
        <li>可以遵循协议</li>
        <li>可以关联值（associated values）</li>
        <li>可以定义原始值（raw values）</li>
        <li>支持递归</li>
      </ul>

      <div class="note">
        <p><strong>注意：</strong>Swift 枚举是一等公民（first-class types），具有许多传统上只有类才具备的能力。</p>
      </div>

      <svg width="600" height="300" viewBox="0 0 600 300">
        <style>
          .diagram-text { font-family: -apple-system, sans-serif; font-size: 14px; }
          .title-text { font-family: -apple-system, sans-serif; font-size: 16px; font-weight: bold; }
          @media (prefers-color-scheme: dark) {
            .diagram-box { fill: #2d3e50; stroke: #f7934c; }
            .diagram-text, .title-text { fill: #f0e6d2; }
            .arrow { stroke: #f7934c; }
          }
          @media (prefers-color-scheme: light) {
            .diagram-box { fill: #f0e6d2; stroke: #e85d3d; }
            .diagram-text, .title-text { fill: #2d3e50; }
            .arrow { stroke: #e85d3d; }
          }
        </style>
        <!-- 标题 -->
        <text x="300" y="30" text-anchor="middle" class="title-text">Swift 枚举的核心特性</text>
        
        <!-- 中央枚举盒子 -->
        <rect x="240" y="60" width="120" height="50" rx="10" class="diagram-box" stroke-width="2"/>
        <text x="300" y="90" text-anchor="middle" class="diagram-text">枚举 (Enum)</text>
        
        <!-- 连接线和特性盒子 -->
        <!-- 左侧特性 -->
        <rect x="40" y="50" width="120" height="40" rx="5" class="diagram-box" stroke-width="2"/>
        <text x="100" y="75" text-anchor="middle" class="diagram-text">方法和计算属性</text>
        <line x1="160" y1="70" x2="240" y2="85" class="arrow" stroke-width="2"/>
        
        <rect x="40" y="110" width="120" height="40" rx="5" class="diagram-box" stroke-width="2"/>
        <text x="100" y="135" text-anchor="middle" class="diagram-text">构造函数</text>
        <line x1="160" y1="130" x2="240" y2="90" class="arrow" stroke-width="2"/>
        
        <rect x="40" y="170" width="120" height="40" rx="5" class="diagram-box" stroke-width="2"/>
        <text x="100" y="195" text-anchor="middle" class="diagram-text">协议遵循</text>
        <line x1="160" y1="190" x2="255" y2="110" class="arrow" stroke-width="2"/>
        
        <!-- 右侧特性 -->
        <rect x="440" y="50" width="120" height="40" rx="5" class="diagram-box" stroke-width="2"/>
        <text x="500" y="75" text-anchor="middle" class="diagram-text">关联值</text>
        <line x1="440" y1="70" x2="360" y2="85" class="arrow" stroke-width="2"/>
        
        <rect x="440" y="110" width="120" height="40" rx="5" class="diagram-box" stroke-width="2"/>
        <text x="500" y="135" text-anchor="middle" class="diagram-text">原始值</text>
        <line x1="440" y1="130" x2="360" y2="90" class="arrow" stroke-width="2"/>
        
        <rect x="440" y="170" width="120" height="40" rx="5" class="diagram-box" stroke-width="2"/>
        <text x="500" y="195" text-anchor="middle" class="diagram-text">递归枚举</text>
        <line x1="440" y1="190" x2="345" y2="110" class="arrow" stroke-width="2"/>
        
        <!-- 用例部分 -->
        <rect x="175" y="200" width="250" height="80" rx="5" class="diagram-box" stroke-width="2" stroke-dasharray="5,5"/>
        <text x="300" y="230" text-anchor="middle" class="diagram-text">常见应用场景</text>
        <text x="300" y="255" text-anchor="middle" class="diagram-text">状态管理、API 结果、错误处理</text>
        <text x="300" y="275" text-anchor="middle" class="diagram-text">配置选项、有限集合</text>
      </svg>
    </section>

    <section class="section">
      <h2>基础语法</h2>
      <p>Swift 枚举使用 <code>enum</code> 关键字定义，后面跟着枚举名称和一对大括号，内部是枚举的不同情况（cases）。</p>

      <div class="example-container">
        <div class="example-title">基本枚举定义</div>
        <div class="example-content">
          <pre><code>// 定义一个表示方向的基本枚举
enum Direction {
    case north
    case south
    case east
    case west
}

// 也可以写在一行
enum Direction {
    case north, south, east, west
}

// 使用枚举
let currentDirection = Direction.north

// 当类型已知时，可以省略枚举类型名
var windDirection = Direction.south
windDirection = .east // 简写形式

// 在 switch 语句中使用枚举
switch currentDirection {
case .north:
    print("向北")
case .south:
    print("向南")
case .east:
    print("向东")
case .west:
    print("向西")
}</code></pre>
        </div>
      </div>

      <div class="note">
        <p><strong>命名约定：</strong> 按照 Swift 的命名规范，枚举名称应使用大驼峰命名法（如 <code>Direction</code>），而枚举成员（case）应使用小驼峰命名法（如 <code>north</code>）。</p>
      </div>
    </section>

    <section class="section">
      <h2>关联值</h2>
      <p>Swift 枚举可以存储不同类型的关联值，这使得枚举变得更加灵活和强大。关联值允许你将额外的信息附加到枚举的每个 case 上。</p>

      <div class="example-container">
        <div class="example-title">带有关联值的枚举</div>
        <div class="example-content">
          <pre><code>// 定义一个处理不同类型条码的枚举
enum Barcode {
    case upc(Int, Int, Int, Int)    // 通用产品编码 UPC-A：系统标识、制造商代码、产品代码、校验位
    case qrCode(String)             // QR 码包含一个字符串
}

// 创建带有关联值的枚举实例
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// 提取和使用关联值
switch productBarcode {
case .upc(let systemID, let manufacturer, let product, let check):
    print("UPC: \(systemID), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR 码: \(productCode)")
}

// 如果所有关联值都用 let 或 var，可以将其放在 case 前面
switch productBarcode {
case let .upc(systemID, manufacturer, product, check):
    print("UPC: \(systemID), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR 码: \(productCode)")
}</code></pre>
        </div>
      </div>

      <p>关联值使枚举能够表示更复杂的数据结构，这在处理网络请求结果、错误处理等场景下特别有用。</p>

      <svg width="600" height="260" viewBox="0 0 600 260">
        <style>
          .diagram-text { font-family: -apple-system, sans-serif; font-size: 14px; }
          .title-text { font-family: -apple-system, sans-serif; font-size: 16px; font-weight: bold; }
          @media (prefers-color-scheme: dark) {
            .diagram-box { fill: #2d3e50; stroke: #f7934c; }
            .diagram-text, .title-text { fill: #f0e6d2; }
            .arrow { stroke: #f7934c; fill: #f7934c; }
            .diagram-box-inner { fill: #1a2836; stroke: #f7934c; }
          }
          @media (prefers-color-scheme: light) {
            .diagram-box { fill: #f0e6d2; stroke: #e85d3d; }
            .diagram-text, .title-text { fill: #2d3e50; }
            .arrow { stroke: #e85d3d; fill: #e85d3d; }
            .diagram-box-inner { fill: #fff5e6; stroke: #e85d3d; }
          }
        </style>
        <!-- 标题 -->
        <text x="300" y="30" text-anchor="middle" class="title-text">枚举关联值示意图</text>
        
        <!-- 枚举定义区域 -->
        <rect x="50" y="50" width="500" height="180" rx="10" class="diagram-box" stroke-width="2"/>
        <text x="300" y="75" text-anchor="middle" class="title-text">enum Barcode</text>
        
        <!-- UPC Case -->
        <rect x="100" y="100" width="160" height="100" rx="5" class="diagram-box-inner" stroke-width="2"/>
        <text x="180" y="125" text-anchor="middle" class="diagram-text">case upc</text>
        <rect x="110" y="140" width="140" height="50" rx="3" stroke-width="1" stroke-dasharray="5,5" class="diagram-box-inner"/>
        <text x="180" y="165" text-anchor="middle" class="diagram-text">(Int, Int, Int, Int)</text>
        <text x="180" y="185" text-anchor="middle" class="diagram-text" font-size="12">关联值</text>
        
        <!-- QR Code Case -->
        <rect x="340" y="100" width="160" height="100" rx="5" class="diagram-box-inner" stroke-width="2"/>
        <text x="420" y="125" text-anchor="middle" class="diagram-text">case qrCode</text>
        <rect x="350" y="140" width="140" height="50" rx="3" stroke-width="1" stroke-dasharray="5,5" class="diagram-box-inner"/>
        <text x="420" y="165" text-anchor="middle" class="diagram-text">(String)</text>
        <text x="420" y="185" text-anchor="middle" class="diagram-text" font-size="12">关联值</text>
      </svg>

      <div class="example-container">
        <div class="example-title">关联值在实际应用中的例子：网络请求结果</div>
        <div class="example-content">
          <pre><code>// 定义一个网络请求结果枚举
enum NetworkResult<T> {
    case success(T)                          // 成功时包含数据
    case failure(Error)                      // 失败时包含错误
    case loading(progress: Double)           // 加载中包含进度
    case empty                               // 没有数据
}

// 实际使用
func fetchUserData(completion: @escaping (NetworkResult<User>) -> Void) {
    // 模拟网络请求
    // ...进行网络请求...
    
    if let user = decodedUser {
        completion(.success(user))
    } else if let error = requestError {
        completion(.failure(error))
    } else {
        completion(.empty)
    }
}

// 处理结果
fetchUserData { result in
    switch result {
    case .success(let user):
        print("获取到用户: \(user.name)")
    case .failure(let error):
        print("请求失败: \(error.localizedDescription)")
    case .loading(let progress):
        print("加载中: \(progress * 100)%")
    case .empty:
        print("没有找到用户数据")
    }
}</code></pre>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>原始值</h2>
      <p>Swift 枚举可以预设默认值，称为原始值（raw values）。原始值与关联值不同，它为枚举的所有 case 都预先设定了特定类型的值。</p>

      <div class="example-container">
        <div class="example-title">带有原始值的枚举</div>
        <div class="example-content">
          <pre><code>// 定义一个带有整型原始值的枚举
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// 字符串原始值可以自动递增
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    // venus = 2, earth = 3, 以此类推...
}

// 访问原始值
let earthRawValue = Planet.earth.rawValue  // 值为 3

// 从原始值创建枚举实例（返回可选值）
let possiblePlanet = Planet(rawValue: 3)   // 返回 Planet.earth
let nonExistentPlanet = Planet(rawValue: 11) // 返回 nil</code></pre>
        </div>
      </div>

      <div class="note">
        <p><strong>注意：</strong> 原始值必须是唯一的。如果是整数或字符串类型，Swift 可以自动为未指定原始值的 case 设置递增的值。</p>
      </div>

      <svg width="600" height="300" viewBox="0 0 600 300">
        <style>
          .diagram-text { font-family: -apple-system, sans-serif; font-size: 14px; }
          .title-text { font-family: -apple-system, sans-serif; font-size: 16px; font-weight: bold; }
          @media (prefers-color-scheme: dark) {
            .diagram-box { fill: #2d3e50; stroke: #f7934c; }
            .diagram-text, .title-text { fill: #f0e6d2; }
            .arrow { stroke: #f7934c; fill: none; }
            .code-text { fill: #f7934c; }
          }
          @media (prefers-color-scheme: light) {
            .diagram-box { fill: #f0e6d2; stroke: #e85d3d; }
            .diagram-text, .title-text { fill: #2d3e50; }
            .arrow { stroke: #e85d3d; fill: none; }
            .code-text { fill: #d14b2b; }
          }
        </style>
        <!-- 标题 -->
        <text x="300" y="30" text-anchor="middle" class="title-text">枚举原始值vs关联值</text>
        
        <!-- 原始值说明 -->
        <rect x="50" y="60" width="220" height="200" rx="10" class="diagram-box" stroke-width="2"/>
        <text x="160" y="90" text-anchor="middle" class="title-text">原始值 (Raw Values)</text>
        <text x="160" y="120" text-anchor="middle" class="diagram-text">• 在定义枚举时预设</text>
        <text x="160" y="145" text-anchor="middle" class="diagram-text">• 同一类型的固定值</text>
        <text x="160" y="170" text-anchor="middle" class="diagram-text">• 所有实例相同</text>
        <text x="160" y="195" text-anchor="middle" class="diagram-text">• 通过.rawValue访问</text>
        <text x="160" y="220" text-anchor="middle" class="code-text">enum Planet: Int {</text>
        <text x="160" y="240" text-anchor="middle" class="code-text">    case earth = 3</text>
        <text x="160" y="260" text-anchor="middle" class="code-text">}</text>
        
        <!-- 关联值说明 -->
        <rect x="330" y="60" width="220" height="200" rx="10" class="diagram-box" stroke-width="2"/>
        <text x="440" y="90" text-anchor="middle" class="title-text">关联值 (Associated Values)</text>
        <text x="440" y="120" text-anchor="middle" class="diagram-text">• 创建实例时设置</text>
        <text x="440" y="145" text-anchor="middle" class="diagram-text">• 可以有不同类型</text>
        <text x="440" y="170" text-anchor="middle" class="diagram-text">• 每个实例可以不同</text>
        <text x="440" y="195" text-anchor="middle" class="diagram-text">• 通过模式匹配提取</text>
        <text x="440" y="220" text-anchor="middle" class="code-text">enum Barcode {</text>
        <text x="440" y="240" text-anchor="middle" class="code-text">    case upc(Int, Int, Int)</text>
        <text x="440" y="260" text-anchor="middle" class="code-text">}</text>
      </svg>

      <div class="warning">
        <p><strong>重要区别：</strong> 枚举实例只能有关联值或原始值，不能同时有两者。关联值在创建实例时设定，而原始值在定义枚举时预设。</p>
      </div>
    </section>

    <section class="section">
      <h2>递归枚举</h2>
      <p>递归枚举是一种可以在其关联值中拥有相同枚举类型的实例的枚举。递归枚举需要使用 <code>indirect</code> 关键字来告诉编译器插入必要的间接层。</p>

      <div class="example-container">
        <div class="example-title">递归枚举示例</div>
        <div class="example-content">
          <pre><code>// 定义一个简单的算术表达式递归枚举
indirect enum ArithmeticExpression {
    case number(Int)                                            // 数字
    case addition(ArithmeticExpression, ArithmeticExpression)   // 加法
    case multiplication(ArithmeticExpression, ArithmeticExpression) // 乘法
}

// 也可以只针对需要递归的 case 使用 indirect
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 创建表达式 (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let two = ArithmeticExpression.number(2)
let product = ArithmeticExpression.multiplication(sum, two)

// 计算表达式的值
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

// 计算 (5 + 4) * 2
print("(5 + 4) * 2 = \(evaluate(product))") // 输出: (5 + 4) * 2 = 18</code></pre>
        </div>
      </div>

      <p>递归枚举特别适合表示具有递归结构的数据，如数学表达式、文件系统结构或者语法树等。</p>

      <svg width="600" height="300" viewBox="0 0 600 300">
        <style>
          .diagram-text { font-family: -apple-system, sans-serif; font-size: 14px; }
          .title-text { font-family: -apple-system, sans-serif; font-size: 16px; font-weight: bold; }
          @media (prefers-color-scheme: dark) {
            .diagram-box { fill: #2d3e50; stroke: #f7934c; }
            .diagram-text, .title-text { fill: #f0e6d2; }
            .arrow { stroke: #f7934c; }
          }
          @media (prefers-color-scheme: light) {
            .diagram-box { fill: #f0e6d2; stroke: #e85d3d; }
            .diagram-text, .title-text { fill: #2d3e50; }
            .arrow { stroke: #e85d3d; }
          }
        </style>
        <!-- 标题 -->
        <text x="300" y="30" text-anchor="middle" class="title-text">递归枚举表达式树: (5 + 4) * 2</text>
        
        <!-- 乘法节点 -->
        <rect x="250" y="60" width="100" height="40" rx="20" class="diagram-box" stroke-width="2"/>
        <text x="300" y="85" text-anchor="middle" class="diagram-text">* (乘法)</text>
        
        <!-- 加法节点 -->
        <rect x="150" y="130" width="100" height="40" rx="20" class="diagram-box" stroke-width="2"/>
        <text x="200" y="155" text-anchor="middle" class="diagram-text">+ (加法)</text>
        
        <!-- 数字2节点 -->
        <rect x="350" y="130" width="100" height="40" rx="20" class="diagram-box" stroke-width="2"/>
        <text x="400" y="155" text-anchor="middle" class="diagram-text">2</text>
        
        <!-- 数字5节点 -->
        <rect x="100" y="200" width="100" height="40" rx="20" class="diagram-box" stroke-width="2"/>
        <text x="150" y="225" text-anchor="middle" class="diagram-text">5</text>
        
        <!-- 数字4节点 -->
        <rect x="250" y="200" width="100" height="40" rx="20" class="diagram-box" stroke-width="2"/>
        <text x="300" y="225" text-anchor="middle" class="diagram-text">4</text>
        
        <!-- 连接线 -->
        <line x1="300" y1="100" x2="200" y2="130" class="arrow" stroke-width="2"/>
        <line x1="300" y1="100" x2="400" y2="130" class="arrow" stroke-width="2"/>
        <line x1="200" y1="170" x2="150" y2="200" class="arrow" stroke-width="2"/>
        <line x1="200" y1="170" x2="250" y2="200" class="arrow" stroke-width="2"/>
      </svg>
    </section>

    <section class="section">
      <h2>枚举方法和计算属性</h2>
      <p>Swift 枚举可以像类和结构体一样包含方法和计算属性，这使得枚举类型更加强大和灵活。</p>

      <div class="example-container">
        <div class="example-title">带有方法和计算属性的枚举</div>
        <div class="example-content">
          <pre><code>// 定义一个表示方向的枚举，带有方法和计算属性
enum Direction {
    case north, south, east, west
    
    // 计算属性
    var description: String {
        switch self {
        case .north: return "北"
        case .south: return "南"
        case .east: return "东"
        case .west: return "西"
        }
    }
    
    // 实例方法
    func opposite() -> Direction {
        switch self {
        case .north: return .south
        case .south: return .north
        case .east: return .west
        case .west: return .east
        }
    }
    
    // 修改当前实例的可变方法
    mutating func turnClockwise() {
        switch self {
        case .north: self = .east
        case .east: self = .south
        case .south: self = .west
        case .west: self = .north
        }
    }
}

// 使用枚举的方法和属性
var heading = Direction.north
print("当前方向: \(heading.description)")  // 输出: 当前方向: 北

let oppositeDirection = heading.opposite()
print("相反方向: \(oppositeDirection.description)")  // 输出: 相反方向: 南

heading.turnClockwise()
print("顺时针旋转后: \(heading.description)")  // 输出: 顺时针旋转后: 东</code></pre>
        </div>
      </div>

      <div class="note">
        <p><strong>注意：</strong> 如果方法需要改变枚举值本身，必须标记为 <code>mutating</code>。</p>
      </div>

      <div class="example-container">
        <div class="example-title">静态方法和属性</div>
        <div class="example-content">
          <pre><code>enum TemperatureUnit {
    case celsius, fahrenheit, kelvin
    
    // 静态属性
    static var defaultUnit: TemperatureUnit {
        return .celsius
    }
    
    // 静态方法
    static func convert(_ value: Double, from source: TemperatureUnit, to target: TemperatureUnit) -> Double {
        var kelvinValue: Double
        
        // 先转换为开尔文
        switch source {
        case .celsius:
            kelvinValue = value + 273.15
        case .fahrenheit:
            kelvinValue = (value - 32) * 5/9 + 273.15
        case .kelvin:
            kelvinValue = value
        }
        
        // 从开尔文转换到目标单位
        switch target {
        case .celsius:
            return kelvinValue - 273.15
        case .fahrenheit:
            return (kelvinValue - 273.15) * 9/5 + 32
        case .kelvin:
            return kelvinValue
        }
    }
    
    // 实例方法
    func symbol() -> String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
}

// 使用静态方法和属性
print("默认温度单位: \(TemperatureUnit.defaultUnit.symbol())")  // 输出: 默认温度单位: °C

let temperatureInCelsius = 25.0
let temperatureInFahrenheit = TemperatureUnit.convert(temperatureInCelsius, 
                                                     from: .celsius, 
                                                     to: .fahrenheit)
print("\(temperatureInCelsius)°C = \(temperatureInFahrenheit)°F")</code></pre>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>模式匹配</h2>
      <p>Swift 枚举与 <code>switch</code> 语句结合使用，提供了强大的模式匹配功能，特别是在处理关联值时尤为有用。</p>

      <div class="example-container">
        <div class="example-title">枚举的模式匹配</div>
        <div class="example-content">
          <pre><code>// 定义一个处理媒体类型的枚举
enum Media {
    case book(title: String, author: String, pages: Int)
    case movie(title: String, director: String, duration: Int)
    case music(title: String, artist: String, duration: Int)
}

let library: [Media] = [
    .book(title: "Swift编程语言", author: "Apple Inc.", pages: 500),
    .movie(title: "复仇者联盟", director: "乔斯·韦登", duration: 143),
    .music(title: "Shape of You", artist: "Ed Sheeran", duration: 4)
]

// 基本模式匹配
for item in library {
    switch item {
    case .book:
        print("这是一本书")
    case .movie:
        print("这是一部电影")
    case .music:
        print("这是一首歌")
    }
}

// 提取关联值
for item in library {
    switch item {
    case .book(let title, let author, let pages):
        print("书: \"\(title)\" 作者: \(author), \(pages)页")
    case .movie(let title, let director, let duration):
        print("电影: \"\(title)\" 导演: \(director), 时长\(duration)分钟")
    case .music(let title, let artist, let duration):
        print("音乐: \"\(title)\" 艺术家: \(artist), 时长\(duration)分钟")
    }
}

// 只提取部分关联值
for item in library {
    switch item {
    case .book(let title, _, _):
        print("发现一本名为 \(title) 的书")
    case .movie(let title, _, _):
        print("发现一部名为 \(title) 的电影")
    case .music(let title, _, _):
        print("发现一首名为 \(title) 的音乐")
    }
}

// 条件匹配
for item in library {
    switch item {
    case .book(_, _, let pages) where pages > 400:
        print("这是一本大部头的书")
    case .movie(_, _, let duration) where duration > 120:
        print("这是一部长电影")
    case .music(_, _, let duration) where duration < 3:
        print("这是一首简短的歌曲")
    default:
        print("其他媒体类型")
    }
}</code></pre>
        </div>
      </div>

      <div class="example-container">
        <div class="example-title">if case 和 guard case 语法</div>
        <div class="example-content">
          <pre><code>// 使用 if case 进行模式匹配
let someMedia = Media.movie(title: "星际穿越", director: "克里斯托弗·诺兰", duration: 169)

// if case 语法
if case .movie(let title, let director, _) = someMedia {
    print("这是由 \(director) 导演的电影 \"\(title)\"")
}

// if case where 语法（带条件）
if case .movie(_, _, let duration) = someMedia, duration > 150 {
    print("这是一部超长电影，时长超过150分钟")
}

// guard case 语法
func processMovie(_ media: Media) {
    guard case .movie(let title, _, let duration) = media else {
        print("这不是一部电影")
        return
    }
    
    print("处理电影: \(title), 时长\(duration)分钟")
}

processMovie(someMedia)</code></pre>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>可迭代的枚举</h2>
      <p>通过遵循 <code>CaseIterable</code> 协议，我们可以让编译器自动为枚举生成一个包含所有 case 的集合。</p>

      <div class="example-container">
        <div class="example-title">可迭代的枚举</div>
        <div class="example-content">
          <pre><code>// 声明一个遵循 CaseIterable 的枚举
enum Season: CaseIterable {
    case spring, summer, autumn, winter
}

// 访问所有枚举 case 的集合
let allSeasons = Season.allCases
print("一年中有 \(allSeasons.count) 个季节:")

for season in Season.allCases {
    print(season)
}

// 结合关联值使用 CaseIterable（需要自己实现）
enum Activity {
    case sleeping
    case eating(food: String)
    case exercising(minutes: Int)
    case coding(language: String)
}

// 我们不能直接在带有关联值的枚举上使用 CaseIterable
// 但可以通过扩展手动实现类似功能
extension Activity {
    static var allActivities: [Activity] {
        return [
            .sleeping,
            .eating(food: "pizza"),
            .exercising(minutes: 30),
            .coding(language: "Swift")
        ]
    }
}</code></pre>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>枚举的实际应用</h2>
      <p>Swift 枚举在实际开发中有着广泛的应用场景。下面是一些常见的使用模式和最佳实践。</p>

      <div class="grid">
        <div class="card">
          <h3>状态管理</h3>
          <p>枚举适合表示有限状态机或对象的不同状态。</p>
          <pre><code>enum ConnectionState {
    case disconnected
    case connecting
    case connected(since: Date)
    case disconnecting(reason: String)
}</code></pre>
        </div>

        <div class="card">
          <h3>错误处理</h3>
          <p>使用枚举定义特定领域的错误类型。</p>
          <pre><code>enum NetworkError: Error {
    case serverError(statusCode: Int)
    case noInternet
    case timeout(after: TimeInterval)
    case invalidData
}</code></pre>
        </div>

        <div class="card">
          <h3>API 结果</h3>
          <p>Result 类型是枚举的一个典型应用。</p>
          <pre><code>enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}</code></pre>
        </div>

        <div class="card">
          <h3>配置选项</h3>
          <p>使用枚举表示互斥的配置选项。</p>
          <pre><code>enum ImageResizing {
    case fill
    case fit
    case aspectFill
    case aspectFit
    case custom(width: CGFloat, height: CGFloat)
}</code></pre>
        </div>
      </div>

      <div class="example-container">
        <div class="example-title">实际案例：SwiftUI 中的枚举用法</div>
        <div class="example-content">
          <pre><code>// SwiftUI 中的 EdgeInsets 构造
struct CustomPaddingView: View {
    enum PaddingOption {
        case none
        case symmetric(horizontal: CGFloat, vertical: CGFloat)
        case all(CGFloat)
        case custom(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat)
    }
    
    let option: PaddingOption
    
    var body: some View {
        let padding: EdgeInsets
        
        switch option {
        case .none:
            padding = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        case .symmetric(let horizontal, let vertical):
            padding = EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
        case .all(let value):
            padding = EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
        case .custom(let top, let leading, let bottom, let trailing):
            padding = EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
        
        return Text("Hello, World!")
            .padding(padding)
            .background(Color.blue)
            .foregroundColor(.white)
    }
}

// 使用方式
struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            CustomPaddingView(option: .none)
            CustomPaddingView(option: .all(10))
            CustomPaddingView(option: .symmetric(horizontal: 20, vertical: 5))
            CustomPaddingView(option: .custom(top: 5, leading: 20, bottom: 15, trailing: 20))
        }
    }
}</code></pre>
        </div>
      </div>
    </section>

    <section class="references">
      <h2>参考资料</h2>
      
      <h3>官方文档</h3>
      <ul>
        <li><a href="https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html" target="_blank">Swift 官方文档 - 枚举</a></li>
        <li><a href="https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes" target="_blank">Apple 开发者文档 - 选择结构体和类</a></li>
      </ul>
      
      <h3>推荐书籍</h3>
      <ul>
        <li>《Swift 进阶》- 王巍 (onevcat)</li>
        <li>《Swift Programming: The Big Nerd Ranch Guide》- Matthew Mathias, John Gallagher</li>
        <li>《Pro Swift》- Paul Hudson</li>
      </ul>
      
      <h3>推荐视频</h3>
      <ul>
        <li><a href="https://developer.apple.com/videos/play/wwdc2019/402" target="_blank">WWDC 2019: What's New in Swift</a></li>
        <li><a href="https://www.youtube.com/watch?v=_F9wPDQ_H30" target="_blank">Swift 枚举全面讲解 - Sean Allen</a></li>
      </ul>
      
      <h3>优秀博客</h3>
      <ul>
        <li><a href="https://www.swiftbysundell.com/articles/enum-iterations-in-swift" target="_blank">Swift by Sundell - Enum iterations in Swift</a></li>
        <li><a href="https://www.hackingwithswift.com/articles/112/enum-associated-values-improved" target="_blank">Hacking with Swift - How to use enums with associated values</a></li>
        <li><a href="https://www.objc.io/books/advanced-swift" target="_blank">objc.io - Advanced Swift</a></li>
      </ul>
      
      <h3>相关开源项目</h3>
      <ul>
        <li><a href="https://github.com/apple/swift" target="_blank">Swift - Swift 编程语言</a></li>
        <li><a href="https://github.com/apple/swift-evolution" target="_blank">Swift Evolution - Swift 语言演进提案</a></li>
        <li><a href="https://github.com/raywenderlich/swift-algorithm-club" target="_blank">Swift Algorithm Club - 用 Swift 实现的算法和数据结构</a></li>
      </ul>
    </section>
  </div>

  <script>
    // 添加代码语法高亮功能
    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll('pre code').forEach((block) => {
        // 为了简化，这里不包含真正的语法高亮功能
        // 实际项目中可以引入 highlight.js 或其他语法高亮库
      });
    });
  </script>
</body>
</html>
