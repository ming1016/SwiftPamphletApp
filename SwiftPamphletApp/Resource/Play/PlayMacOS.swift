//
//  PlayMacOS.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/21.
//

import SwiftUI

class PlayMacOS {
    static func pasteboard() {
        // 读取剪贴板内容
        let s = NSPasteboard.general.string(forType: .string)
        guard let s = s else {
            return
        }
        print(s)

        // 设置剪贴板内容
        let p = NSPasteboard.general
        p.declareTypes([.string], owner: nil)
        p.setString(s, forType: .string)
    }
}
