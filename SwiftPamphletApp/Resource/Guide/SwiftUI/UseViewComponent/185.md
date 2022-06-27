可视化数据，使用 SwiftUI 语法来创建。还可以使用 ChartRenderer 接口将图标渲染成图。

官方文档 [Swift Charts](https://developer.apple.com/documentation/Charts)

入门参看 [Hello Swift Charts](https://developer.apple.com/videos/play/wwdc2022/10136/)

Apple 文章 [Creating a chart using Swift Charts](https://developer.apple.com/documentation/Charts/Creating-a-chart-using-Swift-Charts)

高级定制和创建更精细图表，可以看这个 session [Swift Charts: Raise the bar](https://developer.apple.com/videos/play/wwdc2022/10137) 这个 session 也会提到如何在图表中进行交互。这里是 session 对应的代码示例 [Visualizing your app’s data](https://developer.apple.com/documentation/charts/visualizing_your_app_s_data) 。

图表设计的 session，[Design an effective chart](https://developer.apple.com/videos/play/wwdc2022-110340) 和 [Design app experiences with charts](https://developer.apple.com/videos/play/wwdc2022-110342) 。

下面是一个简单的代码示例：
```swift
import Charts

struct PChartModel: Hashable {
    var day: String
    var amount: Int = .random(in: 1..<100)
}

extension PChartModel {
    static var data: [PChartModel] {
        let calendar = Calendar(identifier: .gregorian)
        let days = calendar.shortWeekdaySymbols
        return days.map { day in
            PChartModel(day: day)
        }
    }
}

struct PlayCharts: View {
    var body: some View {
        Chart(PChartModel.data, id: \.self) { v in
            BarMark(x: .value("天", v.day), y: .value("数量", v.amount))
            
        }
        .padding()
    }
}

struct PSwiftCharts: View {
    struct CData: Identifiable {
        let id = UUID()
        let i: Int
        let v: Double
    }
    
    @State private var a: [CData] = [
        .init(i: 0, v: 2),
        .init(i: 1, v: 20),
        .init(i: 2, v: 3),
        .init(i: 3, v: 30),
        .init(i: 4, v: 8),
        .init(i: 5, v: 80)
    ]
    
    var body: some View {
        Chart(a) { i in
            LineMark(x: .value("Index", i.i), y: .value("Value", i.v))
            BarMark(x: .value("Index", i.i), yStart: .value("开始", 0), yEnd: .value("结束", i.v))
                .foregroundStyle(by: .value("Value", i.v))
        } // end Chart
    } // end body
}
```

BarMark 用于创建条形图，LineMark 用于创建折线图。SwiftUI Charts 框架还提供 PointMark、AxisMarks、AreaMark、RectangularMark 和 RuleMark 用于创建不同类型的图表。注释使用 `.annotation` modifier，修改颜色可以使用 `.foregroundStyle` modifier。`.lineStyle` modifier 可以修改线宽。

AxisMarks 的示例如下：
```swift
struct MonthlySalesChart: View {
    var body: some View {
        Chart(data, id: \.month) {
            BarMark(
                x: .value("Month", $0.month, unit: .month),
                y: .value("Sales", $0.sales)
            )
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month)) { value in
                if value.as(Date.self)!.isFirstMonthOfQuarter {
                    AxisGridLine().foregroundStyle(.black)
                    AxisTick().foregroundStyle(.black)
                    AxisValueLabel(
                        format: .dateTime.month(.narrow)
                    )
                } else {
                    AxisGridLine()
                }
            }
        }
    }
}
```

可交互图表示例如下：
```swift
struct InteractiveBrushingChart: View {
    @State var range: (Date, Date)? = nil
    
    var body: some View {
        Chart {
            ForEach(data, id: \.day) {
                LineMark(
                    x: .value("Month", $0.day, unit: .day),
                    y: .value("Sales", $0.sales)
                )
                .interpolationMethod(.catmullRom)
                .symbol(Circle().strokeBorder(lineWidth: 2))
            }
            if let (start, end) = range {
                RectangleMark(
                    xStart: .value("Selection Start", start),
                    xEnd: .value("Selection End", end)
                )
                .foregroundStyle(.gray.opacity(0.2))
            }
        }
        .chartOverlay { proxy in
            GeometryReader { nthGeoItem in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(DragGesture()
                        .onChanged { value in
                            // Find the x-coordinates in the chart’s plot area.
                            let xStart = value.startLocation.x - nthGeoItem[proxy.plotAreaFrame].origin.x
                            let xCurrent = value.location.x - nthGeoItem[proxy.plotAreaFrame].origin.x
                            // Find the date values at the x-coordinates.
                            if let dateStart: Date = proxy.value(atX: xStart),
                               let dateCurrent: Date = proxy.value(atX: xCurrent) {
                                range = (dateStart, dateCurrent)
                            }
                        }
                        .onEnded { _ in range = nil } // Clear the state on gesture end.
                    )
            }
        }
    }
}
```

社区做的更多 Swift Charts 范例 [Swift Charts Examples](https://github.com/jordibruin/Swift-Charts-Examples) 。

