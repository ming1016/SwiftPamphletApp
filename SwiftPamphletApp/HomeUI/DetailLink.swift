//
//  DetailLink.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI

struct DetailLink {
    
    @ViewBuilder
    static func viewToShow(for title: String?, selectInfo:IOInfo) -> some View {
        switch title {
        case "资料":
            EditInfoView(info: selectInfo)
        default:
            Text("请选择")
        }
    }
}
