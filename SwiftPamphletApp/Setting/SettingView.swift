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
                    Label("自定义标签", systemImage: "mail.and.text.magnifyingglass")
                }
            
        }
        .frame(minHeight: 400)
    }
    
    // MARK: custom search
    @AppStorage(SPC.customSearchTerm) var term = ""
    @ViewBuilder
    func customSearch() -> some View {
        VStack {
            Text("输入自定义的标签，以换行作为间隔")
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
    
    // MARK: 是否显示 Github 内容
    @AppStorage(SPC.isShowGithub) var isShowGithub = false
    
    // MARK: token
    @State private var tokenString = ""
    @ViewBuilder
    func accessTokenView() -> some View {
        VStack(alignment: .leading) {
            Toggle("是否显示 Github", isOn: $isShowGithub)
                .toggleStyle(.switch)
                .padding(20)
            GithubAccessTokenView()
            Spacer()
        }
    }
}
