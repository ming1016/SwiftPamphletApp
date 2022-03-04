//
//  RepoView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI

struct RepoView: View {
    enum EnterType {
        case normal, readme
    }
    @EnvironmentObject var appVM: AppVM
    @StateObject var vm: RepoVM
    @State private var tabSelct = 1
    @State var type: EnterType = .normal
    var isShowRepoCommitsLink = true
    var isShowIssuesLink = true
    var isCleanUnread = false
    var isCleanExpUnread = false
    @State private var expUnreadCount = 0
    
    @State var isEnterFullScreen: Bool = false // 全屏控制
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(vm.repo.name).font(.system(.largeTitle))
                    Text("(\(vm.repo.fullName))")
                }
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.red)
                    Text("\(vm.repo.stargazersCount)")
                    Image(systemName: "tuningfork").foregroundColor(.cyan)
                    Text("\(vm.repo.forks)")
                    Text("议题 \(vm.repo.openIssues)")
                    Text("语言 \(vm.repo.language ?? "")")
                    ButtonGoGitHubWeb(url: vm.repo.htmlUrl ?? "https://github.com", text: "在 GitHub 上访问")
                    Button {
                        withAnimation {
                            isEnterFullScreen.toggle()
                            appVM.fullScreen(isEnter: isEnterFullScreen)
                        }
                    } label: {
                        Image(systemName: isEnterFullScreen == true ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                    }

                }
                if vm.repo.description != nil {
                    Text("简介：\(vm.repo.description ?? "")")
                }
                
                HStack {
                    Text("作者：")
                    AsyncImageWithPlaceholder(size: .smallSize, url: vm.repo.owner.avatarUrl)
                    ButtonGoGitHubWeb(url: vm.repo.owner.login, text: vm.repo.owner.login, ignoreHost: true)
                }
            } // end VStack
            Spacer()
        }
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .frame(minWidth: SPC.detailMinWidth)
        
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            if type == .readme {
                vm.doing(.inInitJustRepo)
                tabSelct = 4
            } else {
                vm.doing(.inInit)
            }
        }
        .onDisappear {
            appVM.expNotis[vm.repoName]?.unRead = 0
            appVM.calculateExpCountNotis()
        }
        // end HStack

        TabView(selection: $tabSelct) {
            RepoCommitsView(commits: vm.commits, repo: vm.repo, isShowLink: isShowRepoCommitsLink, unReadCount: expUnreadCount)
                .tabItem {
                    Text("新提交")
                }
                .onAppear(perform: {
                    vm.doing(.inCommit)
                    if isCleanExpUnread == true {
                        expUnreadCount = appVM.expNotis[vm.repoName]?.unRead ?? 0
                        vm.doing(.clearExpUnReadCommit)
                        appVM.expNotis[vm.repoName]?.unRead = SPC.unreadMagicNumber
                        appVM.calculateExpCountNotis()
                    }
                })
                .tag(1)
                

            IssuesView(issues: vm.issues, repo: vm.repo, isShowLink: isShowIssuesLink)
                .tabItem {
                    Text("议题列表")
                }
                .onAppear {
                    vm.doing(.inIssues)
                }
                .tag(2)

            IssueEventsView(issueEvents: vm.issueEvents, repo: vm.repo, isShowLink: isShowIssuesLink)
                .tabItem {
                    Text("议题事件")
                }
                .onAppear {
                    vm.doing(.inIssueEvents)
                }
                .tag(3)

            ReadmeView(content: vm.readme.content.replacingOccurrences(of: "\n", with: ""))
                .tabItem {
                    Text("README")
                }
                .onAppear {
                    vm.doing(.inReadme)
                }
                .tag(4)

        } // end TabView
        Spacer()
    }
        
}

struct ReadmeView: View {
    var content: String
    var body: some View {
        ScrollView {
            MarkdownView(s: content.base64Decoded() ?? "failed")
                .padding(10)
        }
    }
}

struct IssuesView: View {
    var issues: [IssueModel]
    var repo: RepoModel
    var isShowLink = true
    var body: some View {
        List {
            ForEach(issues) { issue in
                if isShowLink == true {
                    NavigationLink(destination: IssueView(vm: IssueVM(repoName: repo.fullName, issueNumber: issue.number))) {
                        IssueLabelView(issue: issue)
                    }
                } else {
                    IssueLabelView(issue: issue)
                }
                Divider()
            } // end ForEach
        } // end List
    } // end body
}

