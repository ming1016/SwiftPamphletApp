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
    var category: IOCategory? = nil// 关系字段，链接 IOCategory
    var star: Bool = false
    
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String, 
         url: String,
         des: String,
         category: IOCategory? = nil,
         star: Bool,
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
        self.url = url
        self.des = des
        self.category = category
        self.star = star
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
    var infos: [IOInfo]? = [IOInfo]() // 关系字段，链接 IOInfo
    var pin: Int = 0
    
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String,
         infos: [IOInfo]?,
         pin: Int,
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
        self.infos = [IOInfo]()
        self.pin = pin
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    static var all: FetchDescriptor<IOCategory> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\IOCategory.pin, order: .reverse), SortDescriptor(\IOCategory.updateDate, order: .reverse)])
        return fd
    }
    static var allOrderByName: FetchDescriptor<IOCategory> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\IOCategory.pin, order: .reverse), SortDescriptor(\IOCategory.name, order: .forward)])
        return fd
    }
    
    static func pin(_ cate: IOCategory) {
        if cate.modelContext != nil {
            if cate.pin == 0 {
                cate.pin = 1
            } else {
                cate.pin = 0
            }
        }
    }
    
    static func delete(_ cate: IOCategory) {
        if let context = cate.modelContext {
            context.delete(cate)
        }
    }
}
