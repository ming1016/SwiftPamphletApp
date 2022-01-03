## 戴铭的 Swift 小册子 2.0

越来越多同学打算开始用 Swift 来开发了，可很多人以前都没接触过 Swift。这篇[戴铭的 Swift 小册子 · 戴铭的博客 - 星光社](https://ming1016.github.io/2021/11/23/daiming-swift-pamphlet/)和我以前文章不同的是，本篇只是面向 Swift 零基础的同学，内容主要是一些直接可用的小例子，例子可以直接在工程中用或自己调试着看。

记得以前 PHP 有个 chm 的手册，写的很简单，但很全，每个知识点都有例子，社区版每个知识点下面还有留言互动。因此，我弄了个 Swift 的手册，是个 macOS 程序。建议使用我开发的这个 macOS 程序来浏览，使用方法是：
* 从  [GitHub - KwaiAppTeam/SwiftPamphletApp: 戴铭的 Swift 小册子，一本活的 Swift 手册](https://github.com/KwaiAppTeam/SwiftPamphletApp)  仓库拉代码。
* 然后在 SwiftPamphletAppConfig.swift 里 gitHubAccessToken 加入你的 GitHub Access Token。GitHub Access Token 在  [Personal Access Tokens](https://github.com/settings/tokens)  这里获取，scope 勾上 repo 和 user。
* 使用Xcode编译生成这个手册程序或是连点两下compile.command。Xcode 和 macOS 都需要升到最新版，如果遇到 swift package 下载不下来的情况，参看这个议题来解决：[请问markdownui一直更新不下来是什么原因 · Issue #88 · KwaiAppTeam/SwiftPamphletApp · GitHub](https://github.com/KwaiAppTeam/SwiftPamphletApp/issues/88)

***以下可以不用进入Xcode设置开发人员帐号并完成编译***
* 可使用compile.command编译手册程序，无需开启Xcode设置个人开发帐号，只需在SwiftPamphletAppConfig.swift 里 gitHubAccessToken 加入你的 GitHub Access Token，完成后连点compile.command两下等待作业完成。Xcode 和 macOS 都需要升到最新版。GitHub Access Token 在  [Personal Access Tokens](https://github.com/settings/tokens)  这里获取，scope 勾上 repo 和 user。
* 或使用Github action workflow 编译，无需在本地操作、也无需开启Xcode设置个人开发帐号，只需设置personal access token(PAT)在repository设定中action secrets，并命名为PAT。Frok此repository，设置PAT，手动启用action，等候约3分钟即可下载档案，往后专案更新时，只需fetch and merge，action会自动进行。

感谢[@powenn](https://github.com/powenn) 做的 GitHub Actions workflow，使用说明如下：
Requires storaging PAT to actions secrets and name it to PAT

- Fork this repository.
- Go to get a Personal Access Token(PAT) if you haven't done it yet.(GitHub Access Token 在[Personal Access Tokens](https://github.com/settings/tokens)这里获取，scope 勾上 repo 和 user。)
- Set your token in action secrets ,and name it to PAT.
- Get the compiled app package after Github action complete.

While project update ,you won't need to compile it manually in local, only need to fetch and merge commits and wait for about 3 minutes then download it

![image](https://user-images.githubusercontent.com/251980/146639561-8d33bba6-8a84-44b7-b660-1d7a5fffa37a.png)
![image](https://user-images.githubusercontent.com/251980/146639573-e556961f-2c4b-4838-83f2-8bf4665b7d9a.png)


程序截图如下：
![01](https://user-images.githubusercontent.com/251980/142998258-0f44f4fe-e113-4428-b381-be7e4eb5a899.png)
![02](https://user-images.githubusercontent.com/251980/142998276-70f12cd3-46e5-46f0-b5e1-185ec9b0beee.png)
![03](https://user-images.githubusercontent.com/251980/142998296-e6091abe-8639-47f4-acda-f0c20fa20b5e.png)
![04](https://user-images.githubusercontent.com/251980/142998321-37f5d2e7-3377-4b6b-b412-1ac0ae914b56.png)
![05](https://user-images.githubusercontent.com/251980/142998327-c208631c-5d04-433c-b29f-35454864ceed.png)
![06](https://user-images.githubusercontent.com/251980/142998328-4bdea487-4672-4cd9-a3c7-14b93ef947ee.png)
![07](https://user-images.githubusercontent.com/251980/142998333-891f4aeb-6dea-4be1-850d-ddc2bcc5c956.png)


这个程序是Swift写的，按照声明式UI，响应式编程范式开发的，源码也可以看看。与其讲一堆，不如调着试。
