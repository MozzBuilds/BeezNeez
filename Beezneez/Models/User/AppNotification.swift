import Foundation

struct AppNotification: Identifiable, Codable {
    var id = UUID().uuidString
    let userId: String
    let type: NotificationType
    
    // Content
    var title: String
    var message: String
    var actionUrl: String? // Deep link
    
    // Related Entities
    var bookingId: String?
    var businessId: String?
    
    // Status
    var isRead: Bool = false
    var readAt: Date?
    
    // Metadata
    let createdAt: Date
    var expiresAt: Date?
}

enum NotificationType: String, Codable {
    // For Clients
    case bookingConfirmed = "booking_confirmed"
    case bookingRejected = "booking_rejected"
    case bookingCancelled = "booking_cancelled"
    case bookingReminder = "booking_reminder"
    case changeRequestApproved = "change_approved"
    case changeRequestRejected = "change_rejected"
    
    // For Business Owners
    case newBookingRequest = "new_booking"
    case newChangeRequest = "new_change_request"
    case clientCancellation = "client_cancellation"
    case upcomingAppointment = "upcoming_appointment"
}
