//
//  WWDCListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/12.
//

import SwiftUI

struct WWDCListView: View {
    @State private var wwdcData: [WWDCModelForOutline] = [WWDCModelForOutline]()
    @State private var limit: Int = 50
    var body: some View {
        SPOutlineListView(d: wwdcData, c: \.sub, content: { item in
            VStack {
                if let session = item.session {
                    NavigationLink(destination: WWDCDetailView(session: session, limit: $limit)) {
//                        if item.sub?.count ?? 0 > 0 {
//                            Text(item.text)
//                        } else {
//                            
//                                
//                        }
                        VStack(alignment: .leading) {
                            Text(session.title)
                            HStack {
                                Text(simpleSessionid(id: session.id))
                                Text(session.topic)
                            }
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        }
                    }
                    .contentShape(Rectangle())
                } else {
                    Text(item.text)
                }
            }
        })
        .listStyle(.sidebar)
        .onAppear {
            wwdcData = WWDCViewModel.parseModelForOutline()
        }
        
    }
    
    func simpleSessionid(id: String) -> String {
        let arr = id.split(separator: "-")
        if arr.count > 1 {
            return "session " + (arr.last?.description ?? "")
        }
        return ""
    }
}
