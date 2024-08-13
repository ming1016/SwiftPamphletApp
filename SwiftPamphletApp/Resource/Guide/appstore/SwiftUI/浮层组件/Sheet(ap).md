

## 绑定到布尔值

下面代码示例的这个视图允许用户通过点击按钮来显示和隐藏详情。

```swift
struct DetailView: View {
    @Environment(\.dismiss) var close

    var body: some View {
        Button("点击关闭详情") {
            close()
        }
        .font(.headline)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
    }
}

struct MainView: View {
    @State private var showDetail = false

    var body: some View {
        Button("显示详情") {
            showDetail.toggle()
        }
        .sheet(isPresented: $showDetail) {
            DetailView()
        }
    }
}
```

在 `MainView` 中，我们定义了一个状态变量 `showDetail`，并将其初始化为 `false`。然后，我们创建了一个 `Button` 视图，当点击按钮时，`showDetail` 的值会切换。我们还添加了一个 `sheet` 修饰符，当 `showDetail` 为 `true` 时，会显示 `DetailView`。

`DetailView` 视图中会调用 `close` 方法来关闭详情。

用 `fullScreenCover()` 修饰符视图就会全屏显示, 会让向下拖动来关闭 Sheet 功能失效。另外，新增的 `interactiveDismissDisabled` 修饰符也可以用来禁用用户通过向下滑动来关闭 Sheet。


## 绑定到所选项目

```swift
struct ContentView: View {
    @State private var selectedBook: Book? = nil

    var body: some View {
        List(Book.simpleData(), selection: $selectedBook) { book in
            BookRow(book: book)
                .tag(book)
        }
        .sheet(item: $selectedBook,
               onDismiss: { print("查看结束!") },
               content: { BookDetailView(book: $0)
        })
    }
}

struct BookRow: View {
    let book: Book

    var body: some View {
        HStack {
            Text(book.title)
                .font(.headline)
            Spacer()
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct BookDetailView: View {
    let book: Book

    var body: some View {
        VStack {
            Text(book.title)
                .font(.largeTitle)
            Text(book.author)
                .font(.title)
                .foregroundColor(.gray)
            Text("评分: \(book.rating.rate, specifier: "%.1f") (\(book.rating.count) 人评价)")
                .font(.subheadline)
        }
        .padding()
    }
}

struct Book: Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let cover: String
    let rating: Rating
    
    static func simpleData() -> [Book] {
        return [
            Book(
                title: "斗罗大陆",
                author: "唐家三少",
                cover: "https://example.com/img/douluo.jpg",
                rating: Rating(rate: 4.8, count: 2000)
            ),
            Book(
                title: "盗墓笔记",
                author: "南派三叔",
                cover: "https://example.com/img/daomu.jpg",
                rating: Rating(rate: 4.7, count: 1800)
            ),
            Book(
                title: "鬼吹灯",
                author: "天下霸唱",
                cover: "https://example.com/img/guichui.jpg",
                rating: Rating(rate: 4.6, count: 1900)
            ),
            Book(
                title: "三体",
                author: "刘慈欣",
                cover: "https://example.com/img/santi.jpg",
                rating: Rating(rate: 4.9, count: 2100)
            ),
            Book(
                title: "神雕侠侣",
                author: "金庸",
                cover: "https://example.com/img/shendiao.jpg",
                rating: Rating(rate: 4.8, count: 2200)
            )
        ]
    }
}

struct Rating: Hashable {
    let rate: Double
    let count: Int
}
```

在上面的代码中，我们创建了一个 `Book` 结构体，它包含了书籍的标题、作者、封面图片和评分。我们还创建了一个 `Rating` 结构体，用于表示书籍的评分。然后，我们创建了一个 `BookRow` 视图，用于显示书籍的标题和作者。在 `ContentView` 中，我们创建了一个 `List` 视图，用于显示书籍列表。我们使用 `selection` 修饰符来绑定所选的书籍。然后，我们使用 `sheet(item:onDismiss:content:)` 修饰符来显示所选书籍的详细信息。在 `BookDetailView` 中，我们显示了书籍的标题、作者和评分。



## presentationDetents

SwiftUI 新推出的 `presentationDetents()` modifier 可以创建一个可以定制的 bottom sheet。示例代码如下：

```swift
struct ContentView: View {
    @State private var books = Book.simpleData()
    @State private var selectedBook: Book? = nil
    @State private var currentDetent = PresentationDetent.large

    var body: some View {
        List(books, selection: $selectedBook) { book in
            BookRow(book: book)
                .tag(book)
        }
        .sheet(item: $selectedBook,
               onDismiss: { print("查看结束!") },
               content: { book in
                   BookDetailView(book: book)
                       .presentationDetents([.medium, .large, .fraction(0.8), .height(200)],
                                            selection: $currentDetent)
               })
    }
}
```

detent 默认值是 `.large`。也可以提供一个百分比，比如 `.presentationDetents([.fraction(0.7)])`，或者直接指定高度 `.presentationDetents([.height(100)])`。

以下是 detents 的配置：
- large: 全高
- medium: 半高
- fraction: 给出当前屏幕高度的百分比
- height: 给出绝对高度（以磅为单位）

