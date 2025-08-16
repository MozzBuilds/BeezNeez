import Foundation

enum ChangeRequestType: String, Codable {
    case reschedule = "reschedule"
    case cancel = "cancel"
    case modify = "modify" /// Change service, duration, etc.
}

enum RequestStatus: String, Codable {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"
    case expired = "expired"
}

struct BookingChangeRequest: Codable, Identifiable {
    let id = UUID().uuidString
    let bookingId: String
    let requestedBy: String // User ID
    let requestType: ChangeRequestType
    
    // For reschedule requests
    var newDate: Date?
    var newStartTime: String?
    var newEndTime: String?
    
    // For cancellation
    var cancellationReason: String?
    
    // Status
    var status: RequestStatus
    var reviewedBy: String? // Business owner user ID
    var reviewedAt: Date?
    var reviewNotes: String?
    
    // Metadata
    let createdAt: Date
    var updatedAt: Date
}

