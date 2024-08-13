
使用 `.contentShape(Rectangle())` 可以使整个区域都可点击 

```swift
struct ContentView: View {
    var body: some View {
        List {
            ForEach(1..<50) { num in
                HStack {
                    Text("\(num)")
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Clicked \(num)")
                }
            }
        } // end list
    }
}
```
