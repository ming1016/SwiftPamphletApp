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
        // 普通
        Link("前往 www.starming.com", destination: URL(string: "http://www.starming.com")!)
            .buttonStyle(.borderedProminent)
        
        // AttributedString 链接
        Text(aStr)
        
        // markdown 链接
        Text("[Go Ming's GitHub](https://github.com/ming1016)")
        
        // 控件使用 openURL
        Link("小册子源码", destination: URL(string: "https://github.com/KwaiAppTeam/SwiftPamphletApp")!)
            .environment(\.openURL, OpenURLAction { url in
                return .systemAction
                /// return .handled 不会返回系统打开浏览器动作，只会处理 return 前的事件。
                /// .discard 和 .handled 类似。
                /// .systemAction(URL(string: "https://www.anotherurl.com")) 可以返回另外一个 url 来替代指定的url
            })
        
        // 根据内容返回不同链接
        Text("戴铭博客有好几个，存在[GitHub Page](github)、[自建服务器](starming)和[知乎](zhihu)上")
            .environment(\.openURL, OpenURLAction { url in
                switch url.absoluteString {
                case "github":
                    return .systemAction(URL(string: "https://ming1016.github.io/")!)
                case "starming":
                    return .systemAction(URL(string: "http://www.starming.com")!)
                case "zhihu":
                    return .systemAction(URL(string: "https://www.zhihu.com/people/starming/posts")!)
                default:
                    return .handled
                }
            })
        
    }
    
    // 支持 openURL 的能力
    func goUrl(_ url: URL, done: @escaping (_ accepted: Bool) -> Void) {
        openURL(url, completion: done)
    }
}



