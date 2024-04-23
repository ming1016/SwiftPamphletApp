//
//  File.swift
//  
//
//  Created by Ming on 2024/4/23.
//

import Foundation
import SwiftData

@Model
public final class IOInfo {
    public var name: String = ""
    public var url: String = ""
    public var coverImage: IOImg? = nil // 封面图
    public var imageUrls: [String] = [String]() // 图集
    public var imgs: [IOImg]? = [IOImg]() // 本地图集
    public var des: String = ""
    public var category: IOCategory? = nil// 关系字段，链接 IOCategory
    public var star: Bool = false
    @Attribute(.externalStorage) public  var webArchive: Data? = nil
    
    public var createDate: Date = Date.now
    public var updateDate: Date = Date.now
    
    public init(name: String,
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
    
    public static func delete(_ info: IOInfo) {
        if let context = info.modelContext {
            context.delete(info)
        }
    }
    public static func updateCoverImage(info: IOInfo, img: IOImg) {
        if let coverImg = info.coverImage {
            if coverImg.imgData == nil {
                IOImg.delete(coverImg)
            }
        }
        info.coverImage = img
    }
}

@Model
public class IOImg {
    public var url: String = ""
    @Attribute(.externalStorage) public var imgData: Data? = nil
    public init(url: String, imgData: Data? = nil) {
        self.url = url
        self.imgData = imgData
    }
    
    public static func delete(_ img: IOImg) {
        if let context = img.modelContext {
            context.delete(img)
        }
    }
}

@Model
public class IOCategory {
    public var name: String = ""
    public var pin: Int = 0
    public var createDate: Date = Date.now
    public var updateDate: Date = Date.now
    
    public init(name: String,
         pin: Int,
         createDate: Date,
         updateDate: Date
    ) {
        self.name = name
        self.pin = pin
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    public static var all: FetchDescriptor<IOCategory> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\IOCategory.pin, order: .reverse), SortDescriptor(\IOCategory.updateDate, order: .reverse)])
        return fd
    }
    public static var allOrderByName: FetchDescriptor<IOCategory> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\IOCategory.pin, order: .reverse), SortDescriptor(\IOCategory.name, order: .forward)])
        return fd
    }
    
    public static func pin(_ cate: IOCategory) {
        if cate.modelContext != nil {
            if cate.pin == 0 {
                cate.pin = 1
            } else {
                cate.pin = 0
            }
        }
    }
    
    public static func delete(_ cate: IOCategory) {
        if let context = cate.modelContext {
            context.delete(cate)
        }
    }
}
