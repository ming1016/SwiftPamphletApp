//
//  PlayFoundation.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/17.
//

import Foundation
import Contacts
import SwiftUI
import SwiftDate

class PlayFoundation {

    // UserDefault
    static func userDefaults() {
        enum UDKey {
            static let k1 = "token"
        }
        let ud = UserDefaults.standard
        ud.set("xxxxxx", forKey: UDKey.k1)
        let tk = ud.string(forKey: UDKey.k1)
        print(tk ?? "")
    }

    // 随机
    static func random() {
        let ri = Int.random(in: 0..<10)
        print(ri) // 0到10随机数
        let a = [0, 1, 2, 3, 4, 5]
        print(a.randomElement() ?? 0) // 数组中随机取个数
        print(a.shuffled()) // 随机打乱数组顺序
    }

    // 赋值时拷贝和写入时拷贝
    // refer: https://aymanmoo.medium.com/copy-on-assignment-vs-copy-on-write-in-swift-c3016b343d06
    static func coaAndCow() {
        class C {
            var p: String
            init(_ s: String) {
                self.p = s
            }
        }
        struct S {
            var c: C
            init(_ s: String) {
                c = C(s)
            }
        }

        // 赋值时拷贝
        var v1 = S("one")
        var v2 = v1

        withUnsafePointer(to: &v1.c) {
            print("v1.c address \($0)")
            // v1.c address 0x00007ff7b4053810
        }
        withUnsafePointer(to: &v2.c) {
            print("v2.c address \($0)")
            // v2.c address 0x00007ff7b4053808
        }

    }

    static func attributeString() -> [AttributedString] {
        var aStrs = [AttributedString]()
        var aStr1 = AttributedString("""
        标题
        正文内容，具体查看链接。
        这里摘出第一个重点，还要强调的内容。
        """)
        // 标题
        let title = aStr1.range(of: "标题")
        guard let title = title else {
            return aStrs
        }

        var c1 = AttributeContainer() // 可复用容器
        c1.inlinePresentationIntent = .stronglyEmphasized
        c1.font = .largeTitle
        aStr1[title].setAttributes(c1)

        // 链接
        let link = aStr1.range(of: "链接")
        guard let link = link else {
            return aStrs
        }

        var c2 = AttributeContainer() // 链接
        c2.strokeColor = .blue
        c2.link = URL(string: "https://ming1016.github.io/")
        aStr1[link].setAttributes(c2.merging(c1)) // 合并 AttributeContainer

        // Runs
        let i1 = aStr1.range(of: "重点")
        let i2 = aStr1.range(of: "强调")
        guard let i1 = i1, let i2 = i2 else {
            return aStrs
        }

        var c3 = AttributeContainer()
        c3.foregroundColor = .yellow
        c3.inlinePresentationIntent = .stronglyEmphasized
        aStr1[i1].setAttributes(c3)
        aStr1[i2].setAttributes(c3)

        for r in aStr1.runs {
            print("-------------")
            print(r.attributes)
        }

        aStrs.append(aStr1)

        // Markdown
        do {
            let aStr2 = try AttributedString(markdown: """
            内容[链接](https://ming1016.github.io/)。需要**强调**的内容。
            """)

            aStrs.append(aStr2)

        } catch {}

        return aStrs

    }

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

        let path1 = "/Users/mingdai/Downloads/1.html"
        let path2 = "/Users/mingdai/Documents/GitHub/"

        let u1 = URL(string: path1)
        do {
            // 写入
            let url1 = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: u1, create: true) // 保证原子性安全保存
            print(url1)

