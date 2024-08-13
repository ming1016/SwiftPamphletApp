


| 控件视图 | 说明 | Style |
| --- | --- | --- |
| Button | 触发操作的按钮 | .bordered, .borderless, .borderedProminent, .plain |
| Picker | 提供多选项供选择 | .wheel, .inline, .segmented, .menu, .radioGroup |
| DatePicker and MultiDatePicker | 选择日期的工具 | .compact, .wheel, .graphical |
| Toggle | 切换两种状态的开关 | .switch, .botton, .checkbox |
| Stepper | 调整数值的步进器 | 无样式选项 |
| Menu | 显示选项列表的菜单 | .borderlessButton, .button |

Form 有 ColumnFormStyle 还有 GroupedFormStyle。使用 buttonStyle 修饰符：
```swift
Form {
   ...
}.formStyle(.grouped)
```

Form 新版也得到了增强，示例如下：

```swift
struct SimpleFormView: View {
    @State private var date = Date()
    @State private var eventDescription = ""
    @State private var accent = Color.red
    @State private var scheme = ColorScheme.light

    var body: some View {
        Form {
            Section {
                DatePicker("Date", selection: $date)
                TextField("Description", text: $eventDescription)
                    .lineLimit(3)
            }
            
            Section("Vibe") {
                Picker("Accent color", selection: $accent) {
                    ForEach(Color.accentColors, id: \.self) { color in
                        Text(color.description.capitalized).tag(color)
                    }
                }
                Picker("Color scheme", selection: $scheme) {
                    Text("Light").tag(ColorScheme.light)
                    Text("Dark").tag(ColorScheme.dark)
                }
            }
        }
        .formStyle(.grouped)
    }
}

extension Color {
    static let accentColors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
}
```

Form 的样式除了 `.formStyle(.grouped)` 还有 `.formStyle(..columns)`。

关于 Form 字体、单元、背景颜色设置，参看下面代码：

```swift
struct ContentView: View {
    @State private var movieTitle = ""
    @State private var isWatched = false
    @State private var rating = 1
    @State private var watchDate = Date()

    var body: some View {
        Form {
            Section {
                TextField("电影标题", text: $movieTitle)
                LabeledContent("导演", value: "克里斯托弗·诺兰")
            } header: {
                Text("关于电影")
            }
            .listRowBackground(Color.gray.opacity(0.1))

            Section {
                Toggle("已观看", isOn: $isWatched)
                Picker("评分", selection: $rating) {
                    ForEach(1...5, id: \.self) { number in
                        Text("\(number) 星")
                    }
                }

            } header: {
                Text("电影详情")
            }
            .listRowBackground(Color.gray.opacity(0.1))
            
            Section {
                DatePicker("观看日期", selection: $watchDate)
            }
            .listRowBackground(Color.gray.opacity(0.1))
            
            Section {
                Button("重置所有电影数据") {
                    resetAllData()
                }
            }
            .listRowBackground(Color.white)
        }
        .foregroundColor(.black)
        .tint(.indigo)
        .background(Color.yellow)
        .scrollContentBackground(.hidden)
        .navigationBarTitle("电影追踪器")
    }
    
    private func resetAllData() {
        movieTitle = ""
        isWatched = false
        rating = 1
        watchDate = Date()
    }
}

struct LabeledContent: View {
    let label: String
    let value: String

    init(_ label: String, value: String) {
        self.label = label
        self.value = value
    }

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
    }
}
```

