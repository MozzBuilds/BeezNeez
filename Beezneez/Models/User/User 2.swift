import Foundation

//struct User: Identifiable, Codable {
//    let id: String // UUID or from SSO provider
//    
//    // SSO Authentication Info
//    let authProvider: AuthProvider
//    let authProviderId: String
//    
//    // Required Contact Info
//    var email: String
//    var phoneNumber: String?
//    var firstName: String
//    var lastName: String
//    
//    // Profile
//    var profileImageURL: String?
//    var preferredContactMethod: ContactMethod
//    
//    // Business Owner Properties
//    var ownedBusinessIds: [String] = []
//    
//    // Client Properties
//    var favoriteBusinessIds: [String] = []
//    var clientBookingIds: [String] = []
//    
//    // Metadata
//    let createdAt: Date
//    var updatedAt: Date
//    var lastLoginAt: Date?
//    var isActive: Bool = true
//    
//    // Computed Properties
//    var isBusinessOwner: Bool { !ownedBusinessIds.isEmpty }
//    var isClient: Bool { !clientBookingIds.isEmpty || !favoriteBusinessIds.isEmpty }
//    var displayName: String { "\(firstName) \(lastName)" }
//}

struct User: Codable, Identifiable {
    let id: String
    let authUserId: String
    let authProvider: String
    let authProviderId: String
    
    var email: String
    var phoneNumber: String?
    var firstName: String
    var lastName: String
    
    var profileImageId: String?
    var preferredContactMethod: String
    
    let createdAt: Date?
    var updatedAt: Date?
    var lastLoginAt: Date?
    var isActive: Bool
    
    // Computed properties
    var displayName: String {
        "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
    
    // CodingKeys for snake_case conversion
    enum CodingKeys: String, CodingKey {
        case id
        case authUserId = "auth_user_id"
        case authProvider = "auth_provider"
        case authProviderId = "auth_provider_id"
        case email
        case phoneNumber = "phone_number"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImageId = "profile_image_id"
        case preferredContactMethod = "preferred_contact_method"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLoginAt = "last_login_at"
        case isActive = "is_active"
    }
}

enum AuthProvider: String, Codable, CaseIterable {
    case apple = "apple"
    case google = "google"
}

enum ContactMethod: String, Codable, CaseIterable {
    case email = "email"
    case phone = "phone"
    case both = "both"
}

// MARK: - Business Model
struct Business: Identifiable, Codable {
    let id: String
    let ownerId: String // User who owns this business
    
    // Basic Info
    var name: String
    var businessType: BusinessType
    var bio: String
    
    // Contact Information
    var businessPhone: String?
    var mobilePhone: String?
    var emails: [String] = []
    var website: String?
    var youtubeChannel: String?
    
    // Location
    var address: String
    var city: String
    var state: String?
    var postalCode: String
    var country: String
    var coordinates: Coordinates?
    
    // Media (max 3 images)
    var imageURLs: [String] = [] // Max 3
    var logoURL: String?
    
    // Business Settings
    var operatingHours: [DaySchedule] = []
    var appointmentDuration: Int // in minutes
    var bufferTime: Int = 0 // minutes between appointments
    var maxBookingAdvance: Int = 168 // days (24 weeks)
    var autoApproveBookings: Bool = false
    var autoApproveChanges: Bool = false
    var autoApproveCancellations: Bool = false
    
    // Availability
    var isPaused: Bool = false
    var unavailableDates: [DateRange] = []
    
    // Pricing
    var priceList: [ServicePrice] = []
    
    // Stats
    var totalClients: Int = 0
    var rating: Double?
    
    // Metadata
    let createdAt: Date
    var updatedAt: Date
    var isActive: Bool = true
}

struct BusinessType: Codable, Identifiable {
    let id: String
    let name: String
    let category: String
    
    static let predefinedTypes = [
        BusinessType(id: "hairdresser", name: "Hairdresser", category: "Beauty"),
        BusinessType(id: "driving_instructor", name: "Driving Instructor", category: "Education"),
        BusinessType(id: "woodcutter", name: "Wood Cutter", category: "Services"),
        // Add more as needed
    ]
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct DaySchedule: Codable, Identifiable {
    let id = UUID().uuidString
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

struct ServicePrice: Codable, Identifiable {
    let id = UUID().uuidString
    var serviceName: String
    var price: Double
    var duration: Int? // minutes, if different from default
    var description: String?
}

// MARK: - Booking Model
struct Booking: Identifiable, Codable {
    let id: String
    let businessId: String
    let clientId: String // User ID of the client
    
    // Appointment Details
    var date: Date
    var startTime: String // "14:30"
    var endTime: String // "15:00"
    var duration: Int // minutes
    var service: ServicePrice?
    
    // Status
    var status: BookingStatus
    var approvalStatus: ApprovalStatus
    
    // Recurring Info
    var isRecurring: Bool = false
    var recurrenceRule: RecurrenceRule?
    var recurrenceGroupId: String? // Links recurring appointments
    var recurrenceIndex: Int? // Position in the series
    
    // Notes
    var clientNotes: String?
    var businessNotes: String?
    
    // Change Requests
    var pendingChangeRequest: BookingChangeRequest?
    
    // Metadata
    let createdAt: Date
    var updatedAt: Date
    var confirmedAt: Date?
    var cancelledAt: Date?
    var cancelledBy: String? // User ID
    var cancellationReason: String?
    
    // Computed Properties
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

enum ApprovalStatus: String, Codable, CaseIterable {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"
    case autoApproved = "auto_approved"
}

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

// MARK: - Booking Change Request
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

enum ChangeRequestType: String, Codable {
    case reschedule = "reschedule"
    case cancel = "cancel"
    case modify = "modify" // Change service, duration, etc.
}

enum RequestStatus: String, Codable {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"
    case expired = "expired"
}

// MARK: - Notification Model
struct AppNotification: Identifiable, Codable {
    let id = UUID().uuidString
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

// MARK: - Time Slot Model (for availability calculation)
struct TimeSlot: Identifiable, Codable {
    let id = UUID().uuidString
    let businessId: String
    let date: Date
    let startTime: String
    let endTime: String
    var isAvailable: Bool
    var isBlocked: Bool = false // Manually blocked by business
    var bookingId: String? // If booked
}

// MARK: - Client-Business Relationship
struct ClientBusinessRelationship: Codable {
    let clientId: String
    let businessId: String
    var isFavorite: Bool
    var totalBookings: Int
    var lastBookingDate: Date?
    var notes: String? // Business notes about client
    let firstBookingDate: Date
}

// MARK: - Search/Filter Models
struct BusinessSearchCriteria {
    var searchText: String?
    var businessType: BusinessType?
    var location: String?
    var radius: Double? // km
    var isOpen: Bool?
    var hasAvailability: Bool?
    var sortBy: BusinessSortOption
}

enum BusinessSortOption: String, CaseIterable {
    case relevance = "relevance"
    case distance = "distance"
    case rating = "rating"
    case alphabetical = "alphabetical"
}
