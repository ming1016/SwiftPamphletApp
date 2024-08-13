
## 位置变化

Matched Geometry Effect 是一种特殊的动画效果。当你有两个视图，并且你想在一个视图消失，另一个视图出现时，创建一个平滑的过渡动画，你就可以使用这个效果。你只需要给这两个视图添加同样的标识符和命名空间，然后当你删除一个视图并添加另一个视图时，就会自动创建一个动画，让一个视图看起来像是滑动到另一个视图的位置。

示例代码如下：

```swift
struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @Namespace var musicSelectionNamespace
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.topMusic) { item in
                    Button(action: { viewModel.selectTopMusic(item) }) {
                        ZStack {
                            Image(item.name)
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text(item.name)
                                .fontDesign(.rounded)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }
                    }
                    .matchedGeometryEffect(id: item.id, in: musicSelectionNamespace)
                }
            }
            .frame(minHeight: 150)
            Spacer()
                .frame(height: 250)
            HStack {
                ForEach(viewModel.bottomMusic) { item in
                    Button(action: { viewModel.selectBottomMusic(item) }) {
                        ZStack {
                            Image(item.name)
                                .resizable()
                                .frame(width: 90, height: 90)
                            Text(item.name)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }
                    }
                    .matchedGeometryEffect(id: item.id, in: musicSelectionNamespace)
                }
            }
            .frame(minHeight: 150)
        }
    }
}
```

以上代码中，我们创建了一个 `ContentView` 视图，其中包含两个 `HStack` 视图，分别展示了 `viewModel` 中的 `topMusic` 和 `bottomMusic` 数组。我们为每个 `topMusic` 和 `bottomMusic` 元素创建了一个 `Button` 视图，当用户点击按钮时，会调用 `viewModel` 中的 `selectTopMusic` 和 `selectBottomMusic` 方法。我们使用 `matchedGeometryEffect` 修饰符为每个 `Button` 视图添加了一个标识符，这样当用户点击按钮时，就会自动创建一个动画，让一个视图看起来像是滑动到另一个视图的位置。

## 大小变化

Matched Geometry Effect 在大小和位置上都可以进行动画过渡，这样可以让你创建更加复杂的动画效果。

以下是一个视图大小切换的示例：

```swift
struct ContentView: View {
    @State var isExpanded: Bool = false
    
    private var albumId = "Album"
    
    @Namespace var expansionAnimation
    
    var body: some View {
        VStack {
            albumView(isExpanded: isExpanded)
        }
        .padding()
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    @ViewBuilder
    func albumView(isExpanded: Bool) -> some View {
        let imageSize = isExpanded ? CGSize(width: 300, height: 450) : CGSize(width: 100, height: 150)
        Image(isExpanded ? "evermore" : "fearless")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: imageSize.width, height: imageSize.height)
            .clipped()
            .matchedGeometryEffect(id: albumId, in: expansionAnimation)
            .overlay {
                Text("Taylor Swift")
                    .font(isExpanded ? .largeTitle : .headline)
                    .fontDesign(.monospaced)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
            }
    }
}
```


## 内容位置变化

内容位置变化的动画效果。以下是一个内容位置变化的示例：

```swift
struct ContentView: View {
    @State var show = false
    @Namespace var placeHolder
    @State var albumCoverSize: CGSize = .zero
    @State var songListSize: CGSize = .zero
    var body: some View {
        ZStack {
            VStack {
                Text("Taylor Swift，1989年12月13日出生于美国宾夕法尼亚州，美国乡村音乐、流行音乐女歌手、词曲创作人、演员、慈善家。")
                    .font(.title)
                    .fontDesign(.monospaced)
                    .fontDesign(.rounded)
                    .padding(20)
                Spacer()
            }
            Color.clear
                // AlbumCover placeholder
                .overlay(alignment: .bottom) {
                    Color.clear // AlbumCoverView().opacity(0.01)
                        .frame(height: albumCoverSize.height)
                        .matchedGeometryEffect(id: "bottom", in: placeHolder, anchor: .bottom, isSource: true)
                        .matchedGeometryEffect(id: "top", in: placeHolder, anchor: .top, isSource: true)
                }
                .overlay(
                    AlbumCoverView()
                        .sizeInfo($albumCoverSize)
                        .matchedGeometryEffect(id: "bottom", in: placeHolder, anchor: show ? .bottom : .top, isSource: false)
                )
                .overlay(
                    SongListView()
                        .matchedGeometryEffect(id: "top", in: placeHolder, anchor: show ? .bottom : .top, isSource: false)
                )
                .animation(.default, value: show)
                .ignoresSafeArea()
                .overlayButton(show: $show)
        }
    }
}

struct AlbumCoverView: View {
    var body: some View {
        Image("evermore")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct SongListView: View {
    var body: some View {
        List {
            Text("Fearless")
            Text("Speak Now")
            Text("Red")
            // ...
        }
    }
}

extension View {
    func overlayButton(show: Binding<Bool>) -> some View {
        self.overlay(
            Button(action: {
                withAnimation {
                    show.wrappedValue.toggle()
                }
            }) {
                Image(systemName: "arrow.up.arrow.down.square")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.white.opacity(0.75))
                    .clipShape(Circle())
            }
            .padding()
            , alignment: .topTrailing
        )
    }
    
    func sizeInfo(_ size: Binding<CGSize>) -> some View {
        self.background(
            GeometryReader { geometry in
                Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { size.wrappedValue = $0 }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
```

