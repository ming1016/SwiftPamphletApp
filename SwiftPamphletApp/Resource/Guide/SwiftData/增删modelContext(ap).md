
## 添加保存数据

```swift
struct SomeView: View {
   @Environment(\.modelContext) var context
   ...

   var body: some View {
         ...
         Button(action: {
             self.add()
         }, label: {
             Text("添加")
         })
   }

   func add() {
      ...
      context.insert(article)
   }
}
```

默认不用使用 `context.save()`，SwiftData 会自动进行保存，如果不想自动保存，可以在容器中设置

```swift
var body: some Scene {
   WindowGroup {
      ContentView()
   }
   .modelContainer(for: Article.self, isAutosaveEnabled: false)       
}
```

## 编辑和删除数据

编辑数据使用 `@Bindable`。

```swift
struct SomeView: View {
    @Bindable var article: Article
    @Environment(\.modelContext) private var modelContext
    ...
    
    var body: some View {
        Form {
            TextField("文章标题", text: $article.title)
            ...
        }
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("删除") {
                    modelContext.delete(article)
                }
            }
        }
        ...
    }
}
```
