//
//  PlayControlGroupView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/23.
//

import SwiftUI

struct PlayControlGroupView: View {
    var body: some View {
        ControlGroup {
            Button {
                print("plus")
            } label: {
                Image(systemName: "plus")
            }

            Button {
                print("minus")
            } label: {
                Image(systemName: "minus")
            }
        }
        .padding()
        .controlGroupStyle(.automatic) // .automatic 是默认样式，还有 .navigation
    }
}

