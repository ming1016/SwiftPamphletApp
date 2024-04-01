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
    var coverImage: IOImg? = nil // 封面图
    var imageUrls: [String] = [String]() // 图集
    var imgs: [IOImg]? = [IOImg]() // 本地图集
    var des: String = ""
    var category: IOCategory? = nil// 关系字段，链接 IOCategory
    var star: Bool = false
    @Attribute(.externalStorage) var webArchive: Data? = nil
    
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String, 
         url: String,
         coverImage: IOImg? = nil,
         imageUrls: [String],
         imgs: [IOImg]? = [IOImg](),
         des: String,
         category: IOCategory? = nil,
         star: Bool,
         webArchive: Data? = nil,
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
        self.url = url
        self.coverImage = coverImage
        self.imageUrls = imageUrls
        self.imgs = imgs
        self.des = des
        self.category = category
        self.star = star
        self.webArchive = webArchive
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    static func delete(_ info: IOInfo) {
        if let context = info.modelContext {
            context.delete(info)
        }
    }
    static func updateCoverImage(info: IOInfo, img: IOImg) {
        if let coverImg = info.coverImage {
            if coverImg.imgData == nil {
                IOImg.delete(coverImg)
            }
        }
        info.coverImage = img
    }
}

@Model
class IOImg {
    var url: String = ""
    @Attribute(.externalStorage) var imgData: Data? = nil
    init(url: String, imgData: Data? = nil) {
        self.url = url
        self.imgData = imgData
    }
    
    static func delete(_ img: IOImg) {
        if let context = img.modelContext {
            context.delete(img)
        }
    }
}

@Model
class IOCategory {
    var name: String = ""
    var pin: Int = 0
    var createDate: Date = Date.now
    var updateDate: Date = Date.now
    
    init(name: String,
         pin: Int,
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
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
