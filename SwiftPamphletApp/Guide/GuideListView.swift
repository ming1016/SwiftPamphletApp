//
//  AppleGuideListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/28.
//

import SwiftUI

struct GuideListView: View {
    var body: some View {
        SPOutlineListView(d: lModel, c: \.sub) { i in
            NavigationLink(destination: GuideDetailView(t: i.t)) {
                HStack {
                    Text(i.t)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
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
        L(t: "Swift 三方库使用",sub: [
            L(t: "SQLite.swift的使用")
        ])
    ]
    
    struct L: Hashable, Identifiable {
        var id = UUID()
        var t: String
        var sub: [L]?
    }
}


