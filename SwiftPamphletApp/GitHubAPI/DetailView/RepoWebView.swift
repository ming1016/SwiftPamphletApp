//
//  RepoWebView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/25.
//

import SwiftUI

struct RepoWebView: View {
    @EnvironmentObject var appVM: AppVM
    var urlStr: String
    var body: some View {
        WebView(urlStr: urlStr)
            .onAppear {
                appVM.updateWebLink(s: urlStr)
            }
            .frame(minWidth: SPC.detailMinWidth)
    }
}
