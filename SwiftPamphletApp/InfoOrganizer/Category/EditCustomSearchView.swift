//
//  EditCustomSearch.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/10.
//

import SwiftUI

struct EditCustomSearchView: View {
    @AppStorage(SPC.customSearchTerm) var term = ""
    
    var body: some View {
        VStack {
            Text("自定检索，换行间隔，同行逗号间隔")
            TextEditor(text: $term)
                .te()
        }
        .padding(20)
    }
}
