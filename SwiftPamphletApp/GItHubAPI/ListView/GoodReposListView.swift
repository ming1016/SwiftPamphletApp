//
//  GoodReposListView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI

struct GoodReposListView: View {
    @EnvironmentObject var appVM: AppVM
    @StateObject var vm: IssueVM
    var body: some View {
        List {
            ForEach(vm.cIGRs) { gr in
                Section {
                    ForEach(gr.repos) { r in
                        NavigationLink(destination: RepoView(vm: RepoVM(repoName: r.id))) {
                            if let badgeCount = appVM.reposNotis[r.id] ?? 0 {
                                GoodReposListLinkView(r: r)
                                    .badge(badgeCount)
                            } else {
                                GoodReposListLinkView(r: r)
                            }
                        }
                    }
                } header: {
                    Text(gr.name).font(.title)
                }
            }
        } // end List
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .navigationTitle("仓库动态 \(appVM.alertMsg)")
        .onAppear {
            vm.doing(.cigrs)
        }
    } // end body
}

struct GoodReposListLinkView: View {
    var r: ARepoModel
    var rIdArr: [String] {
        r.id.components(separatedBy: "/")
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
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
        } // end VStack
    } // end body
}

