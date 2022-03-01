//
//  SPSidebar.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

// MARK: - Sidebar
struct SPSidebar: View {
    @EnvironmentObject var appVM: AppVM
    var body: some View {
        List {
            Section("新动态") {
                NavigationLink {
                    RSSListView(vm: RSSVM())
                } label: {
                    SideBarLabel(title: "博客|资讯", imageName: "p21")
                        .badge(appVM.rssCountNotis)
                }
                
                NavigationLink {
                    DataSortingListView()
                } label: {
                    SideBarLabel(title: "资料整理", imageName: "p11")
                }
            }
            Section("Github") {

                if SPC.gitHubAccessToken.isEmpty == false {
                    NavigationLink {
                        ExploreRepoListView(showAsGroup: false)
                    } label: {
                        SideBarLabel(title: "库动态", imageName: "p6")
                            .badge(appVM.expCountNotis)

                    } // end NavigationLink
                    
                    NavigationLink(destination: ActiveDeveloperListView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 30))) {
                        SideBarLabel(title: "开发者", imageName: "p5")
                            .badge(appVM.devsCountNotis)
                    } // end NavigationLink

                } // end if
                
                NavigationLink {
                    ExploreRepoListView(showAsGroup: true)
                } label: {
                    SideBarLabel(title: "探索库", imageName: "p24")
                } // end NavigationLink
                
                NavigationLink {
                    ExploreRepoListView(showAsGroup: true, isArchive: true)
                } label: {
                    SideBarLabel(title: "库存档", imageName: "p25")
                }
                
            } // end Section

            Section("Swift指南") {
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"guide-syntax"))) {
                    SideBarLabel(title: "语法速查", imageName: "p23")
                }

                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"guide-features"))) {
                    SideBarLabel(title: "特性", imageName: "p10")
                }

                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"guide-subject"))) {
                    SideBarLabel(title: "专题", imageName: "p12")
                }
            }
            Section("库使用指南") {
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"lib-SwiftUI"))) {
                    SideBarLabel(title: "SwiftUI", imageName: "p3")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Combine"))) {
                    SideBarLabel(title: "Combine", imageName: "p19")
                }

                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Concurrency"))) {
                    SideBarLabel(title: "Concurrency", imageName: "p1")
                }
                
            }

//            Section("个人") {
//                /// isExpanded 来控制是否展开
//                /// 详细查看WWDC：[WWDC 2020: Stacks, Grids, and Outlines in SwiftUI](https://developer.apple.com/videos/play/wwdc2020/10031/)
//                DisclosureGroup(content: {
//                    Text("待建设")
//                }, label: {
//                    Label("我的", systemImage: "person")
//                })
//            }

        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 160)
        .toolbar {
//            ToolbarItem {
//                Menu {
//                    Text("Ops！发现这里了")
//                    Text("彩蛋下个版本见")
//                    Text("隐藏彩蛋1")
//                    Text("隐藏彩蛋2")
//                } label: {
//                    Label("Label", systemImage: "slider.horizontal.3")
//                }
//            }
        }
        // end List

        // MARK: - Mine
//        Spacer()
//        Mine()
    }
}

struct Mine: View {
    var body: some View {
        HStack {
            Label("我的", systemImage: "person")
            Spacer()
        }
        .padding(20)

    }
}
