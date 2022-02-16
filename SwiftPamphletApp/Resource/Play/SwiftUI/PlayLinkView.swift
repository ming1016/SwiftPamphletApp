//
//  PlayLinkView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/16.
//

import SwiftUI

struct PlayLinkView: View {
    @Environment(\.openURL) var openURL
    var aStr: AttributedString {
        var a = AttributedString("戴铭的博客")
        a.link = URL(string: "https://ming1016.github.io/")
        return a
    }
    var body: some View {
        Link("前往 www.starming.com", destination: URL(string: "http://www.starming.com")!)
            .buttonStyle(.borderedProminent)
        // AttributedString 链接
        Text(aStr)
        // markdown 链接
        Text("[Go Ming's GitHub](https://github.com/ming1016)")
        Link("小册子源码", destination: URL(string: "https://github.com/KwaiAppTeam/SwiftPamphletApp")!)
            .environment(\.openURL, OpenURLAction { url in
                return .systemAction
            })
        
    }
    
    // 使用 openURL
    func goUrl(_ url: URL, done: @escaping (_ accepted: Bool) -> Void) {
        openURL(url, completion: done)
    }
}



