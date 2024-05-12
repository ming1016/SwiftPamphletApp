//
//  WWDCModel.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/11.
//

import Foundation
import SMFile

protocol Jsonable : Identifiable, Decodable, Hashable {}

struct WWDCViewModel {
    
    static func parseModelForOutline() -> [WWDCModelForOutline] {
        let model:WWDCModel = SMFile.loadBundleJSONFile("WWDCData.json")
        
        var reModel = [WWDCModelForOutline]()
        for event in model.events {
            reModel.append(WWDCModelForOutline(text: event.name, eventid: event.id, sub: [WWDCModelForOutline]()))
        }
        for session in model.sessions {
            for (index,eo) in reModel.enumerated() {
                if session.eventId == eo.eventid {
                    reModel[index].sub?.append(WWDCModelForOutline(session: session))
                }
            }
        }
        return reModel.reversed()
    }
    
}

// MARK: Model for View
struct WWDCModelForOutline: Identifiable {
    var id = UUID()
    var text: String = ""
    var eventid: String = ""
    var session: WWDCSessionModel?
    var sub: [WWDCModelForOutline]?
}

// MARK: Model for json
struct WWDCModel: Decodable, Hashable {
    var sessions: [WWDCSessionModel]
    var events: [WWDCEvent]
}

struct WWDCSessionModel: Jsonable {
    var id: String
    var title: String
    var description: String?
    var eventId: String
    var eventContentId: String
    var topic: String
    var platforms: [String]?
    var speakers: [String]?
    var appleWeblink: String?
    var media: WWDCMedia
}

struct WWDCMedia: Decodable, Hashable {
    var duration: Int?
    var videoOriginalFilename: String?
    var videoOriginalUrl: String?
    var videoFilename: String?
}

struct WWDCEvent: Jsonable {
    var id: String
    var name: String
    var description: String
}






