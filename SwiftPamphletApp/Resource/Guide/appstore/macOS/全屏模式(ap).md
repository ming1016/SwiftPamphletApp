将 NSSplitView 里的其中一个 NSView 设置为全屏和退出全屏的函数如下：

```swift
// MARK: - 获取 NSSplitViewController
func splitVC() -> NSSplitViewController {
    return ((NSApp.keyWindow?.contentView?.subviews.first?.subviews.first?.subviews.first as? NSSplitView)?.delegate as? NSSplitViewController)!
}

// MARK: - 全屏
func fullScreen(isEnter: Bool) {
    if isEnter == true {
        // 进入全屏
        let presOptions:
        NSApplication.PresentationOptions = ([.autoHideDock,.autoHideMenuBar])
        let optionsDictionary = [NSView.FullScreenModeOptionKey.fullScreenModeApplicationPresentationOptions : NSNumber(value: presOptions.rawValue)]
        
        let v = splitVC().splitViewItems[2].viewController.view
        v.enterFullScreenMode(NSScreen.main!, withOptions: optionsDictionary)
        v.wantsLayer = true
    } else {
        // 退出全屏
        NSApp.keyWindow?.contentView?.exitFullScreenMode()
    } // end if
}
```

使用方法

```swift
struct V: View {
    @StateObject var appVM = AppVM()
    @State var isEnterFullScreen: Bool = false // 全屏控制
    var body: some View {
        Button {
            isEnterFullScreen.toggle()
            appVM.fullScreen(isEnter: isEnterFullScreen)
        } label: {
            Image(systemName: isEnterFullScreen == true ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
        }
    }
}
```
