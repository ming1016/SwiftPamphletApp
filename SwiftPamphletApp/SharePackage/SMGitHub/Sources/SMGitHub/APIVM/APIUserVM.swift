//
//  File.swift
//  
//
//  Created by Ming Dai on 2024/4/27.
//

import Foundation

@Observable
public final class APIUserVM {
    public var name: String = ""
    public var user: UserModel = UserModel()
    public var events: [EventModel] = [EventModel]()
    public var receivedEvents: [EventModel] = [EventModel]()
    
    public init(name: String) {
        self.name = name
    }
    
    public func updateAllData() async {
        await obtainUser()
        await obtainEvents()
        await obtainReceivedEvents()
    }
    
    // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
    @MainActor
    public func obtainUser() async {
        do {
            user = try await GitHubReq.shared.req("users/\(name)", type: UserModel.self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/activity/events?apiVersion=2022-11-28
    @MainActor
    public func obtainEvents() async {
        do {
            events = try await GitHubReq.shared.req("users/\(name)/events", type: [EventModel].self)
        } catch { print("问题是：\(error)") }
    }
    
    // https://docs.github.com/en/rest/activity/events?apiVersion=2022-11-28#list-events-received-by-the-authenticated-user
    @MainActor
    public func obtainReceivedEvents() async {
        do {
            receivedEvents = try await GitHubReq.shared.req("users/\(name)/received_events", type: [EventModel].self)
        } catch { print("问题是：\(error)") }
    }
    
}
