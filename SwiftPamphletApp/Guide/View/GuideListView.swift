//
//  AppleGuideListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/28.
//

import SwiftUI
import SwiftData
import SMFile

struct GuideListView: View {
    @Query(BookmarkModel.all) var bookmarks: [BookmarkModel]
    @State private var apBookmarks: [String] = [String]()
    @State private var listModel = GuideListModel()
    @State private var limit: Int = 50
    @State private var trigger = false // 触发列表书签状态更新
    var body: some View {
        if listModel.searchText.isEmpty == false {
            HStack {
                Text("搜索”\(listModel.searchText)“结果如下")
                Button {
                    listModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
            .padding(.top, 10)
        }
        SPOutlineListView(d: listModel.filtered(), c: \.sub) { i in
            NavigationLink(destination: GuideDetailView(t: i.t, icon: i.icon, plName: "ap", limit: $limit, trigger: $trigger)) {
                HStack(spacing:3) {
                    if i.icon.isEmpty == false {
                        Image(systemName: i.icon)
                            .foregroundStyle(i.sub == nil ? Color.secondary : .indigo)
                    } else if i.sub != nil {
                        Image(systemName: "folder.fill")
                            .foregroundStyle(.indigo)
                    }
                    Text(listModel.searchText.isEmpty == true ? GuideListModel.simpleTitle(i.t) : i.t)
                    Spacer()
                    if apBookmarks.contains(i.t) {
                        Image(systemName: "bookmark")
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                    }
                }
                .contentShape(Rectangle())
            }
        }
        .searchable(text: $listModel.searchText, prompt: "搜索 Apple 技术手册")
        .listStyle(.sidebar)
        .onChange(of: trigger, { oldValue, newValue in
            updateApBookmarks()
        })
        .onAppear(perform: {
            updateApBookmarks()
            //导出内容
//            listModel.buildMDContent()
            
        })
        .overlay {
            if listModel.filtered().isEmpty {
                ContentUnavailableView {
                    Label("无结果", systemImage: "rectangle.and.text.magnifyingglass")
                } description: {
                    Text("请再次输入")
                }
            }
        } // end overlay
    }
    
    func updateApBookmarks() {
        apBookmarks = [String]()
        for bm in bookmarks {
            if bm.pamphletName == "ap" {
                apBookmarks.append(bm.name)
            }
        }
    }
}

@Observable
final class GuideListModel {
    var searchText = ""
    
    func filtered() -> [L] {
        guard !searchText.isEmpty else { return lModel }
        let flatModel = flatLModel(lModel)
        return flatModel.filter { model in
            model.t.lowercased().contains(searchText.lowercased())
        }
    }
    
    func flatLModel(_ models: [L]) -> [L] {
        var fModels = [L]()
        for model in models {
            fModels.append(model)
            if let subs = model.sub {
                let reFModels = flatLModel(subs)
                for reModel in reFModels {
                    fModels.append(reModel)
                }
            }
        }
        return fModels
    }
    
    static func simpleTitle(_ title: String) -> String {
        let arr = title.split(separator: "-")
        if arr.first == arr.last {
            return title
        } else {
            return arr.last?.description ?? ""
        }
    }
    
    // 导出内容
    func buildMDContent() {
        var md = ""
        for one in lModel {
            if one.t == "动画" {
                if let oneSub = one.sub {
                    for two in oneSub {
                        let str =   SMFile.loadBundleString("\(two.t)(ap).md")
                        let strformat = "## \(two.t)\n" + str.replacingOccurrences(of: "## ", with: "### ")
                        md += strformat
                        
                        if two.t == "数据集合组件" {
                            if let twoSub = two.sub {
                                for three in twoSub {
                                    if let threeSub = three.sub {
                                        let title = "\n## \(three.t)\n"
                                        var fourStrs = ""
                                        for four in threeSub {
                                            let fourStr = SMFile.loadBundleString("\(four.t)(ap).md")
                                            let fourStrformat = "\n### \(four.t)\n" + fourStr.replacingOccurrences(of: "## ", with: "#### ")
                                            fourStrs += fourStrformat
                                        }
                                        md += title + fourStrs
                                    } else {
                                        let threeStr = SMFile.loadBundleString("\(three.t)(ap).md")
                                        let threeStrformat = "\n## \(three.t)\n" + threeStr.replacingOccurrences(of: "## ", with: "### ")
                                        md += threeStrformat
                                    }
                                }
                            }
                        }
                    } // end for two
                } // end if let oneSub
                
            } // end if one.t
        } // end for one
        SMFile.writeToDownload(fileName: "read.md", content: md)
    }
    
    var lModel = [
        L(t: "Swift语法", icon: "swift", sub: [
            L(t: "语法基础", sub: [
                L(t: "变量"),
                L(t: "打印", icon: "printer"),
                L(t: "注释", icon: "number.square"),
                L(t: "可选", icon: "exclamationmark.questionmark"),
                L(t: "闭包"),
                L(t: "函数"),
                L(t: "访问控制"),
                L(t: "Regex")
            ]),
            L(t: "基础类型", sub: [
                L(t: "数字"),
                L(t: "布尔数"),
                L(t: "字符串"),
                L(t: "枚举"),
                L(t: "元组"),
                L(t: "泛型和协议"),
                L(t: "不透明类型"),
                L(t: "Result"),
                L(t: "类型转换")
            ]),
            L(t: "类和结构体",sub: [
                L(t: "类"),
                L(t: "结构体"),
                L(t: "属性"),
                L(t: "方法"),
                L(t: "继承")
            ]),
            L(t: "函数式",sub: [
                L(t: "map"),
                L(t: "filter"),
                L(t: "reduce"),
                L(t: "sorted")
            ]),
            L(t: "控制流",sub: [
                L(t: "If"),
                L(t: "Guard"),
                L(t: "遍历"),
                L(t: "While"),
                L(t: "Switch")
            ]),
            L(t: "集合",sub: [
                L(t: "数组"),
                L(t: "Sets"),
                L(t: "字典")
            ]),
            L(t: "操作符",sub: [
                L(t: "赋值"),
                L(t: "计算符"),
                L(t: "比较运算符"),
                L(t: "三元"),
                L(t: "Nil-coalescing"),
                L(t: "范围"),
                L(t: "逻辑"),
                L(t: "恒等"),
                L(t: "运算符")
            ]),
            L(t: "Swift各版本演进"),
            L(t: "Swift规范"),
            L(t: "Swift书单")
        ]),
        L(t: "基础库", icon: "globe.asia.australia.fill", sub: [
            L(t: "系统及设备", sub: [
                L(t: "系统判断"),
                L(t: "版本兼容"),
                L(t: "canImport判断库是否可使用"),
                L(t: "targetEnvironment环境的判断")
            ]),
            L(t: "自带属性包装", sub: [
                L(t: "@resultBuilder"),
                L(t: "@dynamicMemberLookup动态成员查询"),
                L(t: "@dynamicCallable动态可调用类型")
            ]),
            L(t: "自带协议", sub: [
                L(t: "@resultBuilder"),
                L(t: "JSON没有id字段")
            ]),
            L(t: "时间"),
            L(t: "格式化", sub: [
                L(t: "格式化-时间"),
                L(t: "格式化-数据"),
                L(t: "格式化-度量值"),
                L(t: "格式化-生活日常"),
            ]),
            L(t: "度量值"),
            L(t: "Data"),
            L(t: "文件"),
            L(t: "Scanner"),
            L(t: "AttributeString"),
            L(t: "随机"),
            L(t: "UserDefaults")
        ]),
        L(t: "SwiftUI",icon: "heart.text.square.fill",sub: [
            L(t: "介绍",sub: [
                L(t: "SwiftUI是什么"),
                L(t: "SwiftUI参考资料"),
                L(t: "SwiftUI对标的UIKit视图"),
            ]),
            L(t: "图文组件",sub: [
                L(t: "Text", sub: [
                    L(t: "Text"),
                    L(t: "Text-动态时间")
                ]),
                L(t: "Link"),
                L(t: "Label"),
                L(t: "TextEditor", icon: "arrow.up.and.down.text.horizontal"),
                L(t: "TextField"),
                L(t: "Image"),
            ]),
            L(t: "数据集合组件",icon: "list.bullet.rectangle.fill", sub: [
                L(t: "ForEach"),
                L(t: "Scroll视图", icon: "scroll.fill", sub: [
                    L(t: "ScrollView", icon: "arrow.up.arrow.down.circle"),
                    L(t: "固定到滚动视图的顶部",icon: "pin.circle"),
                    L(t: "滚动到特定的位置"),
                    L(t: "scrollTargetBehavior分页滚动", icon: "book.pages"),
                    L(t: "scrollTransition视觉效果"),
                    L(t: "ScrollView-参考资料", icon: "books.vertical"),
                ]),
                L(t: "List列表", icon: "list.bullet.rectangle.portrait.fill", sub: [
                    L(t: "List", icon: "list.bullet.rectangle.portrait"),
                    L(t: "List-设置样式"),
                    L(t: "List-移动元素"),
                    L(t: "List-搜索", icon: "text.magnifyingglass"),
                    L(t: "List-下拉刷新", icon: "arrow.circlepath"),
                    L(t: "List-轻扫操作", icon: "hand.point.up.left.and.text"),
                    L(t: "List-大纲视图", icon: "list.number"),
                    L(t: "List-完全可点击的行", icon: "chevron.right.circle"),
                    L(t: "List-索引标题", icon: "textformat.abc.dottedunderline"),
                    L(t: "List-加载更多", icon: "arrow.down.circle"),
                ]),
                L(t: "Lazy容器", sub: [
                    L(t: "LazyVStack和LazyHStack"),
                    L(t: "LazyVGrid和LazyHGrid"),
                ]),
                L(t: "Grid", icon: "square.grid.3x2"),
                L(t: "Table表格", icon: "tablecells.fill", sub: [
                    L(t: "Table", icon: "tablecells"),
                    L(t: "Table-样式", icon: "paintbrush"),
                    L(t: "Table-行的选择", icon: "line.3.horizontal"),
                    L(t: "Table-多属性排序", icon: "tablecells.badge.ellipsis"),
                    L(t: "Table-contextMenu", icon: "filemenu.and.selection"),
                    L(t: "Table-拖拽"),
                    L(t: "Table-可交互"),
                ]),
            ]),
            L(t: "布局组件",icon: "rectangle.3.group.fill", sub: [
                L(t: "Navigation导航", icon: "sidebar.squares.leading", sub: [
                    L(t: "Navigation", icon: "sidebar.squares.leading"),
                    L(t: "NavigationStack", icon: "square.stack.3d.down.forward"),
                    L(t: "NavigationPath", icon: "arrow.3.trianglepath"),
                    L(t: "NavigationSplitView", icon: "rectangle.split.3x1"),
                    L(t: "自定义导航栏"),
                    L(t: "Inspectors右侧多出一栏", icon: "rectangle.split.3x1"),
                    L(t: "导航状态保存和还原"),
                ]),
                L(t: "布局基础",icon: "rectangle.3.group", sub: [
                    L(t: "布局-基础"),
                    L(t: "布局-留白", icon: "space"),
                    L(t: "布局-对齐", icon: "align.vertical.top"),
                    L(t: "布局-居中", icon: "align.horizontal.center"),
                    L(t: "布局-offset偏移"),
                    L(t: "Safe Area"),
                    L(t: "布局原理"),
                ]),
                L(t: "布局进阶", sub: [
                    L(t: "AnyLayout"),
                    L(t: "ViewThatFits"),
                    L(t: "Layout协议"),
                    L(t: "GeometryReader"),
                    L(t: "alignmentGuide"),
                    L(t: "布局进阶-参考资料"),
                ]),
                L(t: "Stack", icon: "square.3.layers.3d"),
                L(t: "GroupBox", icon: "shippingbox"),
                L(t: "TabView"),
                L(t: "ControlGroup"),
                L(t: "Advanced layout control"),
                L(t: "ContentUnavailableView"),
            ]),
            L(t: "表单", sub: [
                L(t: "Form"),
                L(t: "Picker选择器", sub: [
                    L(t: "Picker", icon: "filemenu.and.selection"),
                    L(t: "文字Picker", icon: "contextualmenu.and.cursorarrow"),
                    L(t: "ColorPicker", icon: "paintpalette"),
                    L(t: "DatePicker", icon: "calendar"),
                    L(t: "PhotoPicker", icon: "photo.on.rectangle.angled"),
                    L(t: "字体Picker", icon: "doc.richtext"),
                    L(t: "WheelPicker"),
                ]),
                L(t: "Toggle", icon: "togglepower"),
                L(t: "Slider", icon: "slider.horizontal.below.sun.max"),
                L(t: "Stepper"),
            ]),
            L(t: "浮层组件", sub: [
                L(t: "浮层"),
                L(t: "Sheet"),
                L(t: "Full Screen Modal View"),
                L(t: "confirmationDialog()"),
                L(t: "Alert", icon: "exclamationmark.triangle"),
                L(t: "Popover", icon: "text.bubble"),
                L(t: "Menu和ContextMenu", icon: "filemenu.and.selection"),
                L(t: "HUD", icon: "speedometer"),
            ]),
            L(t: "视图组件",sub: [
                L(t: "Button"),
                L(t: "进度"),
                L(t: "Keyboard"),
                L(t: "Transferable"),
                L(t: "ShareLink")
            ]),
            L(t: "视觉",sub: [
                L(t: "SwiftUI颜色", icon: "paintbrush"),
                L(t: "SwiftUI-Shadow", icon: "moon.circle"),
                L(t: "Blend Modes"),
                L(t: "SwiftUI-渐变"),
                L(t: "SwiftUI-模糊"),
                L(t: "SwiftUI-背景材质"),
                L(t: "SwiftUI Effect", icon: "sparkles"),
                L(t: "SwiftUI Canvas"),
                L(t: "SF Symbol", icon: "star"),
                L(t: "SwiftCharts", icon: "chart.line.uptrend.xyaxis"),
                L(t: "Shaders Metal", icon: "cpu"),
            ]),
            L(t: "修饰符", sub: [
                L(t: "自定义修饰符"),
                L(t: "背景修饰符"),
                L(t: "修饰符-visualEffect"),
                L(t: "修饰符-圆角"),
                L(t: "ContainerRelativeShape"),
                L(t: "修饰符-fixedSize"),
                L(t: "修饰符-蒙版"),
                L(t: "redacted隐私展示"),
            ]),
            L(t: "视图协议",sub: [
                L(t: "视图协议-简介"),
                L(t: "视图协议-核心协议"),
                L(t: "Style协议"),
                L(t: "小组件协议"),
                L(t: "Shapes协议"),
                L(t: "Animations协议"),
                L(t: "视图协议-Environment"),
                L(t: "Previews协议"),
                L(t: "Legacy bridges协议"),
                L(t: "Responder chain协议"),
                L(t: "Toolbar协议"),
                L(t: "Documents协议"),
                L(t: "特定情况视图协议"),
            ]),
            L(t: "SwiftUI-自定义样式"),
            L(t: "ViewBuilder"),
            L(t: "数据流", sub: [
                L(t: "SwiftUI数据流"),
                L(t: "SwiftUI数据流-@State"),
                L(t: "SwiftUI数据流-@Binding"),
                L(t: "SwiftUI数据流-@Observable"),
                L(t: "SwiftUI数据流-@Environment"),
                L(t: "SwiftUI数据流-@AppStorage")
            ])
        ]),
        L(t: "SwiftData", icon: "swiftdata", sub: [
            L(t: "SwiftData基础"),
            L(t: "创建@Model模型", icon: "plus.rectangle.on.rectangle"),
            L(t: "SwiftData-模型关系", icon: "arrow.triangle.2.circlepath"),
            L(t: "容器配置modelContainer", icon: "gearshape.2"),
            L(t: "增删modelContext"),
            L(t: "SwiftData-检索", icon: "magnifyingglass.circle"),
            L(t: "SwiftData-处理大量数据", icon: "externaldrive.connected.to.line.below"),
            L(t: "SwiftData多线程", icon: "arrow.triangle.branch"),
            L(t: "SwiftData-版本迁移", icon: "arrow.right.arrow.left.square"),
            L(t: "SwiftData-调试", icon: "ant"),
            L(t: "SwiftData和CoreData"),
            L(t: "SwiftData-资料", icon: "books.vertical")
        ]),
        L(t: "小组件", icon: "window.shade.open", sub: [
            L(t: "小组件-StaticConfiguration",icon: "doc.plaintext"),
            L(t: "小组件-AppIntentConfiguration"),
            L(t: "小组件-配置选项",icon: "rectangle.portrait.bottomleft.inset.filled"),
            L(t: "AppIntentTimelineProvider"),
            L(t: "Widget View", icon: "rectangle.grid.1x2"),
            L(t: "刷新小组件", icon: "arrow.clockwise.circle"),
            L(t: "小组件动画", icon: "figure.disc.sports"),
            L(t: "小组件-远程定时获取数据", icon: "cloud"),
            L(t: "小组件-获取位置权限更新内容", icon: "location.fill.viewfinder"),
            L(t: "支持多个小组件", icon: "rectangle.grid.2x2"),
            L(t: "获取小组件形状", icon: "rectangle.inset.filled"),
            L(t: "小组件-Deep link", icon: "link.circle"),
            L(t: "小组件访问SwiftData", icon: "externaldrive"),
            L(t: "小组件-参考资料", icon: "books.vertical"),
        ]),
        L(t: "系统能力",icon: "apple.terminal",sub: [
            L(t: "Swift-DocC", icon: "doc.append"),
            L(t: "AppIcon", icon: "app")
        ]),
        L(t: "工程模式",icon: "building.columns", sub: [
            L(t: "单例"),
            L(t: "程序入口点", icon: "door.right.hand.open")
        ]),
        L(t: "多线程", icon: "text.line.first.and.arrowtriangle.forward", sub: [
            L(t: "Swift Concurrency",sub: [
                L(t: "Swift Concurrency是什么"),
                L(t: "async await"),
                L(t: "Async Sequences"),
                L(t: "结构化并发"),
                L(t: "Actors"),
                L(t: "Distributed Actors"),
                L(t: "Swift Concurrency相关提案"),
                L(t: "Swift Concurrency学习路径"),
                L(t: "Swift Concurrency和Combine"),
                L(t: "Concurrency技术演进")
            ]),
            L(t: "Combine",sub: [
                L(t: "介绍",sub: [
                    L(t: "Combine是什么"),
                    L(t: "Combine的资料")
                ]),
                L(t: "使用说明",sub: [
                    L(t: "publisher"),
                    L(t: "Just"),
                    L(t: "PassthroughSubject"),
                    L(t: "Empty"),
                    L(t: "CurrentValueSubject"),
                    L(t: "removeDuplicates"),
                    L(t: "flatMap"),
                    L(t: "append"),
                    L(t: "prepend"),
                    L(t: "merge"),
                    L(t: "zip"),
                    L(t: "combineLatest"),
                    L(t: "Scheduler")
                ]),
                L(t: "使用场景",sub: [
                    L(t: "Combine网络请求"),
                    L(t: "Combine KVO"),
                    L(t: "Combine通知"),
                    L(t: "Combine Timer")
                ])
            ]),
        ]),
        L(t: "图片处理", icon: "photo.stack", sub: [
            L(t: "图片处理-基础")
        ]),
        L(t: "动画", icon: "moonphase.waning.gibbous.inverse", sub: [
            L(t: "SwiftUI动画", icon: "play"),
            L(t: "contentTransition", icon: "number.circle"),
            L(t: "animation修饰符", icon: "waveform.path.ecg"),
            L(t: "Transaction", icon: "arrow.right.arrow.left"),
            L(t: "Matched Geometry Effect", icon: "arrow.triangle.2.circlepath"),
            L(t: "PhaseAnimator", icon: "arrow.up.right.circle"),
            L(t: "KeyframeAnimator"),
            L(t: "布局动画", icon: "squareshape.split.2x2.dotted"),
            L(t: "动画-例子", icon: "lightbulb")
        ]),
        L(t: "网络", icon:"point.3.connected.trianglepath.dotted", sub: [
            L(t: "网络状态检查")
        ]),
        L(t: "性能和构建",icon: "battery.100percent.bolt", sub: [
            L(t: "性能技术演进"),
            L(t: "内存管理"),
            L(t: "调试"),
            L(t: "链接器")
        ]),
        L(t: "安全", icon: "cross.case", sub: [
            L(t: "Keychain")
        ]),
        L(t: "macOS", icon: "macstudio", sub: [
//            L(t: "macOS技术演进"),
            L(t: "macOS范例"),
            L(t: "三栏结构"),
            L(t: "全屏模式"),
            L(t: "macOS共享菜单"),
            L(t: "macOS剪贴板")
        ]),
        L(t: "三方库使用", icon:"tray.2", sub: [
            L(t: "SQLite.swift的使用")
        ])
    ]
    
    struct L: Hashable, Identifiable {
        var id = UUID()
        var t: String
        var icon: String = ""
        var sub: [L]?
    }

}



