//
//  PlayKeyboard.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/2.
//

import SwiftUI

struct PlayKeyboard: View {
    var body: some View {
        Button(systemIconName: "camera.shutter.button") {
            print("按了回车键")
        }
        .keyboardShortcut(.defaultAction) // 回车
        
        Button("ESC", action: {
            print("按了 ESC")
        })
        .keyboardShortcut(.cancelAction) // ESC 键
        
        Button("CMD + p") {
            print("按了 CMD + p")
        }
        .keyboardShortcut("p")
        
        Button("SHIFT + p") {
            print("按了 SHIFT + p")
        }
        .keyboardShortcut("p", modifiers: [.shift])
        
    }
}


