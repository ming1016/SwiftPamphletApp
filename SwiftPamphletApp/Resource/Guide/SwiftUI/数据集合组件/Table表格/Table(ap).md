


今年 iOS 和 iPadOS 也可以使用去年只能在 macOS 上使用的 Table了，据 digital lounges 里说，iOS table 的性能和 list 差不多，table 默认为 plian list。我想 iOS 上加上 table 只是为了兼容 macOS 代码吧。

table 使用示例如下：
```swift
struct ContentView: View {
    var body: some View {
        Table(Fruit.simpleData()) {
            TableColumn("名字", value: \.name)
            TableColumn("颜色", value: \.color)
            TableColumn("颜色") {
                Text("\($0.name)")
                    .font(.footnote)
                    .foregroundStyle(.cyan)
            }
        }
        .contextMenu(forSelectionType: Fruit.ID.self) { selection in
            if selection.isEmpty {
                Button("添加") {
                    // ...
                }
            } else if selection.count == 1 {
                Button("收藏") {
                    // ...
                }
            } else {
                Button("收藏多个") {
                    // ...
                }
            }
        }
    }
    
    struct Fruit:Identifiable {
        let id = UUID()
        let name: String
        let color: String
        
        static func simpleData() -> [Fruit] {
            var re = [Fruit]()
            re.append(Fruit(name: "Apple", color: "Red"))
            re.append(Fruit(name: "Banana", color: "Yellow"))
            re.append(Fruit(name: "Cherry", color: "Red"))
            re.append(Fruit(name: "Date", color: "Brown"))
            re.append(Fruit(name: "Elderberry", color: "Purple"))
            return re
        }
    }
}
```

