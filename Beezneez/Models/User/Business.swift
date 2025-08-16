import Foundation

struct Business: Identifiable, Codable {
    let id: String
    let ownerId: String
    
    /// Basic Info
    var name: String
    var businessType: BusinessType
    var bio: String
    
    /// Contact Info
    var businessPhone: String?
    var mobilePhone: String?
    var emails: [String] = []
    var website: String?
    var youtubeChannel: String?
    
    /// Location
    var address: String
    var city: String
    var state: String?
    var postalCode: String
    var country: String
    var coordinates: Coordinates?
    
    /// Media (max 3 images)
    var imageURLs: [String] = []
    var logoURL: String?
    
    /// Business Settings
    var operatingHours: [DaySchedule] = []
    var appointmentDuration: Int // in minutes
    var bufferTime: Int = 0 // minutes between appointments
    var maxBookingAdvance: Int = 168 // days (24 weeks)
    var autoApproveBookings: Bool = false
    var autoApproveChanges: Bool = false
    var autoApproveCancellations: Bool = false
    
    /// Availability
    var isPaused: Bool = false
    var unavailableDates: [DateRange] = []
    
    /// Pricing
    var priceList: [ServicePrice] = []
    
    /// Stats
    var totalClients: Int = 0
    var rating: Double?
    
    /// Metadata
    let createdAt: Date
    var updatedAt: Date
    var isActive: Bool = true
}
