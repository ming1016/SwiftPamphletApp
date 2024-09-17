//
//  EditDeveloper.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/3/20.
//

import SwiftUI
import SwiftData
@preconcurrency import SMGitHub

struct EditDeveloper: View {
    @Bindable var dev: DeveloperModel
    @State private var tabSelct = 1
    @State private var tabSelctRepo = 1
    
    @State var repoVM: APIRepoVM
    @State var userVM: APIUserVM
    
    @State var needSetGithubAccessToken = false
    
    var body: some View {
        Form {
            HStack {
                TextField("用户名:", text: $dev.name, prompt: Text("输入 Github 用户名 dev 或仓库名 dev/repo"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: dev.name) { oldValue, newValue in
                        updateReq()
                    }
                TextField("描述:", text: $dev.des)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        .sheet(isPresented: $needSetGithubAccessToken) {
            VStack {
                GithubAccessTokenView() 
                Button {
                    updateReq()
                    needSetGithubAccessToken = false
                } label: {
                    Text("完成")
                }
            }
            .padding(20)

        }
        
        if dev.name.components(separatedBy: "/").count > 1 {
            repoEventView()
        } else {
            devEventView()
        }
    }
    
    func updateReq() {
        let dn =  dev.name.components(separatedBy: "/")
        if dn.count > 1 {
            repoVM = APIRepoVM(name: dev.name)
            Task {
                await repoVM.updateAllData()
            }
            
            dev.repoName = dn.last ?? ""
            dev.repoOwner = dn.first ?? ""
        } else {
            userVM = APIUserVM(name: dev.name)
            Task {
                await userVM.updateAllData()
            }
            
            dev.repoName = ""
            dev.repoOwner = ""
        }
    }
    
    @ViewBuilder
    func repoEventView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(repoVM.repo.name).font(.system(.largeTitle))
                    Text("(\(repoVM.repo.fullName))")
                }
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.red)
                    Text("\(repoVM.repo.stargazersCount)")
                    Image(systemName: "tuningfork").foregroundColor(.cyan)
                    Text("\(repoVM.repo.forks)")
                    Text("议题 \(repoVM.repo.openIssues)")
                    Text("语言 \(repoVM.repo.language ?? "")")
                    ButtonGoGitHubWeb(url: repoVM.repo.htmlUrl ?? "https://github.com", text: "在 GitHub 上访问")

                }
                if repoVM.repo.description != nil {
                    Text("简介：\(repoVM.repo.description ?? "")")
                }
                
                HStack {
                    Text("作者：")
                    NukeImage(width:40, height: 40, url: repoVM.repo.owner.avatarUrl)
                    ButtonGoGitHubWeb(url: repoVM.repo.owner.login, text: repoVM.repo.owner.login, ignoreHost: true)
                }
            } // end VStack
            Spacer()
        }
        .onChange(of: repoVM.repo, { oldValue, newValue in
            if !newValue.owner.avatarUrl.isEmpty {
                dev.avatar = newValue.owner.avatarUrl
            }
        })
        .onChange(of: repoVM.commits, { oldValue, newValue in
            if ((newValue.first?.commit.author.date.isEmpty) != nil) {
                let iso8601String = newValue.first?.commit.author.date ?? ""
                let formatter = ISO8601DateFormatter()
                dev.updateDate = formatter.date(from: iso8601String) ?? Date.now
            }
        })
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            Task {
                await repoVM.updateAllData()
            }
        }
        // end HStack

        Form {
            Section {
                TabView(selection: $tabSelct) {
                    RepoCommitsView(commits: repoVM.commits, repo: repoVM.repo)
                        .tabItem {
                            Text("新提交")
                        }
                        .tag(1)

                    IssuesView(issues: repoVM.issues, repo: repoVM.repo)
                        .tabItem {
                            Text("议题列表")
                        }
                        .tag(2)

                    IssueEventsView(issueEvents: repoVM.issuesEvents, repo: repoVM.repo)
                        .tabItem {
                            Text("议题事件")
                        }
                        .tag(3)

                    ReadmeView(content: repoVM.readme.content.replacingOccurrences(of: "\n", with: ""))
                        .tabItem {
                            Text("README")
                        }
                        .tag(4)

                } // end TabView
            }
        }
        Spacer()
    }
    
    @ViewBuilder
    func devEventView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    NukeImage(width:60, height: 60, url: userVM.user.avatarUrl)
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(userVM.user.name ?? userVM.user.login).font(.system(.title))
                            if !userVM.user.login.isEmpty {
                                Text("(\(userVM.user.login))")
                            }
                            Text("订阅者 \(userVM.user.followers) 人，仓库 \(userVM.user.publicRepos) 个")
                        }
                        HStack {
                            ButtonGoGitHubWeb(url: userVM.user.htmlUrl, text: "在 GitHub 上访问")
                            if userVM.user.location != nil {
                                Text("居住：\(userVM.user.location ?? "")").font(.system(.subheadline))
                            }
                        }
                    } // end VStack
                } // end HStack

                if userVM.user.bio != nil {
                    Text("简介：\(userVM.user.bio ?? "")")
                }
                HStack {
                    if userVM.user.blog != nil {
                        if !userVM.user.blog!.isEmpty {
                            Text("博客：\(userVM.user.blog ?? "")")
                            ButtonGoGitHubWeb(url: userVM.user.blog ?? "", text: "访问")
                        }
                    }
                    if userVM.user.twitterUsername != nil {
                        Text("Twitter：")
                        ButtonGoGitHubWeb(url: "https://twitter.com/\(userVM.user.twitterUsername ?? "")", text: "@\(userVM.user.twitterUsername ?? "")")
                    }
                } // end HStack
            } // end VStack
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            Task {
                await userVM.updateAllData()
            }
        }
        .onChange(of: userVM.events, { oldValue, newValue in
            if ((newValue.first?.createdAt.isEmpty) != nil) {
                let iso8601String = newValue.first?.createdAt ?? ""
                let formatter = ISO8601DateFormatter()
                dev.updateDate = formatter.date(from: iso8601String) ?? Date.now
            }
        })
        .onChange(of: userVM.user, { oldValue, newValue in
            if !newValue.avatarUrl.isEmpty {
                dev.avatar = userVM.user.avatarUrl
            }
        })
        
        Form {
            Section {
                TabView(selection: $tabSelct) {
                    DeveloperEventView(events: userVM.events)
                        .tabItem {
                            Image(systemName: "keyboard")
                            Text("事件")
                        }
                        .tag(1)
                    
                    DeveloperEventView(events: userVM.receivedEvents)
                        .tabItem {
                            Image(systemName: "keyboard.badge.ellipsis")
                            Text("Ta 接收的事件")
                        }
                        .tag(2)
                }
            }
        }
        Spacer()
    }
}

struct DeveloperEventView: View {
    var events: [EventModel]
    var body: some View {
        List {
            ForEach(Array(events.enumerated()), id: \.0) { i, event in
                AUserEventLabel(
                    event: event,
                    isShowActor: false,
                    isUnRead: false
                )
            } // end ForEach
        }//  end List
        .id(UUID()) // 优化 commits 有多个时数据变化可能影响的性能。这样做每次更新都产生新的视图，因此无法做动画效果。相当于 UITableView 上的 reloadData()
    } // end body
} // end struct


