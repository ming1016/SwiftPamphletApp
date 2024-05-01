session [Compose custom layouts with SwiftUI](https://developer.apple.com/videos/play/wwdc2022-10056) 

提供了新的 Grid 视图来同时满足 VStack 和 HStack。还有一个更低级别 Layout 接口，可以完全控制构建应用所需的布局。另外还有 ViewThatFits 可以自动选择填充可用空间的方式。

Grid 示例代码如下：
```swift
Grid {
    GridRow {
        Text("One")
        Text("One")
        Text("One")
    }
    GridRow {
        Text("Two")
        Text("Two")
    }
    Divider()
    GridRow {
        Text("Three")
        Text("Three")
            .gridCellColumns(2)
    }
}
```

`gridCellColumns()`  modifier 可以让一个单元格跨多列。

ViewThatFits 的新视图，允许根据适合的大小放视图。ViewThatFits 会自动选择对于当前屏幕大小合适的子视图进行显示。Ryan Lintott 的[示例效果](https://twitter.com/ryanlintott/status/1534706352177700871) ，对应示例代码 [LayoutThatFits.swift](https://gist.github.com/ryanlintott/d03140dd155d0493a758dcd284e68eaa) 。

新的 Layout 协议可以观看 Swift Talk 第 308 期 [The Layout Protocol](https://talk.objc.io/episodes/S01E308-the-layout-protocol) 。

通过符合 Layout 协议，我们可以自定义一个自定义的布局容器，直接参与 SwiftUI 的布局过程。新的 ProposedViewSize 结构，它是容器视图提供的大小。 `Layout.Subviews` 是布局视图的子视图代理集合，我们可以在其中为每个子视图请求各种布局属性。
```swift
public protocol Layout: Animatable {
  static var layoutProperties: LayoutProperties { get }
  associatedtype Cache = Void
  typealias Subviews = LayoutSubviews

  func updateCache(_ cache: inout Self.Cache, subviews: Self.Subviews)

  func spacing(subviews: Self.Subviews, cache: inout Self.Cache) -> ViewSpacing

  /// We return our view size here, use the passed parameters for computing the
  /// layout.
  func sizeThatFits(
    proposal: ProposedViewSize, 
    subviews: Self.Subviews, 
    cache: inout Self.Cache // 👈🏻 use this for calculated data shared among Layout methods
  ) -> CGSize
  
  /// Use this to tell your subviews where to appear.
  func placeSubviews(
    in bounds: CGRect, // 👈🏻 region where we need to place our subviews into, origin might not be .zero
    proposal: ProposedViewSize, 
    subviews: Self.Subviews, 
    cache: inout Self.Cache
  )
  
  // ... there are more a couple more optional methods
}
```

下面例子是一个自定义的水平 stack 视图，为其所有子视图提供其最大子视图的宽度：
```swift
struct MyEqualWidthHStack: Layout {
  /// Returns a size that the layout container needs to arrange its subviews.
  /// - Tag: sizeThatFitsHorizontal
  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void
  ) -> CGSize {
    guard !subviews.isEmpty else { return .zero }

    let maxSize = maxSize(subviews: subviews)
    let spacing = spacing(subviews: subviews)
    let totalSpacing = spacing.reduce(0) { $0 + $1 }

    return CGSize(
      width: maxSize.width * CGFloat(subviews.count) + totalSpacing,
      height: maxSize.height)
  }

  /// Places the stack's subviews.
  /// - Tag: placeSubviewsHorizontal
  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void
  ) {
    guard !subviews.isEmpty else { return }

    let maxSize = maxSize(subviews: subviews)
    let spacing = spacing(subviews: subviews)

    let placementProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
    var nextX = bounds.minX + maxSize.width / 2

    for index in subviews.indices {
      subviews[index].place(
        at: CGPoint(x: nextX, y: bounds.midY),
        anchor: .center,
        proposal: placementProposal)
      nextX += maxSize.width + spacing[index]
    }
  }

  /// Finds the largest ideal size of the subviews.
  private func maxSize(subviews: Subviews) -> CGSize {
    let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
      CGSize(
        width: max(currentMax.width, subviewSize.width),
        height: max(currentMax.height, subviewSize.height))
    }

    return maxSize
  }

  /// Gets an array of preferred spacing sizes between subviews in the
  /// horizontal dimension.
  private func spacing(subviews: Subviews) -> [CGFloat] {
    subviews.indices.map { index in
      guard index < subviews.count - 1 else { return 0 }
      return subviews[index].spacing.distance(
        to: subviews[index + 1].spacing,
        along: .horizontal)
    }
  }
}
```

自定义 layout 只能访问子视图代理 `Layout.Subviews` ，而不是视图或数据模型。我们可以通过 LayoutValueKey 在每个子视图上存储自定义值，通过 `layoutValue(key:value:)` modifier 设置。
```swift
private struct Rank: LayoutValueKey {
  static let defaultValue: Int = 1
}

extension View {
  func rank(_ value: Int) -> some View { // 👈🏻 convenience method
    layoutValue(key: Rank.self, value: value) // 👈🏻 the new modifier
  }
}
```

然后，我们就可以通过 Layout 方法中的 `Layout.Subviews` 代理读取自定义 `LayoutValueKey` 值：
```swift
func placeSubviews(
  in bounds: CGRect,
  proposal: ProposedViewSize,
  subviews: Subviews,
  cache: inout Void
) {
  let ranks = subviews.map { subview in
    subview[Rank.self] // 👈🏻
  }

  // ...
}
```

要在布局之间变化使用动画，需要用 AnyLayout，代码示例如下：
```swift
struct PAnyLayout: View {
    @State private var isVertical = false
    var body: some View {
        let layout = isVertical ? AnyLayout(VStack()) : AnyLayout(HStack())
        layout {
            Image(systemName: "star").foregroundColor(.yellow)
            Text("Starming.com")
            Text("戴铭")
        }
        Button("Click") {
            withAnimation {
                isVertical.toggle()
            }
        } // end button
    } // end body
}
```

同时 Text 和图片也支持了样式布局变化，代码示例如下：
```swift
struct PTextTransitionsView: View {
    @State private var expandMessage = true
    private let mintWithShadow: AnyShapeStyle = AnyShapeStyle(Color.mint.shadow(.drop(radius: 2)))
    private let primaryWithoutShadow: AnyShapeStyle = AnyShapeStyle(Color.primary.shadow(.drop(radius: 0)))

    var body: some View {
        Text("Dai Ming Swift Pamphlet")
            .font(expandMessage ? .largeTitle.weight(.heavy) : .body)
            .foregroundStyle(expandMessage ? mintWithShadow : primaryWithoutShadow)
            .onTapGesture { withAnimation { expandMessage.toggle() }}
            .frame(maxWidth: expandMessage ? 150 : 250)
            .drawingGroup()
            .padding(20)
            .background(.cyan.opacity(0.3), in: RoundedRectangle(cornerRadius: 6))
    }
}
```

