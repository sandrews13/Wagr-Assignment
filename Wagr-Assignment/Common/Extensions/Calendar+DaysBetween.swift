//
//  Calendar+DaysBetween.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import Foundation

extension Calendar {
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int? {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let components = dateComponents([.day], from: fromDate, to: toDate)
        
        return components.day
    }
    
}
