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
    @State var listModel = GuideListModel()
    @State private var limit: Int = 50
    @State private var trigger = false // 触发列表书签状态更新
    var body: some View {
        if listModel.searchText.isEmpty == false {
            HStack {
                Text("搜索”\(listModel.searchText)“结果如下")
                Button {
                    listModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
            .padding(.top, 10)
        }
        NavigationStack {
            SPOutlineListView(d: listModel.filtered(), c: \.sub) { i in
                NavigationLink(
                    destination: GuideDetailView(
                        t: i.t,
                        icon: i.icon,
                        plName: listModel.plName,
                        limit: $limit,
                        trigger: $trigger
                    )
                ) {
                    HStack(spacing:3) {
                        if i.icon.isEmpty == false {
                            Image(systemName: i.icon)
                                .foregroundStyle(i.sub == nil ? Color.secondary : .indigo)
                        } else if i.sub != nil {
                            Image(systemName: "folder.fill")
                                .foregroundStyle(.indigo)
                        }
                        Text(listModel.searchText.isEmpty == true ? GuideListModel.simpleTitle(i.t) : i.t)
                        Spacer()
                        if apBookmarks.contains(i.t) {
                            Image(systemName: "bookmark")
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                        }
                    }
                    .contentShape(Rectangle())
                }
            }
            .searchable(
                text: $listModel.searchText,
                prompt: "搜索 Apple 技术手册"
            )
            #if os(macOS)
            .listStyle(.sidebar)
            #endif
            .onChange(of: trigger, { oldValue, newValue in
                updateApBookmarks()
            })
            .onAppear(perform: {
                updateApBookmarks()
                //导出内容
    //            listModel.buildMDContent()
                
            })
            .overlay {
                if listModel.filtered().isEmpty {
                    ContentUnavailableView {
                        Label(
                            "无结果",
                            systemImage: "rectangle.and.text.magnifyingglass"
                        )
                    } description: {
                        Text("请再次输入")
                    }
                }
            } // end overlay
        }
        #if os(iOS)
        .navigationTitle("Apple 开发手册")
        #endif
    }
    
    func updateApBookmarks() {
        apBookmarks = [String]()
        for bm in bookmarks {
//            if bm.pamphletName == "ap" {
//                apBookmarks.append(bm.name)
//            }
            apBookmarks.append(bm.name)
        }
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
    var id = UUID()
    var t: String
    var icon: String = ""
    var sub: [L]?
}

