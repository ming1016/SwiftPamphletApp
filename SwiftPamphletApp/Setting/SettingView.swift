//
//  SettingView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/10.
//

import SwiftUI

struct SettingView: View {
    @State private var tokenString = ""
    var body: some View {
        Form {
            Section {
                Text("在这里写上 Github 的 access token")
                TextField("", text: $tokenString)
                    .padding(10)
                    .onSubmit {
                        let ud = UserDefaults.standard
                        ud.set(tokenString, forKey: SPC.githubUDTokenKey)
                    }
            }
            .onAppear(perform: {
                let ud = UserDefaults.standard
                tokenString = ud.string(forKey: SPC.githubUDTokenKey) ?? ""
            })
        }
    }
}