presentationDragIndicator modifier 可以用来显示隐藏拖动标识。

更多 Detents 功能配置，参看下面例子

这是一个“显示音乐列表”的视图，包含一个自定义的 `MusicListView`。这个视图允许用户通过点击列表中的音乐来显示音乐的详细信息。

```swift
struct ContentView: View {
    @State private var showingMusicSheet = true

    var body: some View {
        MusicPlayerView()
        .sheet(isPresented: $showingMusicSheet) {
            ScrollView {
                // 在这里添加底部 Sheet 的内容
            }
            .interactiveDismissDisabled()
            .presentationDetents([.height(100), .medium, .large])
            .presentationBackgroundInteraction(
                .enabled(upThrough: .medium)
            )
        }
    }
}
```

在 `ContentView` 中，我们定义了一个状态变量 `showingMusicSheet`，并设置为 `true`，表示默认显示音乐列表。

然后，我们创建了一个 `MusicPlayerView` 视图，当 `showingMusicSheet` 为 `true` 时，会显示一个底部 Sheet ，该 Sheet 包含一个 `ScrollView`，你可以在其中添加你想要显示的内容。

我们使用了 `.interactiveDismissDisabled()` 修饰符来禁止用户通过向下滑动来关闭 Sheet 。我们使用了 `.presentationDetents([.height(100), .medium, .large])` 修饰符来设置 Sheet 的高度，用户可以通过向上和向下拖动来改变 Sheet 的高度。我们还使用了 `.presentationBackgroundInteraction(.enabled(upThrough: .medium))` 修饰符，允许用户在 Sheet 未完全打开时与父视图进行交互。

## 外观样式

presentationBackground 修饰符可以用来设置 Sheet 的背景颜色。示例代码如下：

```swift
.sheet(isPresented: $showMusicPlayerSettings) {
    MusicPlayerSettingsView()
        .presentationBackground(alignment: .bottom) {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .bottomLeading, endPoint: .topTrailing)
        }
}
```

改变背景颜色：

```swift
.presentationBackground(.red)
```

还可以使用材质：

```swift
.presentationBackground(.ultraThinMaterial)
```

设置背景：

```swift
.presentationBackground {
    Image("someCoverImage")
}
```

iOS 16+ 和 macOS 13+ 新增 presentationCornerRadius 修饰符。这个修饰符可以用来设置 sheet 视图的圆角半径。示例代码如下：

```swift
struct ContentView: View {
    @State private var isShowingShoppingCart = false

    var body: some View {
        Button(action: {
            isShowingShoppingCart = true
        }) {
            Text("查看购物车")
        }
        .sheet(isPresented: $isShowingShoppingCart) {
            ShoppingCartDetailView()
                .presentationBackground(alignment: .bottom) {
                    LinearGradient(colors: [Color.orange, Color.pink], startPoint: .bottomLeading, endPoint: .topTrailing)
                }
                .presentationCornerRadius(20)
        }
    }
}

struct ShoppingCartDetailView: View {
    // 假设我们有一个购物车模型，其中包含商品列表
    @State private var cartItems = ["商品1", "商品2", "商品3"]
    
    var body: some View {
        VStack {
            Text("购物车详情")
                .font(.title)
                .padding()
            
            List(cartItems, id: \.self) { item in
                Text(item)
            }
            .scrollContentBackground(.hidden)
            
            Text("总价: \(calculateTotalPrice())")
                .font(.title2)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
        .edgesIgnoringSafeArea(.all)
    }
    
    // 计算购物车中所有商品的总价
    func calculateTotalPrice() -> Int {
        // 这里我们只是返回一个固定的值作为示例
        return 100
    }
}
```

## 添加工具栏按钮

```swift
.toolbar {
    ToolbarItem(placement: .cancellationAction) {
        Button("关闭", systemImage: "xmark") {
            showSheet = false
        }
    }
}
```


## 多 Sheet

以下是一个示例，展示了如何在 SwiftUI 中使用多个 Sheet。在这个示例中，我们创建了一个 ContentView 视图，其中包含两个按钮，一个用于显示用户信息，另一个用于显示应用配置。当用户点击按钮时，会显示相应的 Sheet。

```swift
struct ContentView: View {
  enum ModalType: String, Identifiable {
    case userInfo, appConfig
    var id: String { rawValue }
  }
    
  @State private var selectedModal: ModalType?
    
  var body: some View {
    VStack {
      Button("查看用户信息", action: { selectedModal = .userInfo })
      Button("查看应用配置", action: { selectedModal = .appConfig })
    }
    .sheet(item: $selectedModal, content: createModalView)
  }
    
  @ViewBuilder
  func createModalView(_ modalType: ModalType) -> some View {
    switch modalType {
      case .userInfo:
        UserInfoView()
      case .appConfig:
        AppConfigView()
    }
  }
}

struct UserInfoView: View {
    var body: some View {
        VStack {
            Text("用户信息")
                .font(.title)
                .padding()

            // 在这里添加更多的用户信息
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct AppConfigView: View {
    var body: some View {
        VStack {
            Text("应用配置")
                .font(.title)
                .padding()

            // 在这里添加更多的应用配置信息
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
```
