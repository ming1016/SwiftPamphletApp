//
//  PlayListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/22.
//

import SwiftUI

struct PlayListView: View {
    @StateObject var l: PLVM = PLVM()
    @State private var s: String = ""
    var body: some View {
        // List 通过$语法可以将集合的元素转换成可绑定的值
        List {
            ForEach($l.ls) { $d in
                PRowView(s: d.s, i: d.i)
                    .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .listRowBackground(Color.black.opacity(0.2))
            }
        }
        .refreshable {
            // 下拉刷新
        }
        .searchable(text: $s) // 搜索
        Divider()
        // 自定义 List
        PCustomListView($l.ls) { $d in
            PRowView(s: d.s, i: d.i)
        }
        Divider()
        // 添加数据
        Button {
            l.ls.append(PLModel(s: "More", i: 0))
        } label: {
            Text("添加")
        }

        
    }
}

// MARK: - List 的抽象，数据兼容任何集合类型
struct PCustomListView<D: RandomAccessCollection & MutableCollection & RangeReplaceableCollection, Content: View>: View where D.Element: Identifiable {
    @Binding var data: D
    var content: (Binding<D.Element>) -> Content
    
    init(_ data: Binding<D>, content: @escaping (Binding<D.Element>) -> Content) {
        self._data = data
        self.content = content
    }
    
    var body: some View {
        List {
            Section {
                ForEach($data, content: content)
                    .onMove { indexSet, offset in
                        data.move(fromOffsets: indexSet, toOffset: offset)
                    }
                    .onDelete { indexSet in
                        data.remove(atOffsets: indexSet) // macOS 暂不支持
                    }
            } header: {
                Text("第一栏，共 \(data.count) 项")
            } footer: {
                Text("The End")
            }
        }
        .listStyle(.plain) // 有.automatic、.inset、.plain、sidebar，macOS 暂不支持的有.grouped 和 .insetGrouped
    }
}

// MARK: - Row
struct PRowView: View {
    var s: String
    var i: Int
    var body: some View {
        HStack {
            Text("\(i)：")
            Text(s)
        }
    }
}

// MARK: - Data Design
struct PLModel: Hashable, Identifiable {
    let id: UUID = UUID()
    var s: String
    var i: Int
}

final class PLVM: ObservableObject {
    @Published var ls: [PLModel]
    init() {
        ls = [PLModel]()
        
        for i in 0...20 {
            ls.append(PLModel(s: "\(i)", i: i))
        }
    }
    
}
