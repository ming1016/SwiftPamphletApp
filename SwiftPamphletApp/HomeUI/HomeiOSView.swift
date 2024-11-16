//
//  HomeiOSView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/10.
//

import SwiftUI

#if os(iOS)
struct HomeiOSView: View {
    @State var state: String = ""
    var body: some View {
        EmptyView()
            .onOpenURL { url in
                if let content = URLComponents(url: url, resolvingAgainstBaseURL: true)?
                    .queryItems?.first(where: { $0.name == "content" })?.value {
                    if content == "detail" {
                        state = "detail"
                    } else {
                        state = ""
                    }
                }
            }
        if state == "detail" {
            DetailView(state: $state)
        } else {
            // 首页
//            GuideListView()
            TaskCaseView()
        }
    }
}

struct TaskCaseView: View {
    var body: some View {
        ScrollView {
            TaskCaseUIUpdateView(isBad: false)
                .onAppear {
                    Perf.showTime("UI更新视图")
                }
//            TaskCaseAnimationView(isBad: false)
//                .onAppear {
//                    Perf.showTime("动画视图")
//                }
            TaskCaseBigImageView(isBad: false)
                .onAppear {
                    Perf.showTime("大图处理视图")
                }
            TaskCaseCacheView()
            // 异步执行，计算量大会影响主线程
//            TaskCasePriorityView(isBad: false)
//                .onAppear {
//                    Perf.showTime(des: "优先级视图")
//                }
        }
    } // end body
}

struct DetailView: View {
    @Binding var state: String
    var body: some View {
        VStack {
            Text("Detail View here")
            Button(action: {
                state = ""
            }) {
                Text("Back")
            }
        }
    }
}

#endif
