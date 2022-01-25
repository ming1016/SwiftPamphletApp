//
//  IssueView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/12.
//

import SwiftUI

struct IssueView: View {
    enum EnterType {
        case normal, hiddenUserInfo
    }

    @StateObject var vm: IssueVM
    @State var type: EnterType = .normal

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(vm.issue.title).font(.system(.largeTitle))
                        ButtonGoGitHubWeb(url: vm.issue.htmlUrl, text: "在 GitHub 上访问")
                        Button {
                            vm.doing(.update)
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }

                    }
                    if type == .hiddenUserInfo {
                        Text(" \(howLongFromNow(timeStr:vm.issue.updatedAt))更新过").font(.footnote)
                    } else {
                        HStack {
                            AsyncImageWithPlaceholder(size: .smallSize, url: vm.issue.user.avatarUrl)
                            VStack(alignment:.leading) {
                                NavigationLink(destination: UserView(vm: UserVM(userName: vm.issue.user.login)), label: {
                                    Text(vm.issue.user.login)
                                })
                                HStack {
                                    Text("更新于 ")
                                    GitHubApiTimeView(timeStr: vm.issue.updatedAt)
                                }
                            }
                        } // end HStack
                    }
                    MarkdownView(s: vm.issue.body ?? "") // TODO: 等 SwiftUI 的 Text 支持完整的 markdown，再进行替换
                } // end VStack
                Spacer()
            } // end HStack
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))

            if vm.comments.count > 0 {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("留言").font(.system(.largeTitle))
                    }
                    .padding(10)
                    Spacer()
                }
                ForEach(vm.comments) { comment in
                    VStack(alignment: .leading) {
                        GitHubApiTimeView(timeStr: comment.updatedAt)
                        HStack {
                            AsyncImageWithPlaceholder(size: .smallSize, url: comment.user.avatarUrl)
                            ButtonGoGitHubWeb(url: comment.user.login, text: comment.user.login, ignoreHost: true)

                            Text(comment.authorAssociation)
                                .font(.footnote)
                                .foregroundColor(.secondary)

                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                MarkdownView(s: comment.body)
                            }
                            Spacer()
                        }
                    } // end VStack
                    .padding(10)
                    Divider()
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                } // end ForEach
            }

        } // end ScrollView
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .frame(minWidth: SPC.detailMinWidth)
        .onAppear {
            vm.doing(.inInit)
        }

    }
}
