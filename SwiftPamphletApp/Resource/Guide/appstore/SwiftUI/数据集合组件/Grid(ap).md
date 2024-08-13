
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
                    .gridCellColumns(2)
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

`gridCellAnchor` 可以让 GridRow 给自己设置对齐方式。

`gridCellColumns()`  modifier 可以让一个单元格跨多列。

GridRow 的间距通过 Grid 的 `horizontalSpacing` 和 `verticalSpacing` 参数来控制。

```swift
struct ContentView: View {
    let numbers: [[Int]] = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(numbers.indices, id: \.self) { i in
                GridRow {
                    ForEach(numbers[i].indices, id: \.self) { j in
                        Text("\(numbers[i][j])")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .border(Color.gray, width: 0.5)
                    }
                }
            }
        }
    }
}
```

按照以上代码这样写，每个数字 GridRow 之间的间隔就是0了。

空白的单元格可以这样写：

```swift
Color.clear
    .gridCellUnsizedAxes([.horizontal, .vertical])
```




