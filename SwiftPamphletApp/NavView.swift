//
//  NavView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        ScrollView {
            MarkdownView(s: loadBundleString("1.md"))
                .padding(20)
        }
        .frame(minWidth: 350)
    }
}
