// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct SMDate {
    public static func nowDateString() -> String {
        let locale = Locale(identifier: "zh_Hans")
        return Date.now.formatted(.dateTime.locale(locale))
    }
    
    public static func howLongAgo(date: Date) -> String {
        let simplifiedChinese = Locale(identifier: "zh_Hans")
        return date.formatted(.relative(presentation: .named,
                                        unitsStyle: .wide).locale(simplifiedChinese))
    }
    public static func howLongAgo(dateStr: String) -> String {
        let iso8601String = dateStr
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: iso8601String) ?? .now
        return howLongAgo(date: date)
    }
}
