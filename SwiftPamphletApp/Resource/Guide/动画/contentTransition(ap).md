
`.contentTransition(.numericText())` 修饰符用于在视图内容发生变化时，以数字动画的方式进行过渡。

```swift
struct ContentView: View {
    @State private var filmNumber: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(filmNumber)")
                .contentTransition(.numericText())
                .animation(.easeIn, value: filmNumber)
            Stepper("电影数量", value: $filmNumber, in: 0...100)
        }
        .font(.largeTitle)
        .foregroundColor(.indigo)
    }
}
```
