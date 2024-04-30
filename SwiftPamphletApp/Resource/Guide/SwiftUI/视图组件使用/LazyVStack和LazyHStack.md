LazyVStack 和 LazyHStack 里的视图只有在滚到时才会被创建。

```swift
struct PlayLazyVStackAndLazyHStackView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...300, id: \.self) { i in
                    PLHSRowView(i: i)
                }
            }
        }
    }
}

struct PLHSRowView: View {
    let i: Int
    var body: some View {
        Text("第 \(i) 个")
    }
    init(i: Int) {
        print("第 \(i) 个初始化了") // 用来查看什么时候创建的。
        self.i = i
    }
}
```
