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
    var plName: String
    @Binding var limit: Int
    @Binding var trigger: Bool
    
    @State var selectInfo: IOInfo? = nil
    @Query var infos: [IOInfo]
    @State private var isBookmarked = false
    
    
    // 初始化
    init(t:String, plName: String, limit: Binding<Int>, trigger: Binding<Bool>) {
        self.t = t
        self.plName = plName
        self._trigger = trigger
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
                    // 书签
                    Toggle(isOn: $isBookmarked) {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    }
                    .toggleStyle(.button)
                    .help("书签")
                    .onChange(of: t, { oldValue, newValue in
                        checkBookmarkState()
                    })
                    .onChange(of: isBookmarked) { oldValue, newValue in
                        if newValue == true {
                            BookmarkModel.addBM(t, plName: plName, context: modelContext)
                        } else {
                            BookmarkModel.delBM(t, plName: plName, context: modelContext)
                        }
                        trigger.toggle()
                    }
                    .onAppear(perform: {
                        checkBookmarkState()
                    })
                    
                    
                    // 标题和资料
                    Spacer()
                    Text(t).font(.title)
                    Spacer()
                    Button("相关资料管理") {
                        isShowInspector.toggle()
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
                // 内容
                WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: "\(SMFile.loadBundleString("\(t)" + "(\(plName)).md"))")), baseURLStr: "")
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
                    let info = IOInfo(name: "新增\(t)资料 - \(SMDate.nowDateString())", url: "", des: "", relateName: t)
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
            isShowInspector = asIsShowPamphletInspector
        }
        .onChange(of: t) { oldValue, newValue in
            selectInfo = nil
        }
        .onChange(of: isShowInspector) { oldValue, newValue in
            asIsShowPamphletInspector = newValue
        }
    }
    
    func checkBookmarkState() {
        if BookmarkModel.hasBM(t, plName: plName, context: modelContext) == nil {
            isBookmarked = false
        } else {
            isBookmarked = true
        }
    }
}

