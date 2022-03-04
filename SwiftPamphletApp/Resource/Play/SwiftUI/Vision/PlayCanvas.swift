//
//  PlayCanvas.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/3/4.
//

import SwiftUI

struct PlayCanvas: View {
    let colors: [Color] = [.purple, .blue, .yellow, .pink]
    
    var body: some View {
        
        // 画路径
        PCCanvasPathView(t: .rounded)
        PCCanvasPathView(t: .ellipse)
        PCCanvasPathView(t: .circle)

        // 图片和文字
        PCCanvasImageAndText(text: "Starming", colors: [.purple, .pink])

        // Symbol，在 Canvas 里引用 SwiftUI 视图
        Canvas { c, s in
            let c0 = c.resolveSymbol(id: 0)!
            let c1 = c.resolveSymbol(id: 1)!
            let c2 = c.resolveSymbol(id: 2)!
            let c3 = c.resolveSymbol(id: 3)!

            c.draw(c0, at: .init(x: 10, y: 10), anchor: .topLeading)
            c.draw(c1, at: .init(x: 30, y: 20), anchor: .topLeading)
            c.draw(c2, at: .init(x: 50, y: 30), anchor: .topLeading)
            c.draw(c3, at: .init(x: 70, y: 40), anchor: .topLeading)

        } symbols: {
            ForEach(Array(colors.enumerated()), id: \.0) { i, c in
                Circle()
                    .fill(c)
                    .frame(width: 100, height: 100)
                    .tag(i)
            }
        }

        // Symbol 动画和 SwiftUI 视图一样，不会受影响
        Canvas { c, s in
            let sb = c.resolveSymbol(id: 0)!
            c.draw(sb, at: CGPoint(x: s.width / 2, y: s.height /  2), anchor: .center)

        } symbols: {
            PCForSymbolView()
                .tag(0)
        }
    } // end var body
}

// MARK: - 给 Symbol 用的视图
struct PCForSymbolView: View {
    @State private var change = true
    var body: some View {
        Image(systemName: "star.fill")
            .renderingMode(.original)
            .font(.largeTitle)
            .rotationEffect(.degrees(change ? 0 : 72))
            .onAppear {
                withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                    change.toggle()
                }
            }
    }
}

// MARK: - 图片和文字
struct PCCanvasImageAndText: View {
    let text: String
    let colors: [Color]
    var fontSize: Double = 42
    
    var body: some View {
        Canvas { context, size in
            let midPoint = CGPoint(x: size.width / 2, y: size.height / 2)
            let font = Font.system(size: fontSize)
            var resolved = context.resolve(Text(text).font(font))
            
            let start = CGPoint(x: (size.width - resolved.measure(in: size).width) / 2.0, y: 0)
            let end = CGPoint(x: size.width - start.x, y: 0)
            
            resolved.shading = .linearGradient(Gradient(colors: colors), startPoint: start, endPoint: end)
            context.draw(resolved, at: midPoint, anchor: .center)
            
        }
    }
}

// MARK: - Path
struct PCCanvasPathView: View {
    enum PathType {
        case rounded, ellipse, casual, circle
    }
    let t: PathType
    
    var body: some View {
        Canvas { context, size in
            
            conf(context: &context, size: size, type: t)
        } // end Canvas
    }
    
    func conf( context: inout GraphicsContext, size: CGSize, type: PathType) {
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: 25, dy: 25)
        var path = Path()
        switch type {
        case .rounded:
            path = Path(roundedRect: rect, cornerRadius: 35.0)
        case .ellipse:
            let cgPath = CGPath(ellipseIn: rect, transform: nil)
            path = Path(cgPath)
        case .casual:
            path = Path {
                let points: [CGPoint] = [
                    .init(x: 10, y: 10),
                    .init(x: 0, y: 50),
                    .init(x: 100, y: 100),
                    .init(x: 100, y: 0),
                ]
                $0.move(to: .zero)
                $0.addLines(points)
            }
        case .circle:
            path = Circle().path(in: rect)
        }
        
        
        let gradient = Gradient(colors: [.purple, .pink])
        let from = rect.origin
        let to = CGPoint(x: rect.width, y: rect.height + from.y)
        
        // Stroke path
        context.stroke(path, with: .color(.blue), lineWidth: 25)
        context.fill(path, with: .linearGradient(gradient, startPoint: from, endPoint: to))
    }
}






