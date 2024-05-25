


## 基本用法

在 SwiftUI 中，创建一个动画需要以下三个组成部分：

- 一个时间曲线函数
- 一个声明将状态（或特定的依赖项）与该时间曲线函数关联起来
- 一个依赖于该状态（或特定的依赖项）的可动画组件

动画的接口定义为 `Animation(timingFunction:property:duration:delay)`

- `timingFunction` 是时间曲线函数，可以是线性、缓动、弹簧等
- `property` 是动画属性，可以是颜色、大小、位置等
- `duration` 是动画持续时间
- `delay` 是动画延迟时间

三种写法

- `withAnimation(_:_:)` 全局应用
- `animation(_:value:)` 应用于 View
- `animation(_:)` 应用于绑定的变量

第一种

```swift
withAnimation(.easeInOut(duration: 1.5).delay(1.0)) {
    myProperty = newValue
}
```

第二种

```swift
View().animation(.easeInOut(duration: 1.5).delay(1.0), value: myProperty)
```

第三种

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    var body: some View {
        PosterView(scale: $scale.animation(.linear(duration: 1)))
    }
}

struct PosterView: View {
    @Binding var scale: CGFloat
    var body: some View {
        Image("evermore")
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .onAppear {
                scale = 1.5
            }
    }
}
```

在这个示例中，我们创建了一个 `MovieView`，它有一个状态变量 `scale`。当 `scale` 的值改变时，`PosterView` 中的海报图片会以线性动画的方式进行缩放。当 `PosterView` 出现时，`scale` 的值会改变为 1.5，因此海报图片会以线性动画的方式放大到 1.5 倍。

在 SwiftUI 中，我们也可以创建一个自定义的 `AnimatableModifier` 来实现对图文卡片大小的动画处理。

```swift
struct ContentView: View {
    @State private var isSmall = false
    var body: some View {
        VStack {
            Image("evermore")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerSize: CGSize(width: 16, height: 16)))
            Text("电影标题")
                .font(.title)
                .fontWeight(.bold)
        }
        .animatableCard(size: isSmall ? CGSize(width: 200, height: 300) : CGSize(width: 400, height: 600))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)){
                isSmall.toggle()
            }
        }
    }
}

struct AnimatableCardModifier: AnimatableModifier {
    var size: CGSize
    var color: Color = .white
    
    var animatableData: CGSize.AnimatableData {
        get { CGSize.AnimatableData(size.width, size.height) }
        set { size = CGSize(width: newValue.first, height: newValue.second) }
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height)
            .background(color)
            .cornerRadius(10)
    }
}

extension View {
    func animatableCard(size: CGSize,
                        color: Color = .white) -> some View {
        self.modifier(AnimatableCardModifier(size: size,
                                             color: color))
    }
}
```

SwiftUI 内置了许多动画过渡函数，主要分为四类：

- 时间曲线动画函数
- 弹簧动画函数
- 高阶动画函数
- 自定义动画函数


### 时间曲线动画函数

时间曲线函数决定了动画的速度如何随时间变化，这对于动画的自然感觉非常重要。

SwiftUI 提供了以下几种预设的时间曲线函数：

- `linear`：线性动画，动画速度始终保持不变。
- `easeIn`：动画开始时速度较慢，然后逐渐加速。
- `easeOut`：动画开始时速度较快，然后逐渐减速。
- `easeInOut`：动画开始和结束时速度较慢，中间阶段速度较快。

除此之外，SwiftUI 还提供了 `timingCurve` 函数，可以通过二次曲线或 Bézier 曲线来自定义插值函数，实现更复杂的动画效果。

以下是代码示例：

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Text("电影标题")
                .font(.title)
                .padding()
            Image("evermore")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                scale = 1.5
            }
        }
    }
}
```

在这个示例中，我们创建了一个 `MovieView`，它包含一个电影标题和一个电影海报。当视图出现时，海报的大小会以 `easeInOut` 的方式在 1 秒内放大到 1.5 倍。

### 弹簧动画函数

弹簧动画函数可以模拟物理世界中的弹簧运动，使动画看起来更加自然和生动。

SwiftUI 提供了以下几种预设的弹簧动画函数：

- `smooth`：平滑的弹簧动画，动画速度逐渐减慢，直到停止。
- `snappy`：快速的弹簧动画，动画速度快速减慢，然后停止。
- `bouncy`：弹跳的弹簧动画，动画在结束时会有一些弹跳效果。

除此之外，SwiftUI 还提供了 `spring` 函数，可以自定义弹簧动画的持续时间、弹跳度和混合持续时间，实现更复杂的弹簧动画效果。

以下是代码示例：

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Text("电影标题")
                .font(.title)
                .padding()
            Image("evermore")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                scale = 1.5
            }
        }
    }
}
```

在这个示例中，我们创建了一个 `MovieView`，它包含一个电影标题和一个电影海报。当视图出现时，海报的大小会以自定义的弹簧动画方式在 0.5 秒内放大到 1.5 倍。

### 高阶动画函数

高级动画函数可以在基础动画函数的基础上，添加延迟、重复、翻转和速度等功能，使动画效果更加丰富和复杂。

以下是这些函数的简单介绍：

- `func delay(TimeInterval) -> Animation`：此函数可以使动画在指定的时间间隔后开始。
- `func repeatCount(Int, autoreverses: Bool) -> Animation`：此函数可以使动画重复指定的次数。如果 `autoreverses` 参数为 `true`，则每次重复时动画都会翻转。
- `func repeatForever(autoreverses: Bool) -> Animation`：此函数可以使动画无限次重复。如果 `autoreverses` 参数为 `true`，则每次重复时动画都会翻转。
- `func speed(Double) -> Animation`：此函数可以调整动画的速度，使其比默认速度快或慢。

以下是代码示例：

```swift
struct MovieView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Text("电影标题")
                .font(.title)
                .padding()
            Image("movie_poster")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.0).delay(0.5).repeatCount(3, autoreverses: true).speed(2)) {
                scale = 1.5
            }
        }
    }
}
```

在这个示例中，我们创建了一个 `MovieView`，它包含一个电影标题和一个电影海报。当视图出现时，海报的大小会以 `easeInOut` 的方式在 1 秒内放大到 1.5 倍，然后在 0.5 秒后开始，重复 3 次，每次重复都会翻转，速度是默认速度的 2 倍。

### 自定义动画函数

SwiftUI 可以通过实现 `CustomAnimation` 协议来完全自定义插值算法。

以下是一个简单的 `Linear` 动画函数的实现：

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Text("电影标题")
                .font(.title)
                .padding()
            Image("evermore")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .animation(.myLinear(duration: 1), value: scale) // use myLinear animation
        }
        .onAppear {
            scale = 1.5
        }
    }
}


struct MyLinearAnimation: CustomAnimation {
  var duration: TimeInterval

  func animate<V>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? where V : VectorArithmetic {
    if time <= duration {
      value.scaled(by: time / duration)
    } else {
      nil
    }
  }

  func velocity<V: VectorArithmetic>(
    value: V, time: TimeInterval, context: AnimationContext<V>
  ) -> V? {
    value.scaled(by: 1.0 / duration)
  }

  func shouldMerge<V>(previous: Animation, value: V, time: TimeInterval, context: inout AnimationContext<V>) -> Bool where V : VectorArithmetic {
    true
  }
}

extension Animation {
  public static func myLinear(duration: TimeInterval) -> Animation { // define function like linear
    return Animation(MyLinearAnimation(duration: duration))
  }
}
```



