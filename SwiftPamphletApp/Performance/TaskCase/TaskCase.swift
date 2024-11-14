//
//  BadCase.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import Foundation

struct TaskCase {
    static func bad() {
        TaskCase.badLoadFile() // 读取文件
        TaskCase.badSemaphore() // 信号量
        TaskCase.badJSONDecode() // JSON 解析
    }
    
    static func good() {
        TaskCase.goodLoadFile() // 读取文件
        TaskCase.goodSemaphore() // 信号量
        TaskCase.goodJSONDecode() // JSON 解析
    }
    
}
