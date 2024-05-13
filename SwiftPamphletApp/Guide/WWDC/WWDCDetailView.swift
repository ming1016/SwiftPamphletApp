//
//  WWDCDetailView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/12.
//

import SwiftUI
import AVKit
import SMDate
import SwiftData
import InfoOrganizer

struct WWDCDetailView: View {
    var session: WWDCSessionModel? = nil
    
    @Environment(\.modelContext) var modelContext
    @State private var isShowInspector = false
    @AppStorage(SPC.isShowWWDCInspector) var asIsShowWWDCInspector: Bool = false
    @Binding var limit: Int
    @State var selectInfo: IOInfo? = nil
    @Query var infos: [IOInfo]
    
    // 初始化
    init(session:WWDCSessionModel, limit: Binding<Int>) {
        self.session = session
        let sid = session.id
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            info.relateName == sid && info.isArchived == false
        }, sortBy: [SortDescriptor(\IOInfo.updateDate, order: .reverse)])
        fd.fetchLimit = limit.wrappedValue
        _infos = Query(fd)
        self._limit = limit
    }
    
    var body: some View {
        if let ss = session {
            VStack {
                if selectInfo == nil {
                    VStack(spacing: 10) {
                        HStack {
                            Spacer()
                            Text(ss.title)
                                .font(.title)
                            Spacer()
                            Button("相关资料管理") {
                                isShowInspector.toggle()
                            }
                        }
                        VStack(alignment:.leading, spacing: 10) {
                            if let vurl = ss.media.videoOriginalUrl {
                                if let okVurl = URL(string: vurl) {
                                    if ss.year > 2020 {
                                        #if arch(arm64)
                                        VideoPlayer(player: AVPlayer(url: okVurl))
                                        #elseif arch(x86_64)
                                        Link("视频地址：\(vurl)", destination: okVurl)
                                        #else
                                        Link("视频地址：\(vurl)", destination: okVurl)
                                        #endif
                                    } else {
                                        Link("视频地址：\(vurl)", destination: okVurl)
                                    }
                                }
                            }
                            if let platforms = ss.platforms {
                                Text(platformDes(platforms))
                                    .foregroundStyle(.secondary)
                            }
                            Text(ss.description ?? "")
                            
                            
                        }
                        Spacer()
                    }
                    .padding(20)
                } else {
                    if let info = selectInfo {
                        EditInfoView(info: info)
                    } else {
                        EmptyView()
                    }
                }
            }
            .inspector(isPresented: $isShowInspector) {
                HStack {
                    // 关闭
                    Button(action: {
                        isShowInspector = false
                        selectInfo = nil
                    }, label: {
                        Image(systemName: "xmark.circle")
                    })
                    .help("command + d")
                    .keyboardShortcut(KeyEquivalent("d"), modifiers: .command)
                    Spacer()
                    Text("资料")
                        .font(.title)
                    Spacer()
                    Button("添加资料") {
                        let info = IOInfo(name: "新增\(session?.id ?? "")资料 - \(SMDate.nowDateString())", url: "", des: "", relateName: session?.id ?? "")
                        modelContext.insert(info)
                        selectInfo = info
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
                List(selection: $selectInfo) {
                    ForEach(infos) { info in
                        InfoRowView(info: info)
                            .tag(info)
                            .id(info)
                            .onAppear {
                                if info == infos.last {
                                    if limit <= infos.count {
                                        limit += 50
                                    }
                                }
                            }
                    }
                }
                .listStyle(.plain)
            }
            .onAppear {
                isShowInspector = asIsShowWWDCInspector
            }
            .onChange(of: session) { oldValue, newValue in
                selectInfo = nil
            }
            .onChange(of: isShowInspector) { oldValue, newValue in
                asIsShowWWDCInspector = newValue
            }
            
        } else {
            EmptyView()
        }
        
    }
    
    func platformDes(_ pf: [String]) -> String {
        var re = ""
        if pf.count > 0 {
            re = "平台：" + pf.joined(separator: ", ")
        }
        return re
    }
}
