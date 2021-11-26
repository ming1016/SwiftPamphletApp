//
//  RepoView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI
import MarkdownUI

struct RepoView: View {
    enum EnterType {
        case normal, readme
    }
    
    @StateObject var vm: RepoVM
    @State private var tabSelct = 1
    @State var type: EnterType = .normal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(vm.repo.name).font(.system(.largeTitle))
                    Text("(\(vm.repo.fullName))")
                    Text("Star \(vm.repo.stargazersCount)")
                    Text("议题 \(vm.repo.openIssues)")
                    Text("语言 \(vm.repo.language ?? "")")
                    ButtonGoGitHubWeb(url: vm.repo.htmlUrl ?? "https://github.com", text: "在 GitHub 上访问")
                }
                
                Text("简介：\(vm.repo.description ?? "")")
                HStack {
                    Text("作者：")
                    AsyncImageWithPlaceholder(size: .smallSize, url: vm.repo.owner.avatarUrl)
                    ButtonGoGitHubWeb(url: vm.repo.owner.login, text: vm.repo.owner.login, ignoreHost: true)
                }
            } // end VStack
            Spacer()
        }
        .frame(minWidth: SPConfig.detailMinWidth)
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        .onAppear {
            if type == .readme {
                vm.doing(.inInitJustRepo)
                tabSelct = 4
            } else {
                vm.doing(.inInit)
            }
            
        }
        // end HStack
        
        TabView(selection: $tabSelct) {
            RepoCommitsView(commits: vm.commits, repo: vm.repo)
                .tabItem {
                    Text("新提交")
                }
                .tag(1)
            
            IssuesView(issues: vm.issues, repo: vm.repo)
                .tabItem {
                    Text("议题列表")
                }
                .onAppear {
                    vm.doing(.inIssues)
                }
                .tag(2)
            
            IssueEventsView(issueEvents: vm.issueEvents, repo: vm.repo)
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
            Markdown(Document(content.base64Decoded() ?? "failed"))
                .padding(10)
        }
    }
}

struct IssuesView: View {
    var issues: [IssueModel]
    var repo: RepoModel
    var body: some View {
        List {
            ForEach(issues) { issue in
                NavigationLink {
                    IssueView(vm: IssueVM(repoName: repo.fullName, issueNumber: issue.number))
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(issue.updatedAt.prefix(10)).font(.system(.footnote))
                            ButtonGoGitHubWeb(url: issue.htmlUrl, text: issue.title)
                            Text("\(issue.comments) 回复")
                        }
                        HStack {
                            AsyncImageWithPlaceholder(size: .tinySize, url: issue.user.avatarUrl)
                            ButtonGoGitHubWeb(url: issue.user.login, text: issue.user.login, ignoreHost: true)
                        }
                        Markdown(Document(issue.body ?? ""))
                    } // end VStack
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                }
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
                NavigationLink {
                    IssueView(vm: IssueVM(repoName: repo.fullName, issueNumber: issueEvent.issue.number))
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(issueEvent.createdAt.prefix(10)).font(.system(.footnote))
                            AsyncImageWithPlaceholder(size: .tinySize, url: issueEvent.actor.avatarUrl)
                            ButtonGoGitHubWeb(url: issueEvent.actor.login, text: issueEvent.actor.login, ignoreHost: true)
                            Text(issueEvent.event)
                        }
                        Group {
                            ButtonGoGitHubWeb(url: issueEvent.issue.title, text: "标题：\(issueEvent.issue.title)")
                            HStack {
                                AsyncImageWithPlaceholder(size: .tinySize, url: issueEvent.issue.user.avatarUrl)
                                ButtonGoGitHubWeb(url: issueEvent.issue.user.login, text: issueEvent.issue.user.login, ignoreHost: true)
                            }
                            Markdown(Document(issueEvent.issue.body ?? ""))
                        }
                    } // end VStack
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                } // end NavigationLink
            } //  end ForEach
        } // end List
    } // end body
}

struct RepoCommitsView: View {
    var commits: [CommitModel]
    var repo: RepoModel
    var body: some View {
        List {
            ForEach(commits) { commit in
                NavigationLink {
                    VStack {
                        if commit.author?.login != nil {
                            UserView(vm: UserVM(userName: commit.author?.login ?? ""))
                        } else {
                            Text(commit.commit.author.name ?? "")
                        }
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(commit.commit.author.date.prefix(10))
                                .font(.system(.footnote))
                            if commit.author != nil {
                                AsyncImageWithPlaceholder(size: .tinySize, url: commit.author?.avatarUrl ?? "")
                                Text(commit.author?.login ?? "").bold()

                            } else {
                                Text(commit.commit.author.name ?? "")
                            }
                            ButtonGoGitHubWeb(url: "https://github.com/\(repo.fullName)/commit/\(commit.sha ?? "")", text: "commit")
                        } // end HStack
                        Markdown(Document(commit.commit.message ?? ""))
                    } // end VStack
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                } // end NavigationLink
            } // end ForEach
        } // end List
    } // end body
}















