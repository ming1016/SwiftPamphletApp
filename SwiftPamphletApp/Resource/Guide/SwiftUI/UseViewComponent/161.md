![](https://user-images.githubusercontent.com/251980/156135869-7451bbc9-95b9-445f-8721-66f0aedbed70.png)

浮层有 HUD、ContextMenu、Sheet、Alert、ConfirmationDialog、Popover、ActionSheet 等几种方式。这些方式实现代码如下：

```swift
struct PlaySuperposedLayerView: View {
    @StateObject var hudVM = PHUDVM()
    @State private var isShow = false
    @State private var isShowAlert = false
    @State private var isShowConfirmationDialog = false
    @State private var isShowPopover = false
    
    var body: some View {
        VStack {
            
            
            List {
                ForEach(0..<100) { i in
                    Text("\(i)")
                        .contextMenu {
                            // 在 macOS 上右键会出现的菜单
                            Button {
                                print("\(i) is clicked")
                            } label: {
                                Text("Click \(i)")
                            }
                        }
                }
            }
            .navigationTitle("列表")
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button("查看 Sheet") {
                        isShow = true
                    }
                    
                    Button("查看 Alert") {
                        isShowAlert = true
                    }
                    
                    Button("查看 confirmationDialog", role: .destructive) {
                        isShowConfirmationDialog = true
                    }
                    
                    // Popover 样式默认是弹出窗口置于按钮上方，指向底部。
                    Button("查看 Popover") {
                        isShowPopover = true
                    }
                    .popover(isPresented: $isShowPopover, attachmentAnchor: .point(.trailing), arrowEdge: .trailing) {
                        Text("Popover 的内容")
                            .padding()
                    }
                    
                } // end ToolbarItemGroup
            } // end toolbar
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("弹框标题"), message: Text("弹框内容"))
            }
            .sheet(isPresented: $isShow) {
                print("dismiss")
            } content: {
                VStack {
                    Label("Sheet", systemImage: "brain.head.profile")
                    Button("关闭") {
                        isShow = false
                    }
                }
                .padding(20)
            }
            .confirmationDialog("确定删除？", isPresented: $isShowConfirmationDialog, titleVisibility: .hidden) {
                Button("确定") {
                    // do good thing
                }
                .keyboardShortcut(.defaultAction) // 使用 keyboardShortcut 可以设置成为默认选项样式
                
                Button("不不", role: .cancel) {
                    // good choice
                }
                
            } message: {
                Text("这个东西还有点重要哦")
            }
            
            Button {
                hudVM.show(title: "您有一条新的短消息", systemImage: "ellipsis.bubble")
            } label: {
                Label("查看 HUD", systemImage: "switch.2")
            }
            .padding()
        }
        .environmentObject(hudVM)
        .hud(isShow: $hudVM.isShow) {
            Label(hudVM.title, systemImage: hudVM.systemImage)
        }
    }
}

// MARK: - 供全局使用的 HUD
final class PHUDVM: ObservableObject {
    @Published var isShow: Bool = false
    var title: String = ""
    var systemImage: String = ""
    
    func show(title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
        withAnimation {
            isShow = true
        }
    }
}

// MARK: - 扩展 View 使其能够有 HUD 的能力
extension View {
    func hud<V: View>(
        isShow: Binding<Bool>,
        @ViewBuilder v: () -> V
    ) -> some View {
        ZStack(alignment: .top) {
            self
            
            if isShow.wrappedValue == true {
                PHUD(v: v)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShow.wrappedValue = false
                            }
                        }
                    }
                    .zIndex(1)
                    .padding()
            }
        }
    }
}

// MARK: - 自定义 HUD
struct PHUD<V: View>: View {
    @ViewBuilder let v: V
    
    var body: some View {
        v
            .padding()
            .foregroundColor(.black)
            .background(
                Capsule()
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 5)
            )
    }
}
```

SwiftUI 新推出的 `presentationDetents()` modifier 可以创建一个可以定制的 bottom sheet。示例代码如下：
```swift
struct PSheet: View {
    @State private var isShow = false
    var body: some View {
        Button("显示 Sheet") {
            isShow.toggle()
        }
        .sheet(isPresented: $isShow) {
            Text("这里是 Sheet 的内容")
                .presentationDetents([.medium, .large])
        }
    }
}
```

detent 默认值是 `.large`。也可以提供一个百分比，比如 `.presentationDetents([.fraction(0.7)])`，或者直接指定高度 `.presentationDetents([.height(100)])`。

presentationDragIndicator modifier 可以用来显示隐藏拖动标识。

