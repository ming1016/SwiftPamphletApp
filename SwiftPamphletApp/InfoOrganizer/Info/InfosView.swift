//
//  InfosView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI
import SwiftData
import InfoOrganizer
import SMDate



struct InfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    @Binding var selectInfo: IOInfo?
    @Binding var limit: Int
    
    init(filterCateName: String = "", searchString: String = "", selectInfo: Binding<IOInfo?>, sortOrder: [SortDescriptor<IOInfo>] = [], limit: Binding<Int>) {
        
        var fd:FetchDescriptor<IOInfo>
        if searchString.isEmpty == false && filterCateName.isEmpty == false {
            fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
                (info.name.localizedStandardContains(searchString)
                || info.url.localizedStandardContains(searchString)
                 || info.relateName.localizedStandardContains(searchString)
                 || info.des.localizedStandardContains(searchString)) && info.category?.name == filterCateName
            }, sortBy: sortOrder)
        } else if searchString.isEmpty == false {
            fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
                info.name.localizedStandardContains(searchString)
                || info.url.localizedStandardContains(searchString)
                || info.relateName.localizedStandardContains(searchString)
                 || info.des.localizedStandardContains(searchString)
            }, sortBy: sortOrder)
        } else if filterCateName.isEmpty == false {
            fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
                info.category?.name == filterCateName
            }, sortBy: sortOrder)
        } else {
            fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
                true
            }, sortBy: sortOrder)
            
        }
        
        // 测试无数据用
//        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
//            info.name.starts(with: "apple")
//        }, sortBy: sortOrder)
        
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
                    Label("无资料", systemImage: "questionmark.square.dashed")
                } description: {
                    Text("点击下方按钮添加一个资料")
                } actions: {
                    Button("新增") {
                        addInfo()
                    }
                }
            }
        }
    } // end body
    
    func addInfo() {
        let info = IOInfo(name: "简单记录 - \(SMDate.nowDateString())", url: "", des: "", relateName: "")
        modelContext.insert(info)
        selectInfo = info
    }
}

