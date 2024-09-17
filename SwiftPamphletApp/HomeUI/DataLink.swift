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
    var color: Color = Color.primary
    var children: [DataLink]?
    
    enum ShowType {
    case content,detail
    }
    
    @MainActor @ViewBuilder
    static func viewToShow(
        for title: String?,
        selectInfo:Binding<IOInfo?>,
        selectDev:Binding<DeveloperModel?>,
        selectInfoBindable: IOInfo?,
        selectDevBindable: DeveloperModel?,
        type: ShowType
    ) -> some View {
        switch title {
        case "全部资料":
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
        case "未分类":
            switch type {
            case .content:
                UnCategoryInfoListView(selectInfo: selectInfo)
            case .detail:
                if let info = selectInfoBindable {
                    EditInfoView(info: info)
                } else {
                    IntroView()
                }
            }
        case "收藏":
            switch type {
            case .content:
                StarInfoListView(selectInfo: selectInfo)
            case .detail:
                if let info = selectInfoBindable {
                    EditInfoView(info: info)
                } else {
                    IntroView()
                }
            }
        case "归档":
            switch type {
            case .content:
                ArchivedInfoListView(selectInfo: selectInfo)
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
                        EditDeveloper(dev: dev, repoVM: APIRepoVM(name: dev.name), userVM: APIUserVM(name: dev.name), needSetGithubAccessToken: true)
                    }
                    
                } else {
                    IntroView()
                }
            }
        case "Apple技术":
            switch type {
            case .content:
                GuideListView()
            case .detail:
                IntroView()
            }
        case "WWDC":
            switch type {
            case .content:
                WWDCListView()
            case .detail:
                IntroView()
            }
        case "书签":
            switch type {
            case .content:
                BookmarkListView()
            case .detail:
                IntroView()
            }
        default:
            switch type {
            case .content:
                // 默认
                GuideListView()
            case .detail:
                IntroView()
            }
        } // end switch
    }
}

extension DataLink {
    static let dataLinks = [
        DataLink(title: "开发手册", imageName: "", children: [
            DataLink(title: "书签", imageName: "p24", color: .mint),
            DataLink(title: "Apple技术", imageName: "p19", color: .indigo),
//            DataLink(title: "WWDC", imageName: "p22")
        ]),
        DataLink(title: "资料整理", imageName: "", children: [
            DataLink(title: "全部资料", imageName: "p7", color: .cyan),
            DataLink(title: "未分类", imageName: "p6"),
            DataLink(title: "收藏", imageName: "p11"),
            DataLink(title: "归档", imageName: "p3")
        ])
    ]
    static func dataLinksWithGithub() -> [DataLink] {
        var arr = DataLink.dataLinks
        arr.append(
            DataLink(title: "Github", imageName: "", children: [
                DataLink(title: "开发/仓库", imageName: "p5", color: .green),
            ]))
        return arr
    }
}
