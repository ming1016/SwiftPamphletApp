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
            GithubAccessTokenView()
                .tabItem {
                    Label("设置", systemImage: "gearshape")
                }
            CustomSearch()
                .tabItem {
                    Label("自定义标签", systemImage: "mail.and.text.magnifyingglass")
                }
            
        }
        .frame(minHeight: 400)
    }

}

struct CustomSearch: View {
    @AppStorage(SPC.customSearchTerm) var term = ""
    var body: some View {
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
}
