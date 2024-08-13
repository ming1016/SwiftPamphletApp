
## Transaction 使用指南

这段内容主要介绍了 SwiftUI 中的 `Transaction` 和 `withTransaction`。`Transaction` 是 SwiftUI 中用于控制动画的一种方式，它可以用来定义动画的详细参数，如动画类型、持续时间等。`withTransaction` 是一个函数，它接受一个 `Transaction` 实例和一个闭包作为参数，闭包中的代码将在这个 `Transaction` 的上下文中执行。

以下是一个使用 `Transaction` 和 `withTransaction` 的代码示例：

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Text("电影标题")
                .font(.title)
                .padding()
            Image("evermore")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
        }
        .onAppear {
            let transaction = Transaction(animation: .easeInOut(duration: 1))
            withTransaction(transaction) {
                scale = 1.5
            }
        }
    }
}
```

在这个示例中，我们创建了一个 `MovieView`，它包含一个电影标题和一个电影海报。当视图出现时，我们创建了一个 `Transaction`，并设置了动画类型为 `easeInOut`，持续时间为 1 秒。然后我们在 `withTransaction` 的闭包中改变 `scale` 的值，这样海报的大小就会以 `easeInOut` 的方式在 1 秒内放大到 1.5 倍。

## 使用 `Transaction` 和 `withTransaction`

SwiftUI 中 `Transaction` 的 `disablesAnimations` 和 `isContinuous` 属性，以及 `transaction(_:)` 方法怎么使用？

`disablesAnimations` 属性可以用来禁止动画，`isContinuous` 属性可以用来标识一个连续的交互（例如拖动）。`transaction(_:)` 方法可以用来创建一个新的 `Transaction` 并在其闭包中设置动画参数。

以下是一个使用这些特性的代码示例：

```swift
struct ContentView: View {
    @State var size: CGFloat = 100
    @GestureState var dragSize: CGSize = .zero

    var body: some View {
        VStack {
            Image("fearless")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size) // 使用 size 控制尺寸，而非位置
                .animation(.spring(), value: size) // 使用弹簧动画
                .transaction {
                    if $0.isContinuous {
                        $0.animation = nil // 拖动时，不设置动画
                    } else {
                        $0.animation = .spring() // 使用弹簧动画
                    }
                }
                .gesture(
                    DragGesture()
                        .updating($dragSize, body: { current, state, transaction in
                            state = .init(width: current.translation.width, height: current.translation.height)
                            transaction.isContinuous = true // 拖动时，设置标识
                        })
                )

            Stepper("尺寸: \(size)", value: $size, in: 50...200) // 使用 Stepper 替代 Slider
            Button("开始动画") {
                var transaction = Transaction()
                if size < 150 { transaction.disablesAnimations = true }
                withTransaction(transaction) {
                    size = 50
                }
            }
        }
    }
}
```

在这个示例中，当 `size` 小于 150 时，我们禁用动画。通过 `.isContinuous` 属性，我们可以标识一个连续的交互（例如拖动）。在这个示例中，当拖动时，我们禁用动画。通过 `transaction(_:)` 方法，我们可以创建一个新的 `Transaction` 并在其中设置动画参数。

## 用于视图组件

大部分 SwiftUI 视图组件都有 `transaction(_:)` 方法，可以用来设置动画参数。比如 NavigationStack, Sheet, Alert 等。

`Transaction` 也可以用于 `Binding` 和 `FetchRequest`。

看下面的例子：

```swift
struct ContentView: View {
    @State var size: CGFloat = 100
    @State var isBold: Bool = false
    let animation: Animation? = .spring

    var sizeBinding: Binding<CGFloat> {
        let transaction = Transaction(animation: animation)
        return $size.transaction(transaction)
    }

    var isBoldBinding: Binding<Bool> {
        let transaction = Transaction(animation: animation)
        return $isBold.transaction(transaction)
    }

    var body: some View {
        VStack {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size) // 使用 size 控制尺寸，而非位置
                .font(.system(size: size, weight: isBold ? .bold : .regular)) // 使用 isBold 控制粗细
            Stepper("尺寸: \(size)", value: sizeBinding, in: 50...200)
            Toggle("粗细", isOn: isBoldBinding)
        }
        .padding()
    }
}
```

## 传播行为

`Transaction` 可以用于控制动画的传播行为。在 SwiftUI 中，动画可以在视图层次结构中传播，这意味着一个视图的动画效果可能会影响到其子视图。`Transaction` 可以用来控制动画的传播行为，例如禁用动画、设置动画类型等。

以下是一个使用 `Transaction` 控制动画传播行为的代码示例：

```swift
enum BookStatus {
    case small, medium, large, extraLarge
}

extension View {
    @ViewBuilder func debugAnimation() -> some View {
        transaction {
            debugPrint($0.animation ?? "")
        }
    }
}

struct ContentView: View {
    @State var status: BookStatus = .small

    var animation: Animation? {
        switch status {
        case .small:
            return .linear
        case .medium:
            return .easeIn
        case .large:
            return .easeOut
        case .extraLarge:
            return .spring()
        }
    }

    var size: CGFloat {
        switch status {
        case .small:
            return 100
        case .medium:
            return 200
        case .large:
            return 300
        case .extraLarge:
            return 400
        }
    }

