//
//  HomeiOSView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/10.
//

import SwiftUI

struct HomeiOSView: View {
    @State var state: String = ""
    var body: some View {
        EmptyView()
            .onOpenURL { url in
                if let content = URLComponents(url: url, resolvingAgainstBaseURL: true)?
                    .queryItems?.first(where: { $0.name == "content" })?.value {
                    if content == "detail" {
                        state = "detail"
                    } else {
                        state = ""
                    }
                }
            }
        if state == "detail" {
            DetailView(state: $state)
        } else {
            GuideListView()
        }
    }
}

struct DetailView: View {
    @Binding var state: String
    var body: some View {
        VStack {
            Text("Detail View here")
            Button(action: {
                state = ""
            }) {
                Text("Back")
            }
        }
    }
}
