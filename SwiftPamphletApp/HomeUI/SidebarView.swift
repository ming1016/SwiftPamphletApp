//
//  SidebarView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/7.
//

import SwiftUI

struct SidebarView: View {
    @Binding var selectedDataLinkString: String?
    
    var body: some View {
//        List(DataLink.dataLinks, children: \.children, selection: $selectedDataLinkString) { link in
//            SideBarLabel(title: link.title, imageName: link.imageName)
//                .tag(link.title)
//        }
        List(selection: $selectedDataLinkString, content: {
            ForEach(DataLink.dataLinks) { link in
                Section {
                    OutlineGroup(link.children ?? [], children: \.children) { i in
                        SideBarLabel(title: i.title, imageName: i.imageName)
                            .tag(i.title)
                    }
                } header: {
                    Label(link.title, systemImage: "")
                }
            }
        })
        .frame(minWidth: 200)
    }
}


