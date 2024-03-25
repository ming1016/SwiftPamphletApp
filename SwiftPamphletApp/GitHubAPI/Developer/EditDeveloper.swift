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
    
    @State var vmRepo: RepoVM
    @State private var tabSelctRepo = 1
    
    
    var body: some View {
        Form {
            HStack {
                TextField("用户名:", text: $dev.name, prompt: Text("输入 Github 用户名 dev 或仓库名 dev/repo"))
                    .onChange(of: dev.name) { oldValue, newValue in
                        let dn =  dev.name.components(separatedBy: "/") 
                        if dn.count > 1 {
                            vmRepo = RepoVM(repoName: dev.name)
                            vmRepo.doing(.inInit)
                            dev.repoName = dn.last ?? ""
                            dev.repoOwner = dn.first ?? ""
                        } else {
                            vm = UserVM(userName: dev.name)
                            vm.doing(.updateAll)
                            dev.repoName = ""
                            dev.repoOwner = ""
                        }
                    }
                TextField("描述:", text: $dev.des)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        
        if dev.name.components(separatedBy: "/").count > 1 {
            repoEventView()
        } else {
            devEventView()
        }
    }
    
    @ViewBuilder
    func repoEventView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(vmRepo.repo.name).font(.system(.largeTitle))
                    Text("(\(vmRepo.repo.fullName))")
                }
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.red)
                    Text("\(vmRepo.repo.stargazersCount)")
                    Image(systemName: "tuningfork").foregroundColor(.cyan)
                    Text("\(vmRepo.repo.forks)")
                    Text("议题 \(vmRepo.repo.openIssues)")
                    Text("语言 \(vmRepo.repo.language ?? "")")
                    ButtonGoGitHubWeb(url: vmRepo.repo.htmlUrl ?? "https://github.com", text: "在 GitHub 上访问")

                }
                if vmRepo.repo.description != nil {
                    Text("简介：\(vmRepo.repo.description ?? "")")
                }
                
                HStack {
                    Text("作者：")
                    AsyncImageWithPlaceholder(size: .smallSize, url: vmRepo.repo.owner.avatarUrl)
                    ButtonGoGitHubWeb(url: vmRepo.repo.owner.login, text: vmRepo.repo.owner.login, ignoreHost: true)
                }
            } // end VStack
            Spacer()
        }
        .frame(minWidth: SPC.detailMinWidth)
        .onChange(of: vmRepo.repo, { oldValue, newValue in
            if !newValue.owner.avatarUrl.isEmpty {
                dev.avatar = newValue.owner.avatarUrl
            }
        })
        .onChange(of: vmRepo.commits, { oldValue, newValue in
            if ((newValue.first?.commit.author.date.isEmpty) != nil) {
                let iso8601String = newValue.first?.commit.author.date ?? ""
                let formatter = ISO8601DateFormatter()
                dev.updateDate = formatter.date(from: iso8601String) ?? Date.now
            }
        })
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            vmRepo.doing(.inInit)
        }
        // end HStack

        TabView(selection: $tabSelct) {
            RepoCommitsView(commits: vmRepo.commits, repo: vmRepo.repo)
                .tabItem {
                    Text("新提交")
                }
                .onAppear {
                    vmRepo.doing(.inCommit)
                }
                .tag(1)

            IssuesView(issues: vmRepo.issues, repo: vmRepo.repo)
                .tabItem {
                    Text("议题列表")
                }
                .onAppear {
                    vmRepo.doing(.inIssues)
                }
                .tag(2)

            IssueEventsView(issueEvents: vmRepo.issueEvents, repo: vmRepo.repo)
                .tabItem {
                    Text("议题事件")
                }
                .onAppear {
                    vmRepo.doing(.inIssueEvents)
                }
                .tag(3)

            ReadmeView(content: vmRepo.readme.content.replacingOccurrences(of: "\n", with: ""))
                .tabItem {
                    Text("README")
                }
                .onAppear {
                    vmRepo.doing(.inReadme)
                }
                .tag(4)

        } // end TabView
        Spacer()
    }
    
    @ViewBuilder
    func devEventView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    AsyncImageWithPlaceholder(size: .normalSize, url: vm.user.avatarUrl)
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(vm.user.name ?? vm.user.login).font(.system(.title))
                            if !vm.user.login.isEmpty {
                                Text("(\(vm.user.login))")
                            }
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
            }
        })
        .onChange(of: vm.user, { oldValue, newValue in
            if !newValue.avatarUrl.isEmpty {
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


