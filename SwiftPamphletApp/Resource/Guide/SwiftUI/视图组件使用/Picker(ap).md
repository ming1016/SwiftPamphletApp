![](https://user-images.githubusercontent.com/251980/156298284-2fb37b3e-55f0-4918-ba8e-74f747bf3171.jpeg)

有 Picker 视图，还有颜色和时间选择的 ColorPicker 和 DatePicker。

示例代码如下：

```swift
struct PlayPickerView: View {
    @State private var select = 1
    @State private var color = Color.red.opacity(0.3)
    
    var dateFt: DateFormatter {
        let ft = DateFormatter()
        ft.dateStyle = .long
        return ft
    }
    @State private var date = Date()
    
    var body: some View {
        
        // 默认是下拉的风格
        Form {
            Section("选区") {
                Picker("选一个", selection: $select) {
                    Text("1")
                        .tag(1)
                    Text("2")
                        .tag(2)
                }
            }
        }
        .padding()
        
        // Segment 风格，
        Picker("选一个", selection: $select) {
            Text("one")
                .tag(1)
            Text("two")
                .tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        
        // 颜色选择器
        ColorPicker("选一个颜色", selection: $color, supportsOpacity: false)
            .padding()
        
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 50, height: 50)
        
        // 时间选择器
        VStack {
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                Text("选时间")
            }
            
            DatePicker("选时间", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
            
            Text("时间：\(date, formatter: dateFt)")
        }
        .padding()
    }
}
```

选择多个日期

MultiDatePicker 视图会显示一个日历，用户可以选择多个日期，可以设置选择范围。示例如下：
```swift
struct PMultiDatePicker: View {
    @Environment(\.calendar) var cal
    @State var dates: Set<DateComponents> = []
    var body: some View {
        MultiDatePicker("选择个日子", selection: $dates, in: Date.now...)
        Text(s)
    }
    var s: String {
        dates.compactMap { c in
            cal.date(from:c)?.formatted(date: .long, time: .omitted)
        }
        .formatted()
    }
}
```

PhotosPick

支持图片选择，示例代码如下：
```swift
import PhotosUI
import CoreTransferable

struct ContentView: View {
    @ObservedObject var viewModel: FilterModel = .shared
    
    var body: some View {
        NavigationStack {
            Gallery()
                .navigationTitle("Birthday Filter")
                .toolbar {
                    PhotosPicker(
                        selection: $viewModel.imageSelection,
                        matching: .images
                    ) {
                        Label("Pick a photo", systemImage: "plus.app")
                    }
                    Button {
                        viewModel.applyFilter()
                    } label: {
                        Label("Apply Filter", systemImage: "camera.filters")
                    }
                }
        }
    }
}
```
