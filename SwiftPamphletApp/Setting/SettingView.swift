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
        TabView {
            Form {
                Section {
                    Text("在这里写上 Github 的 access token")
                    TextField("", text: $tokenString)
                        .padding(10)
                        .onSubmit {
                            save()
                        }
                    Button("保存") {
                        save()
                    }
                }
                .onAppear(perform: {
                    let ud = UserDefaults.standard
                    tokenString = ud.string(forKey: SPC.githubUDTokenKey) ?? ""
                })
            }
            .padding(20)
            .tabItem {
                Label("设置", systemImage: "gearshape")
            }
        }
    }
    
    func save() {
        let ud = UserDefaults.standard
        ud.set(tokenString, forKey: SPC.githubUDTokenKey)
    }
}
