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
            Text("自定标签，换行间隔，同行逗号间隔")
            TextEditor(text: $term).border()
        }
        .padding(20)
    }
}
