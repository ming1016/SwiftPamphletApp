//
//  IntroView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI
import Inject

struct IntroView: View {
    @ObservedObject private var iO = Inject.observer
    var body: some View {
        VStack(spacing: 15) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text("戴铭的开发小册子").bold().font(.largeTitle)
            HStack {
                Text("一本活的开发手册")
                Link("GitHub 地址", destination: URL(string: "https://github.com/KwaiAppTeam/SwiftPamphletApp")!)
            }
            Text("版本5.0").font(.footnote)
        }
        .frame(minWidth: SPC.detailMinWidth)
        .enableInjection()
    }
}



