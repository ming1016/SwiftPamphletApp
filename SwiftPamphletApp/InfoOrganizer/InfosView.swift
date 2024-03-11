//
//  InfosView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData

struct InfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    init(searchString: String = "", sortOrder:[SortDescriptor<IOInfo>] = []) {
        _infos = Query(filter: #Predicate { info in
            if searchString.isEmpty {
                true
            } else {
                info.name.localizedStandardContains(searchString)
                || info.url.localizedStandardContains(searchString)
                || info.des.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        List {
            ForEach(infos) { info in
                NavigationLink(value: info) {
                    Text(info.name)
                }
            }
            .onDelete(perform: { indexSet in
                deleteInfos(at: indexSet)
            })
        }
    }
    
    func deleteInfos(at offsets: IndexSet) {
        for offset in offsets {
            let info = infos[offset]
            modelContext.delete(info)
        }
    }
}

