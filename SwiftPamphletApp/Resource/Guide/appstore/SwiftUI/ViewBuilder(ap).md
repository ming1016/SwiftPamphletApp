

`@ViewBuilder` 是 SwiftUI 中的一个特性，它允许你在函数或计算属性中构建和返回一个或多个视图。这使得你可以创建复杂的视图层次结构，同时保持代码的可读性和简洁性。

```swift
struct ContentView: View {
    @State private var isPrivacyMode = true
    var body: some View {
        MovieView(title: "红高粱", poster: Image("evermore"))
    }
}

struct MovieView: View {
    var title: String
    var poster: Image

    var body: some View {
        VStack {
            poster
                .resizable()
                .scaledToFit()
            Text(title)
                .font(.title)
                .foregroundColor(.yellow)
                .padding(.top, 8)
            footer()
        }
        .background(Color.black)
        .cornerRadius(10)
        .padding()
    }

    @ViewBuilder
    func footer() -> some View {
        HStack {
            Text("导演: 张艺谋")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
            Text("评分: 9.0")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
```

`@ViewBuilder` 的一些主要的功能：

- 支持 `if let` 和 `if case`
- 支持在 'if' 语句中使用多个布尔条件
- 支持 `switch` 语句
- 支持 `if #available` 语句
- 支持处理 `#warning` 和 `#error`
- 支持 `let`/`var` 声明

接下来，我们将使用 `@ViewBuilder` 来创建一个可展开的电影卡片视图。其中会用到上面提到的条件判断的功能。

```swift
struct ContentView: View {
    @State private var isPrivacyMode = true
    var body: some View {
        MovieCard(poster: Image("evermore"), title: "红高粱", director: "张艺谋", rating: 9.0) {
            Text("红高粱是一部由张艺谋执导的电影，讲述了九十年代的中国农村生活。")
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct MovieCard<Content: View>: View {
    let poster: Image
    let title: String
    let director: String
    let rating: Double
    @ViewBuilder var content: () -> Content
    @State private var isExpanded = false

    var body: some View {
        VStack {
            HStack {
                poster
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title2)
                        .foregroundColor(.yellow)
                    Text("导演: \(director)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("评分: \(rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
            }
            if isExpanded {
                content()
                    .transition(.move(edge: .bottom))
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}
```

在这个例子中，我们创建了一个 `MovieCard` 视图，其中包含了一个海报、标题、导演和评分。我们还添加了一个 `content` 属性，用于展示电影的简介。在 `MovieCard` 的主体中，我们使用了 `@ViewBuilder` 来创建一个可展开的电影卡片视图。当点击卡片时，电影的简介会展开或收起。
