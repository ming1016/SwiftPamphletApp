
## 搜索和搜索建议

你可以使用 `.searchable()` 修饰符的 `suggestions` 参数来提供搜索建议。以下是一个例子：

```swift
struct ContentView: View {
    @State private var searchText = ""
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    var body: some View {
        NavigationView {
            List {
                ForEach(items.filter({ searchText.isEmpty ? true : $0.contains(searchText) }), id: \.self) { item in
                    Text(item)
                }
            }
            .searchable(text: $searchText, suggestions: { 
                Button(action: {
                    searchText = "Item 1"
                }) {
                    Text("Item 1")
                }
                Button(action: {
                    searchText = "Item 2"
                }) {
                    Text("Item 2")
                }
            })
            .navigationBarTitle("Items")
        }
    }
}
```

在这个例子中，我们创建了一个包含五个元素的 List，并添加了一个搜索框。当用户在搜索框中输入文本时，List 会自动更新以显示匹配的元素。同时，我们提供了两个搜索建议 "Item 1" 和 "Item 2"，用户可以点击这些建议来快速填充搜索框。


## 在列表中显示搜索建议

```swift
struct ContentView: View {
    @Environment(\.searchSuggestionsPlacement) var placement
    @State private var searchText = ""
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        NavigationView {
            List {
                SearchSuggestionView()
                ForEach(items.filter({ searchText.isEmpty ? true : $0.contains(searchText) }), id: \.self) { item in
                    Text(item)
                }
            }
            .searchable(text: $searchText, suggestions: {
                VStack {
                    Button(action: {
                        searchText = "Item 1"
                    }) {
                        Text("Item 1")
                    }
                    Button(action: {
                        searchText = "Item 2"
                    }) {
                        Text("Item 2")
                    }
                }
                .searchSuggestions(.hidden, for: .content)
            })
            .navigationBarTitle("Items")
        }
    }
    
    @ViewBuilder
    func SearchSuggestionView() -> some View {
        if placement == .content {
            Button(action: {
                searchText = "Item 1"
            }) {
                Text("Item 1")
            }
            Button(action: {
                searchText = "Item 2"
            }) {
                Text("Item 2")
            }
        }
    }
}
```

## 搜索状态

搜索中

```swift
@Environment(\.isSearching) var isSearching
```

关闭搜索

```swift
@Environment(\.dismissSearch) var dismissSearch
```

提交搜索

```swift
List {
    ...
}
.searchable(text: $vm.searchTerm)
.onSubmit(of: .search) {
    //...
}
```

## 搜索栏外观

占位文字说明

```swift
.searchable(text: $wwdcVM.searchText, prompt: "搜索 WWDC Session 内容")
```

一直显示搜索栏

```swift
.searchable(text: $wwdcVM.searchText, 
            placement: .navigationBarDrawer(displayMode:.always))
```

更改搜索栏的位置

```swift
.searchable(text: $wwdcVM.searchText, placement: .sidebar)
```

## 搜索去抖动

你可以使用 Combine 框架来实现搜索的去抖动功能。以下是一个例子：

```swift
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [String] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] in self?.search($0) }
            .store(in: &cancellables)
    }

    private func search(_ text: String) {
        // 这里是你的搜索逻辑
        // 例如，你可以从一个数组中过滤出匹配的元素
        let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
        searchResults = items.filter { $0.contains(text) }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            TextField("Search", text: $viewModel.searchText)
                .padding()
            List(viewModel.searchResults, id: \.self) { result in
                Text(result)
            }
        }
    }
}
```

在这个例子中，我们创建了一个 `SearchViewModel` 类，它有一个 `searchText` 属性和一个 `searchResults` 属性。当 `searchText` 属性的值发生变化时，我们使用 Combine 的 `debounce(for:scheduler:)` 方法来延迟执行搜索操作，从而实现去抖动功能。然后我们在 `ContentView` 中使用这个 `SearchViewModel` 来显示搜索框和搜索结果。

