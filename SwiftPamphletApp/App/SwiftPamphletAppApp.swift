//
//  SwiftPamphletAppApp.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI
import Combine
import SMNetwork
import SwiftData

@main
struct SwiftPamphletAppApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [IOInfo.self, DeveloperModel.self], isUndoEnabled: true)
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: true)) // 用来控制是否展示标题
        Settings {
            SettingView()
        }
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
