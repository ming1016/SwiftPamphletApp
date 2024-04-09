//
//  ExploreRepoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/16.
//

import SwiftUI

// MARK: - 碎视图
struct ExpListLinkView: View {
    @Environment(AppVM.self) var appVM
    var r: ARepoModel
    var rIdArr: [String] {
        r.id.components(separatedBy: "/")
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing:1) {
                Text(rIdArr[0])
                Text("/")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            Text(rIdArr[1])
                .bold()
            if r.des != nil {
                Text("\((r.des != nil) ? "\(r.des!)" : "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if appVM.expNotis[r.id]?.stargazersCount ?? 0 > 0 {
                HStack {
                    Image(systemName: "star.fill")
                    Text("\(appVM.expNotis[r.id]?.stargazersCount ?? 0)")
                    Image(systemName: "captions.bubble")
                    Text("\(appVM.expNotis[r.id]?.openIssues ?? 0)")

                }
                .font(.footnote)

            }
            if appVM.expNotis[r.id]?.language.isEmpty == false {
                HStack {
                    Image(systemName: "globe.asia.australia")
                    Text(appVM.expNotis[r.id]?.language ?? "")
                }
                .font(.footnote)
            }

            if appVM.expNotis[r.id]?.description.isEmpty == false {
                Text(appVM.expNotis[r.id]?.description ?? "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        } // end VStack

    } // end body
}
