
以下是一个基于 NavigationSplitView 的三栏视图的示例。这个示例包含了一个主视图，一个次级视图和一个详细视图。

```swift
struct ContentView: View {
    @State var books: [Book] = [
        Book(title: "Book 1", author: "Author 1", description: "Description 1"),
        Book(title: "Book 2", author: "Author 2", description: "Description 2"),
        Book(title: "Book 3", author: "Author 3", description: "Description 3")
    ]
    @State var selectedBook: Book?
    @State var splitVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $splitVisibility, sidebar: {
            List(books) { book in
                Button(action: { selectedBook = book }) {
                    Text(book.title)
                }
            }
        }, content: {
            if let book = selectedBook {
                Text("Author: \(book.author)")
            } else {
                Text("Select a Book")
            }
        }, detail: {
            if let book = selectedBook {
                Text(book.description)
            } else {
                Text("Book details will appear here")
            }
        })
        .onChange(of: selectedBook) { oldValue, newValue in
            //...
        }
    }
}

struct Book: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var author: String
    var description: String
}
```

示例中，`sidebar` 是主视图，它显示了一个图书列表。当用户选择一个图书时，`content` 视图会显示图书的作者，`detail` 视图会显示图书的详细信息。`NavigationSplitView` 会根据 `splitVisibility` 的值来决定显示哪些视图。

使用 `.toolbar(removing: .sidebarToggle)` 可以移除边栏隐藏的按钮。
