//
//  DeveloperModel.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/3/20.
//

import Foundation
import SwiftData

@Model
final class DeveloperModel {
    var name: String = ""
    var unread: Int = 0
    var lastEventIdStr: String = ""
    
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String, unread: Int, lastEventIdStr: String, createDate: Date, updateDate: Date) {
        self.name = name
        self.unread = unread
        self.lastEventIdStr = lastEventIdStr
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    static var all: FetchDescriptor<DeveloperModel> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\DeveloperModel.updateDate, order: .reverse)])
        return fd
    }
    
    static func delete(_ dev: DeveloperModel) {
        if let context = dev.modelContext {
            context.delete(dev)
        }
    }
}
