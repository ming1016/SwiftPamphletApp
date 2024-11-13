//
//  TaskCaseAnimation.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import SwiftUI
import Combine

struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGPoint
    var color: Color
    var size: CGFloat
}

// 方案1：使用 @unchecked Sendable
@MainActor
final class ParticleSystem: ObservableObject, @unchecked Sendable {
    @Published var particles: [Particle] = []
    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()
    
    func createParticles(at position: CGPoint, count: Int) {
        // 在主线程创建大量粒子(会导致卡顿)
        for _ in 0..<count {
            let particle = Particle(
                position: position,
                velocity: CGPoint(
                    x: CGFloat.random(in: -5...5),
                    y: CGFloat.random(in: -5...5)
                ),
                color: Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
                ),
                size: .random(in: 2...6)
            )
            particles.append(particle)
        }
    }
    
    @MainActor
    func createParticlesAsync(at position: CGPoint, count: Int) async {
        // 创建静态函数来生成粒子数据
        let newParticles = await Task.detached(priority: .userInitiated) {
            return await Self.generateParticles(at: position, count: count)
        }.value
        
        particles.append(contentsOf: newParticles)
    }
    
    // 静态函数用于生成粒子
    private static func generateParticles(at position: CGPoint, count: Int) -> [Particle] {
        return (0..<count).map { _ in
            Particle(
                position: position,
                velocity: CGPoint(
                    x: CGFloat.random(in: -5...5),
                    y: CGFloat.random(in: -5...5)
                ),
                color: Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
                ),
                size: .random(in: 2...6)
            )
        }
    }
    
    func startAnimation() {
        // 使用 Timer.publish 替代 Timer.scheduledTimer
        Timer.publish(every: 1/60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateParticles()
            }
            .store(in: &cancellables)
    }
    
    private func updateParticles() {
        particles = particles.compactMap { particle in
            var newParticle = particle
            newParticle.position.x += particle.velocity.x
            newParticle.position.y += particle.velocity.y
            // 移除超出屏幕的粒子
            if newParticle.position.y > 1000 || newParticle.position.x < -100 || newParticle.position.x > 500 {
                return nil
            }
            return newParticle
        }
    }
    
    func stopAnimation() {
        cancellables.removeAll()
    }
}

struct TaskCaseAnimationView: View {
    @StateObject private var particleSystem = ParticleSystem()
    var isBad = true
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // 绘制所有粒子
            ForEach(particleSystem.particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
            }
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    // 会卡顿的版本
                    Button("创建1000个粒子(卡顿)") {
                        particleSystem.createParticles(
                            at: CGPoint(x: 200, y: 400),
                            count: 1000
                        )
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                    
                    // 不会卡顿的版本
                    Button("异步创建1000个粒子") {
                        Task {
                            await particleSystem.createParticlesAsync(
                                at: CGPoint(x: 200, y: 400),
                                count: 1000
                            )
                        }
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            particleSystem.startAnimation()
            if isBad == true {
                particleSystem.createParticles(
                    at: CGPoint(x: 200, y: 400),
                    count: 1000
                )
            } else {
                Task {
                    await particleSystem.createParticlesAsync(
                        at: CGPoint(x: 200, y: 400),
                        count: 1000
                    )
                }
            }
        }
        .onDisappear {
            particleSystem.stopAnimation()
        }
        .frame(height: 300)
    }
}
