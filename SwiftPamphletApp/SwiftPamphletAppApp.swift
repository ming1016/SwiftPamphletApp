//
//  SwiftPamphletAppApp.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI
import Combine

@main
struct SwiftPamphletAppApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SwiftPamphletApp()
//            Demo()
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: true)) // 用来控制是否展示标题
    }
}

struct Demo: View {
    var body: some View {
        Group {
            LabelView()
        }
        .frame(minWidth:300, minHeight: 550)
        .onAppear {
            
        }
    }
}


struct SwiftPamphletApp: View {
    @StateObject var appVM = AppVM()
    @State var sb = Set<AnyCancellable>()
    @State var alertMsg = ""
    
    let timerForRepos = Timer.publish(every: SPC.timerForReposSec, on: .main, in: .common).autoconnect()
    let timerForDevs = Timer.publish(every: SPC.timerForDevsSec, on: .main, in: .common).autoconnect()
    let timerForExp = Timer.publish(every: SPC.timerForExpSec, on: .main, in: .common).autoconnect()
    let timerForRss = Timer.publish(every: SPC.timerForRssSec, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView {
            if SPC.gitHubAccessToken.isEmpty == SPC.gitHubAccessTokenJudge {
                VStack {
                    Text("Ops!")
                    Text("Token 未设置")
                }
                VStack {
                    Text("请在 SwiftPamphletAppConfig.swift 的 gitHubAccessToken 加入你的 GitHub Access Token").font(.title)
                    HStack {
                        Text("在 GitHub")
                        ButtonGoGitHubWeb(url: "settings/tokens", text: "点这里", ignoreHost: true)
                        Text("进行申请")
                    }
                }
            } else {
                SPSidebar()
                    .onAppear(perform: {
                        appVM.onAppearEvent()
                        appVM.rssFetch()
                    })
                    .onReceive(timerForRepos, perform: { time in
                        if let repoName = appVM.timeForReposEvent() {
                            let vm = RepoVM(repoName: repoName)
                            vm.doing(.notiRepo)
                        }
                    })
                    .onReceive(timerForDevs, perform: { time in
                        if let userName = appVM.timeForDevsEvent() {
                            let vm = UserVM(userName: userName)
                            vm.doing(.notiEvent)
                        }
                    })
                    .onReceive(timerForExp) { time in
                        appVM.timeForExpEvent()
                    }
                    .onReceive(timerForRss) { time in
                        appVM.rssFetch()
                    }
                SPIssuesListView(vm: RepoVM(repoName: SPC.pamphletIssueRepoName))
                IntroView()
                NavView()
            } // end if else
        } // end NavigationView
        .frame(minHeight: 650)
        .navigationTitle("戴铭的 Swift 小册子 \(appVM.alertMsg)")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                } label: {
                    Label("Sidebar", systemImage: "sidebar.left")
                }
            }
        }
        .environmentObject(appVM)
        
    }
}

struct IntroView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text("戴铭的 Swift 小册子").bold().font(.largeTitle)
            Text("一本活的 Swift 手册")
            Text("版本1.0").font(.footnote)
        }
        .frame(minWidth: SPC.detailMinWidth)
    }
}

struct NavView: View {
    var body: some View {
        VStack {
            IssueView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 1), type: .hiddenUserInfo)
        }
        .frame(minWidth: SPC.detailMinWidth)
    }
}

// MARK: - Sidebar
struct SPSidebar: View {
    @EnvironmentObject var appVM: AppVM
    var body: some View {
        List {
            Section("新动态") {
//                NavigationLink {
//                    ExploreRepoListView()
//                } label: {
//                    Label("博客", systemImage: "r.square.on.square.fill")
//                }

                
                NavigationLink(destination: ActiveDeveloperListView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 30))) {
                    if appVM.devsCountNotis > 0 {
                        Label("开发者", systemImage: "person.2.wave.2")
                            .badge(appVM.devsCountNotis)
                    } else {
                        Label("开发者", systemImage: "person.2.wave.2")
                    }
                } // end NavigationLink
                
                NavigationLink(destination: GoodReposListView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 31))) {
                    if appVM.reposCountNotis > 0 {
                        Label("好库", systemImage: "book.closed")
                            .badge(appVM.reposCountNotis)
                    } else {
                        Label("好库", systemImage: "book.closed")
                    }
                } // end NavigationLink
                
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

            }
            Section("Swift指南") {
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 19))) {
                    Label("语法速查", systemImage: "function")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 20))) {
                    Label("特性", systemImage: "pencil")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 21))) {
                    Label("专题", systemImage: "graduationcap")
                }
            }
            Section("库使用指南") {
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 60))) {
                    Label("Combine", systemImage: "app.connected.to.app.below.fill")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 62))) {
                    Label("Concurrency", systemImage: "timer")
                }
                
                NavigationLink(destination: IssuesListFromCustomView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 61))) {
                    Label("SwiftUI", systemImage: "rectangle.fill.on.rectangle.fill")
                }
                
                
            }
            
            Section("小册子") {
                NavigationLink(destination: SPIssuesListView(vm: RepoVM(repoName: SPC.pamphletIssueRepoName))) {
                    Label("小册子议题", systemImage: "square.3.layers.3d.down.right")
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
            ToolbarItem {
                Menu {
                    Text("Ops！发现这里了")
                    Text("彩蛋下个版本见")
                    Text("隐藏彩蛋1")
                    Text("隐藏彩蛋2")
                } label: {
                    Label("Label", systemImage: "slider.horizontal.3")
                }
            }
        }
    }
}

// MARK: - UnCat
protocol Jsonable : Identifiable, Decodable, Hashable {}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var op: String?
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("-- AppDelegate Section --")
        
        
        
//        self.window.makeKey()
    }
}





