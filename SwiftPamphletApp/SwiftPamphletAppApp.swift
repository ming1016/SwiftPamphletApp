//
//  SwiftPamphletAppApp.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI
import Combine
import SMNetwork

@main
struct SwiftPamphletAppApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SwiftPamphletApp()
//            HomeView()
//            Demo()
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: true)) // 用来控制是否展示标题
    }
}

struct Demo: View {
    var body: some View {
        Group {
//            PlayCanvas()
            
        }
        .frame(minWidth:300, maxWidth: .infinity, minHeight: 550, maxHeight: .infinity)
        .onAppear {

        }
    }
}

struct V: View {
    
    @State var appVM = AppVM()
    @State var isEnterFullScreen: Bool = false // 全屏控制
    var body: some View {
        Button {
            isEnterFullScreen.toggle()
            appVM.fullScreen(isEnter: isEnterFullScreen)
        } label: {
            Image(systemName: isEnterFullScreen == true ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
        }
    }
}

struct SwiftPamphletApp: View {
    
    @State var appVM = AppVM()
    @State var networkMonitor = NetworkMonitor()
    
    @State var sb = Set<AnyCancellable>()
    @State var alertMsg = ""
    
    @State private var showNetworkAlert = false // 网络监控

    let timerForDevs = Timer.publish(every: SPC.timerForDevsSec, on: .main, in: .common).autoconnect()
    let timerForExp = Timer.publish(every: SPC.timerForExpSec, on: .main, in: .common).autoconnect()
    let timerForRss = Timer.publish(every: SPC.timerForRssSec, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView {
            SPSidebar()
                .onReceive(timerForDevs, perform: { _ in
                    if SPC.gitHubAccessToken.isEmpty == false {
                        if let userName = appVM.timeForDevsEvent() {
                            let vm = UserVM(userName: userName)
                            vm.doing(.notiEvent)
                        }
                    }
                })
                .onReceive(timerForExp) { _ in
                    if SPC.gitHubAccessToken.isEmpty == false {
                        appVM.timeForExpEvent()
                    }
                }
            IssuesListFromCustomView(vm: IssueVM(guideName:"guide-syntax"))
                .frame(minWidth:60)
            IntroView()
            NavView()

        } // end NavigationView
        .frame(minHeight: 650)
        .navigationTitle("戴铭的开发小册子")
        .navigationSubtitle(appVM.alertMsg)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    appVM.toggleSidebar()
                } label: {
                    Label("Sidebar", systemImage: "sidebar.left")
                }
            }

            ToolbarItemGroup(placement: ToolbarItemPlacement.automatic) {
                // 博客链接用浏览器打开，还有共享菜单进行分享用
                if !appVM.webLinkStr.isEmpty {
                    ShareView(s: appVM.webLinkStr)
                    Button {
                        gotoWebBrowser(urlStr: appVM.webLinkStr)
                    } label: {
                        Label("Browser", systemImage: "safari")
                        Text("用浏览器打开")
                    } // end Button
                } // end if
                
                Button {
                    appVM.toggleLastView()
                } label: {
                    Label("LastView", systemImage: "sidebar.right")
                } // end Button

            } // end ToolbarItemGroup
        } // end .toolbar
        .environment(appVM)
        // 网络监控
        .environment(networkMonitor)
        .onChange(of: networkMonitor.hasNetworkConnection, { oldValue, newValue in
            showNetworkAlert = !newValue
        })
        .alert("NO INTERNET",
               isPresented: $showNetworkAlert,
               actions: {
            Text("Close")
        })
    }
}

// MARK: - UnCat
protocol Jsonable : Identifiable, Decodable, Hashable {}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var op: String?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("-- AppDelegate Section --")

        // 生成 Markdown 文件
//        AutoTask.buildContentMarkdownFile()

    }
    
    func applicationWillTerminate(_ notification: Notification) {
//        codeCoverageProfrawDump()
    }
    
}
