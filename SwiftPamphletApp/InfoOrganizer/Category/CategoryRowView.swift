//
//  CategoryRowView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI
import InfoOrganizer

struct CategoryRowView: View {
    @State var cate: IOCategory
    let selectedCate: IOCategory?
    
    var cateColor: Color {
        selectedCate == cate ? Color.white : Color.accentColor
    }
    
    var body: some View {
        HStack {
            if cate.pin == 1 {
                Image(systemName: "pin.fill")
            }
            TextField("name", text: $cate.name)
            Spacer()
        }
        .swipeActions {
            Button {
                IOCategory.pin(cate)
            } label: {
                Label("置顶", systemImage: cate.pin == 1 ? "pin.slash.fill" : "pin.fill")
            }
            Button(role: .destructive) {
                IOCategory.delete(cate)
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
        .contextMenu {
            Button {
                IOCategory.pin(cate)
            } label: {
                Label(cate.pin == 1 ? "取消置顶" : "置顶", systemImage: cate.pin == 1 ? "pin.slash.fill" : "pin.fill")
            }
            Button(role: .destructive) {
                IOCategory.delete(cate)
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
        
    }
}

