

## 属性

SwifUI 中的属性就是常量，不可变。

```swift
struct SomeView: View {
  let saySomething = "你好世界"

  var body: some View {
    Text(saySomething)
  }
}
```

## @State

当标记为 @State 的属性的值是可变的，当它改变时，视图会重新渲染。

```swift
struct ContentView: View {
    @State private var isShowingAlert = false

    var body: some View {
        Button("Show Alert") {
            isShowingAlert = true
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Hello, SwiftUI!"))
        }
    }
}
```

## @Binding

@Binding 是一个对其他视图的 @State 属性的引用。它允许我们在不拥有这个状态的情况下修改它。

```swift
struct ToggleSwitch: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Toggle Switch")
        }
    }
}
```

## @Observable

下面的协议和属性包装在 iOS 17 后会被 `@Observable` 这个宏所替代了：

- `ObservableObject`
- `@ObservedObject`
- `@EnvironmentObject`
- `@Published`

如果你的程序是在 iOS 17 前写的，可以按照下面的步骤进行迁移：

- 第一步：删掉 ObservableObject 协议，添加 `@Observable`
- 第二步：删 Published 属性
- 第三步：给不需要观察的属性添加 `@ObservationIgnored`
- 第四步：将 `@ObservedObject` 替换成 `@State` 
- 第五步：将 `@Binding` 改成 `@Bindable`
- 第六步：将 environmentObject 换成 environment


## @Environment

@Environment 是一个从环境中获取系统设置或状态的属性。

```swift
struct ContentView: View {
    @Environment(\.layoutDirection) var layoutDirection

    var body: some View {
        if layoutDirection == .leftToRight {
            Text("Left to Right layout")
        } else {
            Text("Right to Left layout")
        }
    }
}
```

Observable 用于 Environment 的方式，举个例子。

有个 Observable 类。

```swift
import Observation

@Observable class Cat {
  var isOrange: Bool = false
}
```

使用 environment 修饰符

```swift
SomeView()
  .environment(Cat())
```

使用键路径声明一个 `Environment` 属性

```swift
struct SomeView: View {
  @Environment(Cat.self) private var cat

  var body: some View {
    @Bindable var catBindable = cat
    Toggle(isOn: $catBindable.isOrange, label: {
      Text("是不是橘猫")
    })
  }
}
```


## @AppStorage

@AppStorage 是一个用于存储用户设置的简单键值存储。当存储的值改变时，视图会重新渲染。

```swift
struct ContentView: View {
    @AppStorage("username") var username: String = "Guest"

    var body: some View {
        Text("Hello, \(username)!")
    }
}
```

