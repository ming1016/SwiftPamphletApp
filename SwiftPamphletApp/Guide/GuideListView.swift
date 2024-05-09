//
//  AppleGuideListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/28.
//

import SwiftUI

struct GuideListView: View {
    @State private var listModel = GuideListModel()
    @State private var limit: Int = 50
    var body: some View {
        SPOutlineListView(d: listModel.filtered(), c: \.sub) { i in
            NavigationLink(destination: GuideDetailView(t: i.t, limit: $limit)) {
                HStack {
                    Text(listModel.searchText.isEmpty == true ? GuideListModel.simpleTitle(i.t) : i.t)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
        }
        .searchable(text: $listModel.searchText)
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
    
    var lModel = [
        L(t: "Swift语法", sub: [
            L(t: "语法基础", sub: [
                L(t: "变量"),
                L(t: "打印"),
                L(t: "注释"),
                L(t: "可选"),
                L(t: "闭包"),
                L(t: "函数"),
                L(t: "访问控制"),
                L(t: "Regex")
            ]),
            L(t: "基础类型",sub: [
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
                L(t: "遍历For-in"),
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
        L(t: "基础库", sub: [
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
            L(t: "格式化"),
            L(t: "度量值"),
            L(t: "Data"),
            L(t: "文件"),
            L(t: "Scanner"),
            L(t: "AttributeString"),
            L(t: "随机"),
            L(t: "UserDefaults")
        ]),
        L(t: "SwiftUI",sub: [
            L(t: "介绍",sub: [
                L(t: "SwiftUI是什么"),
                L(t: "SwiftUI参考资料"),
                L(t: "SwiftUI对标的UIKit视图"),
            ]),
            L(t: "图文组件",sub: [
                L(t: "Text"),
                L(t: "Link"),
                L(t: "Label"),
                L(t: "TextEditor"),
                L(t: "TextField"),
                L(t: "Image"),
            ]),
            L(t: "数据集合组件", sub: [
                L(t: "ScrollView"),
                L(t: "List"),
                L(t: "LazyVStack和LazyHStack"),
                L(t: "LazyVGrid和LazyHGrid"),
                L(t: "table"),
            ]),
            L(t: "布局组件", sub: [
                L(t: "Navigation"),
                L(t: "TabView"),
                L(t: "Stack"),
                L(t: "ControlGroup"),
                L(t: "GroupBox"),
                L(t: "Advanced layout control"),
                L(t: "ContentUnavailableView"),
            ]),
            L(t: "视图组件使用",sub: [
                L(t: "Form"),
                L(t: "Button"),
                L(t: "进度"),
                L(t: "浮层"),
                L(t: "Toggle"),
                L(t: "Picker"),
                L(t: "Slider"),
                L(t: "Stepper"),
                L(t: "Keyboard"),
                L(t: "Transferable"),
                L(t: "ShareLink")
            ]),
            L(t: "视觉",sub: [
                L(t: "SwiftUI颜色"),
                L(t: "SwiftUI Effect"),
                L(t: "SwiftUI动画"),
                L(t: "SwiftUI Canvas"),
                L(t: "SF Symbol"),
                L(t: "SwiftCharts"),
            ]),
            L(t: "SwiftUI数据流")
        ]),
        L(t: "SwiftData",sub: [
            L(t: "创建@Model模型"),
            L(t: "SwiftData-模型关系"),
            L(t: "容器配置modelContainer"),
            L(t: "增删modelContext"),
            L(t: "SwiftData-检索"),
            L(t: "SwiftData-处理大量数据"),
            L(t: "SwiftData多线程"),
            L(t: "SwiftData-版本迁移"),
            L(t: "SwiftData-调试"),
            L(t: "SwiftData-资料")
        ]),
        L(t: "Widget小部件", sub: [
            L(t: "Widget访问SwiftData")
        ]),
        L(t: "系统能力",sub: [
            L(t: "Swift-DocC")
        ]),
        L(t: "工程模式", sub: [
            L(t: "单例"),
            L(t: "程序入口点")
        ]),
        L(t: "多线程", sub: [
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
        L(t: "动画", sub: [
            L(t: "布局动画")
        ]),
        L(t: "网络",sub: [
            L(t: "网络状态检查")
        ]),
        L(t: "性能和构建", sub: [
            L(t: "性能技术演进"),
            L(t: "内存管理"),
            L(t: "调试"),
            L(t: "链接器")
        ]),
        L(t: "安全",sub: [
            L(t: "Keychain")
        ]),
        L(t: "macOS", sub: [
            L(t: "macOS技术演进"),
            L(t: "macOS范例"),
            L(t: "三栏结构"),
            L(t: "全屏模式"),
            L(t: "macOS共享菜单"),
            L(t: "macOS剪贴板")
        ]),
        L(t: "三方库使用",sub: [
            L(t: "SQLite.swift的使用")
        ])
    ]
    
    struct L: Hashable, Identifiable {
        var id = UUID()
        var t: String
        var sub: [L]?
    }

}



