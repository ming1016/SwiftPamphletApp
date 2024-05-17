
简单示例

```swift
struct PlaySliderView: View {
    @State var count: Double = 0
    var body: some View {
        Slider(value: $count, in: 0...100)
            .padding()
        Text("\(Int(count))")
    }
}
```

以下代码演示了如何创建一个自定义的 `Slider` 控件，用于调整亮度。

```swift
struct ContentView: View {
    @State private var brightness: Double = 50
    @State private var isEditing: Bool = false

    var body: some View {
        VStack {
            Text("Brightness Control")
                .font(.title)
                .padding()

            BrightnessSlider(value: $brightness, range: 0...100, step: 5, isEditing: $isEditing)

            Text("Brightness: \(Int(brightness)), is changing: \(isEditing)")
                .font(.footnote)
                .padding()
        }
    }
}

struct BrightnessSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double
    @Binding var isEditing: Bool

    var body: some View {
        Slider(value: $value, in: range, step: step) {
            Label("亮度", systemImage: "light.max")
        } minimumValueLabel: {
            Text("\(Int(range.lowerBound))")
        } maximumValueLabel: {
            Text("\(Int(range.upperBound))")
        } onEditingChanged: {
            print($0)
        }

    }
}
```

以上代码中，我们创建了一个 `BrightnessSlider` 控件，它是一个自定义的 `Slider` 控件，用于调整亮度。`BrightnessSlider` 接受一个 `value` 绑定，一个 `range` 范围，一个 `step` 步长，以及一个 `isEditing` 绑定。在 `BrightnessSlider` 中，我们使用 `Slider` 控件来显示亮度调整器。我们还使用 `Label` 来显示亮度调整器的标题，并使用 `minimumValueLabel` 和 `maximumValueLabel` 来显示亮度调整器的最小值和最大值。最后，我们使用 `onEditingChanged` 修饰符来监听亮度调整器的编辑状态。