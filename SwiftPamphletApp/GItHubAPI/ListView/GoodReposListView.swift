//
//  GoodReposListView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI

struct GoodReposListView: View {
    @StateObject var vm: IssueVM
    var body: some View {
        List {
            ForEach(vm.cIGRs) { gr in
                Section {
                    ForEach(gr.repos) { r in
                        NavigationLink("\(r.id) \((r.des != nil) ? "(\(r.des!))" : "")", destination: RepoView(vm: RepoVM(repoName: r.id)))
                    }
                } header: {
                    Text(gr.name).font(.title)
                }
            }
        } // end List
        .navigationTitle("仓库动态")
        .onAppear {
            vm.doing(.cigrs)
        }
    }
}


