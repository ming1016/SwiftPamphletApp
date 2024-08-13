
这段代码实现了一个字体选择器的功能，用户可以在其中选择和查看自己喜欢的字体。

```swift
struct ContentView: View {
    @State private var fontFamily: String = ""

    var body: some View {
        VStack {
            Text("选择字体:")
            FontPicker(fontFamily: $fontFamily)
                .equatable()
        }
    }
}

struct FontPicker: View, Equatable {
    @Binding var fontFamily: String

    var body: some View {
        VStack {
            Text("\(fontFamily)")
                .font(.custom(fontFamily, size: 20))
            Picker("", selection: $fontFamily) {
                ForEach(NSFontManager.shared.availableFontFamilies, id: \.self) { family in
                    Text(family)
                        .tag(family)
                }
            }
            Spacer()
        }
        .padding()
    }

    static func == (l: FontPicker, r: FontPicker) -> Bool {
        l.fontFamily == r.fontFamily
    }
}
```
