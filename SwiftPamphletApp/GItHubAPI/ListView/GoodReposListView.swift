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
            Section {
                ForEach(vm.cIGRs) { gr in
                    ForEach(gr.repos) { r in
                        GoodReposListUnreadLinkView(r: r)
                    } // end ForEach
                } // end ForEach
            } header: {
                Text("刚更新的").font(.title)
            }
            ForEach(vm.cIGRs) { gr in
                Section {
                    ForEach(gr.repos) { r in
                        if (appVM.reposNotis[r.id] ?? 0) > 0 {
                            
                        } else {
                            NavigationLink(destination: RepoView(vm: RepoVM(repoName: r.id))) {
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

// MAKR: 碎视图
struct GoodReposListUnreadLinkView: View {
    @EnvironmentObject var appVM: AppVM
    var r: ARepoModel
    var body: some View {
        if appVM.reposNotis[r.id] ?? 0 > 0 {
            NavigationLink(destination: RepoView(vm: RepoVM(repoName: r.id), isCleanUnread: true)) {
                GoodReposListLinkView(r: r)
                    .badge(appVM.reposNotis[r.id] == SPC.unreadMagicNumber ? 0 : appVM.reposNotis[r.id] ?? 0)
            }
        } // end if
    }
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

