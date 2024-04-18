//
//  ViewStyle.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/20.
//

import SwiftUI

struct TEModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .stroke(.secondary, lineWidth: 1)
                    .opacity(0.5)
              )
            .disableAutocorrection(true)
    }
}
extension View {
    func te() -> some View {
        modifier(TEModifier())
    }
}

struct TFRoundedModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
extension View {
    func tfRounded() -> some View {
        modifier(TFRoundedModifier())
    }
}

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
