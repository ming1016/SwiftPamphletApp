//
//  MainView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/7.
//

import SwiftUI
import InfoOrganizer
import SMGitHub

struct HomeView: View {
    @State private var selectedDataLinkString: String = ""
    @State private var selectInfo: IOInfo? = nil
    @State private var selectDev: DeveloperModel? = nil
    @AppStorage(SPC.selectedDataLinkString) var sdLinkStr: String = ""
    
    @AppStorage(SPC.isFirstRun) var isFirstRun = true
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
#if os(macOS)
        NavigationSplitView {
            SidebarView(
                selectedDataLinkString: $selectedDataLinkString,
                selectInfo: $selectInfo
            )
        } content: {
            if !selectedDataLinkString.isEmpty {
                DataLink.viewToShow(
                    for: selectedDataLinkString,
                    selectInfo: $selectInfo,
                    selectDev: $selectDev,
                    selectInfoBindable: selectInfo,
                    selectDevBindable: selectDev,
                    type: .content
                )
            } else {
                ContentUnavailableView {
                    Label("未选择栏目",
                          systemImage: "map.circle.fill")
                } description: {
                    Text("请在左侧选择一个栏目")
                }
            }
        } detail: {
            
            if !selectedDataLinkString.isEmpty {
                DataLink.viewToShow(
                    for: selectedDataLinkString,
                    selectInfo: $selectInfo,
                    selectDev: $selectDev,
                    selectInfoBindable: selectInfo,
                    selectDevBindable: selectDev, 
                    type: .detail
                )
            } else {
                IntroView()
            }
        }
        .onAppear(perform: {
            if isFirstRun {
                isFirstRun = false
                // 第一次运行需要处理的
            }
            selectedDataLinkString = sdLinkStr
            _ = WWDCViewModel()
            
            // 性能用，只在开发环境下执行
            #if DEBUG
            if let processStartTime = getProcessStartTime() {
                print("进程创建时间: \(processStartTime) 秒")
            } else {
                print("无法获取进程创建时间")
            }
            #endif
        })
        .onChange(of: selectedDataLinkString, {
            sdLinkStr = selectedDataLinkString
        })
        .onChange(of: scenePhase, {
            guard scenePhase == .active else { return } // 只处理 active 状态
            debugPrint("active")
        })
        .task {
            #if DEBUG
            let sandboxDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            print(sandboxDirectory.debugDescription)
            #endif
        }
        .onOpenURL(perform: { url in
            // 处理外部链接
        })
#endif
    }
}


// 性能用
// 通过 sysctl 获取进程创建时间
func getProcessStartTime() -> Double? {
    var kinfo = kinfo_proc()
    var size = MemoryLayout<kinfo_proc>.stride
    var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]

    let result = mib.withUnsafeMutableBufferPointer { mibPtr -> Int32 in
        sysctl(mibPtr.baseAddress, 4, &kinfo, &size, nil, 0)
    }

    guard result == 0 else {
        print("sysctl 调用失败，错误码: \(result)")
        return nil
    }

    let startTimeSec = kinfo.kp_proc.p_starttime.tv_sec
    let startTimeUsec = kinfo.kp_proc.p_starttime.tv_usec
    let startTime = TimeInterval(startTimeSec) + TimeInterval(startTimeUsec) / 1_000_000
    let currentTime = Date().timeIntervalSince1970
    return currentTime - startTime

}
