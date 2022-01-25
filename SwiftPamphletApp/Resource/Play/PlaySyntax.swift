//
//  PlaySyntax.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/17.
//

import Foundation

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
    }

}
