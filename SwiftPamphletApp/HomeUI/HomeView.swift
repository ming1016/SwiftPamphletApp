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
    }
}
