![](https://ming1016.github.io/qdimg/240505/groupbox-ap01.png)

```swift
struct PlayGroupBoxView: View {
    var body: some View {
        GroupBox {
            Text("这是 GroupBox 的内容")
        } label: {
            Label("标题一", systemImage: "t.square.fill")
        }
        .padding()
        
        GroupBox {
            Text("还是 GroupBox 的内容")
        } label: {
            Label("标题二", systemImage: "t.square.fill")
        }
        .padding()
        .groupBoxStyle(PCGroupBoxStyle())

    }
}

struct PCGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.title)
            configuration.content
        }
        .padding()
        .background(.pink)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
```

叠加 GroupBox 颜色会有区分

```swift
GroupBox {
    Text("电视剧名称: 人民的名义")

    GroupBox {
        Text("播放时间: 每周一至周五")
    }
}
```

最后，您还可以 `GroupBox` 使用 `Label` .将 `Label` 定位为 `GroupBox` 容器的标题。
```swift
GroupBox(label: Label("电视剧", systemImage: "tv")) {
    HStack {
        Text("播放时间: 每周一至周五")
            .padding()
        Spacer()
    }
}
```

GroupBox 也可以用于创建自定义的按钮组，如下所示：

```swift
struct TVShowCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // The header of the card
            // - Photo, Show Name and Genre
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                VStack(alignment: .leading, spacing: 3) {
                    Text("权力的游戏")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("奇幻剧")
                        .font(.caption)
                }
                Spacer()
            }
            
            Divider()
                .foregroundColor(Color(uiColor: UIColor.systemGray6))
                .padding([.top, .bottom], 8)
            
            // The description of the show in a few lines
            Text("《权力的游戏》是一部改编自乔治·马丁的奇幻小说系列《冰与火之歌》的电视剧。")
                .font(.body)
            
            // Buttons to watch, share or save the show
            HStack {
                actionGroupBox(imageName: "play.rectangle", actionName: "观看", action: { print("Watching...") })
                actionGroupBox(imageName: "square.and.arrow.up", actionName: "分享", action: { print("Sharing...") })
                actionGroupBox(imageName: "bookmark", actionName: "保存", action: { print("Saving...") })
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
    
    // A function to create a GroupBox for an action
    func actionGroupBox(imageName: String, actionName: String, action: @escaping () -> Void) -> some View {
        GroupBox {
            VStack(spacing: 5) {
                Image(systemName: imageName)
                    .font(.headline)
                Text(actionName)
                    .font(.caption)
            }
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
        }.onTapGesture {
            action()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                TVShowCardView()
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .navigationTitle("电视剧")
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0, y: 0)
        }
    }
}

```