我们使用 `matchedGeometryEffect` 修饰符为 `AlbumCoverView` 和 `SongListView` 添加了一个标识符，这样当用户点击按钮时，就会自动创建一个动画，让 `AlbumCoverView` 和 `SongListView` 看起来像是从一个位置切换到另一个位置。


## 点击显示详细信息

点击显示详细信息的动画效果。

```swift
struct ContentView: View {
    @Namespace var animation
    @State var showDetail = false
        
    var body: some View {
        ZStack {
            if (!showDetail) {
                VStack {
                    Text("Taylor Swift")
                            .matchedGeometryEffect(id: "artist", in: animation)
                            .font(.largeTitle.bold())
                            .foregroundColor(Color.white)
                    
                    Text("美国歌手")
                        .matchedGeometryEffect(id: "description", in: animation)
                        .font(.title3.bold())
                        .foregroundColor(Color.white)


                }
                .padding(30)
                .background(
                    Rectangle().fill(.black.gradient)
                        .matchedGeometryEffect(id: "background", in: animation)

                )
            } else {
                SingerView(animation: animation)

            }
        }
        .onTapGesture {
            withAnimation {
                showDetail.toggle()
            }
        }
    }
}

struct SingerView: View {
    var animation: Namespace.ID

    var body: some View {
        VStack{
            Text("Taylor Swift")
                    .matchedGeometryEffect(id: "artist", in: animation)
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.white)
            
            Text("美国歌手")
                .matchedGeometryEffect(id: "description", in: animation)
                .font(.title3.bold())
                .foregroundColor(Color.white)

            Spacer()
                .frame(height: 30)
            Text("泰勒·阿利森·斯威夫特（Taylor Swift），1989年12月13日出生于美国宾夕法尼亚州，美国乡村音乐、流行音乐女歌手、词曲创作人、演员、慈善家。")
                .font(.subheadline.bold())
                .foregroundColor(Color.white)
            
            Spacer()
                .frame(height: 30)
            Image("evermore")
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerSize: CGSize(width: 16, height: 16)))
            
            Text("Evermore 是 Taylor Swift 的最新专辑，这是她在 2020 年的第二张专辑，也是她的第九张录音室专辑。")
                .font(.subheadline.bold())
                .foregroundColor(Color.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.all, 20)
        .background(
            Rectangle().fill(.black.gradient)
                .matchedGeometryEffect(id: "background", in: animation)
                .ignoresSafeArea(.all)
        )
    }
}
```


## 导航动画

以下是一个导航动画的示例：

```swift
struct ContentView: View {
    @Namespace var animation
    @State var selectedManga: String? = nil
        
    var body: some View {
        ZStack {
            if (selectedManga == nil) {
                MangaListView(animation: animation, selectedManga: $selectedManga)

            } else {
                MangaDetailView(selectedManga: $selectedManga, animation: animation)
            }
        }

    }
}

struct MangaDetailView: View {
    @Binding var selectedManga: String?
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            Text( "\(selectedManga ?? "")")
                    .matchedGeometryEffect(id: "mangaTitle", in: animation)
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            
            Spacer()
                .frame(height: 50)

            Button(action: {
                withAnimation {
                    selectedManga = nil
                }
            }, label: {
                Text( "返回")
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            })
            .foregroundColor(Color.red)
            .padding(.all, 8)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .fill(Color.white.gradient)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.all, 20)
        .background(
            Color(UIColor.systemTeal)
                .matchedGeometryEffect(id: "background", in: animation)
                .ignoresSafeArea(.all)
        )
    }
}


struct MangaListView: View {
    var animation: Namespace.ID
    @Binding var selectedManga: String?

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    selectedManga = "海贼王"
                }
            }, label: {
                Text( "海贼王")
                    .matchedGeometryEffect(id: "mangaTitle", in: animation)
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            })
            .foregroundColor(Color.black)
            .padding(.all, 8)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .fill(Color.teal)
            )
            
            Button(action: {
                withAnimation {
                    selectedManga = "火影忍者"
                }
            }, label: {
                Text( "火影忍者")
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            })
            .foregroundColor(Color.black)
            .padding(.all, 8)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .fill(Color.mint)
                    .matchedGeometryEffect(id: "background", in: animation)
            )

            Button(action: {
                withAnimation {
                    selectedManga = "进击的巨人"
                }
            }, label: {
                Text( "进击的巨人")
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            })
            .foregroundColor(Color.black)
            .padding(.all, 8)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .fill(Color.orange)
            )

            Button(action: {
                withAnimation {
                    selectedManga = "鬼灭之刃"
                }
            }, label: {
                Text( "鬼灭之刃")
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            })
            .foregroundColor(Color.black)
            .padding(.all, 8)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .fill(Color.purple)
            )

            Button(action: {
                withAnimation {
                    selectedManga = "我的英雄学院"
                }
            }, label: {
                Text( "我的英雄学院")
                    .font(.title3.bold())
                    .foregroundColor(Color.black)
            })
            .foregroundColor(Color.black)
            .padding(.all, 8)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .fill(Color.green)
            )
        }
    }
}

```

## geometryGroup

`.geometryGroup()` 主要用于处理一组视图动画变化时不协调的问题。如果你有一组视图，它们的位置和大小会随着动画变化，你可以使用 `.geometryGroup()` 修饰符来确保它们的位置和大小保持一致。
