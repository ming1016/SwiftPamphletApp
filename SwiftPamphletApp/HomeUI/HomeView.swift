//
//  MainView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/7.
//

import SwiftUI

struct HomeView: View {
    @State var appVM = AppVM()
    @State private var selectedDataLinkString: String?
    @State private var selectInfo: IOInfo? = nil
    @State private var selectDev: DeveloperModel? = nil
    
    var body: some View {
        NavigationSplitView {
            SidebarView(
                selectedDataLinkString: $selectedDataLinkString,
                selectInfo: $selectInfo
            )
        } content: {
            if let link = selectedDataLinkString {
                DataLink.viewToShow(
                    for: link,
                    selectInfo: $selectInfo,
                    selectDev: $selectDev
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
            if let info = selectInfo {
                EditInfoView(info: info)
            } else if let dev = selectDev {
                EditDeveloper(dev: dev)
            } else {
                ContentUnavailableView {
                    Label("未选",
                          systemImage: "pencil.tip.crop.circle.badge.plus")
                } description: {
                    Text("请选择或按+号添加内容")
                }
            }
        }
        .environment(appVM)
    }
}
