//
//  ViewComponet.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI
@preconcurrency import WebKit
import MarkdownUI
import SMFile
import SMNetwork
import SMDate

// MARK: - 大纲
struct SPOutlineListView<D, Content>: View where D: RandomAccessCollection, D.Element: Identifiable, Content: View {
    private let v: SPOutlineView<D, Content>
    
    init(d: D, c: KeyPath<D.Element, D?>, content: @escaping (D.Element) -> Content) {
        self.v = SPOutlineView(d: d, c: c, content: content)
    }
    
    var body: some View {
        List {
            v
        }
    }
}


struct SPOutlineView<D, Content>: View where D: RandomAccessCollection, D.Element: Identifiable, Content: View {
    let d: D
    let c: KeyPath<D.Element, D?>
    let content: (D.Element) -> Content
    
    var body: some View {
        ForEach(d) { i in
            if let sub = i[keyPath: c] {
                SPDisclosureGroup(content: SPOutlineView(d: sub, c: c, content: content), label: content(i))
            } else {
                content(i)
            } // end if
        } // end ForEach
    } // end body
}

struct SPDisclosureGroup<C, L>: View where C: View, L: View {
    @State var isExpanded = false
    var content: C
    var label: L
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            content
        } label: {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                label
            }
            .buttonStyle(.plain)
        }
        
    }
}

// MARK: - 简化大纲
struct DisclosureGroupLikeButton<C, L>: View where C: View, L: View {
    @State var isExpanded = false
    var content: () -> C
    var label: () -> L
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded, content: content) {
            HStack {
                Button(action: {
                    isExpanded.toggle()
                }, label: label)
                    .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Sidebar Label
struct SideBarLabel: View {
    var title: String
    var imageName: String
    var color: Color = Color.primary
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            if color == Color.primary {
                Text(title)
            } else {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundStyle(color.gradient)
                    .fontDesign(.rounded)
            }
            
        }
    }
}



// MARK: - 共享菜单
struct ShareView: View {
    var s: String
    var body: some View {
        Menu {
            Button {
                #if os(macOS)
                let p = NSPasteboard.general
                p.copyText(s)
                #elseif os(iOS)
                UIPasteboard.general.string = s
                #endif
            } label: {
                Image(systemName: "doc.on.doc")
                Text("拷贝链接")
            }
            Divider()
            
//            ForEach(NSSharingService.sharingServices(forItems: [""]), id: \.title) { item in
//                Button {
//                    item.perform(withItems: [s])
//                } label: {
//                    Image(nsImage: item.image)
//                    Text(item.title)
//                }
//            }
        } label: {
            Image(systemName: "square.and.arrow.up")
            Text("分享")
        }
    }
}

#if os(macOS)
// MARK: - WebView
struct WebUIView: NSViewRepresentable {
    var urlStr: String = ""
    var html: String = ""
    var baseURLStr: String = ""

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeNSView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        if urlStr.isEmpty {
            let host = URL(string: baseURLStr)?.host ?? ""
            nsView.loadHTMLString(html, baseURL: URL(string: "https://\(host)"))
        } else {
            if let url = URL(string: urlStr) {
                let r = URLRequest(url: url)
                nsView.load(r)
            }
        }
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
            if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url {
                    // 处理所有URL请求 (不仅限于链接激活类型)
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.scheme == "http" || components?.scheme == "https" {
                        NSWorkspace.shared.open(url)
                    }
                }
            }
            return (.allow, preferences)
        }
        
    }
}

struct WebUIViewWithSave: NSViewRepresentable {
    var urlStr: String = ""
    var html: String = ""
    var baseURLStr: String = ""
    
    @Binding var savingDataTrigger: Bool
    @Binding var savingData: Data?
    
    @Binding var isStop: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeNSView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        if savingDataTrigger == true {
            nsView.createWebArchiveData { result in
                do {
                    let data = try result.get()
                    savingData = data
                } catch {
                    print("创建 webarchivedata 数据失败，\(error)")
                }
            }
            savingDataTrigger = false
        }
        
        if isStop == true {
            return
        }
        
        if savingData != nil {
            if let data = savingData {
                nsView.load(data, mimeType: "application/x-webarchive", characterEncodingName: "utf-8", baseURL: SMFile.getDocumentsDirectory())
                isStop = true
            }
        } else {
            if let url = URL(string: urlStr) {
                let r = URLRequest(url: url)
                nsView.load(r)
                isStop = true
            }
        }
        
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url {
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.scheme == "http" || components?.scheme == "https" {
                        NSWorkspace.shared.open(url)
                        decisionHandler(.cancel)
                        return
                    }
                }
            }
            decisionHandler(.allow)
        }
    } // end Coordinator
}

#elseif os(iOS)
// MARK: - WebView iOS
struct WebUIView: UIViewRepresentable {
    var urlStr: String = ""
    var html: String = ""
    var baseURLStr: String = ""
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if urlStr.isEmpty {
            let host = URL(string: baseURLStr)?.host ?? ""
            uiView.loadHTMLString(html, baseURL: URL(string: "https://\(host)"))
        } else {
            if let url = URL(string: urlStr) {
                let r = URLRequest(url: url)
                uiView.load(r)
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url {
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.scheme == "http" || components?.scheme == "https" {
                        UIApplication.shared.open(url)
                        decisionHandler(.cancel)
                        return
                    }
                }
            }
            decisionHandler(.allow)
        }
    }
}

struct WebUIViewWithSave: UIViewRepresentable {
    var urlStr: String = ""
    var html: String = ""
    var baseURLStr: String = ""
    
    @Binding var savingDataTrigger: Bool
    @Binding var savingData: Data?
    
    @Binding var isStop: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if savingDataTrigger == true {
            uiView.createWebArchiveData { result in
                do {
                    let data = try result.get()
                    savingData = data
                } catch {
                    print("创建 webarchivedata 数据失败，\(error)")
                }
            }
            savingDataTrigger = false
        }
        
        if isStop == true {
            return
        }
        
        if savingData != nil {
            if let data = savingData {
                uiView.load(data, mimeType: "application/x-webarchive", characterEncodingName: "utf-8", baseURL: SMFile.getDocumentsDirectory())
                isStop = true
            }
        } else {
            if let url = URL(string: urlStr) {
                let r = URLRequest(url: url)
                uiView.load(r)
                isStop = true
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url {
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.scheme == "http" || components?.scheme == "https" {
                        UIApplication.shared.open(url)
                        decisionHandler(.cancel)
                        return
                    }
                }
            }
            decisionHandler(.allow)
        }
    }
}
#endif

// MARK: - Time
struct GitHubApiTimeView: View {
    var timeStr: String
    var isUnread = false
    var body: some View {
        HStack {
            Text(SMDate.howLongAgo(dateStr: timeStr))
            if isUnread == true {
                Image(systemName: "envelope.badge")
            }
        }
        .font(.system(.footnote))
        .foregroundColor(.secondary)
    }
}

// MARK: - 跳到 Github 网站
struct ButtonGoGitHubWeb: View {
    var url: String
    var text: String
    var ignoreHost: Bool = false
    var bold: Bool = false
    var body: some View {
        Button {
            if ignoreHost == true {
                SMNetwork.gotoWebBrowser(urlStr: SPC.githubHost + url)
            } else {
                SMNetwork.gotoWebBrowser(urlStr: url)
            }
        } label: {
            if bold == true {
                Text(text).bold()
            } else {
                Text(text)
            }

        }
    }
}
