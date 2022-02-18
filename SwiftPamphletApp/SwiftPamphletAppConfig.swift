//
//  SwiftPamphletAppConfig.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/17.
//

import Foundation

struct SPC {
    static let gitHubAccessToken = "" // 在这里写上 Github 的access token。在 https://github.com/settings/tokens 申请你的access token。
    static let detailMinWidth: CGFloat = 550
    static let githubHost = "https://github.com/"
    static let pamphletIssueRepoName = "KwaiAppTeam/SwiftPamphletApp"

    static let timerForDevsSec: Double = 160
    static let timerForExpSec: Double = 125
    static let timerForRssSec: Double = 60 * 60

    static let unreadMagicNumber = 99999

    static func loadCustomIssues(jsonFileName: String) -> [CustomIssuesModel] {
        let lc: [CustomIssuesModel] = loadBundleJSONFile(jsonFileName + ".json")
        return lc
    }

    static func activeDevelopers() -> [SPActiveDevelopersModel] {
        let ad: [SPActiveDevelopersModel] = loadBundleJSONFile("developers.json")
        return ad
    }

    static func repos() -> [SPReposModel] {
        let re: [SPReposModel] = loadBundleJSONFile("repos.json")
        return re
    }

    static func rssFeed() -> [RSSFeedModel] {
        let re: [RSSFeedModel] = loadBundleJSONFile("rssfeed.json")
        return re
    }

    static func rssStyle() -> String {
        let data = loadBundleData("css_cn.html")
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    static func rssFooterJS() -> String {
        let data = loadBundleData("footer_js.html")
        return String(data: data, encoding: .utf8) ?? ""
    }

    static func outputRepo() {
        let re = repos()
        for r in re {
            print("#### \(r.name)")
            for ar in r.repos {
                let arr = ar.id.components(separatedBy: "/")
                print("* \(arr[1])：\(ar.des ?? "") (https://github.com/\(ar.id))")
            }
        }
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

struct SPReposModel: Jsonable {
    var id: Int64
    var name: String
    var repos: [ARepoModel]
}

struct ARepoModel: Jsonable {
    var id: String
    var des: String?
}

struct RSSFeedModel: Jsonable {
    var id: Int64
    var title: String
    var des: String
    var siteLink: String
    var feedLink: String
}
