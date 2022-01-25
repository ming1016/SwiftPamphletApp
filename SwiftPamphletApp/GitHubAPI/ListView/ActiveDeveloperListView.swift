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
            Section {
                ForEach(vm.cIADs) { ad in
                    ForEach(ad.users) { u in
                        ActiveDeveloperUnreadLinkView(u: u)
                    } // end ForEach
                } // end ForEach
            } header: {
                Text("刚更新的").font(.title)
            }
            ForEach(vm.cIADs) { ad in
                Section {
                    ForEach(ad.users) { u in
                        if (appVM.devsNotis[u.id] ?? 0) > 0 {

                        } else {
                            NavigationLink(destination: UserView(vm: .init(userName: u.id))) {
                                ActiveDeveloperListLinkView(u: u)
                            }
                        }
                    } // end ForEach
                } header: {
                    Text(ad.name).font(.title)
                } // end Sectioin
            } // end Foreach
        } // end List
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .navigationTitle("🤔 开发者")
        .onAppear {
            vm.doing(.ciads)
        }

    }
}

// MARK: - 碎视图

struct ActiveDeveloperUnreadLinkView: View {
    @EnvironmentObject var appVM: AppVM
    var u: ADeveloperModel
    var body: some View {
        if appVM.devsNotis[u.id] ?? 0 > 0 {
            NavigationLink(destination: UserView(vm: .init(userName: u.id), isCleanUnread: true)) {
                ActiveDeveloperListLinkView(u: u)
                    .badge(appVM.devsNotis[u.id] == SPC.unreadMagicNumber ? 0 : appVM.devsNotis[u.id] ?? 0)
            }
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
