//
//  PlayFoundation.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/17.
//

import Foundation

class PlayFoundation {
    
    static func scanner() {
        let s1 = """
one1,
two2,
three3.
"""
        let sn1 = Scanner(string: s1)
        while !sn1.isAtEnd {
            if let r1 = sn1.scanUpToCharacters(from: .newlines) {
                print(r1 as String)
            }
        }
        /// one1,
        /// two2,
        /// three3.
        
        // 找出数字
        let sn2 = Scanner(string: s1)
        sn2.charactersToBeSkipped = CharacterSet.decimalDigits.inverted // 不是数字的就跳过
        var p: Int = 0
        while !sn2.isAtEnd {
            if sn2.scanInt(&p) {
                print(p)
            }
        }
        /// 1
        /// 2
        /// 3
        
    }
    
    static func file() {
        
        let u1 = URL(string: "/Users/mingdai/Downloads/1.html")
        do {
            // 写入
            let url1 = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: u1, create: true) // 保证原子性安全保存
            print(url1)
            
            // 读取
            let s1 = try String(contentsOfFile: "/Users/mingdai/Downloads/1.html", encoding: .utf8)
            print(s1)
            
        } catch {}
        
        // 检查路径是否可用
        let u2 = URL(fileURLWithPath:"/Users/mingdai/Downloads/1.html")
        do {
            let values = try u2.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let capacity = values.volumeAvailableCapacityForImportantUsage {
                print("可用: \(capacity)")
            } else {
                print("不可用")
            }
        } catch {
            print("错误: \(error.localizedDescription)")
        }
        
    }
    
    static func date() {
        let now = Date()
        
        // Date 转 时间戳
        let interval = now.timeIntervalSince1970 // 时间戳
        let df = DateFormatter()
        df.dateFormat = "yyyy 年 MM 月 dd 日 HH:mm:ss"
        print("时间戳：\(Int(interval))") // 时间戳：1642399901
        print("格式化的时间：" + df.string(from: now)) // 格式化的时间：2022 年 01 月 17 日 14:11:41
        df.dateStyle = .short
        print("short 样式时间：" + df.string(from: now)) // short 样式时间：2022/1/17
        df.locale = Locale(identifier: "zh_Hans_CN")
        df.dateStyle = .full
        print("full 样式时间：" + df.string(from: now)) // full 样式时间：2022年1月17日 星期一
        
        
        // 时间戳转 Date
        let date = Date(timeIntervalSince1970: interval)
        print(date) // 2022-01-17 06:11:41 +0000
    }
    
    static func formatter() {
        
        // 计算两个时间之间相差多少时间，支持多种语言字符串
        let d1 = Date().timeIntervalSince1970 - 60 * 60
        let f1 = RelativeDateTimeFormatter()
        f1.locale = Locale(identifier: "zh_Hans_CN")
        let str = f1.localizedString(for: Date(timeIntervalSince1970: d1), relativeTo: Date())
        print(str) // 1小时前
        
        // 描述多个事物
        let s1 = ListFormatter.localizedString(byJoining: ["冬天","春天","夏天","秋天"])
        print(s1)
    }
    
    static func measurement() {
        // 参考：https://developer.apple.com/documentation/foundation/nsdimension
        let m1 = Measurement(value: 1, unit: UnitLength.kilometers)
        let m2 = m1.converted(to: .meters) // 千米转米
        print(m2) // 1000.0 m
        // 度量值转为本地化的值
        let mf = MeasurementFormatter()
        mf.locale = Locale(identifier: "zh_Hans_CN")
        print(mf.string(from: m1)) // 1公里
    }
    
    static func data() {
        
        // 对数据的压缩
        let d1 = "看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？".data(using: .utf8)! as NSData
        print("ori \(d1.count) bytes")
        do {
            /// 压缩算法
            /// * lz4
            /// * lzma
            /// * zlib
            /// * lzfse
            let compressed = try d1.compressed(using: .zlib)
            print("comp \(compressed.count) bytes")
            
            // 对数据解压
            let decomressed = try compressed.decompressed(using: .zlib)
            let deStr = String(data: decomressed as Data, encoding: .utf8)
            print(deStr ?? "")
        } catch {}
        /// ori 297 bytes
        /// comp 37 bytes
        
        
        
    }
}


