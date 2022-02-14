//
//  LinkView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/7.
//

import SwiftUI

struct LinkView: View {
    var body: some View {
        Link("访问我的博客",destination: URL(string: "https://ming1016.github.io/")!)
    }
}
