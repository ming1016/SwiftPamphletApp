//
//  PlaySliderView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/2.
//

import SwiftUI

struct PlaySliderView: View {
    @State var count: Double = 0
    var body: some View {
        Slider(value: $count, in: 0...100)
            .padding()
        Text("\(Int(count))")
    }
}
