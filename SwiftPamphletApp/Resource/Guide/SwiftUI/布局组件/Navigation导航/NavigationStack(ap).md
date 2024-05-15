
## 使用示例

假设我们有一个 TVShow 结构体和一个 Book 结构体，它们分别包含电视剧和书籍的名字。当用户点击一个电视剧或书籍的名字时，他们会被导航到相应的详细信息页面。

以下是一个例子：

```swift
struct TVShow: Hashable {
    let name: String
}

struct Book: Hashable {
    let name: String
}

struct ContentView: View {
    @State var tvShows = [TVShow(name: "Game of Thrones"), TVShow(name: "Breaking Bad")]
    @State var books = [Book(name: "1984"), Book(name: "To Kill a Mockingbird")]

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Best TV Shows"))  {
                    ForEach(tvShows, id: \.name) { show in
                        NavigationLink(value: show, label: {
                            Text(show.name)
                        })
                    }
                }
                Section(header: Text("Books"))  {
                    ForEach(books, id: \.name) { book in
                        NavigationLink(value: book, label: {
                            Text(book.name)
                        })
                    }
                }
            }
            .navigationDestination(for: TVShow.self) { show in
                TVShowView(show: show)
            }
            .navigationDestination(for: Book.self) { book in
                BookView(book: book)
            }
            .navigationTitle(Text("Media"))
        }
    }
}

struct TVShowView: View {
    let show: TVShow

    var body: some View {
        Text("Details for \(show.name)")
    }
}

struct BookView: View {
    let book: Book

    var body: some View {
        Text("Details for \(book.name)")
    }
}
```

## 全局路由

先写个路由的枚举

```swift
enum Route: Hashable {
    case all
    case add(Book)
    case detail(Book)
}

struct Book {
    let name: String
    let des: String
}
```

在 App 中设置好全局路由

```swift
@main
struct LearnNavApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .all:
                                Text("显示所有图书")
                            case .create(let book):
                                Text("添加书 \(book.name)")
                            case .detail(let book):
                                Text("详细 \(book.des)")
                        }
                    }
            }
                
        }
    }
}
```

所有视图都可调用，调用方式如下：

```swift
NavigationLink("查看书籍详细说明", value: Route.detail(Book(name: "1984", des: "1984 Detail")))
```

