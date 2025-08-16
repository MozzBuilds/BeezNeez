import Foundation

struct RecurrenceRule: Codable {
    let frequency: RecurrenceFrequency
    let interval: Int // Every X weeks/days
    let endDate: Date? // When the recurrence ends
    let occurrences: Int? // Or number of occurrences
}

enum RecurrenceFrequency: String, Codable, CaseIterable {
    case daily = "daily"
    case weekly = "weekly"
    case biweekly = "biweekly"
    case monthly = "monthly"
    
    var displayName: String {
        switch self {
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .biweekly: return "Every 2 Weeks"
        case .monthly: return "Monthly"
        }
    }
    
    var maxInterval: Int {
        switch self {
        case .daily: return 7
        case .weekly: return 12
        case .biweekly: return 6
        case .monthly: return 3
        }
    }
}
