//
//  IssueView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/12.
//

import SwiftUI
import MarkdownUI

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
                    HStack{
                        Text(vm.issue.title).font(.system(.largeTitle))
                        ButtonGoGitHubWeb(url: vm.issue.htmlUrl, text: "在 GitHub 上访问")
                        Button {
                            vm.doing(.update)
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                    }
                    if type == .hiddenUserInfo {
                        Text("更新于 \(String(vm.issue.updatedAt.prefix(10)))").font(.footnote)
                    } else {
                        HStack {
                            AsyncImageWithPlaceholder(size: .smallSize, url: vm.issue.user.avatarUrl)
                            VStack(alignment:.leading) {
                                ButtonGoGitHubWeb(url: vm.issue.user.login, text: vm.issue.user.login, ignoreHost: true)
                                Text("更新于 \(String(vm.issue.updatedAt.prefix(10)))").font(.footnote)
                            }
                        } // end HStack
                    }
                    Markdown(Document(vm.issue.body ?? "")) // TODO: 等 SwiftUI 的 Text 支持 markdown，再进行替换
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
                        HStack {
                            AsyncImageWithPlaceholder(size: .smallSize, url: comment.user.avatarUrl)
                            ButtonGoGitHubWeb(url: comment.user.login, text: comment.user.login, ignoreHost: true)
                            Text(comment.authorAssociation)
                            Text(comment.updatedAt.prefix(10)).font(.system(.footnote))
                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Markdown(Document(comment.body))
                            }
                            Spacer()
                        }
                    } // end VStack
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
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

