//
//  ViewStyle.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/20.
//

import SwiftUI

// MARK: Text
extension Text {
    func gradientTitle(color: Color = .primary) -> some View {
        self
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(color.gradient)
            .fontDesign(.rounded)
    }
}

// MARK: TextEidtor
extension TextEditor {
    func border() -> some View {
        self
            .overlay(
                Rectangle()
                    .stroke(.secondary, lineWidth: 1)
                    .opacity(0.5)
            )
            .disableAutocorrection(true)
    }
}


// MARK: TextField

// 圆角
extension TextField {
    func rounded() -> some View {
        self
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

// MARK: Toggle
struct SymbolToggleStyle: ToggleStyle {
    var systemImage: String = "checkmark"
    var activeColor: Color = .green

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 25)
                .fill(configuration.isOn ? activeColor : Color(.lightGray))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .overlay {
                            Image(systemName: systemImage)
                                .foregroundColor(configuration.isOn ? activeColor : Color(.lightGray))
                        }
                        .offset(x: configuration.isOn ? 10 : -10)

                }
                .frame(width: 50, height: 25)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
