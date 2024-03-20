//
//  CategoryListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(IOCategory.allOrderByName) var cates: [IOCategory]
    @State var selectCate: IOCategory?
    
    var body: some View {
        List(selection: $selectCate) {
            ForEach(cates) { cate in
                NavigationLink(value: cate) {
                    CategoryRowView(cate: cate, selectedCate: selectCate)
                }
            }
        }
    }
}

