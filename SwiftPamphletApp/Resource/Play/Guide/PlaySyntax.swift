//
//  PlaySyntax.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/17.
//

import Foundation
import SwiftUI

extension URLSession {
    func dataTaskWithResult(
        with url: URL,
        handler: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: url) { data, _, err in
            if let err = err {
                handler(.failure(err))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}

extension Array where Element == Int {
    // 升序
    func intSortedASC() -> [Int] {
        return self.sorted(by: <)
    }
    // 降序
    func intSortedDESC() -> [Int] {
        return self.sorted(by: <)
    }
}

protocol pc {
    associatedtype T
    mutating func add(_ p: T)
}

class PlaySyntax {
    
    // MARK: - Hashable
    static func hashable() {
        struct H: Hashable {
            var p1: String
            var p2: Int
            
            // 提供随机 seed
            func hash(into hasher: inout Hasher) {
                hasher.combine(p1)
            }
        }
        
        let h1 = H(p1: "one", p2: 1)
        let h2 = H(p1: "two", p2: 2)
        
        var hs1 = Hasher()
        hs1.combine(h1)
        hs1.combine(h2)
        print(h1.hashValue) // 7417088153212460033 随机值
        print(h2.hashValue) // -6972912482785541972 随机值
        print(hs1.finalize()) // 7955861102637572758 随机值
        print(h1.hashValue) // 7417088153212460033 和前面 h1 一样
        
        let h3 = H(p1: "one", p2: 1)
        print(h3.hashValue) // 7417088153212460033 和前面 h1 一样
        var hs2 = Hasher()
        hs2.combine(h3)
        hs2.combine(h2)
        print(hs2.finalize()) // 7955861102637572758 和前面 hs1 一样
    }
    
    // MARK: - @resultBuilder
    static func resultBuilder() {
        
        @resultBuilder
        struct RBS {
            // 基本闭包支持
            static func buildBlock(_ components: Int...) -> Int {
                components.reduce(0) { partialResult, i in
                    partialResult + i
                }
            }
            // 支持条件判断
            static func buildEither(first component: Int) -> Int {
                component
            }
            static func buildEither(second component: Int) -> Int {
                component
            }
            // 支持循环
            static func buildArray(_ components: [Int]) -> Int {
                components.reduce(0) { partialResult, i in
                    partialResult + i
                }
            }
        }
        
        let a = RBS.buildBlock(
            1,
            2,
            3
        )
        print(a) // 6
        
        // 应用到函数中
        @RBS func f1() -> Int {
            1
            2
            3
        }
        print(f1()) // 6
        
        // 设置了 buildEither 就可以在闭包中进行条件判断。
        @RBS func f2(stopAtThree: Bool) -> Int {
            1
            2
            3
            if stopAtThree == true {
                0
            } else {
                4
                5
                6
            }
        }
        print(f2(stopAtThree: false)) // 21
        
        // 设置了 buildArray 就可以在闭包内使用循环了
        @RBS func f3() -> Int {
            for i in 1...3 {
                i * 2
            }
        }
        print(f3()) // 12
        
    }
    
    // MARK: - @dynamicCallable 动态可调用类型
    static func dynamicCallable() {
        @dynamicCallable
        struct D {
            // 带参数说明
            func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Int {
                let firstArg = args.first?.value ?? 0
                return firstArg * 2
            }
            
            // 无参数说明
            func dynamicallyCall(withArguments args: [String]) -> String {
                var firstArg = ""
                if args.count > 0 {
                    firstArg = args[0]
                }
                return "show \(firstArg)"
            }
        }
        
        let d = D()
        let i = d(numberIs: 2)
        print(i) // 4
        let s = d("hi")
        print(s) // show hi
    }
    
    // MARK: - @dynamicMemberLookup 动态成员查询
    static func dynamicMemberLookup() {
        @dynamicMemberLookup
        struct D {
            // 找字符串
            subscript(dynamicMember m: String) -> String {
                let p = ["one": "first", "two": "second"]
                return p[m, default: ""]
            }
            // 找整型
            subscript(dynamicMember m: String) -> Int {
                let p = ["one": 1, "two": 2]
                return p[m, default: 0]
            }
            // 找闭包
            subscript(dynamicMember m: String) -> (_ s: String) -> Void {
                return {
                    print("show \($0)")
                }
            }
            // 静态数组成员
            var p = ["This is a member"]
            // 动态数组成员
            subscript(dynamicMember m: String) -> [String] {
                return ["This is a dynamic member"]
            }
        }
        
        let d = D()
        let s1: String = d.one
        print(s1) // first
        let i1: Int = d.one
        print(i1) // 1
        d.show("something") // show something
        print(d.p) // ["This is a member"]
        let dynamicP:[String] = d.dp
        print(dynamicP) // ["This is a dynamic member"]
        
    }
    
    // MARK: - 函数
    static func function() {
        func f1(p: String = "p") -> String {
            "p is \(p)"
        }

        // 函数作为参数
        func f2(fn: (String) -> String, p: String) -> String {
            return fn(p)
        }

        print(f2(fn:f1, p: "d")) // p is d

        // 函数作为返回值
        func f3(p: String) -> (String) -> String {
            return f1
        }

        print(f3(p: "yes")("no")) // p is no
        
        // 函数中的多个变量参数
        func f4(s: String..., i: Int...) {
            print(s)
            print(i)
        }
        
        f4(s: "one", "two", "three", i: 1, 2, 3)
        /// ["one", "two", "three"]
        /// [1, 2, 3]
        
        // 嵌套函数可以重载，嵌套函数可以在声明函数之前调用他。
        func f5() {
            nf5()
            func nf5() {
                print("this is nested function")
            }
        }
        f5() // this is nested function
    }
    
    // MARK: - 方法
    
    static func method() {
        enum E: String {
            case one, two, three
            func showRawValue() {
                print(rawValue)
            }
        }

        let e = E.three
        e.showRawValue() // three

        // 可变的实例方法，使用 mutating 标记
        struct S1 {
            var p: String
            mutating func addFullStopForP() {
                p += "."
            }
        }
        var s = S1(p: "hi")
        s.addFullStopForP()
        print(s.p)

        // 类方法
        class C {
            class func cf() {
                print("类方法")
            }
        }
        
        // 静态下标
        struct S2 {
            static var sp = [String: Int]()
            
            static subscript(_ s: String, d: Int = 10) -> Int {
                get {
                    return sp[s] ?? d
                }
                set {
                    sp[s] = newValue
                }
            }
        }
        
        S2["key1"] = 1
        S2["key2"] = 2
        print(S2["key2"]) // 2
        print(S2["key3"]) // 10
        
        // callAsFunction()
        struct S3 {
            var p1: String
            
            func callAsFunction() -> String {
                return "show \(p1)"
            }
        }
        let s2 = S3(p1: "hi")
        print(s2()) // show hi
    }
    
    // MARK: - 属性
    static func property() {
        struct S {
            static let sp = "类型属性" // 类型属性通过类型本身访问，非实例访问
            var p1: String = ""
            var p2: Int = 1
            // cp 是计算属性
            var cp: Int {
                get {
                    return p2 * 2
                }
                set {
                    p2 = newValue + 2
                }
            }
            // 只有 getter 的是只读计算属性
            var rcp: Int {
                p2 * 4
            }
        }
        
        print(S.sp)
        print(S().cp) // 2
        var s = S()
        s.cp = 3
        print(s.p2) // 5
        print(S().rcp) // 4
        
        // 键路径表达式作为函数
        struct S2 {
            let p1: String
            let p2: Int
        }
        
        let s2 = S2(p1: "one", p2: 1)
        let s3 = S2(p1: "two", p2: 2)
        let a1 = [s2, s3]
        let a2 = a1.map(\.p1)
        print(a2) // ["one", "two"]
        
    }

    // MARK: - 泛型
    static func generics() {
        func fn<T>(p: T) -> [T] {
            var r = [T]()
            r.append(p)
            return r
        }

        print(fn(p: "one"))

        // 结构体
        struct S1<T> {
            var arr = [T]()

            mutating func add(_ p: T) {
                arr.append(p)
            }
        }

        var s1 = S1(arr: ["zero"])
        s1.add("one")
        s1.add("two")
        print(s1.arr) // ["zero", "one", "two"]

        struct S2: pc {
            typealias T = String // 类型推导，可省略
            var strs = [String]()
            mutating func add(_ p: String) {
                strs.append(p)
            }
        }

        // 泛型适用于嵌套类型
        struct S3<T> {
            struct S4 {
                var p: T
            }

            var p1: T
            var p2: S4
        }

        let s2 = S3(p1: 1, p2: S3.S4(p: 3))
        let s3 = S3(p1: "one", p2: S3.S4(p: "three"))
        print(s2,s3)

    }

    // MARK: - Result
    static func result() {

        let url = URL(string: "https://ming1016.github.io/")!

        // 以前网络请求
        let t1 = URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let err = error {
                print(err)
            } else if let data = data {
                print(String(decoding: data, as: UTF8.self))
            }
        }
        t1.resume()

        // 使用 Result 网络请求
        let t2 = URLSession.shared.dataTaskWithResult(with: url) { result in
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
            case .failure(let err):
                print(err)
            }
        }
        t2.resume()
    }

