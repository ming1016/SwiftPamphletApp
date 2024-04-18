//
//  EditCategoryView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData

struct EditCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @State var cate: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("请填写新增的分类名", text: $cate)
                    .tfRounded()
                    .onSubmit {
                        add()
                    }
                Button("添加") {
                    add()
                }
            }
            .padding(5)
            CategoryListView()
            Spacer()
        }
        
    }
    
    func add() {
        let cateModel = IOCategory(name: cate, pin: 0, createDate: Date.now, updateDate: Date.now)
        modelContext.insert(cateModel)
        cate = ""
    }
}


