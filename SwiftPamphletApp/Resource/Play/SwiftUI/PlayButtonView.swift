//
//  PlayButtonView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/14.
//

import SwiftUI

struct PlayButtonView: View {
    var asyncAction: () async -> Void = {
        do {
            try await Task.sleep(nanoseconds: 300_000_000)
        } catch {}
    }
    @State private var isFollowed: Bool = false
    var body: some View {
        VStack {
            
            // 常用方式
            Button {
                print("Clicked")
            } label: {
                Image(systemName: "ladybug.fill")
                Text("Report Bug")
            }

            // 图标
            Button(systemIconName: "ladybug.fill") {
                print("bug")
            }
            .buttonStyle(.plain) // 无背景
            .simultaneousGesture(LongPressGesture().onEnded({ _ in
                print("长按") // macOS 暂不支持
            }))
            .simultaneousGesture(TapGesture().onEnded({ _ in
                print("短按") // macOS 暂不支持
            }))
            
            // 使用角色 macOS 暂不支持
            Button("要删除了", role: .destructive) {
                print("删除")
            }
            .tint(.purple)
            .controlSize(.large) // .regular 是默认大小
            .buttonStyle(.borderedProminent) // 可显示 tint 的设置
            .cornerRadius(20)
            .accentColor(.pink)
            
            // 自定义 Button
            PCustomButton("点一下触发") {
                print("Clicked!")
            }
            
            // 自定义 ButtonStyle
            Button {
                print("Double Clicked!")
            } label: {
                Text("点两下触发")
            }
            .buttonStyle(PCustomPrimitiveButtonStyle())

            // 将 Text 视图加上另一个 Text 视图中，类型仍还是 Text。
            PCustomButton(Text("点我 ").underline() + Text("别犹豫").font(.title) + Text("🤫悄悄说声，有惊喜").font(.footnote).foregroundColor(.secondary)) {
                print("多 Text 组合标题按钮点击！")
            }
            
            // 异步按钮
            ButtonAsync {
                await asyncAction()
                isFollowed = true
            } label: {
                if isFollowed == true {
                    Text("已关注")
                } else {
                    Text("关注")
                }
            }
            .font(.largeTitle)
            .disabled(isFollowed)
            .buttonStyle(PCustomButtonStyle(backgroundColor: isFollowed == true ? .gray : .pink))
        }
        .padding()
    }
}

// MARK: - 异步操作的按钮
struct ButtonAsync<Label: View>: View {
    var doAsync: () async -> Void
    @ViewBuilder var label: () -> Label
    @State private var isRunning = false // 避免连续点击造成重复执行事件
    
    var body: some View {
        Button {
            isRunning = true
            Task {
                await doAsync()
                isRunning = false
            }
        } label: {
            label().opacity(isRunning == true ? 0 : 1)
            if isRunning == true {
                ProgressView()
            }
        }
        .disabled(isRunning)

    }
}

// MARK: - 扩展 Button
// 使用 SFSymbol 做图标
extension Button where Label == Image {
    init(systemIconName: String, done: @escaping () -> Void) {
        self.init(action: done) {
            Image(systemName: systemIconName)
                .renderingMode(.original)
        }
    }
}

// MARK: - 自定义 Button
struct PCustomButton: View {
    let desTextView: Text
    let act: () -> Void
    
    init(_ des: LocalizedStringKey, act: @escaping () -> Void) {
        self.desTextView = Text(des)
        self.act = act
    }
    
    var body: some View {
        Button {
            act()
        } label: {
            desTextView.bold()
        }
        .buttonStyle(.starming)
    }
}

extension PCustomButton {
    init(_ desTextView: Text, act: @escaping () -> Void) {
        self.desTextView = desTextView
        self.act = act
    }
}

// 点语法使用自定义样式
extension ButtonStyle where Self == PCustomButtonStyle {
    static var starming: PCustomButtonStyle {
        PCustomButtonStyle(cornerRadius: 15)
    }
}


// MARK: - ButtonStyle
struct PCustomButtonStyle: ButtonStyle {
    var cornerRadius:Double = 10
    var backgroundColor: Color = .pink
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(backgroundColor)
        )
        .opacity(configuration.isPressed ? 0.5 : 1)
        .scaleEffect(configuration.isPressed ? 0.99 : 1)
        .shadow(color: configuration.isPressed ? .white : .black, radius: 1, x: 0, y: 1)
    }
}

// MARK: - PrimitiveButtonStyle
struct PCustomPrimitiveButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 双击触发
        configuration.label
            .onTapGesture(count: 2) {
                configuration.trigger()
            }
        // 手势识别
        Button(configuration)
            .gesture(
                LongPressGesture()
                    .onEnded({ _ in
                        configuration.trigger()
                    })
            )
    }
}








