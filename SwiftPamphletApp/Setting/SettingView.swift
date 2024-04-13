//
//  SettingView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/10.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        TabView {
            accessTokenView()
                .tabItem {
                    Label("设置", systemImage: "gearshape")
                }
            customSearch()
                .tabItem {
                    Label("自定义搜索", systemImage: "mail.and.text.magnifyingglass")
                }
            
        }
        .frame(minHeight: 400)
    }
    
    // MARK: custom search
    @AppStorage(SPC.customSearchTerm) var term = ""
    @ViewBuilder
    func customSearch() -> some View {
        VStack {
            Text("输入自定义的搜索关键字，以换行作为间隔")
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
    
    // MARK: token
    @State private var tokenString = ""
    @ViewBuilder
    func accessTokenView() -> some View {
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
    }
    
    func save() {
        let ud = UserDefaults.standard
        ud.set(tokenString, forKey: SPC.githubUDTokenKey)
    }
}
