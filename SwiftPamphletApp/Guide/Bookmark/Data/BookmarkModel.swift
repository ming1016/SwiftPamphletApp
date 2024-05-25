//
//  BookmarkModel.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/9.
//

import Foundation
import SwiftData

@Model
final class BookmarkModel {
    var name: String = ""
    var icon: String = ""
    var pamphletName: String = ""
    var tags: [BookmarkTagModel] = [BookmarkTagModel]()
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(pamphletName: String = "", name: String = "", createDate: Date = Date.now, updateDate: Date = Date.now) {
        self.pamphletName = pamphletName
        self.name = name
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    static var all: FetchDescriptor<BookmarkModel> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\BookmarkModel.updateDate, order: .reverse)])
        return fd
    }
    
    static func hasBM(_ name: String, plName: String, context: ModelContext) -> BookmarkModel? {
        
        let fd = FetchDescriptor<BookmarkModel>(predicate: #Predicate { bm in
            bm.name == name 
            && bm.pamphletName == plName
        }, sortBy: [SortDescriptor(\.updateDate, order: .reverse)])
        if let okBM = try? context.fetch(fd) {
            if okBM.count > 0 {
                return okBM.first
            } else {
                return nil
            }
        }
        return nil
    }
    
    static func addBM(_ name: String, icon: String, plName: String, context: ModelContext) {
        if BookmarkModel.hasBM(name, plName: plName, context: context) == nil {
            let newBM = BookmarkModel(pamphletName: plName, name: name)
            newBM.icon = icon
            context.insert(newBM)
        }
    }
    
    static func delBM(_ name: String, plName: String, context: ModelContext) {
        if let bm = BookmarkModel.hasBM(name, plName: plName, context: context) {
            context.delete(bm)
        }
    }
    
    static func delBM(_ bm: BookmarkModel) {
        if let context = bm.modelContext {
            context.delete(bm)
        }
    }
}

@Model
final class BookmarkTagModel {
    var name: String = ""
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String = "", createDate: Date = Date.now, updateDate: Date = Date.now) {
        self.name = name
        self.createDate = createDate
        self.updateDate = updateDate
    }
}
