//
//  SwiftPamphletAppApp.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI
import Combine
import SwiftData
import InfoOrganizer
import SMFile
import SMGitHub
import os.signpost
import BackgroundTasks
import AppIntents

@main
struct SwiftPamphletAppApp: App {
    
    
    
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #elseif os(iOS)
    @State private var metricsManager = MetricsManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    init() {
        
        let gr = GitHubReq.shared
        if SPC.gitHubAccessToken.isEmpty == true {
            gr.githubat = SPC.githubAccessToken()
        } else {
            gr.githubat = SPC.gitHubAccessToken
        }
    }
    
    @Environment(\.scenePhase) private var phase
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            HomeView()
                .modelContainer(for: [IOInfo.self, DeveloperModel.self, BookmarkModel.self], isUndoEnabled: true)
            #elseif os(iOS)
            HomeiOSView()
//                .modelContainer(for: [IOInfo.self, DeveloperModel.self, BookmarkModel.self], isUndoEnabled: true)
            #endif
        }
        #if os(macOS)
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: true)) // 用来控制是否展示标题
        #endif
        #if os(macOS)
        Settings {
            SettingView()
        }
        #endif
        
    }
}



// MARK: - UnCat

#if os(macOS)
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
#elseif os(iOS)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
        return true
    }
    
}
#endif


