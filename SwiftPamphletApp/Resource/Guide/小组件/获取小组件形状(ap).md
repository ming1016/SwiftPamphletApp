
不同设备小组件大小和形状都不同，比如要加个边框，就很困难。这就需要使用 `ContainerRelativeShape` 来获取 Shape 视图容器。

```swift
var body: some View {
  ZStack {
    ContainerRelativeShape()
        .inset(by: 2)
        .fill(.pink)
    Text("Hello world")
    ...
  }
}
```

