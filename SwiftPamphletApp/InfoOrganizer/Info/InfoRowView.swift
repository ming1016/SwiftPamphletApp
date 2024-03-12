//
//  InfoRowView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI

struct InfoRowView: View {
    @State var info: IOInfo
    let selectedInfo: IOInfo?
    
    var infoColor: Color {
        selectedInfo == info ? Color.white : Color.accentColor
    }
    
    var body: some View {
        HStack {
            Text(info.name)
            Spacer()
            Text(info.category?.name ?? "")
        }
        .swipeActions {
            Button(role: .destructive) {
                IOInfo.delete(info)
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
        .contextMenu {
            Button("删除") {
                IOInfo.delete(info)
            }
        }
    }
}


