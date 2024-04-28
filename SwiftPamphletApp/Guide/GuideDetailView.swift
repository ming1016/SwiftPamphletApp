//
//  AppleGuideDetailView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/28.
//

import SwiftUI
import Ink
import SMFile

struct GuideDetailView: View {
    var t: String
    var body: some View {
        HStack {
            Spacer()
            Text(t).font(.title)
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
        WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: "\(SMFile.loadBundleString("\(t)" + ".md"))")), baseURLStr: "")
    }
}

