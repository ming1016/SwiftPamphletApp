//
//  File.swift
//  
//
//  Created by Ming Dai on 2024/4/27.
//

import Foundation
import SwiftData

@Model
public final class DeveloperModel {
    public var name: String = ""
    public var des: String = ""
    public var avatar: String = ""
    
    public var repoOwner: String = ""
    public var repoName: String = ""
    
    public var createDate: Date = Date.now
    public var updateDate: Date = Date.now
    
    public init(name: String, des: String, avatar: String, repoOwner: String, repoName: String, createDate: Date, updateDate: Date) {
        self.name = name
        self.des = des
        self.avatar = avatar
        self.repoOwner = repoOwner
        self.repoName = repoName
        self.createDate = createDate
        self.updateDate = updateDate
    }
    
    public static var all: FetchDescriptor<DeveloperModel> {
        let fd = FetchDescriptor(sortBy: [SortDescriptor(\DeveloperModel.updateDate, order: .reverse)])
        return fd
    }
    
    public static func delete(_ dev: DeveloperModel) {
        if let context = dev.modelContext {
            context.delete(dev)
        }
    }
}
