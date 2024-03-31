//
//  CategoryListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData
import Charts

struct CategoryListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(IOCategory.allOrderByName) var cates: [IOCategory]
    @State var selectCate: IOCategory?
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.pink.opacity(0.01)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    
    var body: some View {
        List(selection: $selectCate) {
            Section("编辑分类") {
                ForEach(cates) { cate in
                    NavigationLink(value: cate) {
                        CategoryRowView(cate: cate, selectedCate: selectCate)
                    }
                }
            }
        }

    }
    

}

