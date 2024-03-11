//
//  EditCategoryView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData

struct EditCategoryView: View {
    @Bindable var cate: IOCategory
    
    var body: some View {
        VStack {
            Form {
                TextField("分类名", text: $cate.name)
            }
            .navigationTitle("编辑分类")
            .padding(30)
            CategoryListView()
            Spacer()
        }
        
    }
}


