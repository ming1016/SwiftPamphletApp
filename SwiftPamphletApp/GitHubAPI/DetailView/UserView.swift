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
    var isShowUserEventLink = true
    var isCleanUnread = false
    @State private var unReadCount = 0
    @State private var tabSelct = 1
    var body: some View {
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
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            vm.doing(.inInit)
        }
        .onDisappear(perform: {
            appVM.devsNotis[vm.userName] = 0
            appVM.calculateDevsCountNotis()
        })
        .frame(minWidth: SPC.detailMinWidth)

        TabView(selection: $tabSelct) {

            UserEventView(events: vm.events, isShowUserEventLink: isShowUserEventLink, unReadCount: unReadCount)
                .tabItem {
                    Image(systemName: "keyboard")
                    Text("事件")
                }
                .onAppear {
                    // 如果是从列表未读section里来的会检查清理未读
                    vm.doing(.inEvent)
                    if isCleanUnread == true {
                        vm.doing(.clearUnReadEvent)
                        unReadCount = appVM.devsNotis[vm.userName] ?? 0
                        appVM.devsNotis[vm.userName] = SPC.unreadMagicNumber
                        appVM.calculateDevsCountNotis()
                    }
                }
                .tag(1)
            UserEventView(events: vm.receivedEvents, isShowActor: true, isShowUserEventLink: isShowUserEventLink)
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

struct UserEventView: View {
    var events: [EventModel]
    var isShowActor = false
    var isShowUserEventLink = true
    var unReadCount = 0
    var body: some View {
        List {
            ForEach(Array(events.enumerated()), id: \.0) { i, event in

                if isShowUserEventLink == true {
                    NavigationLink {
                        UserEventLinkDestination(event: event)
                    } label: {
                        AUserEventLabel(
                            event: event,
                            isShowActor: isShowActor,
                            isUnRead: unReadCount > 0 && i < unReadCount
                        )
                    } // end NavigationLink
                } else {
                    AUserEventLabel(event: event, isShowActor: isShowActor, isUnRead: unReadCount > 0 && i < unReadCount)
                }
                Divider()
            } // end ForEach
        }//  end List
        .id(UUID()) // 优化 commits 有多个时数据变化可能影响的性能。这样做每次更新都产生新的视图，因此无法做动画效果。相当于 UITableView 上的 reloadData()
    } // end body
} // end struct

// MARK: - 碎视图

struct ListCommits: View {
    var event: EventModel
    var body: some View {
        ForEach(event.payload.commits ?? [PayloadCommitModel](), id: \.self) { c in
            ButtonGoGitHubWeb(url: "https://github.com/\(event.repo.name)/commit/\(c.sha ?? "")", text: "提交")
            MarkdownView(s: c.message ?? "")
        }
    }
}

struct UserEventLinkDestination: View {
    var event: EventModel
    var body: some View {
        VStack {
            if event.payload.issue?.number != nil {
                IssueView(vm: IssueVM(repoName: event.repo.name, issueNumber: event.payload.issue?.number ?? 0))
            } else {
                RepoView(vm: RepoVM(repoName: event.repo.name), type: .readme, isShowRepoCommitsLink: false, isShowIssuesLink: false)
            }
        }
    }
}

struct AUserEventLabel: View {
    var event: EventModel
    var isShowActor: Bool = false
    var isUnRead = false
    var body: some View {
        VStack(alignment: .leading) {
            GitHubApiTimeView(timeStr: event.createdAt)
            HStack {
                if isUnRead {
                    Image(systemName: "envelope.badge.fill")
                }
                Group {
                    Text(event.type)
                        .bold()
                    Text(event.payload.action ?? "")
                }
                .foregroundColor(.secondary)
                .font(.footnote)
            }
            ButtonGoGitHubWeb(url: "https://github.com/\(event.repo.name)", text: event.repo.name, bold: true)
            HStack {
                if event.payload.issue?.number != nil {
                    ButtonGoGitHubWeb(url: "https://github.com/\(event.repo.name)/issues/\(String(describing: event.payload.issue?.number ?? 0))", text: "议题")
                }

                if isShowActor == true {
                    AsyncImageWithPlaceholder(size: .tinySize, url: event.actor.avatarUrl)

                    Text(event.actor.login).bold()

                } // end if

            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))

            if event.payload.issue?.number != nil {
                if event.payload.issue?.title != nil {
                    Text(event.payload.issue?.title ?? "")
                        .font(.system(.title2))
                }
                if event.payload.issue?.body != nil && event.type != "IssueCommentEvent" {
                    MarkdownView(s: event.payload.issue?.body ?? "")
                }
                if event.type == "IssueCommentEvent" && event.payload.comment?.body != nil {
                    MarkdownView(s: event.payload.comment?.body ?? "")
                }
            }

            if event.payload.commits != nil {
                ListCommits(event: event)
            }

            if event.payload.pullRequest != nil {
                if event.payload.pullRequest?.title != nil {
                    Text(event.payload.pullRequest?.title ?? "")
                        .font(.system(.title2))
                }
                if event.payload.pullRequest?.body != nil {
                    MarkdownView(s: event.payload.pullRequest?.body ?? "")
                }
            }

            if event.payload.description != nil {
                MarkdownView(s: event.payload.description ?? "")
            }
        } // end VStack
    }
}
