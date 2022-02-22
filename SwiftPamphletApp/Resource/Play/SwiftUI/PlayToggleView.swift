//
//  PlayToggleView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/22.
//

import SwiftUI

struct PlayToggleView: View {
    @State private var isEnable = false
    var body: some View {
        Toggle(isOn: $isEnable) {
            Label("暗黑模式", systemImage: "cloud.moon")
        }
        .padding()
        .tint(.pink)
        .controlSize(.large)
        .toggleStyle(.button)
    }
}

