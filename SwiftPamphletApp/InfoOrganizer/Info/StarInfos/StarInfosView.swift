//
//  StarInfosView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/5/1.
//

import SwiftUI
import SwiftData
import InfoOrganizer
import SMDate

struct StarInfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    @Binding var selectInfo: IOInfo?
    @Binding var limit: Int
    
    init(selectInfo: Binding<IOInfo?>, limit: Binding<Int>) {
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            info.star == true && info.isArchived == false
        }, sortBy: [SortDescriptor(\IOInfo.updateDate, order: .reverse)])
        
        // 测试用
//        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
//            info.star == true && info.name.starts(with: "apple")
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
        .overlay {
            if infos.isEmpty {
                ContentUnavailableView {
                    Label("无收藏", systemImage: "star.slash")
                } description: {
                    Text("点击下方按钮添加一个收藏资料")
                } actions: {
                    Button("新增") {
                        addInfo()
                    }
                }
            }
        } // end overlay
        
    } // end body
    
    func addInfo() {
        let info = IOInfo(name: "简单记录 - \(SMDate.nowDateString())", url: "", des: "", relateName: "")
        info.star = true
        modelContext.insert(info)
        selectInfo = info
    }
}

