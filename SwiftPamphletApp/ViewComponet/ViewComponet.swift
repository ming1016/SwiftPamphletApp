//
//  ViewComponet.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/17.
//

import SwiftUI


struct AsyncImageWithPlaceholder: View {
    enum Size {
        case tinySize, smallSize,normalSize, bigSize
        
        var v: CGFloat {
            switch self {
            case .tinySize:
                return 20
            case .smallSize:
                return 40
            case .normalSize:
                return 60
            case .bigSize:
                return 100
            }
        }
    }
    var size: Size
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url), content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.v, height: size.v)
                .cornerRadius(5)
        },
        placeholder: {
            Image(systemName: "person")
                .frame(width: size.v, height: size.v)
        })
    }
}

struct ButtonGoGitHubWeb: View {
    var url: String
    var text: String
    var ignoreHost: Bool = false
    var body: some View {
        Button {
            if ignoreHost == true {
                gotoWebBrowser(urlStr: SPC.githubHost + url)
            } else {
                gotoWebBrowser(urlStr: url)
            }
        } label: {
            Text(text)
        }
    }
}
