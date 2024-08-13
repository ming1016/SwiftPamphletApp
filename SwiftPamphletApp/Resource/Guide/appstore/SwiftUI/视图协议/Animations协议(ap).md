
Animations 协议包括：

- `Animatable`
- `AnimatableModifier`
- `GeometryEffect`
- `VectorArithmetic`

动画协议允许我们创建和修改动画。以下是这些协议的介绍和示例：

- `Animatable`：这个协议定义了一个可以在动画中改变的值。例如，我们可以创建一个表示漫画角色移动的动画：

```swift
struct ComicCharacterView: View, Animatable {
    var position: CGFloat

    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }

    var body: some View {
        Image("character")
            .offset(x: position)
    }
}
```

在这个例子中，`ComicCharacterView` 是一个自定义的视图，它的 `position` 属性可以在动画中改变。`animatableData` 属性是 `Animatable` 协议的一部分，它表示可以在动画中改变的数据。

- `AnimatableModifier`：这个协议定义了一个可以在动画中改变视图的修饰符。例如，我们可以创建一个使漫画角色移动的修饰符：

```swift
struct MovingModifier: AnimatableModifier {
    var position: CGFloat

    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }

    func body(content: Content) -> some View {
        content.offset(x: position)
    }
}
```

在这个例子中，`MovingModifier` 是一个自定义的修饰符，它的 `position` 属性可以在动画中改变。我们可以使用这个修饰符来修改我们的 `ComicCharacterView`：

```swift
ComicCharacterView(position: 100)
    .modifier(MovingModifier(position: 200))
```

- `GeometryEffect`：这个协议定义了一个可以改变视图的几何形状的效果。例如，我们可以创建一个使漫画角色旋转的效果：

```swift
struct RotatingEffect: GeometryEffect {
    var angle: Angle

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(rotationAngle: CGFloat(angle.radians)))
    }
}
```

然后，我们可以使用这个效果来修改我们的 `ComicCharacterView`：

```swift
ComicCharacterView(position: 100)
    .modifier(RotatingEffect(angle: .degrees(45)))
```

- `VectorArithmetic`：这个协议定义了一个可以在动画中进行线性插值的类型。例如，`CGFloat` 和 `Double` 都遵循这个协议，我们可以在 `Animatable` 和 `AnimatableModifier` 的动画中使用它们。
