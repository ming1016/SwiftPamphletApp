//
//  PlayArchitecture.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/1/19.
//

import Foundation

class PlayArchitecture {

    static func error() {
        enum E1: Error, LocalizedError {
            case c1
            case c2
            case c3

            var errorDescription: String? {
                switch self {
                case .c1:
                    return "不是正数"
                case .c2:
                    return "百内"
                case .c3:
                    return "千内"
                }
            }
        }

        func f1(i: Int) throws {
            guard i > 0 else {
                throw E1.c1
            }

            guard i > 100 else {
                throw E1.c2
            }

            guard i > 1000 else {
                throw E1.c3
            }
            print("对了 😜")
        }

        do {
            try f1(i: 999)
        } catch {
            print(error.localizedDescription)
        }
    }

    static func codable() {

        struct S1: Codable {
            var p1: String
            var p2: Int
        }

        do {
            // encode
            let c1 = S1(p1: "one", p2: 1)
            let encoder = JSONEncoder()
            let d1 = try encoder.encode(c1)
            let s1 = String(decoding: d1, as: UTF8.self)
            print(s1) // {"p2":1,"p1":"one"}

            // decode
            let decoder = JSONDecoder()
            let c2 = try decoder.decode(S1.self, from: d1)
            print(c2) // S1(p1: "one", p2: 1)

        } catch {}

    }

}
