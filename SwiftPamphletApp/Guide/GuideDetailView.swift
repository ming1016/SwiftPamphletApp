//
//  AppleGuideDetailView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/28.
//

import SwiftUI
import Ink
import SMFile
import SMDate
import SwiftData
import InfoOrganizer

struct GuideDetailView: View {
    @Environment(\.modelContext) var modelContext
    @State private var isShowInspector = false
    @AppStorage(SPC.isShowPamphletInspector) var asIsShowPamphletInspector: Bool = false
    var t: String
    @State var selectInfo: IOInfo? = nil
    @Query var infos: [IOInfo]
    @Binding var limit: Int
    
    init(t:String,limit: Binding<Int>) {
        self.t = t
        var fd = FetchDescriptor<IOInfo>(predicate: #Predicate { info in
            info.relateName == t && info.isArchived == false
        }, sortBy: [SortDescriptor(\IOInfo.updateDate, order: .reverse)])
        fd.fetchLimit = limit.wrappedValue
        _infos = Query(fd)
        self._limit = limit
    }
    
    var body: some View {
        VStack {
            if selectInfo == nil {
                HStack {
                    Spacer()
                    Text(t).font(.title)
                    Spacer()
                    Button("相关资料管理") {
                        isShowInspector.toggle()
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
                WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: "\(SMFile.loadBundleString("\(t)" + "(ap).md"))")), baseURLStr: "")
            } else {
                if let info = selectInfo {
                    EditInfoView(info: info)
                } else {
                    EmptyView()
                }
            }
        }
        .inspector(isPresented: $isShowInspector) {
            ScrollViewReader(content: { proxy in
                HStack {
                    // 关闭
                    Button(action: {
                        isShowInspector = false
                        selectInfo = nil
                    }, label: {
                        Image(systemName: "xmark.circle")
                    })
                    .help("CMD + d")
                    .keyboardShortcut(KeyEquivalent("d"), modifiers: .command)
                    Spacer()
                    Text("资料")
                        .font(.title)
                    Spacer()
                    Button("添加资料") {
                        let info = IOInfo(name: "新增\(t)资料 - \(SMDate.nowDateString())", url: "", des: "", relateName: t)
                        modelContext.insert(info)
                        selectInfo = info
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(selectInfo, anchor: .top)
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
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
                    
                }
                .id(selectInfo)
            })
        }
        .onAppear {
            isShowInspector = asIsShowPamphletInspector
        }
        .onChange(of: t) { oldValue, newValue in
            selectInfo = nil
        }
        .onChange(of: isShowInspector) { oldValue, newValue in
            asIsShowPamphletInspector = newValue
        }
    }
    
    
}

