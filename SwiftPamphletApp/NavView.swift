//
//  NavView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/31.
//

import SwiftUI


struct NavView: View {
    var body: some View {
        VStack {
            IssueView(vm: IssueVM(repoName: SPC.pamphletIssueRepoName, issueNumber: 1), type: .hiddenUserInfo)
        }
        .frame(minWidth: SPC.detailMinWidth)
    }
}
