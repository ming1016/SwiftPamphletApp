//
//  AppleGuideListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/28.
//

import SwiftUI
import SwiftData
import SMFile

struct GuideListView: View {
    @Query(BookmarkModel.all) var bookmarks: [BookmarkModel]
    @State private var apBookmarks: [String] = [String]()
    @State var listModel: GuideListModel
    @Binding var selectedItem: L?
    @AppStorage(SPC.expandedGuideItems) private var expandedItemsString: String = ""
    @State private var expandedItems: Set<String> = []
    
    var body: some View {
        List(selection: $selectedItem) {
            ForEach(listModel.filtered()) { item in
                OutlineGroup(
                    item: item,
                    bookmarks: apBookmarks,
                    selectedItem: $selectedItem,
                    expandedItems: $expandedItems
                )
            }
        }
        .searchable(
            text: $listModel.searchText,
            prompt: "搜索 Apple 技术手册"
        )
        #if os(macOS)
        .listStyle(.sidebar)
        #endif
        .onAppear {
            // 读取保存的展开状态
            expandedItems = Set(expandedItemsString.split(separator: ",").map(String.init))
            print("Loaded expanded items: \(expandedItems.count)") // Debug
            updateApBookmarks()
        }
        .onChange(of: expandedItems) { _, newValue in
            // 保存展开状态
            expandedItemsString = newValue.joined(separator: ",")
            print("Saved expanded items: \(newValue.count)") // Debug
        }
        .overlay {
            if listModel.filtered().isEmpty {
                ContentUnavailableView {
                    Label("无结果", systemImage: "rectangle.and.text.magnifyingglass")
                } description: {
                    Text("请再次输入")
                }
            }
        }
    }
    
    private struct OutlineGroup: View {
        let item: L
        let bookmarks: [String]
        @Binding var selectedItem: L?
        @Binding var expandedItems: Set<String>
        
        var body: some View {
            if let subItems = item.sub {
                DisclosureGroup(
                    isExpanded: expandedBinding(for: item.t, in: $expandedItems)
                ) {
                    ForEach(subItems) { subItem in
                        OutlineGroup(
                            item: subItem,
                            bookmarks: bookmarks,
                            selectedItem: $selectedItem,
                            expandedItems: $expandedItems
                        )
                    }
                } label: {
                    ItemRow(item: item, bookmarks: bookmarks)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // 点击目录时只切换展开状态
                            expandedItems.toggle(item.t)
                        }
                }
            } else {
                // 只有非目录项才可选择
                ItemRow(item: item, bookmarks: bookmarks)
                    .tag(item)
            }
        }
    }
    
    private static func expandedBinding(for id: String, in expandedItems: Binding<Set<String>>) -> Binding<Bool> {
        Binding(
            get: { expandedItems.wrappedValue.contains(id) },
            set: { isExpanded in
                if isExpanded {
                    expandedItems.wrappedValue.insert(id)
                } else {
                    expandedItems.wrappedValue.remove(id)
                }
            }
        )
    }
    
    private struct ItemRow: View {
        let item: L
        let bookmarks: [String]
        
        var body: some View {
            HStack(spacing: 3) {
                if !item.icon.isEmpty {
                    Image(systemName: item.icon)
                        .foregroundStyle(item.sub == nil ? Color.secondary : .indigo)
                } else if item.sub != nil {
                    Image(systemName: "folder.fill")
                        .foregroundStyle(.indigo)
                }
                Text(GuideListModel.simpleTitle(item.t))
                Spacer()
                if bookmarks.contains(item.t) {
                    Image(systemName: "bookmark")
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
            }
            .contentShape(Rectangle())
        }
    }
    
    func updateApBookmarks() {
        apBookmarks = bookmarks.map(\.name)
    }
}

@Observable
final class GuideListModel {
    var searchText = ""
    var lModel: [L]
    var plName: String = "ap"
    
    init(plModel: [L] = AppleGuide().outline, pplName: String = "ap") {
        self.lModel = plModel
        self.plName = pplName
    }
    
    func filtered() -> [L] {
        guard !searchText.isEmpty else { return lModel }
        let flatModel = flatLModel(lModel)
        return flatModel.filter { model in
            model.t.lowercased().contains(searchText.lowercased())
        }
    }
    
    func flatLModel(_ models: [L]) -> [L] {
        var fModels = [L]()
        for model in models {
            fModels.append(model)
            if let subs = model.sub {
                let reFModels = flatLModel(subs)
                for reModel in reFModels {
                    fModels.append(reModel)
                }
            }
        }
        return fModels
    }
    
    static func simpleTitle(_ title: String) -> String {
        let arr = title.split(separator: "-")
        if arr.first == arr.last {
            return title
        } else {
            return arr.last?.description ?? ""
        }
    }
    
    // 导出内容
    func buildMDContent() {
        var md = ""
        for one in lModel {
            if one.t == "动画" {
                if let oneSub = one.sub {
                    for two in oneSub {
                        let str =   SMFile.loadBundleString("\(two.t)(ap).md")
                        let strformat = "## \(two.t)\n" + str.replacingOccurrences(of: "## ", with: "### ")
                        md += strformat
                        
                        if two.t == "数据集合组件" {
                            if let twoSub = two.sub {
                                for three in twoSub {
                                    if let threeSub = three.sub {
                                        let title = "\n## \(three.t)\n"
                                        var fourStrs = ""
                                        for four in threeSub {
                                            let fourStr = SMFile.loadBundleString("\(four.t)(ap).md")
                                            let fourStrformat = "\n### \(four.t)\n" + fourStr.replacingOccurrences(of: "## ", with: "#### ")
                                            fourStrs += fourStrformat
                                        }
                                        md += title + fourStrs
                                    } else {
                                        let threeStr = SMFile.loadBundleString("\(three.t)(ap).md")
                                        let threeStrformat = "\n## \(three.t)\n" + threeStr.replacingOccurrences(of: "## ", with: "### ")
                                        md += threeStrformat
                                    }
                                }
                            }
                        }
                    } // end for two
                } // end if let oneSub
                
            } // end if one.t
        } // end for one
        SMFile.writeToDownload(fileName: "read.md", content: md)
    }
}

struct L: Hashable, Identifiable {
    var id: String { t }
    var t: String
    var icon: String = ""
    var sub: [L]?
}

extension Set {
    mutating func toggle(_ element: Element) {
        if contains(element) {
            remove(element)
        } else {
            insert(element)
        }
    }
}
