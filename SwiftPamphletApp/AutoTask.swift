//
//  AutoTask.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/10.
//

import Foundation

struct AutoTask {
    
    static func buildContentMarkdownFile() {
        let a1 = ["guide-syntax","guide-features","guide-subject","lib-Combine","lib-Concurrency","lib-SwiftUI"]
//        let a1 = ["lib-SwiftUI"]
        var mk = ""
        for e in a1 {
            let fc:[CustomIssuesModel] = loadBundleJSONFile(e + ".json")
            if e == "guide-syntax" {
                mk += "## 语法速查\n\n"
            }
            if e == "guide-feature" {
                mk += "## 特性\n\n"
            }
            if e == "guide-subject" {
                mk += "## 专题\n\n"
            }
            if e == "lib-Combine" {
                mk += "## Combine\n\n"
            }
            if e == "lib-Concurrency" {
                mk += "## Concurrency\n\n"
            }
            if e == "lib-SwiftUI" {
                mk += "## SwiftUI\n\n"
            }
            for e1 in fc {
                mk += "### \(e1.name)\n\n"
                for e2 in e1.issues {
                    mk += "#### \(e2.title)\n\n"
                    let str = loadBundleString(String(e2.number) + ".md")
                    mk += str + "\n\n"
                }
            }
        }
        
        // 开发者
        mk += "## 开发者\n\n"
        let devs:[SPActiveDevelopersModel] = loadBundleJSONFile("developers.json")
        for d1 in devs {
            mk += "### \(d1.name)\n\n"
            for d2 in d1.users {
                let des = d2.des ?? ""
                mk += "* [\(d2.id)](\(SPC.githubHost + d2.id))" + (des.isEmpty == true ? "" : "：\(des)") + "\n"
            }
            mk += "\n"
        }
        
        // 探索库
        mk += "## 探索库\n\n"
        let explibs:[SPReposModel] = loadBundleJSONFile("repos.json")
        for el1 in explibs {
            mk += "### \(el1.name)\n\n"
            for el2 in el1.repos {
                var more = ""
                let des = el2.des ?? ""
                if des.isEmpty == false {
                    more += des + "\n"
                }
                do {
                    if let f = try RepoStoreDataHelper.find(sFullName: el2.id) {
                        more += "Star：\(f.stargazersCount) Issue：\(f.openIssues) 开发语言：\(f.language)\n"
                        more += f.description + "\n"
                    }
                } catch {}
                mk += "*[\(el2.id)](\(SPC.githubHost + el2.id))*\n" + more + "\n"
            }
            
            mk += "\n"
        }
        
        // 博客
        mk += "## 博客和资讯\n\n"
        let bn:[RSSFeedModel] = loadBundleJSONFile("rssfeed.json")
        for r in bn {
            mk += "* [\(r.title)](\(r.siteLink))" + (r.des.isEmpty ? "" : "：\(r.des)") + "\n"
        }
        mk += "\n"
        
        // 册子动态
        mk += loadBundleString("1.md")
        
        
        
        writeToDownload(fileName: "read.md", content: mk)
    }
    
}







