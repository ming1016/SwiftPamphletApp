//
//  GuideView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/14.
//

import SwiftUI

struct TestCSGuideView: View {
    var body: some View {
        CSGuideView(models: [
            Csgm(type: .text, text: "测试"),
            Csgm(type: .image, image: "p10"),
            Csgm(type: .imageWithText, text: "😂", image: "p12"),
            Csgm(type: .text, text: "测试2"),
            Csgm(type: .text, text: "测试3"),
            Csgm(type: .text, text: "测试4"),
            Csgm(type: .text, text: "测试5"),
        ])
    }
}

struct CSGuideView: View {
    @State var models: [Csgm]
    
    var body: some View {
        ScrollView {
            ForEach(models) { model in
                if model.type == .text {
                    Text(model.text)
                } else if model.type == .image {
                    Image(model.image)
                } else if model.type == .imageWithText {
                    VStack {
                        Text(model.text)
                        Image(model.image)
                    }
                }
            }// end foreach
        }
    }
}

struct Csgm:Identifiable {
    var id: UUID = UUID()
    var type: CSGType = .text
    var text: String = ""
    var image: String = ""
    var list: [String] = [String]()
    
    enum CSGType {
    case text, image, imageWithText,list
    }
}

