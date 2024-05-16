
## 基本用法

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

## 添加提醒

```swift
struct ContentView: View {
    @State private var bookVm: BooksViewModel
    
    init() {
        bookVm = BooksViewModel()
    }
    
    var body: some View {
        TabView {
            BookListView(bookVm: bookVm)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Book List")
                }
            SelectedBooksView(bookVm: bookVm)
                .badge(bookVm.selectedBooks.count)
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Selected Books")
                }
        }
    }
}
```

## 自定义样式

iOS 14 和 macOS 11 开始可以使用 tabViewStyle 修饰符更改 TabView 样式。比如有页面指示器的水平滚动图片。

显示页面指示器：

```swift
.tabViewStyle(.page(indexDisplayMode: .always))
```

`.tabViewStyle(.page(indexDisplayMode: .never))` 修饰符隐藏页面指示器。

水平滚动图片：

```swift
struct ContentView: View {
    let images = ["pencil", "scribble", "highlighter"]

    var body: some View {
        VStack {
            TabView {
                ForEach(images, id: \.self) { imageName in
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 100)
        }
    }
}
```

分页视图

```swift
struct OnboardingView: View {
    var body: some View {
        TabView {
            OnboardingPageView(imageName: "figure.mixed.cardio",
                               title: "Welcome",
                               description: "Welcome to MyApp! Get started by exploring our amazing features.")

            OnboardingPageView(imageName: "figure.archery",
                               title: "Discover",
                               description: "Discover new content and stay up-to-date with the latest news and updates.")

            OnboardingPageView(imageName: "figure.yoga",
                               title: "Connect",
                               description: "Connect with friends and share your experiences with the community.")
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
```

`.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))` 修饰符添加了背景。这将在点周围添加一个背景，使其在任何背景下都更容易看到。

## 背景颜色

iOS 16 和 macOS 13 开始可以更改 TabView 的背景颜色。

```swift
struct MainScreen: View {
    var body: some View {
        TabView {
            NavigationView {
                BookListView()
                    .navigationTitle("图书列表")
                    .toolbarBackground(.yellow, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
            }
            .tabItem {
                Label("图书", systemImage: "book.closed")
            }

            UserPreferencesView()
                .tabItem {
                    Label("设置", systemImage: "gearshape")
                }
            .toolbarBackground(.indigo, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

struct BookListView: View {
    var body: some View {
        Text("这里是图书列表")
    }
}

struct UserPreferencesView: View {
    var body: some View {
        Text("这里是用户设置")
    }
}
```
