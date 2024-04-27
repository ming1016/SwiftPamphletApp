//
//  UserView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/10.
//

import SwiftUI
import SMGitHub

struct UserEventView: View {
    var events: [EventModel]
    var isShowActor = false
    var isShowUserEventLink = true
    var unReadCount = 0
    var body: some View {
        List {
            ForEach(Array(events.enumerated()), id: \.0) { i, event in

                AUserEventLabel(event: event, isShowActor: isShowActor, isUnRead: unReadCount > 0 && i < unReadCount)
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
                    NukeImage(width: 20, height: 20, url: event.actor.avatarUrl)
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