    // MARK: - 数组
    static func array() {
        var a0: [Int] = [1, 10]
        a0.append(2)
        a0.remove(at: 0)
        print(a0) // [10, 2]

        let a1 = ["one", "two", "three"]
        let a2 = ["three", "four"]

        // 找两个集合的不同
        let dif = a1.difference(from: a2) // swift的 diffing 算法在这 http://www.xmailserver.org/diff2.pdf swift实现在  swift/stdlib/public/core/Diffing.swift
        for c in dif {
            switch c {
            case .remove(let o, let e, let a):
                print("offset:\(o), element:\(e), associatedWith:\(String(describing: a))")
            case .insert(let o, let e, let a):
                print("offset:\(o), element:\(e), associatedWith:\(String(describing: a))")
            }
        }
        /*
         remove offset:1, element:four, associatedWith:nil
         insert offset:0, element:one, associatedWith:nil
         insert offset:1, element:two, associatedWith:nil
         */
        let a3 = a2.applying(dif) ?? [] // 可以用于添加删除动画
        print(a3) // ["one", "two", "three"]

        // 排序
        struct S1 {
            let n: Int
            var b = true
        }

        let a4 = [
            S1(n: 1),
            S1(n: 10),
            S1(n: 3),
            S1(n: 2)
        ]
        let a5 = a4.sorted { i1, i2 in
            i1.n < i2.n
        }
        for n in a5 {
            print(n)
        }
        /// S1(n: 1)
        /// S1(n: 2)
        /// S1(n: 3)
        /// S1(n: 10)

        let a6 = [1,10,4,7,2]
        print(a6.sorted(by: >)) // [10, 7, 4, 2, 1]

        print(a6.intSortedASC()) // 使用扩展增加自定义排序能力

        // 第一个满足条件了就返回
        let a7 = a4.first {
            $0.n == 10
        }
        print(a7?.n ?? 0)

        // 是否都满足了条件
        print(a4.allSatisfy { $0.n == 1 }) // false
        print(a4.allSatisfy(\.b)) // true

        // 找出最大的那个
        print(a4.max(by: { e1, e2 in
            e1.n < e2.n
        }) ?? S1(n: 0))
        // S1(n: 10, b: true)

        // 看看是否包含某个元素
        print(a4.contains(where: {
            $0.n == 7
        }))
        // false

        // 切片
        // 取前3个，并不是直接复制，对于大的数组有性能优势。
        print(a6[..<3]) // [1, 10, 4] 需要做越界检查
        print(a6.prefix(30)) // [1, 10, 4, 7, 2] 不需要做越界检查，也是切片，性能一样

        // 去掉前3个
        print(a6.dropFirst(3)) // [7, 2]

        // prefix(while:) 和 drop(while:) 方法，顺序遍历执行闭包里的逻辑判断，满足条件就返回，遇到不匹配就会停止遍历。prefix 返回满足条件的元素集合，drop 返回停止遍历之后那些元素集合。
        let a8 = [8, 9, 20, 1, 35, 3]
        let a9 = a8.prefix {
            $0 < 30
        }
        print(a9) // [8, 9, 20, 1]
        let a10 = a8.drop {
            $0 < 30
        }
        print(a10) // [35, 3]
        
        // 删除所有不满足条件的元素
        var a11 = [1, 3, 5, 12, 25]
        a11.removeAll { $0 < 10 } // 比 filter 更高效
        print(a11) // [12, 25]
        
        // 创建未初始化的数组
        let a12 = (0...4).map { _ in
            Int.random(in: 0...5)
        }
        print(a12) // [0, 3, 3, 2, 5] 随机
        
        // #if 用于后缀表达式
        let a13 = a11
        #if os(iOS)
            .count
        #else
            .reduce(0, +)
        #endif
        print(a13) //37
    }

