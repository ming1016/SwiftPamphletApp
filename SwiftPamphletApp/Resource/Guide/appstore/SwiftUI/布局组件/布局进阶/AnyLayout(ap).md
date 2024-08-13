
使用 AnyLayout 包装布局组件，可以在布局之间进行切换，同时保持动画效果。

```swift
struct WeatherLayout: View {
    @State private var changeLayout = false

    var body: some View {
        let layout = changeLayout ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

        layout {
            WeatherView(icon: "sun.max.fill", temperature: 25, color: .yellow)
            WeatherView(icon: "cloud.rain.fill", temperature: 18, color: .blue)
            WeatherView(icon: "snow", temperature: -5, color: .white)
        }
        .animation(.default, value: changeLayout)
        .onTapGesture {
            changeLayout.toggle()
        }
    }
}

struct WeatherView: View {
    let icon: String
    let temperature: Int
    let color: Color

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundColor(color)
            Text("\(temperature)°")
                .font(.system(size: 50))
                .foregroundColor(color)
        }
        .frame(width: 120, height: 120)
    }
}
```

代码中，我们创建了一个 WeatherView 视图，它包含一个天气图标和一个温度标签。然后，我们在 WeatherLayout 视图中使用 AnyLayout 来动态改变布局。用户可以通过点击视图来在水平布局和垂直布局之间切换。
