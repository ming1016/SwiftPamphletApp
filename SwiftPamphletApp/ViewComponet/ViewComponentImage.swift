//
//  ViewComponentImage.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/4.
//

import Foundation
import SwiftUI
import Nuke
import NukeUI

// MARK: - 图片
struct NukeImage: View {
    private let pipeline = ImagePipeline {
        $0.dataLoader = {
            let config = DataLoader.defaultConfiguration
            config.urlCache = DataLoader.sharedUrlCache
            return DataLoader(configuration: config)
        }()
    }
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var url: String
    var contentModel: ContentMode = .fit
    var body: some View {
        LazyImage(url: URL(string: url)) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: contentModel)
            } else if state.isLoading == false {
                ZStack {
                    Color.gray.opacity(0.2) // Placeholder
                    Text(url)
                        .font(.footnote)
                        .foregroundColor(light: .secondary, dark: .secondary)
                }
            } else {
                ProgressView()
            }
        }
        .pipeline(pipeline)
        .frame(width: width, height: height)
        .cornerRadius(5)
    }
}

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
