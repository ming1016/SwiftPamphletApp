//
//  UserVM.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/10.
//

import Foundation
import Combine
import AppKit

final class UserVM: APIVMable {
    private var cancellables: [AnyCancellable] = []

    public let userName: String

    @Published private(set) var user: UserModel
    @Published private(set) var events: [EventModel]
    @Published private(set) var receivedEvents: [EventModel]

    @Published var errHint = false
    @Published var errMsg = ""
    private let errSj = PassthroughSubject<APISevError, Never>()

    private let apiSev: APISev

    private let appearUserSubject = PassthroughSubject<Void, Never>()
    private let appearEventsSubject = PassthroughSubject<Void, Never>()
    private let appearNotiEventsSubject = PassthroughSubject<Void, Never>()
    private let appearReceivedEventsSubject = PassthroughSubject<Void, Never>()

    private let resUserSubject = PassthroughSubject<UserModel, Never>()
    private let resEventsSubject = PassthroughSubject<[EventModel], Never>()
    private let resNotiEventSubject = PassthroughSubject<[EventModel], Never>()
    private let resReceivedEventsSubject = PassthroughSubject<[EventModel], Never>()

    enum UserActionType {
        case inInit, inEvent, inReceivedEvent, notiEvent, clearUnReadEvent
    }
    func doing(_ somethinglike: UserActionType) {
        switch somethinglike {
        case .inInit:
            appearUserSubject.send(())
        case .inEvent:
            appearEventsSubject.send(())
        case .inReceivedEvent:
            appearReceivedEventsSubject.send(())
        case .notiEvent:
            appearNotiEventsSubject.send(())
        case .clearUnReadEvent:
            clearUnReadEvent()
        }
    }

    func clearUnReadEvent() {
        do {
            if let f = try DevsNotiDataHelper.find(sLogin: userName) {
                do {
                    _ = try DevsNotiDataHelper.update(i: DBDevNoti(login: f.login, lastReadId: f.lastReadId, unRead: 0))
                } catch {}
            }
        } catch {}
    }

    init(userName: String) {
        self.userName = userName
        self.apiSev = APISev()
        self.user = UserModel()
        self.events = [EventModel]()
        self.receivedEvents = [EventModel]()

        // MARK: - 用户信息获取
        let reqUser = UserRequest(userName: userName)
        let resUserStream = appearUserSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqUser)
                    .catch { [weak self] error -> Empty<UserModel, Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resUserSubject)

        let repUserStream = resUserSubject
            .assign(to: \.user, on: self)

        // MARK: - 用户事件
        let reqEvent = UserEventsRequest(userName: userName)
        let resEventStream = appearEventsSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqEvent)
                    .catch { [weak self] error -> Empty<[EventModel], Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resEventsSubject)
        let repEventStream = resEventsSubject
            .assign(to: \.events, on: self)

        // MARK: - 用户接受的事件
        let reqReceivedEvent = UserReceivedEventsRequest(userName: userName)
        let resReceivedEventStream = appearReceivedEventsSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqReceivedEvent)
                    .catch { [weak self] error -> Empty<[EventModel], Never> in
                        self?.errSj.send(error)
                        return .init()
                    }
            }
            .share()
            .subscribe(resReceivedEventsSubject)
        let repReceivedEventStream = resReceivedEventsSubject
            .assign(to: \.receivedEvents, on: self)

        // MARK: - 更新用户的通知信息
        let reqNotiEvents = UserEventsRequest(userName: userName)
        let resNotiEventsStream = appearNotiEventsSubject
            .flatMap { [apiSev] in
                apiSev.response(from: reqNotiEvents)
                    .catch { _ -> Empty<[EventModel], Never> in
                        return .init()
                    }
            }
            .share()
            .subscribe(resNotiEventSubject)
        func updateDBDevsInfo(ems: [EventModel]) {
            do {
                if let f = try DevsNotiDataHelper.find(sLogin: userName) {
                    var i = 0
                    var lrid = f.lastReadId
                    for em in ems {
                        if i == 0 {
                            lrid = em.id
                        }
                        if em.id == f.lastReadId {
                            break
                        }
                        i += 1
                    }
                    i = f.unRead + i
                    do {
                        _ = try DevsNotiDataHelper.update(i: DBDevNoti(login: userName, lastReadId: lrid, unRead: i))
                    } catch {}
                } // end if let f
            } catch {}
        } // end func updateDBDevsInfo
        let repNotiEventsStream = resNotiEventSubject
            .map { eventModels in
                updateDBDevsInfo(ems: eventModels)
                return eventModels
            }
            .assign(to: \.events, on: self)

        // MARK: - 错误
        let errMsgSm = errSj
            .map { err -> String in
                err.message
            }
            .assign(to: \.errMsg, on: self)
        let errHintSm = errSj
            .map { _ in
                true
            }
            .assign(to: \.errHint, on: self)

        cancellables += [
            resUserStream, repUserStream,
            resEventStream, repEventStream,
            resReceivedEventStream, repReceivedEventStream,
            resNotiEventsStream, repNotiEventsStream,
            errMsgSm, errHintSm
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
