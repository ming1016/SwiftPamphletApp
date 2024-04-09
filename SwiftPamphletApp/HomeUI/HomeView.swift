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
            
            if let link = selectedDataLinkString {
                DataLink.viewToShow(
                    for: link,
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
        .environment(appVM)
    }
}
