//
//  ActiveDeveloperListView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI

struct ActiveDeveloperListView: View {
    @EnvironmentObject var appVM: AppVM
    @StateObject var vm: IssueVM
    var body: some View {
        List {
            ForEach(vm.cIADs) { ad in
                Section {
                    ForEach(ad.users) { u in
                        NavigationLink(destination: UserView(vm: .init(userName: u.id))) {
                            if let badgeCount = appVM.devsNotis[u.id] ?? 0 {
                                ActiveDeveloperListLinkView(u: u)
                                    .badge(badgeCount)
                            } else {
                                ActiveDeveloperListLinkView(u: u)
                            }
                        }
                    }
                } header: {
                    Text(ad.name).font(.title)
                }

            }
        }
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .navigationTitle("开发者动态 \(appVM.alertMsg)")
        .onAppear {
            vm.doing(.ciads)
        }
        
    }
}

struct ActiveDeveloperListLinkView: View {
    var u: ADeveloperModel
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(u.id)
                .bold()
            if u.des != nil {
                Text("\((u.des != nil) ? "\(u.des!)" : "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
