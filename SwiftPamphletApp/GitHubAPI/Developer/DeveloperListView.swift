//
//  DeveloperListView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/3/20.
//

import SwiftUI
import SwiftData

struct DeveloperListView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var selectDev: DeveloperModel?
    @Query(DeveloperModel.all) var devs: [DeveloperModel]
    
    var body: some View {
        List(selection: $selectDev) {
            ForEach(devs) { dev in
                HStack {
                    AsyncImageWithPlaceholder(size: .smallSize, url: dev.avatar)
                    VStack {
                        HStack {
                            Text(dev.name)
                            Spacer()
                            Text(howLongAgo(date: dev.updateDate))
                                .font(.footnote)
                                .foregroundColor(light: .secondary, dark: .secondary)
                        }
                        HStack {
                            Text(dev.des)
                                .font(.footnote)
                                .foregroundColor(light: .secondary, dark: .secondary)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .tag(dev)
                .swipeActions {
                    Button(role: .destructive) {
                        DeveloperModel.delete(dev)
                    } label: {
                        Label("删除", systemImage: "trash")
                    }
                }
                .contextMenu {
                    Button("删除") {
                        DeveloperModel.delete(dev)
                    }
                }
                    
                    
            }
        }
        .listStyle(.inset)
        .alternatingRowBackgrounds()
        .toolbar(content: {
            ToolbarItem(placement: .navigation) {
                Button("添加开发者", systemImage: "plus", action: addDev)
            }
        })
    }
    
    func addDev() {
        let dev = DeveloperModel(name: "", des: "", avatar: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(dev)
        selectDev = dev
    }
    
}

