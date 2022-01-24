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
                    Label("博客与资讯", systemImage: "r.square.on.square.fill")
                        .badge(appVM.rssCountNotis)
                }
            }
            Section("Github") {
                NavigationLink {
                    ExploreRepoListView()
                } label: {
                    if appVM.expCountNotis > 0 {
                        Label("探索库", systemImage: "globe.asia.australia")
                            .badge(appVM.expCountNotis)
                    } else {
                        Label("探索库", systemImage: "globe.asia.australia")
                    }
                    
                } // end NavigationLink
                
                if SPC.gitHubAccessToken.isEmpty == false {
                    NavigationLink(destination: ActiveDeveloperListView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 30))) {
                        if appVM.devsCountNotis > 0 {
                            Label("开发者", systemImage: "person.2.wave.2")
                                .badge(appVM.devsCountNotis)
                        } else {
                            Label("开发者", systemImage: "person.2.wave.2")
                        }
                    } // end NavigationLink
                    
                } // end if
            } // end Section
            
            
            Section("Swift指南") {
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"guide-syntax"))) {
                    Label("语法速查", systemImage: "function")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"guide-features"))) {
                    Label("特性", systemImage: "pencil")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"guide-subject"))) {
                    Label("专题", systemImage: "graduationcap")
                }
            }
            Section("库使用指南") {
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Combine"))) {
                    Label("Combine", systemImage: "app.connected.to.app.below.fill")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"lib-Concurrency"))) {
                    Label("Concurrency", systemImage: "timer")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(guideName:"lib-SwiftUI"))) {
                    Label("SwiftUI", systemImage: "rectangle.fill.on.rectangle.fill")
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