    var body: some View {
        VStack {
            Image(systemName: "book")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .debugAnimation() // 查看动画变化信息
            Button("改变状态") {
                var transaction = Transaction(animation: animation)
                withTransaction(transaction) {
                    switch self.status {
                    case .small:
                        self.status = .medium
                    case .medium:
                        self.status = .large
                    case .large:
                        self.status = .extraLarge
                    case .extraLarge:
                        self.status = .small
                    }
                }
            }
        }
    }
}
```

这个示例中，我们创建了一个 `BookView`，它包含一个书籍图标。我们通过 `BookStatus` 枚举来控制书籍的大小，通过 `animation` 计算属性来根据状态返回不同的动画类型。在 `withTransaction` 中，我们根据状态创建一个新的 `Transaction`，并在其中设置动画类型。通过 `debugAnimation` 修饰符，我们可以查看动画的变化信息。

## TransactionKey

TransactionKey 是一种在 SwiftUI 的视图更新过程中传递额外信息的机制，它可以让你在不同的视图和视图更新之间共享数据。

```swift
struct ContentView: View {
    @State private var store = MovieStore()
    var body: some View {
        VStack {
            Image("evermore")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .saturation(store.isPlaying ? 1 : 0) // 滤镜变化
                .transaction {
                    $0.animation = $0[StatusKey.self].animation
                }

            PlayView(store: store)
            PauseView(store: store)
        }
    }
}

struct PlayView: View {
    let store: MovieStore
    var body: some View {
        Button("播放") {
            withTransaction(\.status, .playing) {
                store.isPlaying.toggle()
            }
        }
    }
}

struct PauseView: View {
    let store: MovieStore
    var body: some View {
        Button("暂停") {
            withTransaction(\.status, .paused) {
                store.isPlaying.toggle()
            }
        }
    }
}

@Observable
class MovieStore {
    var isPlaying = false
}

enum MovieStatus {
    case playing
    case paused
    case stopped

    var animation: Animation? {
        switch self {
        case .playing:
            Animation.linear(duration: 2)
        case .paused:
            nil
        case .stopped:
            Animation.easeInOut(duration: 1)
        }
    }
}

struct StatusKey: TransactionKey {
    static var defaultValue: MovieStatus = .stopped
}

extension Transaction {
    var status: MovieStatus {
        get { self[StatusKey.self] }
        set { self[StatusKey.self] = newValue }
    }
}
```

以上代码中，我们创建了一个 `MovieStore` 类，用于存储电影播放状态。我们通过 `PlayView` 和 `PauseView` 分别创建了播放和暂停按钮，点击按钮时，我们通过 `withTransaction` 函数改变了 `MovieStore` 的 `isPlaying` 属性，并根据状态设置了动画类型。在 `ContentView` 中，我们通过 `transaction` 修饰符设置了动画类型为 `MovieStatus` 中的动画类型。

## AnyTransition

`AnyTransition` 是一个用于创建自定义过渡效果的类型，它可以让你定义视图之间的过渡动画。你可以使用 `AnyTransition` 的 `modifier` 方法将自定义过渡效果应用到视图上。

```swift
struct ContentView: View {
    
    @StateObject var musicViewModel = MusicViewModel()
    
    var body: some View {
        VStack {
            ForEach(musicViewModel.musicNames, id: \.description) { musicName in
                if musicName == musicViewModel.currentMusic {
                    Image(musicName)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .ignoresSafeArea()
                        .transition(.glitch.combined(with: .opacity))
                }
            }
            
            Button("Next Music") {
                musicViewModel.selectNextMusic()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct MyTransition: ViewModifier {
    let active: Bool

    func body(content: Content) -> some View {
        content
            .rotationEffect(active ? .degrees(Double.random(in: -10...10)) : .zero)
            .offset(x: active ? CGFloat.random(in: -10...10) : 0, y: active ? CGFloat.random(in: -10...10) : 0)
    }
}

extension AnyTransition {
    static var glitch: AnyTransition {
        AnyTransition.modifier(
            active: MyTransition(active: true),
            identity: MyTransition(active: false)
        )
    }
}

class MusicViewModel: ObservableObject {
    @Published var currentMusic = ""
    
    let musicNames = ["fearless", "evermore", "red", "speaknow", "lover"]
    
    init() {
        currentMusic = musicNames.first ?? "fearless"
    }
    
    func selectNextMusic() {
        guard let currentIndex = musicNames.firstIndex(of: currentMusic) else {
            return
        }
        
        let nextIndex = currentIndex + 1 < musicNames.count ? currentIndex + 1 : 0
        
        withAnimation(.easeInOut(duration: 2)) {
            currentMusic = musicNames[nextIndex]
        }
    }
}
```

以上代码中，我们创建了一个 `MusicViewModel` 类，用于存储音乐播放状态。我们通过 `MyTransition` 自定义了一个过渡效果，通过 `AnyTransition` 的 `modifier` 方法将自定义过渡效果应用到视图上。在 `ContentView` 中，我们通过 `transition` 修饰符设置了过渡效果为 `glitch`，并在点击按钮时切换音乐。
