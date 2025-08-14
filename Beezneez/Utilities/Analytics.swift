import Foundation

/// Enum to host all event types - Split in future
enum AnalyticsEvent: String {
    
    case firstTimeLogin = "first_time_login"

    var eventName: String {
        self.rawValue
    }
}

/// Enum to host the user journey, which would be used in combination with the analytics event
enum AnalyticsJourney: String {

    case onboarding = "onboarding"
    
    var name: String {
        self.rawValue
    }
}

///Firebase analytics example
//extension Analytics {
//
//    func sendAnalytics(event: AnalyticsEvent, parameters: [String : Any]?) {
//        Analytics.logEvent(event.eventName, parameters: parameters)
//    }
//}
