//
//  PlaySyntax.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/17.
//

import Foundation

class PlaySyntax {
    
    
    
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
        
    }
    
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
    
    static func dictionary() {
        var d = [
            "k1": "v1",
            "k2": "v2"
        ]
        d["k3"] = "v3"
        d["k4"] = nil

        print(d) // ["k2": "v2", "k3": "v3", "k1": "v1"]

        for (k, v) in d {
            print("key is \(k), value is \(v)")
        }
        /*
         key is k1, value is v1
         key is k2, value is v2
         key is k3, value is v3
         */
         
        if d.isEmpty == false {
            print(d.count) // 3
        }
    }
}

