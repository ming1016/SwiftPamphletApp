//
//  IntroView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI
import MarkdownUI

struct IntroView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text("戴铭的开发小册子").bold()
            Text("Swift Pamphlet App").gradientTitle(color: .mint)
            HStack {
                Text("一本活的开发手册")
                Link("GitHub 地址", destination: URL(string: "https://github.com/ming1016/SwiftPamphletApp")!)
            }
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                Text("版本\(version)").font(.footnote)
            }
            Markdown(loadBundleString("1.md"))
        }
        .frame(minWidth: SPC.detailMinWidth)
    }
}



