


## 交互样式

使用 `navigationSplitViewStyle(_:)` 修饰符

## 改变标签栏背景色

```swift
.toolbarBackground(.yellow.gradient, for: .automatic)
.toolbarBackground(.visible, for: .automatic)
```

## 列宽

 `navigationSplitViewColumnWidth(_:)` 修饰符用于指定列宽。

 设置列的最小、最大和理想大小，使用 `navigationSplitViewColumnWidth(min:ideal:max:)`。可以修饰于不同的列上。

## 自定返回按钮

先通过修饰符隐藏系统返回按钮 `.navigationBarBackButtonHidden(true)`。然后通过 `ToolbarItem(placement: .navigationBarLeading)` 来添加自定义的返回按钮。

```swift
struct BookDetailView: View {
    var book: Book
    @Binding var isDetailShown: Bool

    var body: some View {
        VStack {
            Text(book.title).font(.largeTitle)
            Text("Author: \(book.author)").font(.title)
            Text(book.description).padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(book.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isDetailShown = false
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back to Books")
                    }
                }
            }
        }
    }
}
```
