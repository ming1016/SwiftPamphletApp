
Grid 会将最大的一个单元格大小应用于所有单元格

代码例子：

```swift
struct ContentView: View {
    var body: some View {
        Grid(alignment: .center,
             horizontalSpacing: 30,
             verticalSpacing: 8) {
            GridRow {
                Text("Tropical")
                Text("Mango")
                Text("Pineapple")
            }
            GridRow(alignment: .bottom) {
                Text("Leafy")
                Text("Spinach")
                Text("Kale")
                Text("Lettuce")
            }
        }
    }
}
```

