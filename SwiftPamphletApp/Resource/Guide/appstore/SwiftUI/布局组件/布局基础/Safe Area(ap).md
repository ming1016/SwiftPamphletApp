

## ignoresSafeArea 忽略安全区域

使用 `.ignoresSafeArea()` 可以忽略安全区域。默认是所有方向都忽略。

如果只忽略部分方向，可以按照下面方法做：

```swift
// 默认会同时包含 .keyboard 和 .container。
.ignoresSafeArea(edges: .top)
.ignoresSafeArea(edges: .vertical)
.ignoresSafeArea(edges: [.leading, .trailing])

// 可以对安全区域分别指定
.ignoresSafeArea(.keyboard, edges: .top)
.ignoresSafeArea(.container, edges: [.leading, .trailing])
```

## safeAreaInset

`safeAreaInset` 是 SwiftUI 中的一个属性，它允许你将视图放置在安全区域内。"安全区域"是指设备屏幕上的一块区域，这块区域不会被系统界面（如状态栏、导航栏、工具栏、Tab栏等）遮挡。

例如，你可以使用 `safeAreaInset` 将一个视图放置在屏幕底部的安全区域内，代码如下：

```swift
VStack {
    Text("Hello, World!")
}
.safeAreaInset(edge: .bottom, spacing: 10) {
    Button("Press me") {
        print("Button pressed")
    }
}
```

在这个例子中，"Press me" 按钮会被放置在屏幕底部的安全区域内，而且距离底部有 10 个点的间距。

下面是更完整点的例子：

```swift
struct ContentView: View {
    @State var tasks: [TaskModel] = (0...10).map { TaskModel(name: "Task \($0)") }
    @State var taskName = ""
    @State var isFocused: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        Text(task.name)
                    }
                }
                .listStyle(PlainListStyle())
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        TextField("Add task", text: $taskName, onCommit: {
                            addTask()
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                        
                        Button(action: {
                            addTask()
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.bottom, isFocused ? 0 : 10)
                    .background(Color.white)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    withAnimation {
                        isFocused = true
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    withAnimation {
                        isFocused = false
                    }
                }
            }
            .navigationBarTitle("Task List Demo")
        }
    }

    func addTask() {
        if !taskName.isEmpty {
            withAnimation {
                tasks.append(TaskModel(name: taskName))
            }
            taskName = ""
        }
    }
}

struct TaskModel: Identifiable {
    let id = UUID()
    let name: String
}
```

用户可以在底部的输入框中输入任务名称，然后点击 "+" 按钮将任务添加到任务清单中。添加的任务会显示在屏幕的上方。当键盘出现或消失时，底部的输入框会相应地移动，以确保不会被键盘遮挡。 