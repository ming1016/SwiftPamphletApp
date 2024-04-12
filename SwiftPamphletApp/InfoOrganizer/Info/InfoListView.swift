//
//  InfoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//
//import Foundation
import SwiftUI
import SwiftData

struct InfoListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var searchText = ""
    @Binding var selectInfo:IOInfo?
    @State private var sortOrder = [SortDescriptor(\IOInfo.star, order: .reverse),SortDescriptor(\IOInfo.updateDate, order: .reverse)]
    
    @Query(IOCategory.allOrderByName) var cates: [IOCategory]
    @State private var filterCate = ""
    @State var limit: Int = 50
    @State var filterStar: Bool = false
    
    var body: some View {
        InfosView(filterCateName: filterCate, searchString: searchText, filterStar: filterStar, selectInfo: $selectInfo, sortOrder: sortOrder, limit: $limit)
            .navigationTitle("资料列表")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("添加资料", systemImage: "plus", action: addInfo)
                        .keyboardShortcut(KeyEquivalent("i"), modifiers: .command)
                }
                ToolbarItem(placement: .navigation) {
                    Picker("分类", selection: $filterCate) {
                        HStack {
                            Text("全部")
                        }
                        .tag("")
                        Divider()
                        ForEach(cates) { cate in
                            HStack {
                                if cate.pin == 1 {
                                    Image(systemName: "pin.fill")
                                }
                                Text(cate.name)
                            }
                            .tag(cate.name)
                        }
                    }
                }
                if searchTerms.isEmpty == false {
                    ToolbarItem(placement: .navigation) {
                        customSearchView()
                    }
                }
                if filterCate.isEmpty {
                    ToolbarItem(placement: .navigation) {
                        Toggle(isOn: $filterStar) {
                        }
                        .toggleStyle(SymbolToggleStyle(systemImage: "star.fill", activeColor: .yellow))
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down.square") {
                        Picker("排序", selection: $sortOrder) {
                            Text("正序")
                                .tag([SortDescriptor(\IOInfo.updateDate)])
                            Text("倒序")
                                .tag([SortDescriptor(\IOInfo.updateDate, order: .reverse)])
                        }
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        modelContext.undoManager?.undo()
                    }, label: {
                        Image(systemName: "arrow.uturn.backward.circle")
                        Text("撤回")
                    })
                    .disabled(modelContext.undoManager?.canUndo == false)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        modelContext.undoManager?.redo()
                    }, label: {
                        Image(systemName: "arrow.uturn.forward.circle")
                        Text("重做")
                    })
                    .disabled(modelContext.undoManager?.canRedo == false)
                }
            }
            .searchable(text: $searchText)
            .onAppear {
                parseSearchTerms()
            }
            .onChange(of: term) { oldValue, newValue in
                parseSearchTerms()
            }
    }
    
    
    // MARK: 自定义搜索
    @ViewBuilder
    func customSearchView() -> some View {
        Picker("自定检索", selection: $searchText) {
            Text("自定检索")
                .tag("")
            Divider()
            ForEach(searchTerms, id: \.self) { term in
                Text(customSearchLabel(term))
                    .tag(term)
            }
        }
    }
    
    @AppStorage("customSearchTerm") var term = ""
    @State private var searchTerms: [String] = [String]()
    func parseSearchTerms() {
        let terms = term.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n")
        searchTerms = [String]()
        for t in terms {
            if t.isEmpty == false {
                let tWithoutWhitespaces = t.trimmingCharacters(in: .whitespaces)
                if tWithoutWhitespaces.hasPrefix("//") { continue }
                let ts = t.trimmingCharacters(in: .whitespaces).split(separator: ",")
                if ts.count > 1 {
                    for oneT in ts {
                        searchTerms.append(String(oneT.trimmingCharacters(in: .whitespaces)))
                    }
                } else {
                    searchTerms.append(String(tWithoutWhitespaces))
                }
            } // end if
        } // end for
    }
    func customSearchLabel(_ string: String) -> String {
        let strs = string.split(separator: "/")
        if strs.count > 0 {
            var reStr = ""
            if strs.count == 1 {
                if strs.first?.hasPrefix("《") == false {
                    reStr.append("  ")
                }
            } else {
                for _ in 1...strs.count {
                    reStr.append("  ")
                }
            }
            if let last = strs.last {
                reStr.append(String(last))
            }
            
            
            return reStr
        }
        return string
    }
    
    // MARK: 资料整理数据方面
    func addInfo() {
        let info = IOInfo(name: "简单记录 - \(nowDateString())", url: "", coverImage: nil, imageUrls: [String](), imgs: [IOImg](), des: "", star: false, webArchive: nil , createDate: Date.now, updateDate: Date.now)
        for cate in cates {
            if cate.name == filterCate {
                info.category = cate
            }
        }
        modelContext.insert(info)
        selectInfo = info
    }
    func nowDateString() -> String {
        let locale = Locale(identifier: "zh_Hans")
        return Date.now.formatted(.dateTime.locale(locale))
    }
    
}


