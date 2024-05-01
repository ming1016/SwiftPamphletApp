//
//  StarInfoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/5/1.
//

import SwiftUI
import SwiftData
import InfoOrganizer

struct StarInfoListView: View {
    @Binding var selectInfo: IOInfo?
    @State var limit: Int = 50
    var body: some View {
        StarInfosView(selectInfo: $selectInfo, limit: $limit)
            .navigationTitle("资料列表 - 收藏")
    }
}


