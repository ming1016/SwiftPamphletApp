//
//  IssuesListFromCustom.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/15.
//

import SwiftUI

struct IssuesListFromCustomView: View {
    @StateObject var vm: IssueVM
    var body: some View {
        List {
//            ForEach(SPConfig.loadCustomIssues(jsonFileName: "guide-syntax")) { ci in
            ForEach(vm.customIssues) { ci in
                Section {
                    ForEach(ci.issues) { i in
                        NavigationLink {
                            IssueView(vm: IssueVM(repoName: SPConfig.pamphletIssueRepoName, issueNumber: i.number))
                        } label: {
                            Text(i.title)
                        }
                    }
                } header: {
                    Text(ci.name).font(.title)
                }

            }
        }
        .onAppear {
            vm.apCustomIssues()
        }
    }
}

struct CustomIssuesModel: Identifiable, Decodable, Hashable {
    var id: Int64
    var name: String
    var issues: [CustomIssue]
}

struct CustomIssue: Identifiable, Decodable, Hashable {
    var id: Int64
    var title: String
    var number: Int
}
