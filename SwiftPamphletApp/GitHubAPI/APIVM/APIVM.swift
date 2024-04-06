//
//  FetchGitHubAPI.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/6.
//

import Foundation
import SwiftUI

@Observable
final class APIRepoVM {
    var repo: RepoModel = RepoModel()
    
    @MainActor
    func repos(_ name: String) async {
        var ct = githubAPIUC()
        ct.path = "repos/\(name)"
        guard let url = ct.url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            repo = try JSONDecoder().decode(RepoModel.self, from: data)
        } catch {
            print("问题是：\(error)")
        }
    }
}

func githubAPIUC() -> URLComponents {
    var ct = URLComponents()
    ct.scheme = "https"
    ct.host = "api.github.com"
    return ct
}
