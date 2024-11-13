//
//  TaskCaseBigImageView.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/13.
//

import SwiftUI
import Observation

#if os(iOS)
@MainActor @Observable
final class ImageProcessor {
    var processedImages: [UIImage] = []
    var isProcessing = false
    
    // 同步处理图片(会阻塞主线程)
    func processImagesSynchronously() {
        // 模拟加载多张大图
        let imageCount = 10
        processedImages.removeAll()
        
        for i in 0..<imageCount {
            // 创建一个大尺寸的渐变图片
            let size = CGSize(width: 2000, height: 2000)
            let renderer = UIGraphicsImageRenderer(size: size)
            
            let image = renderer.image { context in
                let colors = [
                    UIColor(red: CGFloat(i)/CGFloat(imageCount), green: 0.5, blue: 0.5, alpha: 1.0),
                    UIColor(red: 0.5, green: CGFloat(i)/CGFloat(imageCount), blue: 0.5, alpha: 1.0)
                ]
                
                let gradient = CGGradient(
                    colorsSpace: CGColorSpaceCreateDeviceRGB(),
                    colors: colors.map { $0.cgColor } as CFArray,
                    locations: [0.0, 1.0]
                )!
                
                context.cgContext.drawLinearGradient(
                    gradient,
                    start: .zero,
                    end: CGPoint(x: size.width, y: size.height),
                    options: []
                )
                
                // 模拟耗时操作
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            // 处理图片 - 调整大小
            let processedImage = processImage(image)
            processedImages.append(processedImage)
        }
    }
    
    // 异步处理图片
    func processImagesAsync() async {
        isProcessing = true
        processedImages.removeAll()
        
        // 创建和处理图片的任务数组
        async let images = withTaskGroup(of: UIImage.self) { group in
            for i in 0..<10 {
                group.addTask {
                    // 创建大尺寸渐变图片
                    let size = CGSize(width: 2000, height: 2000)
                    let renderer = UIGraphicsImageRenderer(size: size)
                    
                    let image = renderer.image { context in
                        let colors = [
                            UIColor(red: CGFloat(i)/10.0, green: 0.5, blue: 0.5, alpha: 1.0),
                            UIColor(red: 0.5, green: CGFloat(i)/10.0, blue: 0.5, alpha: 1.0)
                        ]
                        
                        let gradient = CGGradient(
                            colorsSpace: CGColorSpaceCreateDeviceRGB(),
                            colors: colors.map { $0.cgColor } as CFArray,
                            locations: [0.0, 1.0]
                        )!
                        
                        context.cgContext.drawLinearGradient(
                            gradient,
                            start: .zero,
                            end: CGPoint(x: size.width, y: size.height),
                            options: []
                        )
                        
                        // 模拟耗时操作
                        Thread.sleep(forTimeInterval: 0.2)
                    }
                    
                    return await self.processImage(image)
                }
            }
            
            var results: [UIImage] = []
            for await image in group {
                results.append(image)
            }
            return results
        }
        
        // 等待所有图片处理完成并更新UI
        processedImages = await images
        isProcessing = false
    }
    
    private func processImage(_ image: UIImage) -> UIImage {
        let targetSize = CGSize(width: 200, height: 200)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

struct TaskCaseBigImageView: View {
    @State private var processor = ImageProcessor()
    var isBad = true
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100))
            ], spacing: 10) {
                ForEach(Array(processor.processedImages.enumerated()), id: \.offset) { _, image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .padding()
            
            VStack(spacing: 20) {
                Button("同步处理图片(会卡顿)") {
                    processor.processImagesSynchronously()
                }
                .buttonStyle(.bordered)
                
                Button("异步处理图片") {
                    Task {
                        await processor.processImagesAsync()
                    }
                }
                .buttonStyle(.bordered)
                
                if processor.isProcessing {
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
        .onAppear {
            if isBad == true {
                processor.processImagesSynchronously()
            } else {
                Task {
                    await processor.processImagesAsync()
                }
            }
        }
    }
}
#endif

