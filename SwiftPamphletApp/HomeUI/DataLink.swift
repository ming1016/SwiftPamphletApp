//
//  DataLink.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/7.
//

import SwiftUI
import InfoOrganizer
import SMGitHub

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
                    IntroView()
                }
            }
        case "开发/仓库":
            switch type {
            case .content:
                DeveloperListView(selectDev:selectDev)
            case .detail:
                if let dev = selectDevBindable {
                    if SPC.gitHubAccessToken.isEmpty == false || SPC.githubAccessToken().isEmpty == false {
                        EditDeveloper(dev: dev, repoVM: APIRepoVM(name: dev.name), userVM: APIUserVM(name: dev.name))
                    } else {
                        Text("请在设置里写上 Github 的 access token")
                    }
                } else {
                    IntroView()
                }
            }
        case "Apple 技术":
            switch type {
            case .content:
                GuideListView()
            case .detail:
                IntroView()
            }
        case "特性":
            switch type {
            case .content:
                IssuesListFromCustomView(vm: IssueVM(guideName:"guide-features"))
            case .detail:
                IntroView()
            }
        case "SwiftUI":
            switch type {
            case .content:
                IssuesListFromCustomView(vm: IssueVM(guideName:"lib-SwiftUI"))
            case .detail:
                IntroView()
            }
        case "Combine":
            switch type {
            case .content:
                IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Combine"))
            case .detail:
                IntroView()
            }
        case "Concurrency":
            switch type {
            case .content:
                IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Concurrency"))
            case .detail:
                IntroView()
            }
        default:
            switch type {
            case .content:
                // 默认是语法速查
                IssuesListFromCustomView(vm: IssueVM(guideName: "guide-syntax"))
            case .detail:
                IntroView()
            }
        } // end switch
    }
}

extension DataLink {
    static var dataLinks = [
        DataLink(title: "资料", imageName: "", children: [
            DataLink(title: "资料整理", imageName: "p11")
        ]),
        DataLink(title: "Github", imageName: "", children: [
            DataLink(title: "开发/仓库", imageName: "p5"),
        ]),
        DataLink(title: "开发手册", imageName: "", children: [
            DataLink(title: "Apple 技术", imageName: "p22")
        ]),
        DataLink(title: "Swift指南", imageName: "", children: [
            DataLink(title: "特性", imageName: "p10"),
        ]),
        DataLink(title: "库使用指南", imageName: "", children: [
            DataLink(title: "SwiftUI", imageName: "p3"),
            DataLink(title: "Combine", imageName: "p19"),
            DataLink(title: "Concurrency", imageName: "p1")
        ])
    ]
}
