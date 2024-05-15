
Inspector 的示例

```swift
struct Book: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var description: String
}

struct ContentView: View {
    @State var books: [Book] = [
        Book(title: "Book 1", author: "Author 1", description: "Description 1"),
        Book(title: "Book 2", author: "Author 2", description: "Description 2"),
        Book(title: "Book 3", author: "Author 3", description: "Description 3")
    ]
    @State var selectedBook: Book?
    @State var showInspector: Bool = false
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
            Button("Inspector 开关") {
                showInspector.toggle()
            }
            if let book = selectedBook {
                Text(book.description)
            } else {
                Text("Book details will appear here")
            }
        })
        .inspector(isPresented: $showInspector) {
            if let book = selectedBook {
                InspectorView(book: book)
            }
        }
    }
}

struct InspectorView: View {
    var book: Book

    var body: some View {
        VStack {
            Text(book.title).font(.largeTitle)
            Text("Author: \(book.author)").font(.title)
            Text(book.description).padding()
        }
        .inspectorColumnWidth(200)
        .presentationDetents([.medium, .large])
    }
}
```

它显示了一个图书列表。当用户选择一个图书时，会显示 InspectorView，这是辅助视图，它显示了图书的详细信息。inspector 方法用于显示和隐藏 InspectorView，inspectorColumnWidth 方法用于设置辅助视图的宽度，presentationDetents 方法用于设置辅助视图的大小。
