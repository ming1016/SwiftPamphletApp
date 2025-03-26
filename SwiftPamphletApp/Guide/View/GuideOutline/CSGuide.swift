//
//  CSGuide.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import Foundation

struct CSGuide {
    var outline = [
        L(t: "汇编", sub: [
            L(t: "ARM汇编语言", type: 1),
            L(t: "ARM反汇编", type: 1),
            L(t: "ARM解释器和虚拟机", type: 1),
            L(t: "QEMU的TCG和TCI", type: 1),
            L(t: "ARM解释器支持OC的语法特性", type: 1),
            L(t: "ARM架构基础知识", type: 1),
            L(t: "ARM解释器模拟内存和堆栈", sub: [
                L(t: "ARM内存模型", type: 1),
                L(t: "ARM解释器堆栈实现与管理", type: 1),
                L(t: "ARM解释器内存访问指令模拟", type: 1),
                L(t: "ARM解释器高级特性模拟", type: 1),
                L(t: "ARM解释器模拟内存和堆栈-代码实现与示例", type: 1),
                L(t: "ARM解释器模拟内存和堆栈-性能优化与挑战", type: 1),
                L(t: "ARM解释器模拟内存和堆栈-调试与可视化", type: 1),
                L(t: "ARM解释器模拟内存和堆栈-实际应用与案例分析", type: 1),
            ]),
            L(t: "ARM解释器中FFI调用iOS原生函数", type: 1),
        ])
    ]
}

