//
//  MainView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/7.
//

import SwiftUI

struct HomeView: View {
    @StateObject var appVM = AppVM()
    @State private var selectedDataLinkString: String?
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectedDataLinkString: $selectedDataLinkString)
        } detail: {
          DataLink.viewToShow(for: selectedDataLinkString)
        }
        .environmentObject(appVM)
    }
}
