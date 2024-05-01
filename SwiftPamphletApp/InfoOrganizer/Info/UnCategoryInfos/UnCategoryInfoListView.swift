//
//  UnCategoryInfoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/5/1.
//

import SwiftUI
import SwiftData
import InfoOrganizer

struct UnCategoryInfoListView: View {
    @Binding var selectInfo:IOInfo?
    @State var limit: Int = 50
    
    var body: some View {
        UnCategoryInfosView(selectInfo: $selectInfo, limit: $limit)
            .navigationTitle("资料列表 - 未分类")
    }
}

