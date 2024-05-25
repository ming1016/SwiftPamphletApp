
`KeyframeAnimator`是一个在SwiftUI中创建关键帧动画的工具。关键帧动画是一种动画类型，其中定义了动画开始和结束的关键帧，以及可能的一些中间关键帧，然后动画系统会在这些关键帧之间进行插值以创建平滑的动画。

`KeyframeAnimator`接受一个初始值，一个内容闭包，以及一个关键帧闭包。初始值是一个包含了动画所需的所有属性的结构（在这个例子中是`scale`，`rotation`和`offset`）。内容闭包接受一个这样的结构实例，并返回一个视图。这个视图将使用结构中的值进行配置，以便它可以根据这些值进行动画。关键帧闭包接受一个这样的结构实例，并定义了一系列的关键帧轨道。每个轨道都对应于结构中的一个属性，并定义了一系列的关键帧。每个关键帧都定义了一个值和一个时间点，动画系统将在这些关键帧之间进行插值。

此外，SwiftUI提供了四种不同类型的关键帧：`LinearKeyframe`，`SpringKeyframe`，`CubicKeyframe`和`MoveKeyframe`。前三种关键帧使用不同的动画过渡函数进行插值，而`MoveKeyframe`则立即跳转到指定值，无需插值。

`KeyframeAnimator`可以用于创建各种复杂的动画效果，例如根据滚动位置调整关键帧驱动的效果，或者根据时间进行更新。


```swift
struct ContentView: View {
    @State var animationTrigger: Bool = false

    var body: some View {
        VStack {
            KeyframeAnimator(
                initialValue: AnimatedMovie(),
                content: { movie in
                    Image("evermore")
                        .resizable()
                        .frame(width: 100, height: 150)
                        .scaleEffect(movie.scaleRatio)
                        .rotationEffect(movie.rotationAngle)
                        .offset(y: movie.verticalOffset)
                }, keyframes: { movie in
                    KeyframeTrack(\.scaleRatio) {
                        LinearKeyframe(1.0, duration: 0.36)
                        SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
                        SpringKeyframe(1.0, spring: .bouncy)
                    }

                    KeyframeTrack(\.rotationAngle) {
                        CubicKeyframe(.degrees(-30), duration: 1.0)
                        CubicKeyframe(.zero, duration: 1.0)
                    }

                    KeyframeTrack(\.verticalOffset) {
                        LinearKeyframe(0.0, duration: 0.1)
                        SpringKeyframe(20.0, duration: 0.15, spring: .bouncy)
                        CubicKeyframe(-60.0, duration: 0.2)
                        MoveKeyframe(0.0)
                    }
                }
            )
        }
    }
}

struct AnimatedMovie {
    var scaleRatio: Double = 1
    var rotationAngle = Angle.zero
    var verticalOffset: Double = 0
}
```

以上代码中，我们首先定义了一个`AnimatedMovie`结构，它包含了动画所需的所有属性。然后，我们在`ContentView`视图中创建了一个`KeyframeAnimator`，该修饰符接受一个观测值`animationTrigger`，用于触发动画。在`content`闭包中，我们使用`Image`视图创建了一个电影海报，并根据`AnimatedMovie`结构中的值对其进行配置。在`keyframes`闭包中，我们为每个属性定义了一系列的关键帧轨道。例如，我们为`scaleRatio`属性定义了三个关键帧，分别使用`LinearKeyframe`和`SpringKeyframe`进行插值。我们还为`rotationAngle`和`verticalOffset`属性定义了两个关键帧轨道，分别使用`CubicKeyframe`和`MoveKeyframe`进行插值。


也可以使用 `.keyframeAnimator` 修饰符来创建关键帧动画。以下是一个示例，演示了如何使用 .keyframeAnimator 修饰符创建一个关键帧动画，该动画在用户点击时触发。

```swift
struct ContentView: View {
    @State var animationTrigger: Bool = false
    
    var body: some View {
        Image("evermore")
            .resizable()
            .frame(width: 100, height: 150)
            .scaleEffect(animationTrigger ? 1.5 : 1.0)
            .rotationEffect(animationTrigger ? .degrees(-30) : .zero)
            .offset(y: animationTrigger ? -60.0 : 0.0)
            .keyframeAnimator(initialValue: AnimatedMovie(),
                              trigger: animationTrigger,
                              content: { view, value in
                view
                    .scaleEffect(value.scaleRatio)
                    .rotationEffect(value.rotationAngle)
            },
                              keyframes: { value in
                KeyframeTrack(\.scaleRatio) {
                    LinearKeyframe(1.5, duration: 0.36)
                    SpringKeyframe(1.0, duration: 0.8, spring: .bouncy)
                    SpringKeyframe(1.5, spring: .bouncy)
                }
                
                KeyframeTrack(\.rotationAngle) {
                    CubicKeyframe(.degrees(-30), duration: 1.0)
                    CubicKeyframe(.zero, duration: 1.0)
                }
                
                KeyframeTrack(\.verticalOffset) {
                    LinearKeyframe(-60.0, duration: 0.1)
                    SpringKeyframe(0.0, duration: 0.15, spring: .bouncy)
                    CubicKeyframe(-60.0, duration: 0.2)
                    MoveKeyframe(0.0)
                }
            })
        
            .onTapGesture {
                withAnimation {
                    animationTrigger.toggle()
                }
            }
    }
}

struct AnimatedMovie {
    var scaleRatio: Double = 1
    var rotationAngle = Angle.zero
    var verticalOffset: Double = 0
}
```

在这个例子中，我们创建了一个 `AnimatedMovie` 结构，它包含了动画所需的所有属性。然后，我们在 `ContentView` 视图中创建了一个 `KeyframeAnimator`，该修饰符接受一个观测值 `animationTrigger`，用于触发动画。在 `content` 闭包中，我们使用 `Image` 视图创建了一个电影海报，并根据 `AnimatedMovie` 结构中的值对其进行配置。在 `keyframes` 闭包中，我们为每个属性定义了一系列的关键帧轨道。例如，我们为 `scaleRatio` 属性定义了三个关键帧，分别使用 `LinearKeyframe` 和 `SpringKeyframe` 进行插值。我们还为 `rotationAngle` 和 `verticalOffset` 属性定义了两个关键帧轨道，分别使用 `CubicKeyframe` 和 `MoveKeyframe` 进行插值。
