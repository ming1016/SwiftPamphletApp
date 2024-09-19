# 戴铭的开发小册子 6.x
[![Available on the App Store](https://ming1016.github.io/qdimg/badge-download-on-the-mac-app-store.svg)](https://apps.apple.com/cn/app/id1609702529)

Swift开发的手册，是个 macOS 程序，已上线macOS应用商店，[点击安装](https://apps.apple.com/cn/app/%E6%88%B4%E9%93%AD%E7%9A%84%E5%BC%80%E5%8F%91%E5%B0%8F%E5%86%8C%E5%AD%90/id1609702529?mt=12)，或直接在商店搜索“戴铭”关键字。安装应用方便更新程序。在我[博客](https://starming.com)上会有部分文字内容可以看。有什么想说的，来我的 [Discord](https://discord.gg/sBksuXjQmj) 吧

本手册使用 SwiftData、Observable、NavigationSplitView 进行了重构，现在可自己添加管理资料，和知识点做关联。

内容主要包含

- Apple 技术知识点以及示例

功能主要包含

- 手册书签收藏
- 资料收集整理（参考[我是怎么做个人知识管理（PKM）的，从史前时代备忘录、Sublime，经历了Evernote，Markdown兴起，Bear的优雅，Notion革命，飞书语雀，Obsidian、Flomo，到最后使用卢曼卡片盒笔记法串起了流程](https://mp.weixin.qq.com/s/PbUOxURK57eIeSnuE1mh4g)这篇文章，里面有提及如何使用小册子的资料整理功能）
- 离线保存资料
- 知识点和资料关联
- 手册内容和资料可搜索
- Github 开发者和仓库信息添加管理

本应用知识点目前主要有 Swift 基础语法，SwiftUI，SwiftData，小组件等知识内容。

本版本解决了以下几个问题。

第一个，存储的问题。以前使用的是三方数据库，写法比较繁琐且和 SwiftUI 结合的不好。现在用的是 SwiftData，写法简洁了很多，代码也好维护了。更多技术重构细节可以直接查看代码。

第二，手册内容和资料之间的关系。以前比较隔离，资料和手册没有联系。现在采用的是每个知识点都可以添加相关资料，这样更利于知识的积累。

第三，Github 库和开发者信息的管理问题。以前添加和删除都在代码层面，现在可以直接在 App 内进行。

这三个问题解决后，可以将更多精力花在内容的更新增加以及 App 使用体验上了。

![截屏2024-05-07 18 54 42](https://github.com/ming1016/SwiftPamphletApp/assets/251980/9514574b-0f20-4ff5-848c-9b5130f03b81)

![截屏2024-05-07 18 48 33](https://github.com/ming1016/SwiftPamphletApp/assets/251980/f748a32d-7f4d-4327-a4b5-97a65ca754ec)

![截屏2024-05-07 18 49 43](https://github.com/ming1016/SwiftPamphletApp/assets/251980/bb147ab7-5cbc-4263-a023-b924054a0f4b)

![截屏2024-05-07 19 06 30](https://github.com/ming1016/SwiftPamphletApp/assets/251980/f590cbe5-8a94-41e3-8260-6492e3acf46e)

![截屏2024-05-07 19 08 18](https://github.com/ming1016/SwiftPamphletApp/assets/251980/89b34786-44b1-4fcd-bdf6-8ad92ea80d4e)


