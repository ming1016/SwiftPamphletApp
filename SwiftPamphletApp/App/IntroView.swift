//
//  IntroView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI
import MarkdownUI
import SMFile

struct LightingView<Content: View>: View {
    @Environment(\.colorScheme) var colorSchemeMode
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        ZStack {
            content
                .blendMode(colorSchemeMode == .dark ? .colorDodge : .colorBurn)
            content
                .blendMode(colorSchemeMode == .dark ? .softLight : .softLight)
            content
                .blur(radius: 1)
            content
                
        }
    }
}

struct IntroView: View {
    var body: some View {
        VStack(spacing: 15) {
            if let appIcon = NSImage(named: "AppIcon") {
                Image(nsImage: appIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
            }
            Text("戴铭的开发小册子").bold()
            LightingView {
                Text("Swift Pamphlet App").gradientTitle(color: .mint)
            }

            HStack {
                Text("一本活的开发手册")
            }
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                Text("版本\(version)").font(.footnote)
            }
            Markdown(SMFile.loadBundleString("1.md"))
        }
        .frame(minWidth: SPC.detailMinWidth)
    }
}



