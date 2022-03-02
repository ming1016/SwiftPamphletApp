```swift
struct PlayStepperView: View {
    @State private var count: Int = 0
    var body: some View {
        Stepper(value: $count, step: 2) {
            Text("共\(count)")
        } onEditingChanged: { b in
            print(b)
        } // end Stepper
    }
}
```
