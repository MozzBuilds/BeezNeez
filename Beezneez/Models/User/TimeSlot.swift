import Foundation

struct TimeSlot: Identifiable, Codable {
    var id = UUID().uuidString
    let businessId: String
    let date: Date
    let startTime: String
    let endTime: String
    var isAvailable: Bool
    var isBlocked: Bool = false // Manually blocked by business
    var bookingId: String? // If booked
}
