//
//  Formatter+ISO8601.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//

import Foundation

extension Formatter {
    
    static let iso8601withFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let timezoneCode = TimeZone.current.abbreviation() ?? "EST" // default to EST
        formatter.timeZone = TimeZone(abbreviation: timezoneCode)
        
        return formatter
    }()
    
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        let timezoneCode = TimeZone.current.abbreviation() ?? "EST" // default to EST
        formatter.timeZone = TimeZone(abbreviation: timezoneCode)
        
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
