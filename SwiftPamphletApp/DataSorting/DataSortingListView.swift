//
//  DataSortingListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/1.
//

import SwiftUI

struct DataSortingListView: View {
    struct M: Hashable, Identifiable {
        var id = UUID()
        var name: String
        var icon: String?
        var subs: [M]?
        
        init(name: String) {
            self.name = name
        }
        
        init(name: String, subs: [M]) {
            self.name = name
            self.subs = subs
        }
    }
    
    @State private var model = [
        M(name: "新鲜事", subs: [
            M(name: "周报"),
            M(name: "播客")
        ]),
        M(name: "Swift", subs: [
            M(name: "Swift 官方"),
            M(name: "Swift 技术"),
            M(name: "SwiftUI")
        ]),
        M(name: "美术", subs: [
            M(name: "图片工具"),
            M(name: "美术素材")
        ])
    ]
    
    var body: some View {
        List {
            ForEach(model) { m in
                Section {
                    OutlineGroup(m.subs ?? [], children: \.subs) { c in
//                        Text(c.name)
                        NavigationLink {
                            DataListView(name: c.name)
                        } label: {
                            Text(c.name)
                                .font(.title3)
                        }

                    }
                } header: {
                    Text(m.name)
                        .font(.title)
                }
                
            }
        }
        
    }
}

