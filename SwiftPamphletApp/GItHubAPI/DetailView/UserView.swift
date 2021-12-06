//
//  UserView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/10.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var appVM: AppVM
    @StateObject var vm: UserVM
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
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
                    
                }
            }
            Spacer()
        }
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            vm.doing(.inInit)
            
            appVM.devsNotis[vm.userName] = 0
            appVM.calculateDevsCountNotis()
        }
        .frame(minWidth: SPC.detailMinWidth)
        
        TabView {
            UserEventView(events: vm.events)
            .tabItem {
                Text("事件")
            }
            UserEventView(events: vm.receivedEvents, isShowActor: true)
                .tabItem {
                    Text("Ta 接收的事件")
                }
                .onAppear {
                    vm.doing(.inReceivedEvent)
                }
        }
        .frame(minWidth: SPC.detailMinWidth)
        Spacer()
        
        
        
    }
}

struct UserEventView: View {
    var events: [EventModel]
    var isShowActor: Bool = false
    
    var body: some View {
        List {
            ForEach(events) { event in
                NavigationLink {
                    RepoView(vm: RepoVM(repoName: event.repo.name), type: .readme)
                } label: {
                    HStack {
                        Text(event.createdAt.prefix(10)).font(.system(.footnote))
                        Text(event.repo.name).bold()
                        if event.payload.issue?.number != nil {
                            ButtonGoGitHubWeb(url: "https://github.com/\(event.repo.name)/issues/\(String(describing: event.payload.issue?.number ?? 0))", text: "Issue")
                        }

                        Text(event.type)
                        Text(event.payload.action ?? "")
                        if isShowActor == true {
                            AsyncImageWithPlaceholder(size: .tinySize, url: event.actor.avatarUrl)
                            
                            Text(event.actor.login).bold()

                        } // end if
                    }
                    .padding(5)// end HStack
                }
                
            } // end ForEach
        }//  end List
    } // end body
} // end struct
