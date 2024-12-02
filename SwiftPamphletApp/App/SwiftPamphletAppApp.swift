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
    
    // 启动时间打点
    private let launchStartTime = DispatchTime.now()
    private let signpostID = OSSignpostID(log: OSLog.default)
    private let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Launch")
    
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #elseif os(iOS)
    @State private var metricsManager = MetricsManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    init() {
        os_signpost(.begin, log: log, name: "Launch", signpostID: signpostID)
        
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
                .onAppear {
#if DEBUG
                    // background fetch
                    BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.starming.fetch", using: nil) { task in
                        self.handleAppRefresh(task: task as! BGAppRefreshTask)
                    }
                    scheduleAppRefresh()
                    
                    // 查看整体从进程创建到主界面加载完成时间
                    if let processStartTime = Perf.getProcessRunningTime() {
                        // 主界面加载完成，记录终点
                        let launchEndTime = DispatchTime.now()
                        let launchTime = Double(launchEndTime.uptimeNanoseconds - launchStartTime.uptimeNanoseconds) / 1_000_000_000
                        
                        // Pre-main
                        print("Pre-main : \(String(format: "%.2f", (processStartTime - launchTime))) 秒")
                    } else {
                        print("无法获取进程创建时间")
                    }
                    
                    // 任务示例
//                    TaskCase.bad()
                    TaskCase.good()
                    
                    // 任务管理器示例
                    taskgroupDemo()
                    
                    if let processStartTime = Perf.getProcessRunningTime() {
                        // Post-main
                        print("进程创建到进入主界面时间: \(String(format: "%.2f", processStartTime)) 秒")
                    }
#endif
                    
                    // 记录启动结束
                    os_signpost(.end, log: log, name: "Launch", signpostID: signpostID)
                }
                .onChange(of: phase) { oldValue, newValue in
                    switch newValue {
                    case .background:
                        print("background")
                    default:
                        break
                    }
                }
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
    
    #if os(iOS)
    // MARK: - Background Task
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.starming.fetch")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 15) // 最早15分钟后运行
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("后台任务请求失败: \(error)")
        }
    }
    func handleAppRefresh(task: BGAppRefreshTask) {
        // 确保任务在有限的时间内完成
        task.expirationHandler = {
            // 如果任务时间即将耗尽，取消任务
            task.setTaskCompleted(success: false)
        }
        
        // 模拟数据获取
        print("后台任务开始，获取数据")
    }
    #endif
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
