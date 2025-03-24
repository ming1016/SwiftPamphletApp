//
//  HomeiOSView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/10.
//

import SwiftUI

#if os(iOS)
struct HomeiOSView: View {
    @State var state: String = ""
    var body: some View {
        GuideListView()
    }
}


#endif
