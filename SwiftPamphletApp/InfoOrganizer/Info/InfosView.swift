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
    @Binding var limit: Int
    
    init(filterCateName: String = "", searchString: String = "", filterStar: Bool = false ,selectInfo: Binding<IOInfo?>, sortOrder: [SortDescriptor<IOInfo>] = [], limit: Binding<Int>) {
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            if !filterCateName.isEmpty && !searchString.isEmpty {
                (info.name.localizedStandardContains(searchString)
                || info.url.localizedStandardContains(searchString)
                 || info.des.localizedStandardContains(searchString)) && info.category?.name == filterCateName
            } else if !filterCateName.isEmpty {
                info.category?.name == filterCateName
            } else if searchString.isEmpty {
                info.star == filterStar
            } else {
                info.name.localizedStandardContains(searchString)
                || info.url.localizedStandardContains(searchString)
                 || info.des.localizedStandardContains(searchString)
            }
        }, sortBy: sortOrder)
        fd.fetchLimit = limit.wrappedValue
        _infos = Query(fd)
        
        self._selectInfo = selectInfo
        self._limit = limit
    }
    
    var body: some View {
        List(selection: $selectInfo) {
            ForEach(infos) { info in
                InfoRowView(info: info, selectedInfo: selectInfo)
                .tag(info)
                .onAppear {
                    if info == infos.last {
                        if limit <= infos.count {
                            limit += 50
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
        .alternatingRowBackgrounds()
    }
}

