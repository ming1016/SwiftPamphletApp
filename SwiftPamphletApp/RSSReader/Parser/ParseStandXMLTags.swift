//
//  ParseStandXMLTags.swift
//  SA
//
//  Created by ming on 2019/8/28.
//  Copyright © 2019 ming. All rights reserved.
//

import Foundation

public enum XMLTagNodeType {
    case xml
    case single // 单个标签
    case start  // 开标签 <p>
    case value  // 标签的值 <p>value</p>
    case end    // 闭合的标签 </p>
}

public struct XMLTagAttribute {
    public let name: String
    public let value: String
}

public struct XMLTagNode {
    public let type: XMLTagNodeType
    public let value: String // 标签值
    public let name: String  // 标签名
    public let attributes: [XMLTagAttribute] // 标签属性
}

public class ParseStandXMLTags {

    private var allTagTokens: [XMLTagTokens]
    private var allTagNodes: [XMLTagNode]

    private enum State {
        case startTagName
        case startAttributeName
        case startAttributeValue
    }

    public init(input: String) {
        allTagTokens = ParseStandXMLTagTokens(input: input).parse()
        allTagNodes = [XMLTagNode]()
    }

    public func parse() -> [XMLTagNode] {
        for tokens in allTagTokens {
            //
            parseTokens(tokens: tokens)
        }
        return allTagNodes
    }

    static func des(tagNodes: [XMLTagNode]) {
        for tagNode in tagNodes {
            print("name:\(tagNode.name)")
            print("type:\(tagNode.type)")
            print("value:\(tagNode.value)")
            print("attribute:\(tagNode.attributes)")
            print("\n")
        }
    }

    private func parseTokens(tokens: XMLTagTokens) {
        // 处理 tag 类型
        if tokens.type == .tag {
            enum pTagState {
                case start
                case questionMark
                case xml
                case tagName
                case attributeName
                case equal
                case attributeValue
                case startForwardSlash
                case endForwardSlash
                case startDoubleQuotationMarks
                case backSlash
                case endDoubleQuotationMarks
            }
            var state:pTagState = .start
            var attributes = [XMLTagAttribute]()
            var nodeName = ""
            var nodeType:XMLTagNodeType = .xml
            var currentXMLTagAttributeName = ""
            var currentXMLTagAttributeValue = ""

            for token in tokens.tokens {
                // 处理双引号字符串内的空格
                if state != .startDoubleQuotationMarks && token == .space {
                    continue
                }

                // 正常处理
                if state == .start {
                    if token.des() == "?" {
                        state = .questionMark
                        nodeType = .xml
                    } else if token.des() == "/" {
                        state = .startForwardSlash
                        nodeType = .end
                    } else {
                        nodeName = token.des()
                        nodeType = .start
                        state = .tagName
                    }
                    continue
                }
                // /
                if state == .startForwardSlash {
                    nodeName = token.des()
                    continue
                }
                // ?
                if state == .questionMark {
                    if token.des() == "xml" {
                        state = .xml
                        nodeName = "xml"
                    }
                    continue
                }
                // xml
                if state == .xml {
                    currentXMLTagAttributeName = token.des()
                    state = .attributeName
                    continue
                }
                // <tagname
                if state == .tagName {
                    currentXMLTagAttributeName = token.des()
                    state = .attributeName
                    // 兼容单个标签情况，比如<br/>
                    if token.des() == "/" {
                        nodeType = .single
                    }
                    continue
                }
                // attributeName =
                if state == .attributeName {
                    if token.des() == "=" {
                        state = .equal
                    }
                    continue
                }
                // =
                if state == .equal {
                    if token.des() == "\"" {
                        state = .startDoubleQuotationMarks
                    }
                    continue
                }
                // "
                if state == .startDoubleQuotationMarks {
                    if token.des() == "\\" {
                        state = .backSlash
                    } else if token.des() == "\"" {
                        // 添加属性
                        state = .endDoubleQuotationMarks
                        attributes.append(XMLTagAttribute(name: currentXMLTagAttributeName, value: currentXMLTagAttributeValue))
                        currentXMLTagAttributeName = ""
                        currentXMLTagAttributeValue = ""
                    } else {
                        currentXMLTagAttributeValue.append(token.des())
                    }
                    continue
                }
                // /
                if state == .backSlash {
                    state = .startDoubleQuotationMarks
                    continue
                }
                // "
                if state == .endDoubleQuotationMarks {
                    if token.des() == "/" {
                        state = .endForwardSlash
                        nodeType = .single
                    } else if token.des() == "?" {

                    } else {
                        state = .attributeName
                        currentXMLTagAttributeName = token.des()
                    }
                    continue
                } // end if
            } // end for

            // 添加 Node
            allTagNodes.append(XMLTagNode(type: nodeType, value: "", name: nodeName, attributes: attributes))
        }

        // 处理 value 类型
        if tokens.type == .value {

            var value = ""

            for token in tokens.tokens {
                value.append(token.des())
            }
            allTagNodes.append(XMLTagNode(type: .value, value: value, name: "", attributes: [XMLTagAttribute]()))
        }

    }

}
