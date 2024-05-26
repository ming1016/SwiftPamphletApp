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
                    Text(url.prefix(100))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            } else {
                Image(systemName: "chart.bar.doc.horizontal")
                    .imageScale(.large)
                    .symbolEffect(.variableColor.iterative.dimInactiveLayers.reversing, isActive: state.image == nil)
            }
        }
        .pipeline(pipeline)
        .frame(width: width, height: height)
        .cornerRadius(5)
    }
}


