//
//  ArchivedInfoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/5/1.
//

import SwiftUI
import SwiftData
import InfoOrganizer

struct ArchivedInfoListView: View {
    @Binding var selectInfo: IOInfo?
    @State var limit: Int = 50
    
    var body: some View {
        ArchivedInfosView(selectInfo: $selectInfo, limit: $limit)
            .navigationTitle("资料列表 - 归档")
            .onDisappear {
                selectInfo = nil
            }
    }
}

