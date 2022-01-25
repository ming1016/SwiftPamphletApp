//
//  Token.swift
//  SA
//
//  Created by ming on 2019/8/5.
//  Copyright © 2019 ming. All rights reserved.
//

import Foundation

public enum Token {
    case eof
    case newLine
    case space
    case comments(String)      // 注释
    case constant(Constant)    // float、int
    case id(String)            // string
    case string(String)        // 代码中引号内字符串

    func des() -> String {
        switch self {
        case .space:
            return " "
        case let .comments(commentString):
            return commentString
        case let .constant(.float(float)):
            return "\(float)"
        case let .constant(.integer(int)):
            return "\(int)"
        case let .constant(.string(string)):
            return string
        case let .id(idString):
            return idString
        case let .string(sString):
            return sString
        default:
            return ""
        }
    }
}

extension Token: Equatable {
    public static func == (lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.eof, .eof):
            return true
        case (.newLine, .newLine):
            return true
        case (.space, .space):
            return true
        case let (.constant(left), .constant(right)):
            return left == right
        case let (.comments(left), .comments(right)):
            return left == right
        case let (.id(left), .id(right)):
            return left == right
        case let (.string(left), .string(right)):
            return left == right
        default:
            return false
        }
    }
}

public enum Constant {
    case string(String)
    case integer(Int)
    case float(Float)
    case boolean(Bool)
}

extension Constant: Equatable {
    public static func == (lhs: Constant, rhs: Constant) -> Bool {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return left == right
        case let (.string(left), .string(right)):
            return left == right
        case let (.float(left), .float(right)):
            return left == right
        case let (.boolean(left), .boolean(right)):
            return left == right
        default:
            return false
        }
    }
}
