//
//  PlayColor.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/2.
//

import SwiftUI

struct PlayColor: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Color 也是一个 View
            
            VStack(spacing: 10) {
                Text("这是一个适配了暗黑的文字颜色")
                    .foregroundColor(light: .purple, dark: .pink)
                    .background(Color(nsColor: .quaternaryLabelColor)) // 使用以前 NSColor
                
                Text("自定义颜色")
                    .foregroundColor(Color(red: 0, green: 0, blue: 100))
            }
            .padding()
            
        }
    }
}

// MARK: - 暗黑适配颜色
struct PCColorModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    var light: Color
    var dark: Color
    
    private var adaptColor: Color {
        switch colorScheme {
        case .light:
            return light
        case .dark:
            return dark
        @unknown default:
            return light
        }
    }
    
    func body(content: Content) -> some View {
        content.foregroundColor(adaptColor)
    }
}

extension View {
    func foregroundColor(light: Color, dark: Color) -> some View {
        modifier(PCColorModifier(light: light, dark: dark))
    }
}
