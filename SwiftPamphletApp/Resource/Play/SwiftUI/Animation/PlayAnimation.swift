//
//  PlayAnimation.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/2.
//

import SwiftUI

struct PlayAnimation: View {
    @State private var changeText = false
    var body: some View {
        Text(changeText ? "另一种状态" : "一种状态")
            .font(.largeTitle)
            .padding()
            .animation(.default, value: changeText) // 受限的隐式动画，只绑定某个值。
            .onHover { b in
                // 使用 withAnimation 就是显式动画
                withAnimation {
                    changeText = b
                }
                
            }
    }
}


