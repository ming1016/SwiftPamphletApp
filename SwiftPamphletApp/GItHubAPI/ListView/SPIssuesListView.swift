//
//  SwiftPamphletIssuesListView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/12.
//

import SwiftUI

struct SPIssuesListView: View {
    @StateObject var repoVm: RepoVM
    var body: some View {
        HStack(spacing:0) {
            Text("小册子议题更新").bold()
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
        List {
            ForEach(repoVm.issues) { issue in
                NavigationLink {
                    IssueView(vm: IssueVM(repoName: repoVm.repoName, issueNumber: issue.number))
                } label: {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(issue.title).bold()
                        Text(issue.updatedAt.prefix(10)).font(.system(.footnote)).foregroundColor(.secondary)
                    }
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                } // end NavigationLink
            } // end ForEach
        } // end List
        .onAppear {
            repoVm.doing(.inIssues)
        }
        .frame(minWidth:60)
    }
}


