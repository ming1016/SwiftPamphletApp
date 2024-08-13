
本示例是一个可折叠的滚轮选择器 `CollapsibleWheelPicker`。这个选择器允许用户从一组书籍中选择一本。

```swift
struct ContentView: View {
  @State private var selection = 0
  let items = ["Book 1", "Book 2", "Book 3", "Book 4", "Book 5"]

  var body: some View {
    NavigationStack {
      Form {
        CollapsibleWheelPicker(selection: $selection) {
          ForEach(items, id: \.self) { item in
            Text("\(item)")
          }
        } label: {
          Text("Books")
          Spacer()
          Text("\(items[selection])")
        }
      }
    }
  }
}

struct CollapsibleWheelPicker<SelectionValue, Content, Label>: View where SelectionValue: Hashable, Content: View, Label: View {
    @Binding var selection: SelectionValue
    @ViewBuilder let content: () -> Content
    @ViewBuilder let label: () -> Label

    var body: some View {
        CollapsibleView(label: label) {
            Picker(selection: $selection, content: content) {
                EmptyView()
            }
            .pickerStyle(.wheel)
        }
    }
}

struct CollapsibleView<Label, Content>: View where Label: View, Content: View {
  @State private var isSecondaryViewVisible = false

  @ViewBuilder let label: () -> Label
  @ViewBuilder let content: () -> Content

  var body: some View {
    Group {
      Button(action: { isSecondaryViewVisible.toggle() }, label: label)
        .buttonStyle(.plain)
      if isSecondaryViewVisible {
        content()
      }
    }
  }
}

```

在 `ContentView` 中，我们创建了一个 `CollapsibleWheelPicker` 视图。这个视图包含一个滚轮样式的选择器，用户可以从中选择一本书。选择的书籍会绑定到 `selection` 变量。

`CollapsibleWheelPicker` 视图是一个可折叠的滚轮选择器，它接受一个绑定的选择变量、一个内容视图和一个标签视图。内容视图是一个 `Picker` 视图，用于显示可供选择的书籍。标签视图是一个 `Text` 视图，显示当前选择的书籍。
