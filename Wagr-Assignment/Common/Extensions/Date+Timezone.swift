//
//  Date+Timezone.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import Foundation

extension Date {
    
    static var timeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        let timezoneCode = TimeZone.current.abbreviation() ?? "EST" // default to EST
        formatter.timeZone = TimeZone(abbreviation: timezoneCode)
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.dateFormat = "h:mma z"
        
        return formatter
    }()
    
    static var dayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        let timezoneCode = TimeZone.current.abbreviation() ?? "EST" // default to EST
        formatter.timeZone = TimeZone(abbreviation: timezoneCode)
        formatter.dateFormat = "MMM d"
        
        return formatter
    }()
    
    func stringWithTimezone() -> String {
        let dateString = Date.timeDateFormatter.string(from: self).replacingOccurrences(of: ":00", with: "")
        return dateString
    }
    
    func stringWithMonth(daysUntilGame: Int) -> String {
        let dateString = Date.stringforDaysInFuture(daysUntilGame) + ", " + Date.timeDateFormatter.string(from: self).replacingOccurrences(of: ":00", with: "")
        return dateString
    }
    
    static func stringforDaysInFuture(_ days: Int) -> String {
        
        switch days {
            case 0:
                return NSLocalizedString("today", comment: "")
            case 1:
                return NSLocalizedString("tomorrow", comment: "")
            default:
                let rightNow = Date.rightNow
                let sectionDate = Calendar.current.date(byAdding: .day, value: days, to: rightNow) ?? rightNow
                let dateString = Date.dayDateFormatter.string(from: sectionDate)
                
                return dateString
        }
        
    }
}
