//
//  InfosFilterWithCateView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI
import SwiftData

struct InfosFilterWithCateView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    @Binding var selectInfo: IOInfo?
    
    init(filterCateName: String = "", selectInfo: Binding<IOInfo?>, sortOrder: [SortDescriptor<IOInfo>] = []) {
        
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            if filterCateName.isEmpty {
                true
            } else {
                info.category?.name == filterCateName
            }
        }, sortBy: sortOrder)
        fd.fetchLimit = 1000
        _infos = Query(fd)
        
        self._selectInfo = selectInfo
    }
    
    var body: some View {
        List(selection: $selectInfo) {
            ForEach(infos) { info in
                InfoRowView(info: info, selectedInfo: selectInfo)
                .tag(info)
            }
        }
    }
}
