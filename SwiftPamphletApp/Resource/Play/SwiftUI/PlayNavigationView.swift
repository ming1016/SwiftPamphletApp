//
//  PlayNavigationView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/24.
//

import SwiftUI

struct PlayNavigationView: View {
    let lData = 1...10
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                List(lData, id: \.self) { i in
                    NavigationLink {
                        PNavDetailView(contentStr: "\(i)")
                    } label: {
                        Text("\(i)")
                    }
                }
            }
            
            ZStack {
                LinearGradient(colors: [.mint, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Text("一个 NavigationView 的示例")
                        .bold()
                        .font(.largeTitle)
                        .shadow(color: .white, radius: 9, x: 0, y: 0)
                        .scaleEffect(2)
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Button("bottom1") {}
                    .font(.headline)
                    Button("bottom2") {}
                    Button("bottom3") {}
                    Spacer()
                }
                .padding(5)
                .background(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
        .foregroundColor(.white)
        .navigationTitle("数字列表")
        .toolbar {
            // placement 共有 keyboard、destructiveAction、cancellationAction、confirmationAction、status、primaryAction、navigation、principal、automatic 这些
            ToolbarItem(placement: .primaryAction) {
                Button("primaryAction") {}
                .background(.ultraThinMaterial)
                .font(.headline)
            }
            // 通过 ToolbarItemGroup 可以简化相同位置 ToolbarItem 的编写。
            ToolbarItemGroup(placement: .navigation) {
                Button("返回") {}
                Button("前进") {}
            }
            PCToolbar(doDestruct: {
                print("删除了")
            }, doCancel: {
                print("取消了")
            }, doConfirm: {
                print("确认了")
            })
            ToolbarItem(placement: .status) {
                Button("status") {}
            }
            ToolbarItem(placement: .principal) {
                Button("principal") {
                    
                }
            }
            ToolbarItem(placement: .keyboard) {
                Button("Touch Bar Button") {}
            }
        } // end toolbar
    }
}

// MARK: - NavigationView 的目的页面
struct PNavDetailView: View {
    @Environment(\.presentationMode) var pMode: Binding<PresentationMode>
    var contentStr: String
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text(contentStr)
                Button("返回") {
                    pMode.wrappedValue.dismiss()
                }
            }
        } // end ZStack
    } // end body
}

// MARK: - 自定义 toolbar
// 通过 ToolbarContent 创建可重复使用的 toolbar 组
struct PCToolbar: ToolbarContent {
    let doDestruct: () -> Void
    let doCancel: () -> Void
    let doConfirm: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .destructiveAction) {
            Button("删除", action: doDestruct)
        }
        ToolbarItem(placement: .cancellationAction) {
            Button("取消", action: doCancel)
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("确定", action: doConfirm)
        }
    }
}
