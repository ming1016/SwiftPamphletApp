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
                                Text("\(r.id) \((r.des != nil) ? "(\(r.des!))" : "")")
                                    .badge(badgeCount)
                            } else {
                                Text("\(r.id) \((r.des != nil) ? "(\(r.des!))" : "")")
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
            print(appVM.reposNotis)
        }
    }
}


