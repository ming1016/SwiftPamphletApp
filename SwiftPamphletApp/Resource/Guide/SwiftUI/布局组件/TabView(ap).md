```swift
struct PlayTabView: View {
    @State private var selection = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                Text("one")
                    .tabItem {
                        Text("首页")
                            .hidden()
                    }
                    .tag(0)
                Text("two")
                    .tabItem {
                        Text("二栏")
                    }
                    .tag(1)
                Text("three")
                    .tabItem {
                        Text("三栏")
                    }
                    .tag(2)
                Text("four")
                    .tag(3)
                Text("five")
                    .tag(4)
                Text("six")
                    .tag(5)
                Text("seven")
                    .tag(6)
                Text("eight")
                    .tag(7)
                Text("nine")
                    .tag(8)
                Text("ten")
                    .tag(9)
            } // end TabView
            
            
            HStack {
                Button("上一页") {
                    if selection > 0 {
                        selection -= 1
                    }
                }
                .keyboardShortcut(.cancelAction)
                Button("下一页") {
                    if selection < 9 {
                        selection += 1
                    }
                }
                .keyboardShortcut(.defaultAction)
            } // end HStack
            .padding()
        }
    }
}
```

.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) 可以实现 UIPageViewController 的效果，如果要给小白点加上背景，可以多添加一个 .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) 修改器。
