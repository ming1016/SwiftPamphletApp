
## Text 视图动态时间

利用 Text 的动态时间能力

## timeline 动画

timeline 是由一组时间和数据组成的，每次刷新时，小组件通过和上次数据不一致加入动画效果。

默认情况小组件使用的是弹簧动画。我们也可以添加转场（Transition）、动画（Animation）和内容过渡（Content Transition）动画效果。

## 文本内容过渡动画效果

```swift
.contentTransition(.numericText(value: rate))
```

## 从底部翻上来的专场

```swift
.transition(.push(from: .bottom))
```