    // MARK: - Set
    static func set() {
        let s0: Set<Int> = [2, 4]
        let s1: Set = [2, 10, 6, 4, 8]
        let s2: Set = [7, 3, 5, 1, 9, 10]

        let s3 = s1.union(s2) // 合集
        let s4 = s1.intersection(s2) // 交集
        let s5 = s1.subtracting(s2) // 非交集部分
        let s6 = s1.symmetricDifference(s2) // 非交集的合集
        print(s3) // [4, 2, 1, 7, 3, 10, 8, 9, 6, 5]
        print(s4) // [10]
        print(s5) // [8, 4, 2, 6]
        print(s6) // [9, 1, 3, 4, 5, 2, 6, 8, 7]

        // s0 是否被 s1 包含
        print(s0.isSubset(of: s1)) // true
        // s1 是否包含了 s0
        print(s1.isSuperset(of: s0)) // true

        let s7: Set = [3, 5]
        // s0 和 s7 是否有交集
        print(s0.isDisjoint(with: s7)) // true

        // 可变 Set
        var s8: Set = ["one", "two"]
        s8.insert("three")
        s8.remove("one")
        print(s8) // ["two", "three"]
    }

    // MARK: - 字典
    static func dictionary() {
        var d1 = [
            "k1": "v1",
            "k2": "v2"
        ]
        d1["k3"] = "v3"
        d1["k4"] = nil

        print(d1) // ["k2": "v2", "k3": "v3", "k1": "v1"]

        for (k, v) in d1 {
            print("key is \(k), value is \(v)")
        }
        /*
         key is k1, value is v1
         key is k2, value is v2
         key is k3, value is v3
         */

        if d1.isEmpty == false {
            print(d1.count) // 3
        }

        // mapValues
        let d2 = d1.mapValues {
            $0 + "_new"
        }
        print(d2) // ["k2": "v2_new", "k3": "v3_new", "k1": "v1_new"]

        // 对字典的值或键进行分组
        let d3 = Dictionary(grouping: d1.values) {
            $0.count
        }
        print(d3) // [2: ["v1", "v2", "v3"]]

        // 从字典中取值，如果键对应无值，则使用通过 default 指定的默认值
        d1["k5", default: "whatever"] += "."
        print(d1["k5"] ?? "") // whatever.
        let v1 = d1["k3", default: "whatever"]
        print(v1) // v3
        
        // compactMapValues() 对字典值进行转换和解包。可以解可选类型，并去掉 nil 值
        let d4 = [
            "k1": 1,
            "k2": 2,
            "k3": nil
        ]
        let d5 = d4.mapValues { $0 }
        let d6 = d4.compactMapValues{ $0 }
        print(d5)
        // ["k3": nil, "k1": Optional(1), "k2": Optional(2)]
        print(d6)
        // ["k1": 1, "k2": 2]
    }

