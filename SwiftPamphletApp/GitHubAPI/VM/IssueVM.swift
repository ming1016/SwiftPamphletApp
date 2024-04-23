//
//  IssueVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/15.
//

import Foundation
import Combine
import SMFile

@Observable
final class IssueVM {
    @ObservationIgnored
    public let guideName: String
    var customIssues: [CustomIssuesModel]

    // MARK: - APISev

    enum IssueActionType {
        case customIssues
    }
    typealias ActionType = IssueActionType // 可在定义doing函数时，通过参数类型指定，类型推导出来
    func doing(_ somethinglike: IssueActionType) {
        switch somethinglike {
        case .customIssues: // 内容
            customIssues = SMFile.loadBundleJSONFile(guideName + ".json")
        }
    }

    init(guideName: String = "") {
        self.customIssues = [CustomIssuesModel]()
        self.guideName = guideName
    }
}
