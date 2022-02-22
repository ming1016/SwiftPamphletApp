Stack View 有 VStack、HStack 和 ZStack

![](https://user-images.githubusercontent.com/251980/155077158-f6efd3bb-4b82-48ac-b5e6-792dd833dfda.jpeg)

```swift
struct PlayStackView: View {
    var body: some View {
        // 默认是 VStack 竖排
        
        // 横排
        HStack {
            Text("左")
            Spacer()
            Text("右")
        }
        .padding()
        
        // Z 轴排
        ZStack(alignment: .top) {
            Image("logo")
            Text("戴铭的开发小册子")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 0, y: 2)
                .padding()
        }
        
        Color.cyan
            .cornerRadius(10)
            .frame(width: 100, height: 100)
            .overlay(
                Text("一段文字")
            )
    }
}
```
