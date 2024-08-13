

## 内置样式

通过 `.listStyle` 修饰符可以用系统内置样式更改 List 外观。

```swift
List {
   ...
}
.listStyle(.sidebar)
```

不同平台有不同的选项


| ListStyle    | iOS     | macOS        | watchOS    | tvOS     |
| ------------ | ------- | ------------ | ---------- | -------- |
| plain        | iOS 13+ | macOS 10.15+ | watchOS 6+ | tvOS 13+ |
| sidebar      | iOS 14+ | macOS 10.15+ | -          | -        |
| inset        | iOS 13+ | macOS 11.15+ | -          | -        |
| grouped      | iOS 13+ | -            | -          | tvOS 13+ |
| insetGrouped | iOS 14+ | -            | -          | -        |
| bordered     | -       | macOS 12+    | -          | -        |
| carousel     | -       | -            | watchOS 6+ | -        |
| elliptical   | -       | -            | watchOS 7+ | -        |


## 行高

```swift
List {
  ...
}
.environment(\.defaultMinListRowHeight, 100)
.environment(\.defaultMinListHeaderHeight, 50)
```

## 分隔符

listSectionSeparator 和 listRowSeparator 隐藏行和 Section 分隔符。

listRowSeparatorTint 和 listSectionSeparatorTint 更改分隔符颜色

例如：

```swift
.listRowSeparatorTint(.cyan, edges: .bottom)
```

## 背景

`.alternatingRowBackgrounds()` 可以让 List 的行底色有区分。

listRowBackground 调整行的背景颜色

更改背景颜色前需要隐藏内容背景

```swift
List {
  ...
}
.scrollContentBackground(.hidden)
.background(Color.cyan)
```

这个方法同样可用于 ScrollView 和 TextEditor。

你可以使用 `.listRowBackground()` 修饰符来更改列表行的背景。以下是一个例子：

```swift
struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<5) { index in
                Text("Row \(index)")
                    .listRowBackground(index % 2 == 0 ? Color.blue : Color.green)
            }
        }
    }
}
```

在这个例子中，我们创建了一个包含五个元素的 List。我们使用 `.listRowBackground()` 修饰符来更改每个元素的背景颜色。如果元素的索引是偶数，我们将背景颜色设置为蓝色，否则我们将背景颜色设置为绿色。

## Section

你可以使用 `Section` 视图的 `header` 和 `footer` 参数来添加头部和尾部。以下是一个例子：

```swift
struct ContentView: View {
    var body: some View {
        List {
            Section {
                ForEach(0..<5) { index in
                    Text("Row \(index)")
                }
            } header: {
                Text("Header").font(.title)
            } footer: {
                Text("Footer").font(.caption)
            }
        }
    }
}
```

headerProminence（.increase） 可以增加 Section Header 的大小。

## safeAreaInset

你可以使用 `.safeAreaInset()` 修饰符来调整视图的安全区域插入。以下是一个例子：

```swift
struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<5) { index in
                Text("Row \(index)")
            }
        }
        .safeAreaInset(edge: .top, spacing: 20) {
            Text("Header")
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
        }
    }
}
```

在这个例子中，我们创建了一个包含五个元素的 List。然后我们使用 `.safeAreaInset()` 修饰符来在 List 的顶部添加一个 Header。我们将 `edge` 参数设置为 `.top`，将 `spacing` 参数设置为 20，然后提供一个视图作为 Header。这个 Header 是一个文本视图，它的背景颜色是蓝色，前景颜色是白色，它被居中对齐，并且它的宽度和 List 的宽度相同。
