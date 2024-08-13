
## 多模型

配置方法

```swift
@main
struct SomeApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Article.self, Author.self])
    }
}
```

有关系的两个模型，只需要加父模型，SwiftData 会推断出子模型。

## 数据存内存

```swift
let configuration = ModelConfiguration(inMemory: true)
let container = try ModelContainer(for: schema, configurations: [configuration])
```

## 数据只读

```swift
let config = ModelConfiguration(allowsSave: false)
```

## 自定义存储文件和位置

如果要指定数据库存储的位置，可以按下面写法：

```swift
@main
struct SomeApp: App {
    var container: ModelContainer

    init() {
        do {
            let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")
            let config = ModelConfiguration(url: storeURL)
            container = try ModelContainer(for: Article.self, configurations: config)
        } catch {
            fatalError("Failed")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
```

## iCloud 支持

如果要添加 iCloud 支持，需要先确定模型满足以下条件：
- 没有唯一约束
- 关系是可选的
- 有所值有默认值

iCloud 支持操作步骤：
- 进入 Signing & Capabilities 中，在 Capability 里选择 iCloud
- 选中 CloudKit 旁边的框
- 设置 bundle identifier
- 再按 Capability，选择 Background Modes
- 选择 Remote Notifications

## 指定部分表同步到 iCloud

使用多个 ModelConfiguration 对象来配置，这样可以指定哪个配置成同步到 iCloud，哪些不同步。

## 添加多个配置

```swift
@main
struct SomeApp: App {
    var container: ModelContainer
    init() {
        do {
            let c1 = ModelConfiguration(for: Article.self)
            let c2 = ModelConfiguration(for: Author.self, isStoredInMemoryOnly: true)
            container = try ModelContainer(for: Article.self, Author.self, configurations: c1, c2)
        } catch {
            fatalError("Failed")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
```

## 撤销和重做

创建容器时进行指定
```swift
.modelContainer(for: Article.self, isUndoEnabled: true)
```

这样 modelContext 就可以调用撤销和重做函数。
```swift
struct SomeView: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        Button(action: {
            context.undoManager?.undo()
        }, label: {
            Text("撤销")
        })
    }
}
```

## context

View 之外的地方，可以通过 ModelContainer 的 context 属性来获取 modelContext。

```swift
let context = container.mainContext
let context = ModelContext(container)
```

## 预先导入数据

方法如下：

```swift
.modelContainer(for: Article.self) { result in
    do {
        let container = try result.get()

        // 先检查有没数据
        let descriptor = FetchDescriptor<Article>()
        let existingArticles = try container.mainContext.fetchCount(descriptor)
        guard existingArticles == 0 else { return }

        // 读取 bundle 里的文件
        guard let url = Bundle.main.url(forResource: "articles", withExtension: "json") else {
            fatalError("Failed")
        }

        let data = try Data(contentsOf: url)
        let articles = try JSONDecoder().decode([Article].self, from: data)

        for article in articles {
            container.mainContext.insert(article)
        }
    } catch {
        print("Failed")
    }
}
```
