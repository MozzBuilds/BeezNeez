import Foundation

struct ClientBusinessRelationship: Codable {
    let clientId: String
    let businessId: String
    var isFavorite: Bool
    var totalBookings: Int
    var lastBookingDate: Date?
    var notes: String? // Business notes about client
    let firstBookingDate: Date
}
