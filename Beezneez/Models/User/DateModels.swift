import Foundation

struct DaySchedule: Codable, Identifiable {
    var id = UUID().uuidString
    let dayOfWeek: DayOfWeek
    var isOpen: Bool
    var openTime: String? // "09:00"
    var closeTime: String? // "17:00"
    var breakTimes: [TimeRange] = []
}

enum DayOfWeek: Int, Codable, CaseIterable {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    
    var displayName: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        }
    }
}

struct TimeRange: Codable {
    let startTime: String
    let endTime: String
}

struct DateRange: Codable {
    let startDate: Date
    let endDate: Date
}
