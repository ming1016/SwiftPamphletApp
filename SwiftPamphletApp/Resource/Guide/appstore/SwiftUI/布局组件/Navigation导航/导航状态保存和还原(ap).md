
通过 SceneStorage 保存导航路径，程序终止时会持久化存储路径，重启时恢复路径。

```swift
protocol URLProcessor<RouteType> {
    associatedtype RouteType: Hashable
    func process(_ url: URL, mutating: inout [RouteType])
}

protocol UserActivityProcessor<RouteType> {
    associatedtype RouteType: Hashable
    func process(_ activity: NSUserActivity, mutating: inout [RouteType])
}

@Observable
@MainActor final class RouteManager<RouteType: Hashable> {
    var navigationPath: [RouteType] = []

    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    private let urlProcessor: any URLProcessor<RouteType>
    private let activityProcessor: any UserActivityProcessor<RouteType>

    init(
        urlProcessor: some URLProcessor<RouteType>,
        activityProcessor: some UserActivityProcessor<RouteType>
    ) {
        self.urlProcessor = urlProcessor
        self.activityProcessor = activityProcessor
    }

    func process(_ activity: NSUserActivity) {
        activityProcessor.process(activity, mutating: &navigationPath)
    }

    func process(_ url: URL) {
        urlProcessor.process(url, mutating: &navigationPath)
    }
}

extension RouteManager where RouteType: Codable {
    func toData() -> Data? {
        try? jsonEncoder.encode(navigationPath)
    }
    
    func restore(from data: Data) {
        do {
            navigationPath = try jsonDecoder.decode([RouteType].self, from: data)
        } catch {
            navigationPath = []
        }
    }
}

```

这段代码定义了一个名为 `RouteManager` 的类，它用于处理和管理导航路径。这个类使用了 SwiftUI 的 `@MainActor` 和 `@Observable` 属性包装器，以确保它的操作在主线程上执行，并且当 `navigationPath` 发生变化时，会自动更新相关的 UI。

`RouteManager` 类有两个协议类型的属性：`urlProcessor` 和 `activityProcessor`。这两个属性分别用于处理 URL 和用户活动（`NSUserActivity`）。这两个处理器的任务是根据给定的 URL 或用户活动，更新 `navigationPath`。

`RouteManager` 类还有两个方法：`process(_ activity: NSUserActivity)` 和 `process(_ url: URL)`。这两个方法分别用于处理用户活动和 URL。处理的方式是调用相应的处理器的 `process` 方法。

此外，`RouteManager` 类还有一个扩展，这个扩展只适用于 `RouteType` 是 `Codable` 的情况。这个扩展提供了两个方法：`toData()` 和 `restore(from data: Data)`。`toData()` 方法将 `navigationPath` 转换为 `Data`，`restore(from data: Data)` 方法则将 `Data` 转换回 `navigationPath`。这两个方法可以用于将 `navigationPath` 保存到磁盘，并在需要时从磁盘恢复。


```swift
struct MainView: View {
    @SceneStorage("navigationState") private var navigationData: Data?
    @State private var dataStore = DataStore()
    @State private var routeManager = RouteManager<Route>(
        urlProcessor: SomeURLProcessor(),
        activityProcessor: SomeUserActivityProcessor()
    )
    
    var body: some View {
        NavigationStack(path: $routeManager.navigationPath) {
            SomeView(categories: dataStore.categories)
                .task { await dataStore.fetch() }
                .navigationDestination(for: Route.self) { route in
                    // ...
                }
                .onOpenURL { routeManager.process($0) }
        }
        .task {
            if let navigationData = navigationData {
                routeManager.restore(from: navigationData)
            }
            
            for await _ in routeManager.$navigationPath.values {
                navigationData = routeManager.toData()
            }
        }
    }
}

```

`@SceneStorage("navigationState")` 是用来保存和恢复导航状态的。当应用程序被挂起时，它会自动将 `navigationData` 保存到磁盘，当应用程序重新启动时，它会自动从磁盘恢复 `navigationData`。

`@State private var dataStore = DataStore()` 和 `@State private var routeManager = RouteManager<Route>(...)` 是用来存储数据和路由管理器的。`DataStore` 是用来获取和存储数据的，`RouteManager` 是用来处理和管理导航路径的。

`body` 属性定义了视图的内容。它首先创建了一个 `NavigationStack`，然后在这个 `NavigationStack` 中创建了一个 `SomeView`。`SomeView` 使用了 `dataStore.categories` 作为它的参数，并且在被创建后立即执行 `dataStore.fetch()` 来获取数据。

`body` 属性还定义了一个任务，这个任务在视图被创建后立即执行。这个任务首先检查 `navigationData` 是否存在，如果存在，就使用 `routeManager.restore(from: navigationData)` 来恢复导航路径。然后，它监听 `routeManager.$navigationPath.values`，每当 `navigationPath` 发生变化时，就使用 `routeManager.toData()` 来将 `navigationPath` 转换为 `Data`，并将结果保存到 `navigationData` 中。
