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
                Text(dev.name)
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
        })
    }
    
    func addDev() {
        let dev = DeveloperModel(name: "new", unread: 0, createDate: Date.now, updateDate: Date.now)
        modelContext.insert(dev)
        selectDev = dev
    }
}

