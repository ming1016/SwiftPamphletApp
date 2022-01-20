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
            TextView()
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
//                        SPC.outputRepo()
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
                        appVM.rssUpdateNotis() // 定时更新博客未读数
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
        .navigationTitle("戴铭的 Swift 小册子")
        .navigationSubtitle(appVM.alertMsg)
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







// MARK: - UnCat
protocol Jsonable : Identifiable, Decodable, Hashable {}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var op: String?
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("-- AppDelegate Section --")
        
//        PlaySecurity.keyChain()
        
//        PlayArchitecture.error()
//        PlayArchitecture.codable()
        
//        PlaySyntax.result()
//        PlaySyntax.string()
//        PlaySyntax.array()
//        PlaySyntax.set()
//        PlaySyntax.dictionary()
        
//        PlayFoundation.random()
//        PlayFoundation.data()
//        PlayFoundation.date()
//        PlayFoundation.formatter()
//        PlayFoundation.measurement()
//        PlayFoundation.file()
//        PlayFoundation.scanner()
//        let _ = PlayFoundation.attributeString()
//        PlayFoundation.coaAndCow()
        
        
//        self.window.makeKey()
    }
}





