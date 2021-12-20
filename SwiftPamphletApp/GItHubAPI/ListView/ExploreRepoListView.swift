//
//  ExploreRepoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/16.
//

import SwiftUI

struct ExploreRepoListView: View {
    @EnvironmentObject var appVM: AppVM
    var body: some View {
        List {
            Section {
                ForEach(appVM.exps) { gr in
                    ForEach(gr.repos) { r in
                        ExpListUnreadLinkView(r: r)
                    }
                }
            } header: {
                Text("刚更新的").font(.title)
            }
            // end Section
            ForEach(appVM.exps) { er in
                Section {
                    ForEach(er.repos) { r in
                        if (appVM.expNotis[r.id] ?? 0) > 0 {
                            
                        } else {
                            NavigationLink(destination: RepoView(vm: RepoVM(repoName: r.id))) {
                                ExpListLinkView(r: r)
                            }
                        } // end if
                    } // end ForEach
                } header: {
                    Text(er.name).font(.title)
                } // end Section
                
            } // end ForEach
        } // end List
        .navigationTitle("探索更多库 \(appVM.alertMsg)")
        .onAppear {
            appVM.loadExpFromServer()
        }
    }
}

// MARK: - 碎视图
struct ExpListUnreadLinkView: View {
    @EnvironmentObject var appVM: AppVM
    var r: ARepoModel
    var body: some View {
        if appVM.expNotis[r.id] ?? 0 > 0 {
            NavigationLink {
                RepoView(vm: RepoVM(repoName: r.id), isCleanExpUnread: true)
            } label: {
                ExpListLinkView(r: r)
                    .badge(appVM.expNotis[r.id] == SPC.unreadMagicNumber ? 0 : appVM.expNotis[r.id] ?? 0)
            } // end NavigationLink
        } // end if
    } // end body
}

struct ExpListLinkView: View {
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
