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

    let timerForDevs = Timer.publish(every: SPC.timerForDevsSec, on: .main, in: .common).autoconnect()
    let timerForExp = Timer.publish(every: SPC.timerForExpSec, on: .main, in: .common).autoconnect()
    let timerForRss = Timer.publish(every: SPC.timerForRssSec, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView {
            SPSidebar()
                .onAppear(perform: {
                    appVM.onAppearEvent()
                    appVM.rssFetch()
                })
                .onReceive(timerForDevs, perform: { _ in
                    if SPC.gitHubAccessToken.isEmpty == false {
                        if let userName = appVM.timeForDevsEvent() {
                            let vm = UserVM(userName: userName)
                            vm.doing(.notiEvent)
                        }
                    }
                    appVM.rssUpdateNotis() // 定时更新博客未读数
                })
                .onReceive(timerForExp) { _ in
                    if SPC.gitHubAccessToken.isEmpty == false {
                        appVM.timeForExpEvent()
                    }
                }
                .onReceive(timerForRss) { _ in
                    appVM.rssFetch()
                }
            IssuesListFromCustomView(vm: IssueVM(guideName:"guide-syntax"))
                .frame(minWidth:60)
            IntroView()
            NavView()

        } // end NavigationView
        .frame(minHeight: 650)
        .navigationTitle("戴铭的 Swift 小册子")
        .navigationSubtitle(appVM.alertMsg)
        .toolbar {
//            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
//                Menu {
//                    Text("Ops！发现这里了")
//                    Text("彩蛋下个版本见")
//                    Text("隐藏彩蛋1")
//                    Text("隐藏彩蛋2")
//                } label: {
//                    Label("Label", systemImage: "slider.horizontal.3")
//                }
//            }
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
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

            } // end ToolbarItemGroup
        } // end .toolbar
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

//        PlaySyntax.hashable()
//        PlaySyntax.dynamicCallable()
//        PlaySyntax.dynamicMemberLookup()
//        PlaySyntax.method()
//        PlaySyntax.property()
//        PlaySyntax.generics()
//        PlaySyntax.result()
//        PlaySyntax.string()
//        PlaySyntax.array()
//        PlaySyntax.set()
//        PlaySyntax.dictionary()
//        PlaySyntax.enum()
//        PlaySyntax.number()

//        PlayFoundation.userDefaults()
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
