//
//  IntroView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text("戴铭的 Swift 小册子").bold().font(.largeTitle)
            Text("一本活的 Swift 手册")
            Text("版本4.0").font(.footnote)
        }
        .frame(minWidth: SPC.detailMinWidth)
    }
}
