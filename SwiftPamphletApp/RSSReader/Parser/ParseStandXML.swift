//
//  ParseStandXML.swift
//  SA
//
//  Created by ming on 2019/8/28.
//  Copyright © 2019 ming. All rights reserved.
//

import Foundation

public struct XMLNode {
    public let name: String
    public let attributes: [XMLTagAttribute]
    public var value: String
    public var subNodes: [XMLNode]
}

public class ParseStandXML {

    private var tagNodes: [XMLTagNode]
    private var nodeTree: XMLNode

    enum state {
        case normal
        case start
        case value
        case end
    }

    public init(input: String) {
        tagNodes = ParseStandXMLTags(input: input).parse()
        // ParseStandXMLTags.des(tagNodes: tagNodes)
        nodeTree = XMLNode(name: "root", attributes: [XMLTagAttribute](), value: "", subNodes: [XMLNode]())

    }

    public func parse() -> XMLNode {
        nodeTree = recusiveParseTagNodes(parentNode: XMLNode(name: "root", attributes: [XMLTagAttribute](), value: "", subNodes: [XMLNode]()), tagNodes: tagNodes)
        return nodeTree
    } // end func

    public func recusiveParseTagNodes(parentNode: XMLNode, tagNodes: [XMLTagNode]) -> XMLNode {
        var pNode = parentNode
        var currentState:state = .normal
        var tagNodeArrs = [[XMLTagNode]]() // 一级 array 记录一组
        var currentTagNodeArr = [XMLTagNode]() // 二级 array
        var currentTagName = ""
        for node in tagNodes {
            if (node.type == .xml || node.type == .single) && currentState != .start {
                currentState = .normal
                currentTagNodeArr.append(node)
                // 添加到一级
                tagNodeArrs.append(currentTagNodeArr)
                currentTagNodeArr = [XMLTagNode]()
                continue
            }
            // 以下顺序不可变
            // 当遇到.end 类型时将一组 XMLTagNode 加到 tagNodeArrs 里。然后重置。
            if node.type == .end && node.name == currentTagName {
                currentState = .end
                currentTagNodeArr.append(node)
                // 添加到一级
                tagNodeArrs.append(currentTagNodeArr)
                // 重置
                currentTagNodeArr = [XMLTagNode]()
                currentTagName = ""
                continue
            }
            if currentState == .start {
                currentTagNodeArr.append(node)
                continue
            }
            if node.type == .start {
                currentState = .start
                currentTagNodeArr.append(node)
                currentTagName = node.name
                continue
            }

        } // end for

        for tagNodeArr in tagNodeArrs {
            if tagNodeArr.count == 1 {
                // 只有一个的情况，即 xml 和 single
                let aTagNode = tagNodeArr[0]
                pNode.subNodes.append(tagNodeToNode(tagNode: aTagNode))
            } else if tagNodeArr.count == 2 {
                // 2个的情况，就是比如 <p></p>
                let aTagNode = tagNodeArr[0] // 取 start 的信息
                pNode.subNodes.append(tagNodeToNode(tagNode: aTagNode))
            } else if tagNodeArr.count > 2 {
                // 大于2个的情况
                let startTagNode = tagNodeArr[0]
                var startNode = tagNodeToNode(tagNode: startTagNode)
                let secondTagNode = tagNodeArr[1]

                // 判断是否是 value 这种情况比如 <p>paragraph</p>
                if secondTagNode.type == .value {
                    // 有 value 的处理
                    startNode.value = secondTagNode.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    pNode.subNodes.append(startNode)
                } else {
                    // 有子标签的情况
                    // 递归得到结果
                    var newTagNodeArr = tagNodeArr
                    newTagNodeArr.remove(at: tagNodeArr.count - 1)
                    newTagNodeArr.remove(at: 0)

                    pNode.subNodes.append(recusiveParseTagNodes(parentNode: startNode, tagNodes: newTagNodeArr))
                } // end else

            } // end else if

        } // end for

        return pNode
    }

    private func tagNodeToNode(tagNode: XMLTagNode) -> XMLNode {
        return XMLNode(name: tagNode.name, attributes: tagNode.attributes, value: tagNode.value, subNodes: [XMLNode]())
    }
}
