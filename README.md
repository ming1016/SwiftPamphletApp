# 戴铭的开发小册子 4.3

Swift开发的手册，是个 macOS 程序。
![](https://user-images.githubusercontent.com/251980/153746040-8379ad07-4f64-4cb2-b162-40a80fb87d6b.PNG)

## 下载

直接下载最新 dmg 使用：[戴铭的开发小册子4.4.dmg.zip](https://github.com/KwaiAppTeam/SwiftPamphletApp/files/8150518/4.4.dmg.zip)


## 编译

自己编译生成程序的方法是：

### 方式一：本地编译

* 拉代码。直接编译生成无 Github 功能的手册程序。
* 如要带 Github 功能可在 SwiftPamphletAppConfig.swift 里 gitHubAccessToken 加入你的 GitHub Access Token。GitHub Access Token 在  [Personal Access Tokens](https://github.com/settings/tokens)  这里获取。记得scope 勾上 repo 和 user。
* 使用Xcode编译生成这个手册程序或是连点两下compile.command。

Xcode 和 macOS 都需要升到最新版。如果遇到 swift package 下载不下来的情况，参看这个议题来解决：[Issue #88](https://github.com/KwaiAppTeam/SwiftPamphletApp/issues/88)

### 方式二：云编译

***无需 Xcode 设置开发人员帐号编译***

* 可使用 compile.command 编译手册程序，无需开启 Xcode 设置个人开发帐号，只需在 SwiftPamphletAppConfig.swift 里 gitHubAccessToken 加入你的 [GitHub Access Token](https://github.com/settings/tokens)，完成后连点 compile.command 两下等待作业完成。
* 或使用 Github action workflow 编译（感谢[@powenn](https://github.com/powenn)），无需在本地操作、也无需开启 Xcode 设置个人开发帐号，只需设置 personal access token(PAT) 在 repository 设定中 action secrets，并命名为 PAT。Fork 此 repository，设置 PAT，手动启用 action，等候约3分钟即可下载档案，往后专案更新时，只需 fetch and merge，action 会自动进行。

英文说明：
Requires storaging PAT to actions secrets and name it to PAT

- Fork this repository.
- Go to get a Personal Access Token(PAT) if you haven't done it yet.(GitHub Access Token in [Personal Access Tokens](https://github.com/settings/tokens)，scope checked repo and user)
- Set your token in action secrets ,and name it to PAT.
- Get the compiled app package after Github action complete.

While project update ,you won't need to compile it manually in local, only need to fetch and merge commits and wait for about 3 minutes then download it

### 介绍
小册子能够方便的查看 Swift 语法，还有一些主要库的使用指南，内容还在完善中，选择的库主要就是开发小册子应用使用到的 SwitUI、Combine、Swift Concurrency

除了这些速查和库的使用内容外，这个应用还有一些开发者的动态，当他们有新的动作，比如提交了代码、star 了什么项目，提交和留言了议题都会直接在程序坞中提醒你。 

![](https://ming1016.github.io/uploads/develop-macos-with-swiftui-combine-concurrency-aysnc-await-actor/15.png)

我对一些库做了分类，方便按需查找，库有新的提交也会在程序坞中提醒。 

![](https://ming1016.github.io/uploads/develop-macos-with-swiftui-combine-concurrency-aysnc-await-actor/16.png)

还能方便的查看库的议题。比如在阮一峰的《科技爱好者周刊》的议题中可以看到有很多人推荐和自荐了一些信息。保留议题有一千六百多个。 

![](https://ming1016.github.io/uploads/develop-macos-with-swiftui-combine-concurrency-aysnc-await-actor/17.png)

博客动态的功能，可以跟进一些博客内容的更新。 

代码说明参看这篇[《如何用 SwiftUI + Combine + Swift Concurrency Aysnc/Await Actor 欢畅开发》](https://ming1016.github.io/2022/01/03/develop-macos-with-swiftui-combine-concurrency-aysnc-await-actor/)文章

小册子文字版 《[戴铭的 Swift 小册子](https://ming1016.github.io/2021/11/23/daiming-swift-pamphlet/)》