    // MARK: - 字符串
    static func string() {
        let s1 = "Hi! This is a string. Cool?"

        /// 转义符 \n 表示换行。
        /// 其它转义字符有 \0 空字符)、\t 水平制表符 、\n 换行符、\r 回车符
        let s2 = "Hi!\nThis is a string. Cool?"

        _ = s1 + s2

        // 多行
        let s3 = """
        Hi!
        This is a string.
        Cool?
        """

        // 长度
        print(s3.count)
        print(s3.isEmpty)

        // 拼接
        print(s3 + "\nSure!")

        // 字符串中插入变量
        let i = 1
        print("Today is good day, double \(i)\(i)!")

        /// 遍历字符串
        /// 输出：
        /// o
        /// n
        /// e
        for c in "one" {
            print(c)
        }

        // 查找
        print(s3.lowercased().contains("cool")) // true

        // 替换
        let s4 = "one is two"
        let newS4 = s4.replacingOccurrences(of: "two", with: "one")
        print(newS4)

        // 删除空格和换行
        let s5 = " Simple line. \n\n  "
        print(s5.trimmingCharacters(in: .whitespacesAndNewlines))

        // 切割成数组
        let s6 = "one/two/three"
        let a1 = s6.components(separatedBy: "/") // 继承自 NSString 的接口
        print(a1) // ["one", "two", "three"]

        let a2 = s6.split(separator: "/")
        print(a2) // ["one", "two", "three"] 属于切片，性能较 components 更好

        // 判断是否是某种类型
        let c1: Character = "🤔"
        print(c1.isASCII) // false
        print(c1.isSymbol) // true
        print(c1.isLetter) // false
        print(c1.isNumber) // false
        print(c1.isUppercase) // false

        // 字符串和 Data 互转
        let data = Data("hi".utf8)
        let s7 = String(decoding: data, as: UTF8.self)
        print(s7) // hi

        // 字符串可以当作集合来用。
        let revered = s7.reversed()
        print(String(revered))
        
        // 原始字符串
        let s8 = #"\(s7)\#(s7) "one" and "two"\n. \#nThe second line."#
        print(s8)
        /// \(s7)hi "one" and "two"\n.
        /// The second line.
        
        // 原始字符串在正则使用效果更佳，反斜杠更少了。
        let s9 = "\\\\[A-Z]+[A-Za-z]+\\.[a-z]+"
        let s10 = #"\\[A-Z]+[A-Za-z]+\.[a-z]+"#
        print(s9) // \\[A-Z]+[A-Za-z]+\.[a-z]+
        print(s10) // \\[A-Z]+[A-Za-z]+\.[a-z]+
    } // end func string
    
