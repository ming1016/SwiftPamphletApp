//
//  RepoWebView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/25.
//

import SwiftUI

struct RepoWebView: View {
    @Environment(AppVM.self) var appVM
    var urlStr: String
    var body: some View {
        WebUIView(urlStr: urlStr)
            .onAppear {
                appVM.updateWebLink(s: urlStr)
            }
            .frame(minWidth: SPC.detailMinWidth)
    }
}
