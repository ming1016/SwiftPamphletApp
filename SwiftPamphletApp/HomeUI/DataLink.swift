//
//  DataLink.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/7.
//

import SwiftUI

struct DataLink: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    var children: [DataLink]?
    
    @ViewBuilder
    static func viewToShow(for title: String?) -> some View {
        switch title {
        case "资料整理":
            InfoListView()
        case "库动态":
            ExploreRepoListView(showAsGroup: false)
        case "开发者":
            ActiveDeveloperListView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 30))
        case "探索库":
            ExploreRepoListView(showAsGroup: true)
        case "库存档":
            ExploreRepoListView(showAsGroup: true, isArchive: true)
        case "语法速查":
            IssuesListFromCustomView(vm: IssueVM(guideName: "guide-syntax"))
        case "特性":
            IssuesListFromCustomView(vm: IssueVM(guideName:"guide-features"))
        case "专题":
            IssuesListFromCustomView(vm: IssueVM(guideName:"guide-subject"))
        case "SwiftUI":
            IssuesListFromCustomView(vm: IssueVM(guideName:"lib-SwiftUI"))
        case "Combine":
            IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Combine"))
        case "Concurrency":
            IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Concurrency"))
        case "设置":
            SettingView()
        default:
            // 默认是语法速查
            IssuesListFromCustomView(vm: IssueVM(guideName: "guide-syntax"))
        }
    }
}

extension DataLink {
    static var dataLinks = [
        DataLink(title: "动态", imageName: "", children: [
            DataLink(title: "资料整理", imageName: "p11")
        ]),
        DataLink(title: "Github", imageName: "", children: [
//            DataLink(title: "库动态", imageName: "p6"),
//            DataLink(title: "开发者", imageName: "p5"),
            DataLink(title: "探索库", imageName: "p24"),
            DataLink(title: "库存档", imageName: "p25")
        ]),
        DataLink(title: "Swift指南", imageName: "", children: [
            DataLink(title: "语法速查", imageName: "p23"),
            DataLink(title: "特性", imageName: "p10"),
            DataLink(title: "专题", imageName: "p12")
        ]),
        DataLink(title: "库使用指南", imageName: "", children: [
            DataLink(title: "SwiftUI", imageName: "p3"),
            DataLink(title: "Combine", imageName: "p19"),
            DataLink(title: "Concurrency", imageName: "p1")
        ]),
        DataLink(title: "更多", imageName: "", children: [
            DataLink(title: "设置", imageName: "p4")
        ])
    ]
}
