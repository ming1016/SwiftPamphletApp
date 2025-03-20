# SwiftPamphletApp 项目文件结构及说明

## 应用核心

### App 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/App/SwiftPamphletAppApp.swift** - 应用主入口，包含应用生命周期管理、性能监控和后台任务配置
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/App/SwiftPamphletAppConfig.swift** - 应用全局配置，包含各种常量、AppStorage 键值和 GitHub 访问令牌管理
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/App/IntroView.swift** - 应用欢迎页面视图，显示应用图标和版本信息
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/App/AutoTask.swift** - 自动化任务处理，用于生成内容等批处理任务

### Core 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Core/FundationFunction.swift** - 基础功能函数和扩展，包含 Web、Base64、复制文本等通用功能

## 用户界面

### HomeUI 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/HomeUI/HomeView.swift** - 主页视图，应用程序的主界面
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/HomeUI/DataLink.swift** - 数据链接模型，管理应用中不同区域内容的导航

### 信息组织功能

#### InfoOrganizer 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/InfoOrganizer/Info/InfoListView.swift** - 信息列表视图，显示所有资料项目
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/InfoOrganizer/Info/InfoRowView.swift** - 信息行视图，单个信息项的显示组件
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/InfoOrganizer/Info/EditInfoView.swift** - 编辑信息视图，用于创建和编辑信息
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/InfoOrganizer/Info/ArchivedInfos/ArchivedInfosView.swift** - 归档信息视图，显示已归档的信息项
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/InfoOrganizer/Info/StarInfos/StarInfosView.swift** - 收藏信息视图，显示已收藏的信息项
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/InfoOrganizer/Info/UnCategoryInfos/UnCategoryInfosView.swift** - 未分类信息视图，显示未分类的信息项

### 指南功能

#### Guide 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Guide/View/GuideOutline/AppleGuide.swift** - Apple技术指南大纲，定义Apple技术文档的分类和结构
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Guide/View/GuideListView.swift** - 指南列表视图，以树状结构显示技术指南
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Guide/WWDC/WWDCModel.swift** - WWDC模型，定义WWDC会话数据结构
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Guide/WWDC/WWDCDetailView.swift** - WWDC详情视图，展示WWDC会话详细信息

### GitHub功能

#### GitHubAPIUI 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/GitHubAPIUI/Developer/DeveloperListView.swift** - 开发者列表视图，显示GitHub开发者和仓库信息

### 性能工具

#### Performance 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Performance/TaskCase/TaskCaseLoadFile.swift** - 任务案例加载文件，演示文件加载性能优化

## 共享包

### SharePackage 目录
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/SharePackage/SMFile/Sources/SMFile/SMFile.swift** - 文件操作工具库，提供文件读取、保存等功能
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/SharePackage/InfoOrganizer/Sources/InfoOrganizer/Model/InfoDataModel.swift** - 信息数据模型，定义SwiftData模型结构

## 资源文件

### Resource 目录

#### Guide/Swift语法
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/Swift规范(ap).md** - Swift代码规范指南
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/Swift各版本演进(ap).md** - Swift各版本特性变化历史
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/Swift书单(ap).md** - Swift学习书籍推荐列表
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/语法基础/访问控制(ap).md** - Swift访问控制语法介绍
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/语法基础/注释(ap).md** - Swift注释语法介绍
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/语法基础/打印(ap).md** - Swift打印函数使用介绍
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/类和结构体/方法(ap).md** - Swift方法相关语法介绍
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/Swift语法/基础类型/数字(ap).md** - Swift数字类型介绍

#### 其他资源
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Style/footer_js.html** - 页面底部JavaScript脚本
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Style/css_cn.html** - 中文页面CSS样式
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/1.md** - 应用介绍和版本信息

#### 文档
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/SwiftPamphletApp/Resource/Guide/appstore/Apple/0.Document/PromptHistory.md** - 提示词历史记录

## 项目文档
- **/Users/mingdai/Documents/GitHub/SwiftPamphletApp/Document/WorkspaceFilesDes.md** - 本文件，项目文件结构和功能说明