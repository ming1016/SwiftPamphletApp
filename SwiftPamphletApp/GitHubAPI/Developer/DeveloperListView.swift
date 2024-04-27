//
//  DeveloperListView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/3/20.
//

import SwiftUI
import SwiftData
import SMDate
import SMGitHub

struct DeveloperListView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var selectDev: DeveloperModel?
    @Query(DeveloperModel.all) var devs: [DeveloperModel]
    
    var body: some View {
        List(selection: $selectDev) {
            ForEach(devs) { dev in
                HStack {
                    NukeImage(width: 40, height: 40, url: dev.avatar)
                    VStack {
                        HStack {
                            if dev.repoName.isEmpty {
                                Text(dev.name)
                                
                            } else {
                                VStack(alignment:.leading) {
                                    Text(dev.repoOwner)
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    Text(dev.repoName)
                                }
                            }
                            
                            Spacer()
                            Text(SMDate.howLongAgo(date: dev.updateDate))
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                            Text(dev.des)
                                .font(.footnote)
                                .foregroundColor(.secondary)
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
                    .keyboardShortcut(KeyEquivalent("a"), modifiers: .option)
            }
        })
    }
    
    func addDev() {
        let dev = DeveloperModel(name: "", des: "", avatar: "", repoOwner: "", repoName: "", createDate: Date.now, updateDate: Date.now)
        modelContext.insert(dev)
        selectDev = dev
    }
    
}

