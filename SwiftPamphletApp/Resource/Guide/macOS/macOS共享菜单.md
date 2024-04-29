```swift
struct ShareView: View {
    var s: String
    var body: some View {
        Menu {
            Button {
                let p = NSPasteboard.general
                p.declareTypes([.string], owner: nil)
                p.setString(s, forType: .string)
            } label: {
                Text("拷贝链接")
                Image(systemName: "doc.on.doc")
            }
            Divider()
            ForEach(NSSharingService.sharingServices(forItems: [""]), id: \.title) { item in
                Button {
                    item.perform(withItems: [s])
                } label: {
                    Text(item.title)
                    Image(nsImage: item.image)
                }
            }
        } label: {
            Text("分享")
            Image(systemName: "square.and.arrow.up")
        }
    }
}
```