
## List 树状结构

通过 children 参数指定子树路径。

```swift
List(outlineModel, children: \.children) { i in
    Label(i.title, systemImage: i.iconName)
}
```

## DisclosureGroup 实现展开和折叠

`DisclosureGroup` 视图可以用来创建一个可以展开和折叠的内容区域。以下是一个例子：

```swift
struct ContentView: View {
    @State private var isExpanded = false

    var body: some View {
        DisclosureGroup("Options", isExpanded: $isExpanded) {
            Text("Option 1")
            Text("Option 2")
            Text("Option 3")
        }
    }
}
```

在这个例子中，我们创建了一个 `DisclosureGroup` 视图，它的标题是 "Options"，并且它包含三个选项。我们使用一个 `@State` 属性 `isExpanded` 来控制 `DisclosureGroup` 视图是否展开。当用户点击标题时，`DisclosureGroup` 视图会自动展开或折叠，同时 `isExpanded` 属性的值也会相应地改变。

## OutlineGroup 创建大纲视图

可以使用 `OutlineGroup` 视图来创建一个大纲视图。以下是一个例子：

```swift
struct ContentView: View {
    var body: some View {
        List {
            OutlineGroup(sampleData, id: \.self) { item in
                Text(item.name)
            }
        }
    }
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var children: [Item]?
}

let sampleData: [Item] = [
    Item(name: "Parent 1", children: [
        Item(name: "Child 1"),
        Item(name: "Child 2")
    ]),
    Item(name: "Parent 2", children: [
        Item(name: "Child 3"),
        Item(name: "Child 4")
    ])
]
```

在这个例子中，我们创建了一个 `Item` 结构体，它有一个 `name` 属性和一个 `children` 属性。然后我们创建了一个 `sampleData` 数组，它包含两个父项，每个父项都有两个子项。最后我们在 `ContentView` 中使用 `OutlineGroup` 视图来显示这个数组，每个父项和子项都显示为一个文本视图。


## 结合 OutlineGroup 和 DisclosureGroup 实现自定义可折叠大纲视图

代码如下：
```swift
struct SPOutlineListView<D, Content>: View where D: RandomAccessCollection, D.Element: Identifiable, Content: View {
    private let v: SPOutlineView<D, Content>
    
    init(d: D, c: KeyPath<D.Element, D?>, content: @escaping (D.Element) -> Content) {
        self.v = SPOutlineView(d: d, c: c, content: content)
    }
    
    var body: some View {
        List {
            v
        }
    }
}

struct SPOutlineView<D, Content>: View where D: RandomAccessCollection, D.Element: Identifiable, Content: View {
    let d: D
    let c: KeyPath<D.Element, D?>
    let content: (D.Element) -> Content
    @State var isExpanded = true // 控制初始是否展开的状态
    
    var body: some View {
        ForEach(d) { i in
            if let sub = i[keyPath: c] {
                SPDisclosureGroup(content: SPOutlineView(d: sub, c: c, content: content), label: content(i))
            } else {
                content(i)
            } // end if
        } // end ForEach
    } // end body
}

struct SPDisclosureGroup<C, L>: View where C: View, L: View {
    @State var isExpanded = false
    var content: C
    var label: L
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            content
        } label: {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                label
            }
            .buttonStyle(.plain)
        }
        
    }
}
```
