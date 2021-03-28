//
//  Date+FakeCurrentDate.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import Foundation

// Extension used to fake the current date
// Required since all games returned by the API are in the past
extension Date {
    
    static var rightNow: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let rightNow = formatter.date(from: "2021/01/21 00:00") ?? Date()
        
        return rightNow
    }()
    
}
