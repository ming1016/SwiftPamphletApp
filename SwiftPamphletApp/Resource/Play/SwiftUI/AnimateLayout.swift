//
//  AnimateLayout.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/30.
//

import SwiftUI

struct AnimateLayout: View {
  @State var changeLayout: Bool = true
  @Namespace var namespace

  var body: some View {
    VStack(spacing: 30) {
      if changeLayout {
        HStack { items }
      } else {
        VStack { items }
      }
      Button("切换布局") {
        withAnimation { changeLayout.toggle() }
      }
    }
    .padding()
  }

  @ViewBuilder var items: some View {
    Text("one")
      .matchedGeometryEffect(id: "one", in: namespace)
    Text("Two")
      .matchedGeometryEffect(id: "Two", in: namespace)
    Text("Three")
      .matchedGeometryEffect(id: "Three", in: namespace)
  }
}
