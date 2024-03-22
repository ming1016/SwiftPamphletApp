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
    @State private var showAlert = false
    
    var infoColor: Color {
        selectedInfo == info ? Color.white : Color.accentColor
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                if info.star == true {
                    Image(systemName: "star.fill")
                }
                if info.category != nil {
                    Text(info.category?.name ?? "")
                }
                Spacer()
                
            }
            .foregroundColor(light: .secondary, dark: .secondary)
            Text(info.name)
            HStack {
                Text(dateString(date: info.updateDate))
                    .font(.footnote)
                Spacer()
            }
            .foregroundColor(light: .secondary, dark: .secondary)
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
    
    func dateString(date: Date) -> String {
        var re = ""
        if date.year != Date.now.year {
            re += date.year.description + "."
        }
        re += date.month.description + "." + date.day.description
        return re
    }
}


