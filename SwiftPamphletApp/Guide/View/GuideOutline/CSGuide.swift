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
            L(t: "机器学习与神经网络", type: 1),
            L(t: "LLM如何工作", type: 1),
            L(t: "Transformer", type: 1),
            L(t: "图像生成", type: 1),
            L(t: "AI基础设施如何工作", type: 1),
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
            L(t: "GCC、GDB、Make", type: 1),
            L(t: "Git版本控制系统", type: 1),
            L(t: "基本的性能分析和调试技术", type: 1)
        ]),
        L(t: "计算机基础", sub: [
            L(t: "计算机组成原理", type: 1),
            L(t: "指令集架构", type: 1),
            L(t: "操作系统原理", type: 1)
        ]),
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
        ]),
        L(t: "编译器和解释器", sub: [
            L(t: "代码如何运行", type: 1),
            L(t: "解释器是什么", type: 1),
            L(t: "编译器是什么", type: 1),
            L(t: "代码速度", type: 1),
        ]),
        L(t: "图形", sub: [
            L(t: "像素和颜色", sub: [
                L(t: "屏幕如何工作", type: 1),
                L(t: "触摸屏", type: 1),
                L(t: "图片是什么", type: 1),
                L(t: "色彩空间、模型和色域", type: 1),
                L(t: "色彩对比计算", type: 1),
                L(t: "Gradients和perceptual uniformity", type: 1),
                L(t: "混合模式背后的数学原理", type: 1),
            ]),
            L(t: "字体和矢量图", sub: [
                L(t: "曲线绘图", type: 1),
                L(t: "光栅化和抗锯齿", type: 1),
                L(t: "SVG", type: 1),
                L(t: "图形数学", type: 1),
            ]),
            L(t: "3D和着色器", sub: [
                L(t: "GPU如何工作", type: 1),
                L(t: "着色器是什么", type: 1),
                L(t: "3D-SDF", type: 1),
                L(t: "模糊噪点等效果", type: 1),
                L(t: "投射、行进和追踪光线", type: 1),
                L(t: "3D投影", type: 1),
            ])
        ]),
        L(t: "数据和压缩", sub: [
            L(t: "字节是什么", type: 1),
            L(t: "二进制、十六进制和十进制", type: 1),
            L(t: "熵", type: 1),
            L(t: "无损压缩与有损压缩", type: 1),
            L(t: "密码学", type: 1),
            L(t: "图像压缩", type: 1),
            L(t: "CRDT", type: 1),
        ]),
        L(t: "网络", sub: [
            L(t: "浏览器是什么", type: 1),
            L(t: "客户端和服务器", type: 1),
            L(t: "DNS查找怎么工作", type: 1),
            L(t: "网络-协议", type: 1),
            L(t: "网络-序列化", type: 1),
            L(t: "网络-Streaming", type: 1),
            L(t: "网络-缓存", type: 1),
        ]),
    ]
}

