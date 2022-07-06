对于一个基于UIKit的项目是没有必要全部用SwiftUI重写的，在UIKit里使用SwiftUI的视图非常容易，UIHostingController是UIViewController的子类，可以直接用在UIKit里，因此直接将SwiftUI视图加到UIHostingController中，就可以在UIKit里使用SwiftUI视图了。

SwiftUI的布局核心是 GeometryReader、View Preferences和Anchor Preferences。如下图所示：

![](https://user-images.githubusercontent.com/251980/142988837-ab49c202-9779-4c7a-8dc2-5584900c0765.png)

SwiftUI的数据流更适合Redux结构，如下图所示：

![](https://user-images.githubusercontent.com/251980/142988879-af591aaf-161f-4f60-9891-d7b8d313f69f.png)

如上图，Redux结构是真正的单向单数据源结构，易于分割，能充分利用SwiftUI内置的数据流Property Wrapper。UI组件干净、体量小、可复用并且无业务逻辑，因此开发时可以聚焦于UI代码。业务逻辑放在一起，所有业务逻辑和数据Model都在Reducer里。 [ACHNBrowserUI](https://github.com/Dimillian/ACHNBrowserUI)  和  [MovieSwiftUI](https://github.com/Dimillian/MovieSwiftUI)  开源项目都是使用的Redux架构。最近比较瞩目的TCA（The Composable Architecture）也是类Redux/Elm的架构的框架， [项目地址见](https://github.com/pointfreeco/swift-composable-architecture) 。

提到数据流就不得不说下苹果公司新出的Combine，对标的是RxSwift，由于是苹果公司官方的库，所以应该优先选择。不过和SwiftUI一样，这两个新库对APP支持最低的系统版本都要求是iOS13及以上。那么怎么能够提前用上SwiftUI和Combine呢？或者说现在使用什么库可以以相同接口方式暂时替换它们，又能在以后改为SwiftUI和Combine时成本最小化呢？

对于SwiftUI，AcFun自研了声明式UI Ysera，类似SwiftUI的接口，并且重构了AcFun里收藏模块列表视图和交互逻辑，如下图所示：

![](https://user-images.githubusercontent.com/251980/142988909-e6626954-2c93-4c34-b10e-5345c8015cea.png)

通过上图可以看到，swift代码量相比较OC减少了65%以上，原先使用Objective-C实现的相同功能代码超过了1000行，而Swift重写只需要350行，对于AcFun的业务研发工程师而言，同样的需求实现代码比之前少了至少30%，面对单周迭代这样的节奏，团队也变得更从容。代码可读性增加了，后期功能迭代和维护更容易了，Swift让AcFun驶入了iOS开发生态的“快车道”。

SwiftUI全部都是基于Swift的各大可提高开发效率特性完成的，比如前面提到的，能够访问只给语言特性级别行为的Property Wrapper，通过Property Wrapper包装代码逻辑，来降低代码复杂度，除了SwiftUI和Combine里@开头的Property Wrapper外，Swift还自带类似 [@dynamicMemberLookup](https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md)  和 [@dynamicCallable](https://github.com/apple/swift-evolution/blob/master/proposals/0216-dynamic-callable.md)  这样重量级的Property Wrapper。还有 [ResultBuilder](https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md) 这种能够简化语法的特性，有些如GraphQL、REST和Networking实际使用ResultBuilder的 [范例可以参考](https://github.com/carson-katri/awesome-result-builders) 。这些Swift的特性如果也能得到充分利用，即使不用SwiftUI也能使开发效率得到大幅提升。

网飞（Netflix）App已使用SwiftUI重构了登录界面，网飞增长团队移动负责人故胤道长记录了SwiftUI在网飞的落地过程，详细描述了 [SwiftUI的收益](https://mp.weixin.qq.com/s/oRPRCx78owLe3_gROYapCw) 。网飞能够直接使用SwiftUI得益于他们最低支持iOS 13系统。

不过如最低支持系统低于iOS 13，还有开源项目 [AltSwiftUI](https://github.com/rakutentech/AltSwiftUI) 也实现了SwiftUI的语法和特性，能够向前兼容到iOS 11。

[Kuba Suder](https://twitter.com/kuba_suder) 做了一个 [SwiftUI Index/Changelog](https://mackuba.eu/swiftui/changelog) ，从官方文档中提取版本信息，一目了然 SwiftUI 每个版本 view，modifier 还有属性做了哪些增加和改变。当然也包括这次 SwiftUI 4 的更新。还有份对今年更新整理的 cheat sheet [What’s New In SwiftUI for iOS Cheat Sheet - WWDC22](https://bigmountainstudio.github.io/What-is-new-in-SwiftUI/) 。

SwiftUI 4 做了大量细节更新，比如添加了后台任务函数 [backgroundTask(_:action:)](https://developer.apple.com/documentation/swiftui/scene/backgroundtask(_:action:)?changes=latest_minor) 。List 改用 UICollectionView。AnyLayout 让 HStack 和 VStack 之间可以自由切换。`scrollDismissesKeyboard()` modifier 可以让键盘在滚动时自动 dismiss。`scrollIndicators()` modifier 可以隐藏 ScrollView 和 List 等视图的滚动指示。defersSystemGestures() modifier 允许我们的手势优先于系统的内置手势。颜色的 `.gradient ` 可以获得很简单的渐变，`Rectangle().fill(.red.gradient)`，还有 `.shadow` 用来创建投影 `Rectangle().fill(.red.shadow(.drop(color: .black, radius: 10)))`，还有 `.inner` 内阴影。`lineLimit()` modifier 支持范围设置。还有一些 modifier 支持 toggle 参数，比如 `.bold()` 和 `.italic()` 等，这样利于运行时进行调整。

嵌入 UIKit
示例如下：
```swift
cell.contentConfiguration = UIHostingConfiguration {
    VStack {
        Image(systemName: "wand.and.stars")
            .font(.title)
        Text("Like magic!")
            .font(.title2).bold()
    }
    .foregroundStyle(Color.purple)
}
```

锁屏的 Widget 和 WatchOS 一样，可以瞟一眼就获取信息。

官方指南 [Creating Lock Screen Widgets and Watch Complications](https://developer.apple.com/documentation/WidgetKit/Creating-lock-screen-widgets-and-watch-complications)

可以将 SwiftUI 的 View 生成图片。

官方参考文档 [ImageRenderer](https://developer.apple.com/documentation/swiftui/imagerenderer)

session [Efficiency awaits: Background tasks in SwiftUI](https://developer.apple.com/videos/play/wwdc2022-10142) 了解如何使用 SwiftUI 后台任务 API 简洁地处理任务。展示如何使用 Swift Concurrency 来处理网络响应、后台刷新等——同时保持性能和功率。
