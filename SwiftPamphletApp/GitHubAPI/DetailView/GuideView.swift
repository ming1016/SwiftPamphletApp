//
//  GuideView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/24.
//

import SwiftUI
import Ink

struct GuideView: View {
    var number: Int
    var title: String
    var body: some View {
        HStack {
            Spacer()
            Text(title).font(.title)
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
        WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: "\(loadBundleString("\(number)" + ".md"))")), baseURLStr: "")
            .frame(minWidth: SPC.detailMinWidth)
    }
}
