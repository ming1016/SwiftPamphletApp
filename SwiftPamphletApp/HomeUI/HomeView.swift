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
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectedDataLinkString: $selectedDataLinkString, selectInfo: $selectInfo)
        } content: {
            if let link = selectedDataLinkString {
                DataLink.viewToShow(for: link, selectInfo: $selectInfo)
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
                DetailLink.viewToShow(for: "资料", selectInfo: info)
            } else {
                ContentUnavailableView {
                    Label("未选",
                          systemImage: "pencil.tip.crop.circle.badge.plus")
                } description: {
                    Text("请选择或按+号增加一个资料")
                }
            }
        }
        .environment(appVM)
    }
}
