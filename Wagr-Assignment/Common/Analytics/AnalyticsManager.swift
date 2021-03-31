//
//  AnalyticsManager.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-29.
//

import FirebaseAnalytics

// Analytics class to simplify firing analytic events
// Could turn into a protocol to make it platform agnostic, i.e. if you want to switch from Firebase
class AnalyticsManager {
    
    static func logScreenView(screenName: String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: screenName])
    }
    
}
