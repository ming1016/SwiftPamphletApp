//
//  GuideView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/24.
//

import SwiftUI
import Ink

struct GuideView: View {
    @EnvironmentObject var appVM: AppVM
    var number: Int
    var body: some View {
        WebUIView(html: wrapperHtmlContent(content: MarkdownParser().html(from: "\(loadBundleString("\(number)" + ".md"))")), baseURLStr: "")
            .onAppear {
                appVM.updateWebLink(s: "https://github.com/\(SPC.pamphletIssueRepoName)/issues/" + "\(number)")
            }
    }
}










