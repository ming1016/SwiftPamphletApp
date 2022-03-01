//
//  DataListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/1.
//

import SwiftUI

struct DLModel: Jsonable {
    var t: String
    var d: String?
    var id: String
}

struct DataListView: View {
    @State private var model = [DLModel]()
    let name: String
    var body: some View {
        List {
            ForEach(model) { m in
                NavigationLink {
                    RepoWebView(urlStr: m.id)
                } label: {
                    VStack(alignment: .leading) {
                        Text(m.t)
                            .font(.headline)
                        if m.d != nil {
                            Text(m.d ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    // end VStack
                } // end NavigationLink
            }
        }
        .onAppear {
            model = loadBundleJSONFile("D-\(name).json")
        }
    }
}


