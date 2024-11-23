//
//  SettingSidebarView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/11/23.
//

import SwiftUI

struct SettingSidebarView: View {
    @Binding var selectedItem: String?
    var body: some View {
        List(selection: $selectedItem) {
            item(title: "Github Token 设置", icon: "gearshape")
                .tag("Github Token 设置")
            item(title: "自定义标签", icon: "tag")
                .tag("自定义标签")
        }
    }
    
    @ViewBuilder func item(title:String, icon:String) -> some View {
        Label(title, systemImage: icon)
    }
}

