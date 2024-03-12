//
//  CategoryRowView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI

struct CategoryRowView: View {
    @State var cate: IOCategory
    let selectedCate: IOCategory?
    
    var cateColor: Color {
        selectedCate == cate ? Color.white : Color.accentColor
    }
    
    var body: some View {
        HStack {
            TextField("name", text: $cate.name)
            Spacer()
            Text("\(cate.infos?.count ?? 0)")
        }
        .swipeActions {
            Button(role: .destructive) {
                IOCategory.delete(cate)
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
        .contextMenu {
            Button("删除") {
                IOCategory.delete(cate)
            }
        }
        
    }
}

