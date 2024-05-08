//
//  GithubAccessTokenView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/8.
//

import SwiftUI
import SMGitHub

struct GithubAccessTokenView: View {
    @State private var tokenString: String = ""
    var body: some View {
        Form {
            Section {
                Text("在这里写上 Github 的 access token 来访问内容")
                TextField("", text: $tokenString, prompt: Text("输入 access token"))
                    .padding(10)
                    .onSubmit {
                        save()
                    }
            }
        }
        .onAppear(perform: {
            let ud = UserDefaults.standard
            tokenString = ud.string(forKey: SPC.githubUDTokenKey) ?? ""
        })
        .onChange(of: tokenString) { oldValue, newValue in
            save()
        }
    }
    
    func save() {
        let ud = UserDefaults.standard
        ud.set(tokenString, forKey: SPC.githubUDTokenKey)
        
        let gr = GitHubReq.shared
        gr.githubat = tokenString
    }
}

