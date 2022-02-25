//
//  PlayLazyVGridAndLazyHGridView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/25.
//

import SwiftUI

struct PlayLazyVGridAndLazyHGridView: View {
    @State private var colors: [String:Color] = [
        "red" : .red,
        "orange" : .orange,
        "yellow" : .yellow,
        "green" : .green,
        "mint" : .mint,
        "teal" : .teal,
        "cyan" : .cyan,
        "blue" : .blue,
        "indigo" : .indigo,
        "purple" : .purple,
        "pink" : .pink,
        "brown" : .brown,
        "gray" : .gray,
        "black" : .black
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 50), spacing: 10)
            ], pinnedViews: [.sectionHeaders]) {
                Section(header:
                            Text("🎨调色板")
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(RoundedRectangle(cornerRadius: 0)
                                                .fill(.black.opacity(0.1)))
                ) {
                    ForEach(Array(colors.keys), id: \.self) { k in
                        colors[k].frame(height:Double(Int.random(in: 50...150)))
                            .overlay(
                                Text(k)
                            )
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                    }
                }
            }
            .padding()
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 20), spacing: 10)
            ]) {
                Section(header: Text("图标集").font(.title)) {
                    ForEach(1...30, id: \.self) { i in
                        Image("p\(i)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                    }
                }
            }
            .padding()
        }
    }
}