    // MARK: - 数字
    static func number() {
        // Int
        let i1 = 100
        let i2 = 22
        print(i1 / i2) // 向下取整得 4

        // Float
        let f1: Float = 100.0
        let f2: Float = 22.0
        print(f1 / f2) // 4.5454545
        
//        let f3: Float16 = 5.0 // macOS 还不能用
        let f4: Float32 = 5.0
        let f5: Float64 = 5.0
//        let f6: Float80 = 5.0
        print(f4, f5) // 5.0 5.0 5.0

        // Double
        let d1: Double = 100.0
        let d2: Double = 22.0
        print(d1 / d2) // 4.545454545454546

        // 字面量
        print(Int(0b10101)) // 0b 开头是二进制
        print(Int(0x00afff)) // 0x 开头是十六进制
        print(2.5e4) // 2.5x10^4 十进制用 e
        print(0xAp2) // 10*2^2  十六进制用 p
        print(2_000_000) // 2000000
        
        // isMultiple(of:) 方法检查一个数字是否是另一个数字的倍数
        let i3 = 36
        print(i3.isMultiple(of: 9)) // true
    }

    // MARK: - 枚举
    static func `enum`() {
        enum E1:String, CaseIterable {
            case e1, e2 = "12"
        }

        // 关联值
        enum E2 {
            case e1([String])
            case e2(Int)
        }
        let e1 = E2.e1(["one","two"])
        let e2 = E2.e2(3)

        switch e1 {
        case .e1(let array):
            print(array)
        case .e2(let int):
            print(int)
        }
        print(e2)

        // 原始值
        print(E1.e1.rawValue)

        // 遵循 CaseIterable 协议可迭代
        for ie in E1.allCases {
            print("show \(ie)")
        }

        // 递归枚举
        enum RE {
            case v(String)
            indirect case node(l:RE, r:RE)
        }

        let lNode = RE.v("left")
        let rNode = RE.v("right")
        let pNode = RE.node(l: lNode, r: rNode)

        switch pNode {
        case .v(let string):
            print(string)
        case .node(let l, let r):
            print(l,r)
            switch l {
            case .v(let string):
                print(string)
            case .node(let l, let r):
                print(l, r)
            }
            switch r {
            case .v(let string):
                print(string)
            case .node(let l, let r):
                print(l, r)
            }
        }
        
        // @unknown
        enum E3 {
            case e1, e2, e3
        }
        
        func fe1(e: E3) {
            switch e {
            case .e1:
                print("e1 ok")
            case .e2:
                print("e2 ok")
            case .e3:
                print("e3 ok")
            @unknown default:
                print("not ok")
            }
        }
        
        // Comparable 枚举比较
        enum E4: Comparable {
            case e1, e2
            case e3(i: Int)
            case e4
        }
        let e3 = E4.e4
        let e4 = E4.e3(i: 3)
        let e5 = E4.e3(i: 2)
        let e6 = E4.e1
        print(e3 > e4) // true
        let a1 = [e3, e4, e5, e6]
        let a2 = a1.sorted()
        for i in a2 {
            print(i.self)
        }
        /// e1
        /// e3(i: 2)
        /// e3(i: 3)
        /// e4
    }
}
