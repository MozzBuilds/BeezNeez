import Foundation

struct Booking: Identifiable, Codable {
    let id: String
    let businessId: String
    let clientId: String
    
    /// Appointment Details
    var date: Date
    var startTime: String // "14:30"
    var endTime: String // "15:00"
    var duration: Int // minutes
    var service: ServicePrice?
    
    /// Status
    var status: BookingStatus
    var approvalStatus: ApprovalStatus
    
    /// Recurring Info
    var isRecurring: Bool = false
    var recurrenceRule: RecurrenceRule?
    var recurrenceGroupId: String? // Links recurring appointments
    var recurrenceIndex: Int? // Position in the series
    
    /// Notes
    var clientNotes: String?
    var businessNotes: String?
    
    /// Change Requests
    var pendingChangeRequest: BookingChangeRequest?
    
    /// Metadata
    let createdAt: Date
    var updatedAt: Date
    var confirmedAt: Date?
    var cancelledAt: Date?
    var cancelledBy: String? // User ID
    var cancellationReason: String?
    
    /// Computed Properties
    var isPast: Bool { date < Date() }
    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}

enum BookingStatus: String, Codable, CaseIterable {
    case pending = "pending"
    case confirmed = "confirmed"
    case cancelled = "cancelled"
    case completed = "completed"
    case noShow = "no_show"
}
