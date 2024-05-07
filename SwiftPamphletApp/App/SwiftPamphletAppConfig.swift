//
//  SwiftPamphletAppConfig.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/17.
//

import Foundation
import SMFile

struct SPC {
    static let gitHubAccessToken = "" // 在这里可以手动写上 Github 的 access token。在 https://github.com/settings/tokens 申请你的access token。
    static let githubUDTokenKey = "udtoken" // UserDefault 存储 token 的 key
    static func githubAccessToken() -> String {
        let ud = UserDefaults.standard
        return ud.string(forKey: SPC.githubUDTokenKey) ?? ""
    }
    
    static let detailMinWidth: CGFloat = 550
    static let githubHost = "https://github.com/"
    
    // MARK: AppStorage
    static let isShowGithub = "isShowGithub"
    static let selectedDataLinkString = "selectedDataLinkString"
    static let isFirstRun = "isFirstRun"
    static let customSearchTerm = "customSearchTerm"
    static let isShowInspector = "isShowInspector"
    static let isShowPamphletInspector = "isShowPamphletInspector"
    static let inspectorType = "inspectorType"

//    static func loadCustomIssues(jsonFileName: String) -> [CustomIssuesModel] {
//        let lc: [CustomIssuesModel] = SMFile.loadBundleJSONFile(jsonFileName + ".json")
//        return lc
//    }
    
    static func rssStyle() -> String {
        let data = SMFile.loadBundleData("css_cn.html")
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    static func rssFooterJS() -> String {
        let data = SMFile.loadBundleData("footer_js.html")
        return String(data: data, encoding: .utf8) ?? ""
    }
}

