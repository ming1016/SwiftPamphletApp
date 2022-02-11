//
//  CCYReq.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2021/12/20.
//

import Foundation

func RSSReq(_ urlStr: String) async throws -> String? {
    guard let url = URL(string: urlStr) else {
        fatalError("wrong url")
    }
    let req = URLRequest(url: url)
    let (data, res) = try await URLSession.shared.data(for: req)
    guard (res as? HTTPURLResponse)?.statusCode == 200 else {
        return ""
    }
    let dataStr = String(data: data, encoding: .utf8)
    return dataStr
}