struct IssueEventsView: View {
    var issueEvents: [IssueEventModel]
    var repo: RepoModel
    var isShowLink = true
    var body: some View {
        List {
            ForEach(issueEvents) { issueEvent in
                if isShowLink == true {
                    NavigationLink(destination: IssueView(vm: IssueVM(repoName: repo.fullName, issueNumber: issueEvent.issue.number))) {
                        IssueEventLabelView(issueEvent: issueEvent)
                    } // end NavigationLink
                } else {
                    IssueEventLabelView(issueEvent: issueEvent)
                }
                Divider()
            } //  end ForEach
        } // end List
    } // end body
}

struct RepoCommitsView: View {
    var commits: [CommitModel]
    var repo: RepoModel
    var isShowLink = true
    var unReadCount = 0
    var body: some View {
        List {
            ForEach(Array(commits.enumerated()), id: \.0) { i, commit in
                if isShowLink == true {
                    NavigationLink {
                        VStack {
                            if commit.author?.login != nil {
                                UserView(vm: UserVM(userName: commit.author?.login ?? ""), isShowUserEventLink: false)
                            } else {
                                Text(commit.commit.author.name ?? "")
                            }
                        }
                    } label: {
                        RepoCommitLabelView(repo: repo, commit: commit, isUnRead: unReadCount > 0 && i < unReadCount)
                    } // end NavigationLink
                } else {
                    RepoCommitLabelView(repo: repo, commit: commit, isUnRead: unReadCount > 0 && i < unReadCount)
                }

                Divider()
            } // end ForEach
        } // end List
        .frame(minWidth: SPC.detailMinWidth)
    } // end body
}

// MARK: - 碎视图
struct RepoCommitLabelView: View {
    var repo: RepoModel
    var commit: CommitModel
    var isUnRead = false
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            GitHubApiTimeView(timeStr: commit.commit.author.date)
            HStack {
                if isUnRead {
                    Image(systemName: "envelope.badge.fill")
                }
                if commit.author != nil {
                    AsyncImageWithPlaceholder(size: .tinySize, url: commit.author?.avatarUrl ?? "")
                    ButtonGoGitHubWeb(url: commit.author?.login ?? "", text: commit.author?.login ?? "", ignoreHost: true, bold: true)

                } else {
                    Text(commit.commit.author.name ?? "")
                }
                ButtonGoGitHubWeb(url: "https://github.com/\(repo.fullName)/commit/\(commit.sha ?? "")", text: "commit")
            } // end HStack
            MarkdownView(s: commit.commit.message ?? "")
        } // end VStack
    }
}

struct IssueLabelView: View {
    var issue: IssueModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            GitHubApiTimeView(timeStr: issue.updatedAt)
            HStack {
                Text(issue.title)
                    .font(.title2)
                Text("\(issue.comments) 回复")
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            HStack {
                AsyncImageWithPlaceholder(size: .tinySize, url: issue.user.avatarUrl)
                ButtonGoGitHubWeb(url: issue.user.login, text: issue.user.login, ignoreHost: true)
            }
            MarkdownView(s: issue.body ?? "")
        } // end VStack
    }
}

struct IssueEventLabelView: View {
    var issueEvent: IssueEventModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            GitHubApiTimeView(timeStr: issueEvent.createdAt)
            HStack {
                AsyncImageWithPlaceholder(size: .tinySize, url: issueEvent.actor.avatarUrl)
                ButtonGoGitHubWeb(url: issueEvent.actor.login, text: issueEvent.actor.login, ignoreHost: true)
                Text(issueEvent.event)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text(issueEvent.issue.title)
                    .font(.title2)
                Text("\(issueEvent.issue.comments) 回复")
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            HStack {
                AsyncImageWithPlaceholder(size: .tinySize, url: issueEvent.issue.user.avatarUrl)
                ButtonGoGitHubWeb(url: issueEvent.issue.user.login, text: issueEvent.issue.user.login, ignoreHost: true)
            }
            MarkdownView(s: issueEvent.issue.body ?? "")
        } // end VStack
    }
}
