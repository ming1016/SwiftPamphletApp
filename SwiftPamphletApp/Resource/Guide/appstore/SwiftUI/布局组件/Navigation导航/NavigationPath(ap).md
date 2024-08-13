
`NavigationPath` 是一个用于管理 SwiftUI 中导航路径的工具。它可以帮助你在 SwiftUI 中实现更复杂的导航逻辑。

在 SwiftUI 中，我们通常使用 `NavigationLink` 来实现导航。然而，`NavigationLink` 只能实现简单的前进导航，如果你需要实现更复杂的导航逻辑，例如后退、跳转到任意页面等，你就需要使用 `NavigationPath`。

`NavigationPath` 的工作原理是，它维护了一个路径数组，每个元素代表一个页面。当你需要导航到一个新的页面时，你只需要将这个页面添加到路径数组中。当你需要后退时，你只需要从路径数组中移除最后一个元素。这样，你就可以实现任意复杂的导航逻辑。

看个例子

假设我们有一个 TVShow 结构体，它包含电视剧的名字。当用户点击一个电视剧的名字时，他们会被导航到这个电视剧的详细信息页面。

```swift
struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var tvShows = [ TVShow(name: "Game of Thrones"), TVShow(name: "Breaking Bad"), TVShow(name: "The Witcher") ]

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Text("Select a TV show to get started.")
                    .font(.subheadline.weight(.semibold))
                ForEach(tvShows, id: \.name) { show in
                    NavigationLink(value: show, label: {
                        Text(show.name)
                            .font(.subheadline.weight(.medium))
                    })
                }
                Button(action: showFriends) {
                    Text("This isn't navigation")
                }
            }
            .navigationDestination(for: TVShow.self, destination: { show in
                TVShowView(onSelectReset: { popToRoot() }, show: show, otherShows: tvShows)
            })
            .navigationTitle(Text("Select your show"))
        }
        .onChange(of: path.count) { oldValue, newValue in
            print(newValue)
        }
    }

    func showFriends() {
        let show = TVShow(name: "Friends")
        path.append(show)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

struct TVShowView: View {
    var onSelectReset: () -> Void
    var show: TVShow
    var otherShows: [TVShow]

    var body: some View {
        VStack {
            Text(show.name)
                .font(.title)
                .padding(.bottom)
            Button(action: onSelectReset) {
                Text("Reset Selection")
            }
            List(otherShows, id: \.name) { otherShow in
                Text(otherShow.name)
            }
        }
        .padding()
    }
}

struct TVShow: Hashable {
    let name: String
    let premiereDate: Date = Date.now
    var description: String = "detail"
}
```

代码中，`NavigationPath` 被用作一个 `@State` 变量，这意味着它会自动响应变化，并更新视图。当你修改 `NavigationPath` 中的路径数组时，视图会自动更新，显示新的页面。
