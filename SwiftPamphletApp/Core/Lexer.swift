//
//  Lexer.swift
//  SA
//
//  Created by ming on 2019/8/2.
//  Copyright © 2019 ming. All rights reserved.
//

import Foundation

public enum LexerType {
    case code
    case plain
}

public class Lexer {

    private let text: String
    private var currentIndex: Int
    private var currentCharacter: Character?
    private var type: LexerType

    public init(input: String, type: LexerType) {
        if input.count == 0 {
            // fatalError("Error! input can't be empty")
            text = "0"
        } else {
            text = input
        }
        currentIndex = 0
        currentCharacter = text[text.startIndex]
        self.type = type

    }

    public func allTkFastWithoutNewLineAndWhitespace(operaters:String) -> [Token] {
        let allToken = allTkFast(operaters: operaters)
        let flAllToken = allToken.filter {
            $0 != .newLine
        }
        let fwAllToken = flAllToken.filter {
            $0 != .space
        }
        return fwAllToken
    }

    public func allTkFast(operaters:String) -> [Token] {
        var nText = text.replacingOccurrences(of: " ", with: " starmingspace ")
        nText = nText.replacingOccurrences(of: "\n", with: " starmingnewline ")
        let scanner = Scanner(string: nText)
        var tks = [Token]()
        var set = CharacterSet()
        set.insert(charactersIn: operaters)
        set.formUnion(CharacterSet.whitespacesAndNewlines)

        while !scanner.isAtEnd {
            for operater in operaters {
                let opStr = operater.description
                if (scanner.scanString(opStr) != nil) {
                    tks.append(.id(opStr))
                }
            }

            if let result = scanner.scanUpToCharacters(from: set) {
                let resultString = result as String
                if resultString == "starmingnewline" {
                    tks.append(.newLine)
                } else if resultString == "starmingspace" {
                    tks.append(.space)
                } else {
                    tks.append(.id(result as String))
                }
            }
        }
        tks.append(.eof)
        return tks
    }

    // 返回所有 Token
    public func allTk() -> [Token] {
        var tk = nextTk()
        var all = [tk]
        while tk != .eof {
            tk = self.nextTk()
            all.append(tk)
        }
        return all
    }

    // 流程
    private func nextTk() -> Token {
        // 检查是否到达文件末
        if isEof() {
            return .eof
        }

        if CharacterSet.whitespaces.contains((currentCharacter?.unicodeScalars.first!)!) {
            skipWhiteSpace()
        }

        // 检查是否到达文件末
        if isEof() {
            return .eof
        }

        // 换行
        if CharacterSet.newlines.contains((currentCharacter?.unicodeScalars.first!)!) {
            advance()
            return .newLine
        }

        // 数字
        if CharacterSet.decimalDigits.contains((currentCharacter?.unicodeScalars.first!)!) {
            let n = number()
            print(n.des())
            return n
        }

        // 字符
        if CharacterSet.alphanumerics.contains((currentCharacter?.unicodeScalars.first!)!) {
            return id()
        }

        // 代码分析
        if type == .code {

            // 双引号内字符串
            if currentCharacter == "\"" {
                return doubleQuotationMarksString()
            }

            // 处理注释
            if currentCharacter == "/" {
                // 双引号注释
                if peek() == "/" {
                    advance()
                    advance()
                    return commentsFromDoubleSlash()
                } else if peek() == "*" {
                    advance()
                    advance()
                    return commentsFromSlashAsterisk()
                }
            }
        }

        // 其余当作符号处理
        guard let cStr = currentCharacter else {
            return .eof
        }
        advance()
        return .id(String(cStr))

        // 需要处理严格规则的时候会走下面条件
//        advance()
//        return .eof
    }

    // 对字符的处理
    private func id() -> Token {
        var idStr = ""
        while let character = currentCharacter, CharacterSet.alphanumerics.contains(character.unicodeScalars.first!) {
            idStr += String(character)
            advance()
        }
        return .id(idStr)
    }

    // 对数字的处理
    private func number() -> Token {
        var numStr = ""
        while let character = currentCharacter,CharacterSet.decimalDigits.contains(character.unicodeScalars.first!) {
                numStr += String(character)
                advance()
        }

        if let character = currentCharacter, character == ".", peek() != "." {
            numStr += "."
            advance()
            while let character = currentCharacter, CharacterSet.decimalDigits.contains(character.unicodeScalars.first!) {
                numStr += String(character)
                advance()
            }
            return .constant(.float(Float(numStr)!))
        }
        return .constant(.integer(Int(numStr)!))
    }

    // MARK: 辅助函数
    private func advance() {
        currentIndex += 1
        guard currentIndex < text.count else {
            currentCharacter = nil
            return
        }
        currentCharacter = text[text.index(text.startIndex, offsetBy: currentIndex)]
    }

    // 往前探一个字符
    private func peek() -> String? {
        return peekStep(step: 1)
    }
    private func peekStep(step:Int) -> String? {
        var reStr = ""
        for index in 1..<step+1 {
            let peekIndex = currentIndex + index
            guard peekIndex < text.count else {
                return nil
            }
            reStr.append(text[text.index(text.startIndex, offsetBy: peekIndex)])
        }
        return reStr
    }

    // 取 // 这种注释
    private func commentsFromDoubleSlash() -> Token {
        var cStr = ""
        while let character = currentCharacter, !CharacterSet.newlines.contains(character.unicodeScalars.first!) {
            advance()
            cStr += String(character)
        }
        return .comments(cStr)
    }

    // 取 /* */ 这样的注释
    private func commentsFromSlashAsterisk() -> Token {
        var cStr = ""
        while let character = currentCharacter {
            if character == "*" && peek() == "/" {
                advance()
                advance()
                break
            } else {
                advance()
                cStr += String(character)
            }

        }
        return .comments(cStr)
    }

    // 双引号内字符串
    private func doubleQuotationMarksString() -> Token {
        advance()
        var cStr = ""
        while let character = currentCharacter {
            if character == "\\" && peek() == "\"" {
                advance()
                advance()
                cStr += String("\"")
            } else if character == "\"" {
                advance()
                break
            } else {
                advance()
                cStr += String(character)
            }
        }
        return .string(cStr)
    }

    // 跳过空格
    private func skipWhiteSpace() {
        while let character = currentCharacter, CharacterSet.whitespacesAndNewlines.contains(character.unicodeScalars.first!) {
            advance()
        }
    }

    private func isEof() -> Bool {
        if currentIndex > self.text.count - 1 {
            return true
        }
        return false
    }

}
