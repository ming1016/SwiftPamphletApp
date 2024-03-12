//
//  InfosView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI
import SwiftData

struct InfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    @Binding var selectInfo: IOInfo?
    
    init(searchString: String = "", selectInfo: Binding<IOInfo?>, sortOrder: [SortDescriptor<IOInfo>] = []) {
        _infos = Query(filter: #Predicate { info in
            if searchString.isEmpty {
                true
            } else {
                info.name.localizedStandardContains(searchString)
                || info.url.localizedStandardContains(searchString)
                 || info.des.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
        
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

