//
//  EditDeveloper.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/3/20.
//

import SwiftUI
import SwiftData

struct EditDeveloper: View {
    @Bindable var dev: DeveloperModel
    @State var vm: UserVM
    @State private var tabSelct = 1
    
    var body: some View {
        Form {
            HStack {
                TextField("用户名:", text: $dev.name, prompt: Text("输入 Github 用户名"))
                    .onSubmit {
                        vm = UserVM(userName: dev.name)
                        vm.doing(.updateAll)
                    }
                TextField("描述:", text: $dev.des)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    AsyncImageWithPlaceholder(size: .normalSize, url: vm.user.avatarUrl)
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(vm.user.name ?? vm.user.login).font(.system(.title))
                            Text("(\(vm.user.login))")
                            Text("订阅者 \(vm.user.followers) 人，仓库 \(vm.user.publicRepos) 个")
                        }
                        HStack {
                            ButtonGoGitHubWeb(url: vm.user.htmlUrl, text: "在 GitHub 上访问")
                            if vm.user.location != nil {
                                Text("居住：\(vm.user.location ?? "")").font(.system(.subheadline))
                            }
                        }
                    } // end VStack
                } // end HStack

                if vm.user.bio != nil {
                    Text("简介：\(vm.user.bio ?? "")")
                }
                HStack {
                    if vm.user.blog != nil {
                        if !vm.user.blog!.isEmpty {
                            Text("博客：\(vm.user.blog ?? "")")
                            ButtonGoGitHubWeb(url: vm.user.blog ?? "", text: "访问")
                        }
                    }
                    if vm.user.twitterUsername != nil {
                        Text("Twitter：")
                        ButtonGoGitHubWeb(url: "https://twitter.com/\(vm.user.twitterUsername ?? "")", text: "@\(vm.user.twitterUsername ?? "")")
                    }
                } // end HStack
            } // end VStack
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            vm.doing(.updateAll)
        }
        .onChange(of: dev.name, { oldValue, newValue in
            vm = UserVM(userName: newValue)
            vm.doing(.updateAll)
        })
        .onChange(of: vm.events, { oldValue, newValue in
            if ((newValue.first?.createdAt.isEmpty) != nil) {
                let iso8601String = newValue.first?.createdAt ?? ""
                let formatter = ISO8601DateFormatter()
                dev.updateDate = formatter.date(from: iso8601String) ?? Date.now
                dev.avatar = vm.user.avatarUrl
            }
            
        })
        .frame(minWidth: SPC.detailMinWidth)
        
        TabView(selection: $tabSelct) {

            DeveloperEventView(events: vm.events)
                .tabItem {
                    Image(systemName: "keyboard")
                    Text("事件")
                }
                .onAppear {
                    // 如果是从列表未读section里来的会检查清理未读
                    vm.doing(.inEvent)
                }
                .tag(1)
            DeveloperEventView(events: vm.receivedEvents)
                .tabItem {
                    Image(systemName: "keyboard.badge.ellipsis")
                    Text("Ta 接收的事件")
                }
                .onAppear {
                    vm.doing(.inReceivedEvent)
                }
                .tag(2)
        }
        .frame(minWidth: SPC.detailMinWidth)
        Spacer()
    }
}

struct DeveloperEventView: View {
    var events: [EventModel]
    var body: some View {
        List {
            ForEach(Array(events.enumerated()), id: \.0) { i, event in
                
                NavigationLink {
                    UserEventLinkDestination(event: event)
                } label: {
                    AUserEventLabel(
                        event: event,
                        isShowActor: false,
                        isUnRead: false
                    )
                } // end NavigationLink
            } // end ForEach
        }//  end List
        .id(UUID()) // 优化 commits 有多个时数据变化可能影响的性能。这样做每次更新都产生新的视图，因此无法做动画效果。相当于 UITableView 上的 reloadData()
    } // end body
} // end struct


