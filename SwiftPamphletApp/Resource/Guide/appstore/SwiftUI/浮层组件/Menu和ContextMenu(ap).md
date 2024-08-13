
## Menu 视图

`Menu` 视图可以用来创建一个菜单，比如创建相册或文件夹时的下拉选项。用户可以从中选择一个选项。以下是一个使用 `Menu` 的例子，其中包含一个子菜单：

```swift
struct ContentView: View {
    @State private var selectedComic = "漫画1"

    var body: some View {
        VStack {
            Text("当前选择的漫画是：\(selectedComic)")
                .padding()

            Menu {
                Button(action: { selectedComic = "漫画1" }) {
                    Text("漫画1")
                }

                Button(action: { selectedComic = "漫画2" }) {
                    Text("漫画2")
                }

                Menu {
                    Button(action: { selectedComic = "漫画3" }) {
                        Text("漫画3")
                    }

                    Button(action: { selectedComic = "漫画4" }) {
                        Text("漫画4")
                    }
                } label: {
                    Label("更多", systemImage: "folder.circle")
                }
            } label: {
                Label("选择漫画", systemImage: "ellipsis.circle")
            }
            .menuIndicator(.hidden)
            .menuOrder(.fixed) // 保持菜单列表顺序
            
        }
    }
}
```

## `.contextMenu`

`Menu` 视图可以用来创建一个菜单，用户可以从中选择一个选项。以下是一个使用 `Menu` 的例子：

```swift
struct Comic: Identifiable,Hashable {
    let id = UUID()
    let name: String
}

struct ContentView: View {
    let comics = [Comic(name: "漫画1"), Comic(name: "漫画2"), Comic(name: "漫画3")]

    var body: some View {
        Table(comics) {
            TableColumn("漫画名称", value: \.name)
        }
        .contextMenu(forSelectionType: Comic.ID.self) { comics in
            ControlGroup {
                Button("添加到收藏") { }
                Button("分享") { }
            }

            Button(role: .destructive) {
                // 删除动作
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
    }
}
```

