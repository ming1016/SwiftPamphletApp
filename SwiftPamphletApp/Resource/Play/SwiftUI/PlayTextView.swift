//
//  File.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/11/29.
//

import SwiftUI

struct PlayTextView: View {
    var body: some View {
        Group {
            Text("大标题").font(.largeTitle)
            Text("说点啥呢？")
                .tracking(30) // 字间距
                .kerning(30) // 尾部留白
            Text("划重点")
                .underline()
                .foregroundColor(.yellow)
            Text("可旋转的文字")
                .rotationEffect(.degrees(45))
                .fixedSize()
                .frame(width: 20, height: 80)
        }
        Group {
            Text("有阴影")
                .bold()
                .italic()
                .shadow(color: .primary, radius: 1, x: 0, y: 2)
            Text("Gradient Background")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.white, .black, .red]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
            Text("Gradient Background")
                .padding(5)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.white, .black, .purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
            Text("Angular Gradient Background")
                .padding()
                .background(AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center))
                .cornerRadius(20)
            Text("带背景图片的")
                .padding()
                .font(.largeTitle)
                .foregroundColor(.white)
                .background {
                    Rectangle()
                        .fill(Color(.black))
                        .cornerRadius(10)
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .frame(width: 200, height: 100)
        }

        Group {
            Text("这是一段长文。总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么，总得说点什么吧。")
                .lineLimit(3) // 对行的限制，如果多余设定行数，尾部会显示...
                .lineSpacing(10) // 行间距
                .multilineTextAlignment(.leading) // 对齐
        }
        
        // 使用 AttributeString
        PAttributeTextView()
            .padding()

    }
}

struct PAttributeTextView: View {
    let aStr: AttributedString = {
        var a1 = AttributedString("这是一个 ")
        var c1 = AttributeContainer()
        c1.font = .footnote
        c1.foregroundColor = .secondary
        a1.setAttributes(c1)
        
        var a2 = AttributedString("Attribute ")
        var c2 = AttributeContainer()
        c2.font = .title
        a2.setAttributes(c2)
        
        var a3 = AttributedString("String ")
        var c3 = AttributeContainer()
        c3.baselineOffset = 10
        c3.appKit.foregroundColor = .yellow // 仅在 macOS 里显示的颜色
        c3.swiftUI.foregroundColor = .secondary
        c3.font = .footnote
        a3.setAttributes(c3)
        
        // formatter 的支持
        var a4 = Date.now.formatted(.dateTime
                                        .hour()
                                        .minute()
                                        .weekday()
                                        .attributed
        )
        let c4AMPM = AttributeContainer().dateField(.amPM)
        let c4AMPMColor = AttributeContainer().foregroundColor(.green)
        
        a4.replaceAttributes(c4AMPM, with: c4AMPMColor)
        let c4Week = AttributeContainer().dateField(.weekday)
        let c4WeekColor = AttributeContainer().foregroundColor(.purple)
        a4.replaceAttributes(c4Week, with: c4WeekColor)
        
        a1.append(a2)
        a1.append(a3)
        a1.append(a4)
        
        return a1
    }()
    var body: some View {
        Text(aStr)
        
    }
}



