//
//  APIUserVM.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/4/7.
//

import Foundation

@Observable
final class APIUserVM {
    var name: String = ""
    var user: UserModel = UserModel()
    var events: [EventModel] = [EventModel]()
    var receivedEvents: [EventModel] = [EventModel]()
    
    init(name: String) {
        self.name = name
    }
    
    func updateAllData() async {
        await obtainUser()
        await obtainEvents()
        await obtainReceivedEvents()
    }
    
    // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
    @MainActor
    func obtainUser() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("users/\(name)"))
            user = try GitHubReq.jsonDecoder().decode(UserModel.self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/activity/events?apiVersion=2022-11-28
    @MainActor
    func obtainEvents() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("users/\(name)/events"))
            events = try GitHubReq.jsonDecoder().decode([EventModel].self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/activity/events?apiVersion=2022-11-28#list-events-received-by-the-authenticated-user
    @MainActor
    func obtainReceivedEvents() async {
        do {
            let (data, _) = try await  URLSession.shared.data(for: GitHubReq.req("users/\(name)/received_events"))
            receivedEvents = try GitHubReq.jsonDecoder().decode([EventModel].self, from: data)
        } catch { print("问题是：\(error)") }
    }
    
}
