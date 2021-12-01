//
//  SwiftPamphletAppConfig.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/17.
//

import Foundation

struct SPC {
    static let gitHubAccessToken = "" // 在这里写上 Github 的access token。在 https://github.com/settings/tokens 申请你的access token。
    static let gitHubAccessTokenJudge = true
    static let detailMinWidth: CGFloat = 500
    static let githubHost = "https://github.com/"
    static let pamphletIssueRepoName = "ming1016/SwiftPamphletApp"
    
    static let timerForReposSec: Double = 60
    static let timerForDevsSec: Double = 70
    
    static func loadCustomIssues(jsonFileName: String) -> [CustomIssuesModel] {
        let lc: [CustomIssuesModel] = loadBundleJSONFile(jsonFileName + ".json")
        return lc
    }
    
    static func activeDevelopers() -> [SPActiveDevelopersModel] {
        let ad: [SPActiveDevelopersModel] = loadBundleJSONFile("developers.json")
        return ad
    }
    
    static func goodRepos() -> [SPGoodReposModel] {
        let re: [SPGoodReposModel] = loadBundleJSONFile("goodrepos.json")
        return re
    }
    
}

struct SPActiveDevelopersModel: Jsonable {
    var id: Int64
    var name: String
    var users: [ADeveloperModel]
}

struct ADeveloperModel: Jsonable {
    var id: String
    var des: String?
}

struct SPGoodReposModel: Jsonable {
    var id: Int64
    var name: String
    var repos: [ARepoModel]
}

struct ARepoModel: Jsonable {
    var id: String
    var des: String?
}
