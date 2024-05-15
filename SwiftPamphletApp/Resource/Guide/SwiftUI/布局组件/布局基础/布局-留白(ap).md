

## Space

`Spacer` 是一个灵活的空间，它会尽可能地占用多的空间，从而将其周围的视图推向堆栈的两边。因此，第一个 `Text` 视图会被推到左边，第二个 `Text` 视图会被推到中间，第三个 `Text` 视图会被推到右边。

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            Text("左边")
            Spacer()
            Text("中间")
            Spacer()
            Text("右边")
        }
    }
}
```

下面这个例子是用 Space() 让三个视图都居右。

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("视图1")
            Text("视图2")
            Text("视图3")
        }
    }
}
```


