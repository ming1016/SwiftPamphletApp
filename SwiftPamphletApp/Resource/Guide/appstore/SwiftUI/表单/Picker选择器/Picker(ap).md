![](https://ming1016.github.io/qdimg/240505/picker-ap01.jpeg)

SwiftUI 中的 `Picker` 视图是一个用于选择列表中的一个选项的用户界面元素。你可以使用 `Picker` 视图来创建各种类型的选择器，包括滚动选择器、弹出菜单和分段控制。

示例代码如下：

```swift
struct PlayPickerView: View {
    @State private var select = 1
    @State private var color = Color.red.opacity(0.3)
    
    var dateFt: DateFormatter {
        let ft = DateFormatter()
        ft.dateStyle = .long
        return ft
    }
    @State private var date = Date()
    
    var body: some View {
        
        // 默认是下拉的风格
        Form {
            Section("选区") {
                Picker("选一个", selection: $select) {
                    Text("1")
                        .tag(1)
                    Text("2")
                        .tag(2)
                }
            }
        }
        .padding()
        
        // Segment 风格，
        Picker("选一个", selection: $select) {
            Text("one")
                .tag(1)
            Text("two")
                .tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        
        // 颜色选择器
        ColorPicker("选一个颜色", selection: $color, supportsOpacity: false)
            .padding()
        
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 50, height: 50)
        
        // 时间选择器
        VStack {
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                Text("选时间")
            }
            
            DatePicker("选时间", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
            
            Text("时间：\(date, formatter: dateFt)")
        }
        .padding()
    }
}
```

上面的代码中，有三种类型的 `Picker` 视图：

1. 默认的下拉风格 `Picker` 视图。这种类型的 `Picker` 视图在 `Form` 中使用，用户可以点击选择器来打开一个下拉菜单，然后从菜单中选择一个选项。

```swift
Form {
    Section("选区") {
        Picker("选一个", selection: $select) {
            Text("1")
                .tag(1)
            Text("2")
                .tag(2)
        }
    }
}
```

2. 分段控制风格 `Picker` 视图。这种类型的 `Picker` 视图使用 `SegmentedPickerStyle()` 修饰符，它将选择器显示为一组水平排列的按钮，用户可以点击按钮来选择一个选项。

```swift
Picker("选一个", selection: $select) {
    Text("one")
        .tag(1)
    Text("two")
        .tag(2)
}
.pickerStyle(SegmentedPickerStyle())
```

3. `ColorPicker` 和 `DatePicker` 视图。这两种类型的视图是 `Picker` 视图的特殊形式，它们分别用于选择颜色和日期。

```swift
ColorPicker("选一个颜色", selection: $color, supportsOpacity: false)

DatePicker("选时间", selection: $date)
    .datePickerStyle(GraphicalDatePickerStyle())
```

在所有这些 `Picker` 视图中，你都需要提供一个绑定的选择状态，这个状态会在用户选择一个新的选项时更新。你还需要为每个选项提供一个视图和一个唯一的标签。


