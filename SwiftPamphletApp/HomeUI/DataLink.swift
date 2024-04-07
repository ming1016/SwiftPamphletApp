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
    
    enum ShowType {
    case content,detail
    }
    
    @ViewBuilder
    static func viewToShow(
        for title: String?,
        selectInfo:Binding<IOInfo?>,
        selectDev:Binding<DeveloperModel?>,
        selectInfoBindable: IOInfo?,
        selectDevBindable: DeveloperModel?,
        type: ShowType
    ) -> some View {
        switch title {
        case "资料整理":
            switch type {
            case .content:
                InfoListView(selectInfo: selectInfo)
            case .detail:
                if let info = selectInfoBindable {
                    EditInfoView(info: info)
                } else {
                    EmptyView()
                }
            }
        case "开发/仓库":
            switch type {
            case .content:
                DeveloperListView(selectDev:selectDev)
            case .detail:
                if let dev = selectDevBindable {
                    if SPC.gitHubAccessToken.isEmpty == false || SPC.githubAccessToken().isEmpty == false {
                        EditDeveloper(dev: dev, vm: UserVM(userName: dev.name), vmRepo: RepoVM(repoName: dev.name), repoVM: APIRepoVM(name: dev.name))
                    } else {
                        Text("请在设置里写上 Github 的 access token")
                    }
                } else {
                    EmptyView()
                }
            }
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
        default:
            // 默认是语法速查
            IssuesListFromCustomView(vm: IssueVM(guideName: "guide-syntax"))
        }
    }
}

extension DataLink {
    static var dataLinks = [
        DataLink(title: "资料", imageName: "", children: [
            DataLink(title: "资料整理", imageName: "p11")
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
        DataLink(title: "Github", imageName: "", children: [
            DataLink(title: "开发/仓库", imageName: "p5"),
        ]),
    ]
}
