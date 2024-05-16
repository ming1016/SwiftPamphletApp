


通过实现 Layout 协议，创建一个水平堆栈布局，其中所有子视图的宽度都相等。

```swift
struct OptimizedEqualWidthHStack: Layout {
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
    if subviews.isEmpty { return .zero }
    let maxSubviewSize = calculateMaxSize(subviews: subviews)
    let totalSpacing = calculateSpacing(subviews: subviews).reduce(0, +)
    return CGSize(width: maxSubviewSize.width * CGFloat(subviews.count) + totalSpacing, height: maxSubviewSize.height)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
    if subviews.isEmpty { return }
    let maxSubviewSize = calculateMaxSize(subviews: subviews)
    let spacings = calculateSpacing(subviews: subviews)
    let placementProposal = ProposedViewSize(width: maxSubviewSize.width, height: maxSubviewSize.height)
    var nextX = bounds.minX + maxSubviewSize.width / 2
    for index in subviews.indices {
      subviews[index].place(at: CGPoint(x: nextX, y: bounds.midY), anchor: .center, proposal: placementProposal)
      nextX += maxSubviewSize.width + spacings[index]
    }
  }

  private func calculateMaxSize(subviews: Subviews) -> CGSize {
    return subviews.map { $0.sizeThatFits(.unspecified) }.reduce(.zero) { CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height)) }
  }

  private func calculateSpacing(subviews: Subviews) -> [CGFloat] {
    return subviews.indices.map { $0 < subviews.count - 1 ? subviews[$0].spacing.distance(to: subviews[$0 + 1].spacing, along: .horizontal) : 0 }
  }
}
```

上面这段代码中 sizeThatFits 方法计算并返回布局容器需要的大小，以便排列其子视图。它首先检查子视图数组是否为空，如果为空则返回 .zero。然后，它计算子视图的最大尺寸和总间距，最后返回一个 CGSize 对象，其宽度等于最大子视图宽度乘以子视图数量加上总间距，高度等于最大子视图高度。

placeSubviews 方法将子视图放置在布局容器中。它首先检查子视图数组是否为空，如果为空则返回。然后，它计算子视图的最大尺寸和间距，然后遍历子视图数组，将每个子视图放置在布局容器中的适当位置。

calculateMaxSize 和 calculateSpacing 是两个私有方法，用于计算子视图的最大尺寸和间距。

