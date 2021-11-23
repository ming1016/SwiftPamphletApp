//
//  UserVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/10.
//

import Foundation
import Combine
import AppKit

final class UserVM: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    @Published private(set) var user: UserModel
    @Published private(set) var events: [EventModel]
    @Published private(set) var receivedEvents: [EventModel]
    
    private let apiSev: APISev
    
    private let appearUserSubject = PassthroughSubject<Void, Never>()
    private let appearEventsSubject = PassthroughSubject<Void, Never>()
    private let appearReceivedEventsSubject = PassthroughSubject<Void, Never>()
    
    private let resUserSubject = PassthroughSubject<UserModel, Never>()
    private let resEventsSubject = PassthroughSubject<[EventModel], Never>()
    private let resReceivedEventsSubject = PassthroughSubject<[EventModel], Never>()

    func appearInInit() {
        appearUserSubject.send(())
        appearEventsSubject.send(())
    }
    func appearInReceivedEvent() {
        appearReceivedEventsSubject.send(())
    }
    
    init(userName: String) {
        self.apiSev = APISev()
        self.user = UserModel()
        self.events = [EventModel]()
        self.receivedEvents = [EventModel]()
        
        // 用户信息获取
        let reqUser = UserRequest(userName: userName)
        let resUserStream = appearUserSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqUser)
                    .catch { error -> Empty<UserModel, Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resUserSubject)
        
        let repUserStream = resUserSubject
            .assign(to: \.user, on: self)
        
        // 用户事件
        let reqEvent = UserEventsRequest(userName: userName)
        let resEventStream = appearEventsSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqEvent)
                    .catch { error -> Empty<[EventModel], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resEventsSubject)
        let repEventStream = resEventsSubject
            .assign(to: \.events, on: self)
        
        // 用户接受的事件
        let reqReceivedEvent = UserReceivedEventsRequest(userName: userName)
        let resReceivedEventStream = appearReceivedEventsSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqReceivedEvent)
                    .catch { error -> Empty<[EventModel], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resReceivedEventsSubject)
        let repReceivedEventStream = resReceivedEventsSubject
            .assign(to: \.receivedEvents, on: self)
        
        
        cancellables += [
            resUserStream, repUserStream,
            resEventStream, repEventStream,
            resReceivedEventStream, repReceivedEventStream
        ]
    }
}

struct UserReceivedEventsRequest: APIReqType {
    typealias Res = [EventModel]
    var userName: String
    var path: String {
        return "/users/\(userName)/received_events"
    }
    var qItems: [URLQueryItem]? {
        return [
            .init(name: "per_page", value: "100")
        ]
    }
}

struct UserEventsRequest: APIReqType {
    typealias Res = [EventModel]
    var userName: String
    var path: String {
        return "/users/\(userName)/events"
    }
    var qItems: [URLQueryItem]? {
        return [
            .init(name: "per_page", value: "100")
        ]
    }
}

struct UserRequest: APIReqType {
    typealias Res = UserModel
    var userName: String
    var path: String {
        return "/users/\(userName)"
    }
    var qItems: [URLQueryItem]? {
        return []
    }
}
