使用例子如下：
```swift
extension Notification.Name {
    static let noti = Notification.Name("nameofnoti")
}

let notiPb = NotificationCenter.default.publisher(for: .noti, object: nil)
        .sink {
            print($0)
        }
```

退到后台接受通知的例子如下：
```swift
class A {
  var storage = Set<AnyCancellable>()
   
  init() {
    NotificationCenter.default.publisher(for: UIWindowScene.didEnterBackgroundNotification)
      .sink { _ in
        print("enter background")
      }
      .store(in: &self.storage)
  }
}
```
