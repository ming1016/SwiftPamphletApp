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
    @Query var cates: [IOCategory]
    
    var body: some View {
        List {
            ForEach(cates) { cate in
                NavigationLink(value: cate) {
                    Text(cate.name)
                }
            }
            .onDelete(perform: deleteCates(at:))
        }
    }
    func deleteCates(at offsets: IndexSet) {
        for offset in offsets {
            let cate = cates[offset]
            modelContext.delete(cate)
        }
    }
}

