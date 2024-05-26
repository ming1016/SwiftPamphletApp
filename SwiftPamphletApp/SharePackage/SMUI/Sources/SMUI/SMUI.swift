// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

// MARK: Text
extension Text {
    public func gradientTitle(color: Color = .primary) -> some View {
        self
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(color.gradient)
            .fontDesign(.rounded)
    }
}

// MARK: TextEidtor
extension TextEditor {
    public func border() -> some View {
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
    public func rounded() -> some View {
        self
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
