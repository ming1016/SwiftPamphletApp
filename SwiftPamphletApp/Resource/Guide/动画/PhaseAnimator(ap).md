
PhaseAnimator

以下代码示例演示了如何使用 `PhaseAnimator` 视图修饰符创建一个动画，该动画通过循环遍历所有动画步骤来连续运行。在这个例子中，我们使用 `PhaseAnimator` 来创建一个简单的动画，该动画通过循环遍历所有动画步骤来连续运行。当观测值发生变化时，动画会触发一次。

```swift
enum AlbumAnimationPhase: String, CaseIterable, Comparable {
    case evermore, fearless, folklore, lover, midnights, red, speaknow

    static func < (lhs: AlbumAnimationPhase, rhs: AlbumAnimationPhase) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct ContentView: View {
    @State var animate: Bool = false

    var body: some View {
        ScrollView {
            PhaseAnimator(
                AlbumAnimationPhase.allCases,
                trigger: animate,
                content: { phase in
                    VStack {
                        ForEach(AlbumAnimationPhase.allCases, id: \.self) { album in
                            if phase >= album {
                                VStack {
                                    Image(album.rawValue)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    Text(album.rawValue.capitalized)
                                        .font(.title)
                                }
                                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                            }
                        }
                    }
                    .padding()
                }, animation: { phase in
                    .spring(duration: 0.5)
                }
            )
        } // end ScrollView
        Button(action: {
            animate.toggle()
        }, label: {
            Text("开始")
                .font(.largeTitle)
                .bold()
        })
    }
}
```

在上面的代码中，我们首先定义了一个枚举类型 `AlbumAnimationPhase`，用于表示专辑的不同阶段。然后，我们在 `ContentView` 视图中创建了一个 `PhaseAnimator` 视图修饰符，该修饰符接受一个观测值 `trigger`，用于触发动画。在 `content` 闭包中，我们遍历所有专辑，并根据当前阶段 `phase` 来决定是否显示专辑。在 `animation` 闭包中，我们使用 `.spring(duration: 0.5)` 创建了一个弹簧动画效果。   
