
Blend Modes

### 介绍

`blendMode(_:)` 是 SwiftUI 中的一个视图修饰符，用于混合视图。以下是两种使用 `blendMode(_:)` 的方式，以及相应的示例：

1. 通过 `ZStack` 使用 `blendMode(_:)`：

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Image("evermore")
            Image("fearless")
                .blendMode(.multiply)
        }
    }
}
```

在这个例子中，我们创建了一个 `ZStack`，它包含两个图像。我们将 `blendMode(.multiply)` 应用于第二个图像，这样它就会与第一个图像混合。

2. 通过 `.overlay` 使用 `blendMode(_:)`：

```swift
struct ContentView: View {   
    var body: some View {
        Image("evermore")
            .overlay {
                Image("fearless")
                    .blendMode(.color)
                    .blendMode(.multiply)
            }
    }
}
```

在这个例子中，我们创建了一个图像，并添加了一个覆盖层。这个覆盖层是另一个图像，我们将 `blendMode(.multiply)` 应用于这个图像，这样它就会与底层的图像混合。

`.multiply` 是一种混合模式，你可以根据需要选择其他的混合模式。

blendMode 混合模式可以分为以下几种类型：

## 变亮

提升亮部亮度

- `colorDodge`
- `lighten`
- `screen`
- `plusLighter`

## 变暗

使暗部更暗

- `colorBurn`
- `darken`
- `multiply`
- `plusDarker`

## 对比

让亮部更亮，暗部更暗，对比度增加，更艳丽。

- `overlay`
- `softLight`
- `hardLight`

## 融合

这些模式会根据源图像和目标图像的色调、饱和度、颜色或亮度进行混合。

- `hue`
- `saturation`
- `color`
- `luminosity`
- `sourceAtop`
- `destinationOver`
- `destinationOut`
- `difference`
- `exclusion`