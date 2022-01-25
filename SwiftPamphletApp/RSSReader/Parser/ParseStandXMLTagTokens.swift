//
//  ParseStandXML.swift
//  SA
//
//  Created by ming on 2019/8/27.
//  Copyright © 2019 ming. All rights reserved.
//

import Foundation

public enum XMLTagTokensType {
    case tag
    case value
}

public struct XMLTagTokens {
    public let type: XMLTagTokensType
    public let tokens: [Token]
}

public class ParseStandXMLTagTokens {

    private enum State {
        case normal
        case startTag
        case cdata
    }

    private var tokens: [Token]
    private var allTagTokens: [XMLTagTokens]

    private var currentIndex: Int
    private var currentToken: Token
    private var currentState: State
    private var currentTokens: [Token]

    public init(input: String) {
        tokens = Lexer(input: input, type: .plain).allTkFast(operaters: "<>=\"/?![]")

        allTagTokens = [XMLTagTokens]() // 第一步 Token 整理按照 tag、value 类型整理

        currentIndex = 0
        currentToken = tokens[currentIndex]
        currentState = .normal
        currentTokens = [Token]()
    }

    // 解析 driver
    public func parse() -> [XMLTagTokens] {
        parseNext()
        while currentToken != .eof {
            parseNext()
        }
        return allTagTokens
    }

    // 调试打印结果用
    static func des(allTagTokens: [XMLTagTokens]) {
        for tks in allTagTokens {
            print(tks)
            for tk in tks.tokens {
                print(tk)
            }
            print("\n")
        }
    }

    private func parseNext() {
        if currentToken == .newLine {
            advanceTk()
            return
        }
        // 处理 cdata 的情况
        if currentState == .cdata {
            if currentToken == .id("]") && peekTk() == .id("]") && peekTkStep(step: 2) == .id(">") {
                if currentTokens.count > 0 {
                    addTagTokens(type: .value) // 结束一组
                }
                currentState = .normal
                advanceTk() // jump ]
                advanceTk() // jump ]
                advanceTk() // jump >
                return
            }
            currentTokens.append(currentToken)
            advanceTk()
            return
        }

        // tag 的值 <a>value</a>
        if currentState == .normal && currentToken != .id("<") {
            currentTokens.append(currentToken)
            advanceTk()
            return
        }

        // <tagname ...> 和 <![CDATA[
        if currentState == .normal && currentToken == .id("<") {
            // <![CDATA[
            if peekTk() == .id("!") && peekTkStep(step: 2) == .id("[") && peekTkStep(step: 3) == .id("CDATA") && peekTkStep(step: 4) == .id("[") {
                currentState = .cdata
                advanceTk() // jump <
                advanceTk() // jump !
                advanceTk() // jump [
                advanceTk() // jump CDATA
                advanceTk() // jump [
                return
            }

            // <tagname …>
            if currentTokens.count > 0 {
                addTagTokens(type: .value) // 结束一组
            }
            currentState = .startTag
            advanceTk()
            return
        }

        if currentState == .startTag && currentToken != .id(">") {
            currentTokens.append(currentToken)
            advanceTk()
            return
        }

        // <tagname ...>
        if currentState == .startTag && currentToken == .id(">") {
            currentState = .normal
            addTagTokens(type: .tag) // 结束一组
            advanceTk()
            return
        }
    }

    private func addTagTokens(type: XMLTagTokensType) {
        var isValid = false
        for tk in currentTokens {
            if tk == .space {

            } else {
                isValid = true
            }
        }
        if isValid {
            allTagTokens.append(XMLTagTokens(type: type, tokens: currentTokens))
        }

        currentTokens = [Token]()
    }

    // MARK: 辅助
    private func peekTk() -> Token? {
        return peekTkStep(step: 1)
    }

    private func peekTkStep(step: Int) -> Token? {
        let peekIndex = currentIndex + step
        guard peekIndex < tokens.count else {
            return nil
        }
        return tokens[peekIndex]
    }

    private func advanceTk() {
        currentIndex += 1
        guard currentIndex < tokens.count else {
            return
        }
        currentToken = tokens[currentIndex]
    }

}
