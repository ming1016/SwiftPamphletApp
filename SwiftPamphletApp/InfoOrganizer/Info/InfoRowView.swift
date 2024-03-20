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
        VStack(alignment:.leading) {
            HStack {
                Text(info.category?.name ?? "")
                if info.star == true {
                    Image(systemName: "star.fill")
                }
                Spacer()
            }
            .foregroundColor(light: .secondary, dark: .secondary)
            Text(info.name)
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