            // 读取
            let s1 = try String(contentsOfFile: path1, encoding: .utf8)
            print(s1)

        } catch {}

        // 检查路径是否可用
        let u2 = URL(fileURLWithPath:path2)
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

        // 遍历路径下所有目录
        let u3 = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let fm = FileManager.default
        fm.enumerator(atPath: u3.path)?.forEach({ path in
            guard let path = path as? String else {
                return
            }
            let url = URL(fileURLWithPath: path, relativeTo: u3)
            print(url.lastPathComponent)
        })

        // FileWrapper 的使用
        // 创建文件
        let f1 = FileWrapper(regularFileWithContents: Data("# 第 n 个文件\n ## 标题".utf8))
        f1.fileAttributes[FileAttributeKey.creationDate.rawValue] = Date()
        f1.fileAttributes[FileAttributeKey.modificationDate.rawValue] = Date()
        // 创建文件夹
        let folder1 = FileWrapper(directoryWithFileWrappers: [
            "file1.md": f1
        ])
        folder1.fileAttributes[FileAttributeKey.creationDate.rawValue] = Date()
        folder1.fileAttributes[FileAttributeKey.modificationDate.rawValue] = Date()

        do {
            try folder1.write(
                to: URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("NewFolder"),
                options: .atomic,
                originalContentsURL: nil
            )
        } catch {}
        print(FileManager.default.currentDirectoryPath)
    }

    static func date() {
        let now1 = Date()

        // Date 转 时间戳
        let interval = now1.timeIntervalSince1970 // 时间戳
        let df = DateFormatter()
        df.dateFormat = "yyyy 年 MM 月 dd 日 HH:mm:ss"
        print("时间戳：\(Int(interval))") // 时间戳：1642399901
        print("格式化的时间：" + df.string(from: now1)) // 格式化的时间：2022 年 01 月 17 日 14:11:41
        df.dateStyle = .short
        print("short 样式时间：" + df.string(from: now1)) // short 样式时间：2022/1/17
        df.locale = Locale(identifier: "zh_Hans_CN")
        df.dateStyle = .full
        print("full 样式时间：" + df.string(from: now1)) // full 样式时间：2022年1月17日 星期一

        // 时间戳转 Date
        let date = Date(timeIntervalSince1970: interval)
        print(date) // 2022-01-17 06:11:41 +0000

        // 使用 SwiftDate 库
        let cn = Region(zone: Zones.asiaShanghai, locale: Locales.chineseChina)
        SwiftDate.defaultRegion = cn
        print("2008-02-14 23:12:14".toDate()?.year ?? "") // 2008

        let d1 = "2022-01-17T23:20:35".toISODate(region: cn)
        guard let d1 = d1 else {
            return
        }
        print(d1.minute) // 20
        let d2 = d1 + 1.minutes
        print(d2.minute)

        // 两个 DateInRegion 相差时间 interval
        let i1 = DateInRegion(Date(), region: cn) - d1
        let s1 = i1.toString {
            $0.maximumUnitCount = 4
            $0.allowedUnits = [.day, .hour, .minute]
            $0.collapsesLargestUnit = true
            $0.unitsStyle = .abbreviated
            $0.locale = Locales.chineseChina
        }
        print(s1) // 9小时45分钟

    }

    static func formatter() {

        // 计算两个时间之间相差多少时间，支持多种语言字符串
        let d1 = Date().timeIntervalSince1970 - 60 * 60 * 24
        let f1 = RelativeDateTimeFormatter()
        f1.dateTimeStyle = .named
        f1.formattingContext = .beginningOfSentence
        f1.locale = Locale(identifier: "zh_Hans_CN")
        let str1 = f1.localizedString(for: Date(timeIntervalSince1970: d1), relativeTo: Date())
        print(str1) // 昨天

        // 简写
        let str2 = Date.now.addingTimeInterval(-(60 * 60 * 24))
            .formatted(.relative(presentation: .named))
        print(str2) // yesterday

        // 描述多个事物
        let s1 = ListFormatter.localizedString(byJoining: ["冬天","春天","夏天","秋天"])
        print(s1)

        // 名字
        let f2 = PersonNameComponentsFormatter()
        var nc1 = PersonNameComponents()
        nc1.familyName = "戴"
        nc1.givenName = "铭"
        nc1.nickname = "铭哥"
        print(f2.string(from: nc1)) // 戴铭
        f2.style = .short
        print(f2.string(from: nc1)) // 铭哥
        f2.style = .abbreviated
        print(f2.string(from: nc1)) // 戴

        var nc2 = PersonNameComponents()
        nc2.familyName = "Dai"
        nc2.givenName = "Ming"
        nc2.nickname = "Starming"
        f2.style = .default
        print(f2.string(from: nc2)) // Ming Dai
        f2.style = .short
        print(f2.string(from: nc2)) // Starming
        f2.style = .abbreviated
        print(f2.string(from: nc2)) // MD

        // 取出名
        let componets = f2.personNameComponents(from: "戴铭")
        print(componets?.givenName ?? "") // 铭

        // 数字
        let f3 = NumberFormatter()
        f3.locale = Locale(identifier: "zh_Hans_CN")
        f3.numberStyle = .currency
        print(f3.string(from: 123456) ?? "") // ¥123,456.00
        f3.numberStyle = .percent
        print(f3.string(from: 123456) ?? "") // 12,345,600%

        let n1 = 1.23456
        let n1Str = n1.formatted(.number.precision(.fractionLength(3)).rounded())
        print(n1Str) // 1.235

        // 地址
        let f4 = CNPostalAddressFormatter()
        let address = CNMutablePostalAddress()
        address.street = "海淀区王庄路27号院4号楼4门301"
        address.postalCode = "100083"
        address.city = "北京"
        address.country = "中国"
        print(f4.string(from: address))
        /// 海淀区王庄路27号院4号楼4门301
        /// 北京 100083
        /// 中国
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
