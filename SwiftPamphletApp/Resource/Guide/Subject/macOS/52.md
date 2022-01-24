三栏结构架子搭建，代码如下：

```swift
import SwiftUI
struct SwiftPamphletApp: View {
    var body: some View {
        NavigationView {
            SPSidebar()
            Text("第二栏")
            Text("第三栏")
        }
        .navigationTitle("Swift 小册子")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                } label: {
                    Label("Sidebar", systemImage: "sidebar.left")
                }
            }
        }
    }
}
struct SPSidebar: View {
    var body: some View {
        List {
            Section("第一组") {
                NavigationLink("第一项", destination: SPList(title: "列表1"))
                    .badge(3)
                NavigationLink("第二项", destination: SPList(title: "列表2"))
            }
            Section("第二组") {
                NavigationLink("第三项", destination: SPList(title: "列表3"))
                NavigationLink("第四项", destination: SPList(title: "列表4"))
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 160)
        .toolbar {
            ToolbarItem {
                Menu {
                    Text("1")
                    Text("2")
                } label: {
                    Label("Label", systemImage: "slider.horizontal.3")
                }
            }
        }
    }
}
struct SPList: View {
    var title: String
    @State var searchText: String = ""
    var body: some View {
        List(0..<3) { i in
            Text("内容\(i)")
        }
        .toolbar(content: {
            Button {
                //
            } label: {
                Label("Add", systemImage: "plus")
            }
        })
        .navigationTitle(title)
        .navigationSubtitle("副标题")
        .searchable(text: $searchText)
    }
}
```

显示效果如下：
![](https://user-images.githubusercontent.com/251980/142977421-bed5b5ae-01fe-471f-a951-63dd4338c97a.png)

