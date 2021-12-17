//
//  ExploreRepoListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/16.
//

import SwiftUI

struct ExploreRepoListView: View {
    @State var eRepos = [SPReposModel]()
    var body: some View {
        List {
            ForEach(eRepos) { er in
                Section {
                    ForEach(er.repos) { r in
                        NavigationLink(destination: RepoView(vm: RepoVM(repoName: r.id))) {
                            GoodReposListLinkView(r: r)
                        }
                    }
                } header: {
                    Text(er.name).font(.title)
                }
                
            }
        }
        .onAppear {
            eRepos = loadBundleJSONFile("ilikedrepos.json")
        }
    }
}

