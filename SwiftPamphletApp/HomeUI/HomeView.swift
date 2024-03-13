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
                Text("请选择")
            }
        } detail: {
            if let info = selectInfo {
                DetailLink.viewToShow(for: "资料", selectInfo: info)
            } else {
                Text("请选择")
            }
        }
        .environment(appVM)
    }
}
