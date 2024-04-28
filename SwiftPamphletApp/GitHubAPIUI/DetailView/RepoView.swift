//
//  RepoView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI
import SMGitHub

struct ReadmeView: View {
    @Environment(\.colorScheme) private var colorScheme
    var content: String
    var body: some View {
        ScrollView {
            MarkdownView(s: content.base64Decoded() ?? "failed")
                .padding(10)
        }
        .background(colorScheme == .light ? Color.white : Color.black)
    }
}

struct IssuesView: View {
    var issues: [IssueModel]
    var repo: RepoModel
    var body: some View {
        List {
            ForEach(issues) { issue in
                IssueLabelView(issue: issue)
            } // end ForEach
        } // end List
    } // end body
}

struct IssueEventsView: View {
    var issueEvents: [IssueEventModel]
    var repo: RepoModel
    var body: some View {
        List {
            ForEach(issueEvents) { issueEvent in
                IssueEventLabelView(issueEvent: issueEvent)
            } //  end ForEach
        } // end List
    } // end body
}

struct RepoCommitsView: View {
    var commits: [CommitModel]
    var repo: RepoModel
    var unReadCount = 0
    var body: some View {
        List {
            ForEach(Array(commits.enumerated()), id: \.0) { i, commit in
                RepoCommitLabelView(repo: repo, commit: commit, isUnRead: unReadCount > 0 && i < unReadCount)
            } // end ForEach
        } // end List
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
                    NukeImage(width: 20, height: 20, url: commit.author?.avatarUrl ?? "")
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
                NukeImage(width: 20, height: 20, url: issue.user.avatarUrl)
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
                NukeImage(width: 20, height: 20, url: issueEvent.actor.avatarUrl)
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
                NukeImage(width: 20, height: 20, url: issueEvent.issue.user.avatarUrl)
                ButtonGoGitHubWeb(url: issueEvent.issue.user.login, text: issueEvent.issue.user.login, ignoreHost: true)
            }
            MarkdownView(s: issueEvent.issue.body ?? "")
        } // end VStack
    }
}
