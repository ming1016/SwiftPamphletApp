//
//  EditCustomSearch.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/10.
//

import SwiftUI

struct EditCustomSearchView: View {
    @AppStorage("customSearchTerm") var term = ""
    
    var body: some View {
        VStack {
            Text("自定义的搜索关键字，以换行作为间隔")
            TextEditor(text: $term)
                .overlay {
                    Rectangle()
                        .stroke(.secondary, lineWidth: 1)
                        .opacity(0.5)
                        .disableAutocorrection(true)
                        
                }
        }
        .padding(20)
    }
}
