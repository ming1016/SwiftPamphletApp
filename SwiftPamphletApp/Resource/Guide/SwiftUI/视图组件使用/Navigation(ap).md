控制导航启动状态、管理 size class 之间的 transition 和响应 deep link。

Navigation bar 有新的默认行为，如果没有提供标题，导航栏默认为 inline  title 显示模式。使用 `navigationBarTitleDisplayMode(_:)` 改变显示模式。如果 navigation bar  没有标题、工具栏项或搜索内容，它就会自动隐藏。使用 `.toolbar(.visible)` modifier 显示一个空 navigation bar。

参考：
- [Migrating to New Navigation Types](https://developer.apple.com/documentation/swiftui/migrating-to-new-navigation-types?changes=latest_minor) 官方迁移指南
- [NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack?changes=latest_minor)
- [NavigationSplitView](https://developer.apple.com/documentation/swiftui/navigationsplitview)
- [The SwiftUI cookbook for navigation](https://developer.apple.com/videos/play/wwdc2022/10054/)

NavigationStack 的示例：
```swift
struct PNavigationStack: View {
    @State private var a = [1, 3, 9] // 深层链接
    var body: some View {
        NavigationStack(path: $a) {
            List(1..<10) { i in
                NavigationLink(value: i) {
                    Label("第 \(i) 行", systemImage: "\(i).circle")
                }
            }
            .navigationDestination(for: Int.self) { i in
                Text("第 \(i) 行内容")
            }
            .navigationTitle("NavigationStack Demo")
        }
    }
}
```

这里的 path 设置了 stack 的深度路径。

NavigationSplitView 两栏的例子：
```swift
struct PNavigationSplitViewTwoColumn: View {
    @State private var a = ["one", "two", "three"]
    @State private var choice: String?
    
    var body: some View {
        NavigationSplitView {
            List(a, id: \.self, selection: $choice, rowContent: Text.init)
        } detail: {
            Text(choice ?? "选一个")
        }
    }
}
```

NavigationSplitView 三栏的例子：
```swift
struct PNavigationSplitViewThreeColumn: View {
    struct Group: Identifiable, Hashable {
        let id = UUID()
        var title: String
        var subs: [String]
    }
    
    @State private var gps = [
        Group(title: "One", subs: ["o1", "o2", "o3"]),
        Group(title: "Two", subs: ["t1", "t2", "t3"])
    ]
    
    @State private var choiceGroup: Group?
    @State private var choiceSub: String?
    
    @State private var cv = NavigationSplitViewVisibility.automatic
    
    var body: some View {
        NavigationSplitView(columnVisibility: $cv) {
            List(gps, selection: $choiceGroup) { g in
                Text(g.title).tag(g)
            }
            .navigationSplitViewColumnWidth(250)
        } content: {
            List(choiceGroup?.subs ?? [], id: \.self, selection: $choiceSub) { s in
                Text(s)
            }
        } detail: {
            Text(choiceSub ?? "选一个")
            Button("点击") {
                cv = .all
            }
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
}
```

`navigationSplitViewColumnWidth() ` 是用来自定义宽的，`navigationSplitViewStyle` 设置为 `.prominentDetail` 是让 detail 的视图尽量保持其大小。

SwiftUI 新加了个[功能](https://developer.apple.com/documentation/swiftui/presentedwindowcontent/toolbar(_:in:))可以配置是否隐藏 Tabbar，这样在从主页进入下一级时就可以选择不显示底部标签栏了，示例代码如下：
```swift
ContentView().toolbar(.hidden, in: .tabBar)
```

相比较以前 NavigationView 增强的是 destination 可以根据值的不同类型展示不同的目的页面，示例代码如下：
```swift
struct PNavigationStackDestination: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: "字符串") {
                    Text("字符串")
                }
                NavigationLink(value: Color.red) {
                    Text("红色")
                }
            }
            .navigationTitle("不同类型 Destination")
            .navigationDestination(for: Color.self) { c in
                c.clipShape(Circle())
            }
            .navigationDestination(for: String.self) { s in
                Text("\(s) 的 detail")
            }
        }
    }
}
```

对 toolbar 的自定义，示例如下：
```swift
.toolbar(id: "toolbar") {
    ToolbarItem(id: "new", placement: .secondaryAction) {
        Button(action: {}) {
            Label("New Invitation", systemImage: "envelope")
        }
    }
}
.toolbarRole(.editor)
```

以下是废弃的 NavigationView 的用法。

![](https://user-images.githubusercontent.com/251980/155517358-4e5d54b8-0284-4fde-bf09-4b5e22e0e9a5.jpeg)

对应代码如下：

```swift
struct PlayNavigationView: View {
    let lData = 1...10
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                List(lData, id: \.self) { i in
                    NavigationLink {
                        PNavDetailView(contentStr: "\(i)")
                    } label: {
                        Text("\(i)")
                    }
                }
            }
            
            ZStack {
                LinearGradient(colors: [.mint, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Text("一个 NavigationView 的示例")
                        .bold()
                        .font(.largeTitle)
                        .shadow(color: .white, radius: 9, x: 0, y: 0)
                        .scaleEffect(2)
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Button("bottom1") {}
                    .font(.headline)
                    Button("bottom2") {}
                    Button("bottom3") {}
                    Spacer()
                }
                .padding(5)
                .background(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
        .foregroundColor(.white)
        .navigationTitle("数字列表")
        .toolbar {
            // placement 共有 keyboard、destructiveAction、cancellationAction、confirmationAction、status、primaryAction、navigation、principal、automatic 这些
            ToolbarItem(placement: .primaryAction) {
                Button("primaryAction") {}
                .background(.ultraThinMaterial)
                .font(.headline)
            }
            // 通过 ToolbarItemGroup 可以简化相同位置 ToolbarItem 的编写。
            ToolbarItemGroup(placement: .navigation) {
                Button("返回") {}
                Button("前进") {}
            }
            PCToolbar(doDestruct: {
                print("删除了")
            }, doCancel: {
                print("取消了")
            }, doConfirm: {
                print("确认了")
            })
            ToolbarItem(placement: .status) {
                Button("status") {}
            }
            ToolbarItem(placement: .principal) {
                Button("principal") {
                    
                }
            }
            ToolbarItem(placement: .keyboard) {
                Button("Touch Bar Button") {}
            }
        } // end toolbar
    }
}

// MARK: - NavigationView 的目的页面
struct PNavDetailView: View {
    @Environment(\.presentationMode) var pMode: Binding<PresentationMode>
    var contentStr: String
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text(contentStr)
                Button("返回") {
                    pMode.wrappedValue.dismiss()
                }
            }
        } // end ZStack
    } // end body
}

// MARK: - 自定义 toolbar
// 通过 ToolbarContent 创建可重复使用的 toolbar 组
struct PCToolbar: ToolbarContent {
    let doDestruct: () -> Void
    let doCancel: () -> Void
    let doConfirm: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .destructiveAction) {
            Button("删除", action: doDestruct)
        }
        ToolbarItem(placement: .cancellationAction) {
            Button("取消", action: doCancel)
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("确定", action: doConfirm)
        }
    }
}
```

toolbar 的位置设置可选项如下：

* primaryAction：放置到最主要位置，macOS 就是放在 toolbar 的最左边
* automatic：根据平台不同放到默认位置
* confirmationAction：一些确定的动作
* cancellationAction：取消动作
* destructiveAction：删除的动作
* status：状态变化，比如检查更新等动作
* navigation：导航动作，比如浏览器的前进后退
* principal：突出的位置，iOS 和 macOS 会出现在中间的位置
* keyboard：macOS 会出现在 Touch Bar 里。iOS 会出现在弹出的虚拟键盘上。
