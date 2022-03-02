//
//  PlayEffect.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/2.
//

import SwiftUI

struct PlayEffect: View {
    @State private var isHover = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .black, .pink], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // 材质
                Text("材质效果")
                    .font(.system(size:30))
                    .padding(isHover ? 40 : 30)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .onHover { b in
                        withAnimation {
                            isHover = b
                        }
                    }
                
                // 模糊
                Text("模糊效果")
                    .font(.system(size: 30))
                    .padding(30)
                    .background {
                        Color.black.blur(radius: 8, opaque: false)
                    }
                
                // 选择
                Text("3D 旋转")
                    .font(.largeTitle)
                    .rotation3DEffect(Angle(degrees: 45), axis: (x: 0, y: 20, z: 0))
                    .scaleEffect(1.5)
                    .blendMode(.hardLight)
                    .blur(radius: 3)
                
            }
                
        }
    }
}














