## 戴铭的 Swift 小册子

越来越多同学打算开始用 Swift 来开发了，可很多人以前都没接触过 Swift。这篇[戴铭的 Swift 小册子 · 戴铭的博客 - 星光社](https://ming1016.github.io/2021/11/23/daiming-swift-pamphlet/)和我以前文章不同的是，本篇只是面向 Swift 零基础的同学，内容主要是一些直接可用的小例子，例子可以直接在工程中用或自己调试着看。

记得以前 PHP 有个 chm 的手册，写的很简单，但很全，每个知识点都有例子，社区版每个知识点下面还有留言互动。因此，我弄了个 Swift 的手册，是个 macOS 程序。建议使用我开发的这个 macOS 程序来浏览，使用方法是：
* 从  [GitHub - ming1016/SwiftPamphletApp: 戴铭的 Swift 小册子，一本活的 Swift 手册](https://github.com/ming1016/SwiftPamphletApp)  仓库拉代码。
* 然后在 SwiftPamphletAppConfig.swift 里 gitHubAccessToken 加入你的 GitHub Access Token。GitHub Access Token 在  [Personal Access Tokens](https://github.com/settings/tokens)  这里获取，scope 勾上 repo 和 user。
* 使用Xcode编译生成这个手册程序或是连点两下compile.command。Xcode 和 macOS 都需要升到最新版，如果遇到 swift package 下载不下来的情况，参看这个议题来解决：[请问markdownui一直更新不下来是什么原因 · Issue #88 · ming1016/SwiftPamphletApp · GitHub](https://github.com/ming1016/SwiftPamphletApp/issues/88)

截图如下：
![01](https://user-images.githubusercontent.com/251980/142998258-0f44f4fe-e113-4428-b381-be7e4eb5a899.png)
![02](https://user-images.githubusercontent.com/251980/142998276-70f12cd3-46e5-46f0-b5e1-185ec9b0beee.png)
![03](https://user-images.githubusercontent.com/251980/142998296-e6091abe-8639-47f4-acda-f0c20fa20b5e.png)
![04](https://user-images.githubusercontent.com/251980/142998321-37f5d2e7-3377-4b6b-b412-1ac0ae914b56.png)
![05](https://user-images.githubusercontent.com/251980/142998327-c208631c-5d04-433c-b29f-35454864ceed.png)
![06](https://user-images.githubusercontent.com/251980/142998328-4bdea487-4672-4cd9-a3c7-14b93ef947ee.png)
![07](https://user-images.githubusercontent.com/251980/142998333-891f4aeb-6dea-4be1-850d-ddc2bcc5c956.png)


这个程序是Swift写的，按照声明式UI，响应式编程范式开发的，源码也可以看看。与其讲一堆，不如调着试。
