//
//  UnCategoryInfosView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/5/1.
//

import SwiftUI
import SwiftData
import InfoOrganizer
import SMDate

struct UnCategoryInfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    @Binding var selectInfo: IOInfo?
    @Binding var limit: Int
    
    init(selectInfo: Binding<IOInfo?>, limit: Binding<Int>) {
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            info.category == nil && info.isArchived == false
        }, sortBy: [SortDescriptor(\IOInfo.updateDate, order: .reverse)])
        fd.fetchLimit = limit.wrappedValue
        
        _infos = Query(fd)
        self._selectInfo = selectInfo
        self._limit = limit
    }
    
    var body: some View {
        List(selection: $selectInfo) {
            ForEach(infos) { info in
                InfoRowView(info: info)
                    .tag(info)
                    .onAppear {
                        if info == infos.last {
                            if limit <= infos.count {
                                limit += 50
                            }
                        }
                    }
            } // endforeach
        } // end list
        .listStyle(.plain)
        .overlay {
            if infos.isEmpty {
                ContentUnavailableView {
                    Label("无未分类", systemImage: "questionmark.square.dashed")
                } description: {
                    Text("点击下方按钮添加一个未分类资料")
                } actions: {
                    Button("新增") {
                        addInfo()
                    }
                }
            }
        }
    }
    
    func addInfo() {
        let info = IOInfo(name: "简单记录 - \(SMDate.nowDateString())", url: "", des: "", relateName: "")
        modelContext.insert(info)
        selectInfo = info
    }
}

