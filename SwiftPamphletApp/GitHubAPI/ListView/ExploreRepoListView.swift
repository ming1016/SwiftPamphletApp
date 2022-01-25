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
            if SPC.gitHubAccessToken.isEmpty == false {
                Section {
                    ForEach(appVM.exps) { er in
                        ForEach(er.repos) { r in
                            ExpListUnreadLinkView(r: r)
                        }
                    }
                } header: {
                    Text("刚更新的").font(.title3)
                }

            }

            // end Section
            ForEach(appVM.exps) { er in
                if SPC.gitHubAccessToken.isEmpty == false {
                    Section {
                        ForEach(er.repos) { r in
                            if (appVM.expNotis[r.id]?.unRead ?? 0) > 0 {

                            } else {
                                NavigationLink(destination: RepoView(vm: RepoVM(repoName: r.id))) {
                                    ExpListLinkView(r: r)
                                }
                            } // end if

                        }
                    } header: {
                        Text(er.name).font(.title3)
                    }
                } else {
                    DisclosureGroup {
                        ForEach(er.repos) { r in
                            NavigationLink(destination: RepoWebView(urlStr: SPC.githubHost + r.id)) {
                                ExpListLinkView(r: r)
                            }
                        } // end ForEach
                    } label: {
                        Text(er.name).font(.title3)
                    }
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                } // end if token

            } // end ForEach
        } // end List
        .navigationTitle("👾 探索库")
        .onAppear {
            appVM.loadExpFromServer()
        }
        .onDisappear {
            appVM.updateWebLink(s: "")
        }
    }
}

// MARK: - 碎视图
struct ExpListUnreadLinkView: View {
    @EnvironmentObject var appVM: AppVM
    var r: ARepoModel
    var body: some View {
        if appVM.expNotis[r.id]?.unRead ?? 0 > 0 {
            NavigationLink {
                RepoView(vm: RepoVM(repoName: r.id), isCleanExpUnread: true)
            } label: {
                ExpListLinkView(r: r)
                    .badge(appVM.expNotis[r.id]?.unRead == SPC.unreadMagicNumber ? 0 : appVM.expNotis[r.id]?.unRead ?? 0)
            } // end NavigationLink
        } // end if
    } // end body
}

struct ExpListLinkView: View {
    @EnvironmentObject var appVM: AppVM
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
//            Divider()
//                .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
        } // end VStack

    } // end body
}
