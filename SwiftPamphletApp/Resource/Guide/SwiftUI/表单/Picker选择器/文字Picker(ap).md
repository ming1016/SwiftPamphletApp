
## 基本使用

文字 Picker 示例：

```swift
struct StaticDataPickerView: View {
    @State private var selectedCategory = "动作"

    var body: some View {
        VStack {
            Text("选择的类别: \(selectedCategory)")

            Picker("电影类别",
                 selection: $selectedCategory) {
                Text("动作")
                    .tag("动作")
                Text("喜剧")
                    .tag("喜剧")
                Text("剧情")
                    .tag("剧情")
                Text("恐怖")
                    .tag("恐怖")
            }
        }
    }
}
```

## 使用枚举

使用枚举来创建选取器的示例：

```swift
enum MovieCategory: String, CaseIterable, Identifiable {
    case action = "动作"
    case comedy = "喜剧"
    case drama = "剧情"
    case horror = "恐怖"
    var id: MovieCategory { self }
}

struct MoviePicker: View {
   @State private var selectedCategory: MovieCategory = .action

  var body: some View {
     Picker("电影类别", selection: $selectedCategory) {
        ForEach(MovieCategory.allCases) { category in
             Text(category.rawValue).tag(category)
       }
     }
   }
}
```


## 样式

SwiftUI 提供了多种内置的 `Picker` 样式，以改变 `Picker` 的外观和行为。以下是一些主要的 `Picker` 样式及其使用示例：

- `DefaultPickerStyle`：根据平台和环境自动调整样式。这是默认的 `Picker` 样式。

```swift
Picker("Label", selection: $selection) {
    ForEach(0..<options.count) {
        Text(self.options[$0])
    }
}
```

- `WheelPickerStyle`：以旋转轮的形式展示选项。在 iOS 上，这种样式会显示一个滚动的选择器。

```swift
Picker("Label", selection: $selection) {
    ForEach(0..<options.count) {
        Text(self.options[$0])
    }
}
.pickerStyle(WheelPickerStyle())
```

- `SegmentedPickerStyle`：将选项以分段控件的形式展示。这种样式会显示一个分段控制，用户可以在其中选择一个选项。

```swift
Picker("Label", selection: $selection) {
    ForEach(0..<options.count) {
        Text(self.options[$0])
    }
}
.pickerStyle(SegmentedPickerStyle())
```

- `InlinePickerStyle`：在列表或表格中内联展示选项。这种样式会在 `Form` 或 `List` 中显示一个内联的选择器。

```swift
Form {
    Picker("Label", selection: $selection) {
        ForEach(0..<options.count) {
            Text(self.options[$0])
        }
    }
    .pickerStyle(InlinePickerStyle())
}
```

- `MenuPickerStyle`：点击时以菜单的形式展示选项。这种样式会显示一个菜单，用户可以在其中选择一个选项。

```swift
Picker("Label", selection: $selection) {
    ForEach(0..<options.count) {
        Text(self.options[$0])
    }
}
.pickerStyle(MenuPickerStyle())
```

- `.navigationLink`：在 iOS 16+ 中，点击后进入下一个页面。这种样式会显示一个导航链接，用户可以点击它来打开一个新的视图。
- `.radioGrouped`：仅在 macOS 中可用，以单选按钮组的形式展示选项。这种样式会显示一个单选按钮组，用户可以在其中选择一个选项。

