//
//  InfoDataModel.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import Foundation
import SwiftData

@Model
final class IOInfo {
    var name: String = ""
    var url: String = ""
    var des: String = ""
    var category: IOCategory?
    
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String, 
         url: String,
         des: String,
         category: IOCategory? = nil,
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
        self.url = url
        self.des = des
        self.category = category
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    static func delete(_ info: IOInfo) {
        if let context = info.modelContext {
            context.delete(info)
        }
    }
}

@Model
class IOCategory {
    var name: String = ""
    var infos: [IOInfo]? = [IOInfo]()
    
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String, 
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    static func delete(_ cate: IOCategory) {
        if let context = cate.modelContext {
            context.delete(cate)
        }
    }
}
