//
//  CSGuide.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import Foundation

struct CSGuide {
    var outline = [
        L(t: "AI", sub: [
            L(t:"AI编程", sub: [
                L(t: "AI编程-工具", type: 1),
                L(t: "CURSOR入门指南", type: 1),
                L(t: "AI编程-常用交互方式", type: 1),
                L(t: "处理现有代码库", sub: [
                    L(t: "AI编程-代码重构", type: 1),
                    L(t: "AI编程-调试", type: 1),
                    L(t: "AI编程-理解代码", type: 1),
                    L(t: "AI编程-使用场景", type: 1),
                    L(t: "AI编程-遗留代码协作最佳实践", type: 1),
                ]),
                L(t: "AI编程-加速开发", type: 1),
                L(t: "AI编程-适用场景与局限", type: 1),
                L(t: "AI编程-学习与技能提升", type: 1),
                L(t: "AI编程-学习路线图", type: 1),
            ])
        ]),
        L(t: "开发工具和语言", sub: [
            L(t: "C语言", type: 1),
//            L(t: "GCC、GDB、Make", type: 1),
//            L(t: "Git版本控制系统", type: 1),
//            L(t: "基本的性能分析和调试技术", type: 1)
        ]),
//        L(t: "计算机基础", sub: [
//            L(t: "计算机组成原理", type: 1),
//            L(t: "指令集架构", type: 1),
//            L(t: "操作系统原理", type: 1)
//        ]),
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
            L(t: "虚拟化技术", sub: [
                L(t: "虚拟化的基本概念", type: 1),
                L(t: "常见虚拟化技术原理", type: 1),
                L(t: "CPU虚拟化", type: 1),
                L(t: "内存虚拟化", type: 1),
                L(t: "IO虚拟化", type: 1)
            ]),
            L(t: "相关开源项目", sub: [
                L(t: "QEMU", sub: [
                    L(t: "QEMU概览", type: 1),
                    L(t: "QEMU源码初探", type: 1),
                    L(t: "QEMU-简单修改与实验", type: 1),
                    L(t: "QEMU-CPU模拟", type: 1),
                    L(t: "QEMU-内存管理", type: 1),
                    L(t: "QEMU-设备模拟", type: 1),
                    L(t: "QEMU-IO子系统", type: 1),
                    L(t: "QEMU高级特性", type: 1),
                    L(t: "开发一个简单的QEMU设备", type: 1),
                    L(t: "QEMU-调试与性能分析", type: 1),
                    L(t: "QEMU-贡献代码", type: 1),
                    L(t: "QEMU-设计简化版模拟器", type: 1),
                    L(t: "QEMU-实现基础框架", type: 1),
                    L(t: "QEMU-实现核心功能", type: 1),
                    L(t: "QEMU-扩展与完善", type: 1)
                ]),
            ]),
        ])
    ]
}

