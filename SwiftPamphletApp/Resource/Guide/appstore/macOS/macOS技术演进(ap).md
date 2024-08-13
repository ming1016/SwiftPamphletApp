支持了 window，可以控制位置和大小。官方代码示例 [Bringing multiple windows to your SwiftUI app](https://developer.apple.com/documentation/swiftui/bringing_multiple_windows_to_your_swiftui_app)

openWindow 代码示例如下：
```swift
struct PartyPlanner: App {
    var body: some Scene {
        WindowGroup("Party Planner") {
            PartyPlannerHome()
        }

        Window("Party Budget", id: "budget") {
            Text("Budget View")
        }
        .keyboardShortcut("0")
        .defaultPosition(.topLeading)
        .defaultSize(width: 220, height: 250)
    }
}

struct DetailView: View {
    @Environment(\.openWindow) var openWindow

    var body: some View {
        Text("Detail View")
            .toolbar {
                Button {
                    openWindow(id: "budget")
                } label: {
                    Image(systemName: "dollarsign")
                }
            }
    }
}
```

session [Bring multiple windows to your SwiftUI app](https://developer.apple.com/videos/play/wwdc2022-10061) 两个新 Scene 类型。WindowGroup 允许多 window。MenuBarExtra。可编程方式打开新 window 和 document。

MenuBarExtra 代码示例如下：
```swift
struct PartyPlanner: App {
    var body: some Scene {
        Window("Party Budget", id: "budget") {
            Text("Budget View")
        }

        MenuBarExtra("Bulletin Board", systemImage: "quote.bubble") {
            BulletinBoard()
        }
        .menuBarExtraStyle(.window)
    }
}
```

讲和 AppKit 混编的 session [Use SwiftUI with AppKit](https://developer.apple.com/videos/play/wwdc2022/10075/)

[The craft of SwiftUI API design: Progressive disclosure](https://developer.apple.com/videos/play/wwdc2022-10059) 使用 windows 还有 MenuBarExtra，使用 modifier 来自定义应用程序 window 的 presentation 和行为。

使用 `.dropDestination` 来支持拖动。示例如下：
```swift
.dropDestination(payloadType: Image.self) { receivedImages, location in
        guard let image = receivedImages.first else {
            return false
        }
        viewModel.imageState = .success(image)
        return true
    }
```

今年有新的 [FormStyle](https://developer.apple.com/documentation/swiftui/formstyle/columns) ，示例如下：
```swift
Form {
    Picker("Notify Me About:", selection: $notifyMeAbout) {
        Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
        Text("Mentions").tag(NotifyMeAboutType.mentions)
        Text("Anything").tag(NotifyMeAboutType.anything)
    }
    Toggle("Play notification sounds", isOn: $playNotificationSounds)
    Toggle("Send read receipts", isOn: $sendReadReceipts)

    Picker("Profile Image Size:", selection: $profileImageSize) {
        Text("Large").tag(ProfileImageSize.large)
        Text("Medium").tag(ProfileImageSize.medium)
        Text("Small").tag(ProfileImageSize.small)
    }
    .pickerStyle(.inline)
}
.formStyle(.columns)
```

Apple 自身在 macOS 系统中使用了多少 SwiftUI 呢？邮件、iWork 和  Keychain Access 的部分视图使用了，笔记、照片 和 Xcode 部分功能及新增功能的完整界面都是用的 SwiftUI，另外控制中心、字体册和系统设置的大部分都是用 SwiftUI 开发了。
