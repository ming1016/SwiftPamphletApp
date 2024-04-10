//
//  SwiftPamphletAppApp.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI
import Combine
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
