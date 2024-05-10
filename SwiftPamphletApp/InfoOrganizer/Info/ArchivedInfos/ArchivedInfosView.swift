//
//  ArchivedInfosView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/5/1.
//

import SwiftUI
import SwiftData
import InfoOrganizer
import SMDate

struct ArchivedInfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    @Binding var selectInfo: IOInfo?
    @Binding var limit: Int
    
    init(selectInfo: Binding<IOInfo?>, limit: Binding<Int>) {
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            info.isArchived == true
        }, sortBy: [SortDescriptor(\IOInfo.updateDate, order: .reverse)])
        
        // 测试用
//        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
//            info.isArchived == true && info.name.starts(with: "apple")
//        }, sortBy: [SortDescriptor(\IOInfo.updateDate, order: .reverse)])
        
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
            }
        } // end List
        .listStyle(.plain)
        .overlay {
            if infos.isEmpty {
                ContentUnavailableView {
                    Label("无归档", systemImage: "archivebox")
                } description: {
                    Text("点击下方按钮添加一个归档资料")
                } actions: {
                    Button("新增") {
                        addInfo()
                    }
                }
            }
        } // end overlay
    }
    
    func addInfo() {
        let info = IOInfo(name: "简单记录 - \(SMDate.nowDateString())", url: "", des: "", relateName: "")
        info.isArchived = true
        modelContext.insert(info)
        selectInfo = info
    }
}

