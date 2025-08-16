import Foundation

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
    
    // MARK: -  Relationship properties
    var ownedBusinesses: [Business]?
    var favoriteBusinesses: [Business]?
    var clientBookings: [Booking]?
    
    // MARK: - Computed properties
    var displayName: String {
        let name = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        return name.isEmpty ? email : name
    }
    
    var isBusinessOwner: Bool {
        ownedBusinesses?.isEmpty == false
    }
    
    var isClient: Bool {
        clientBookings?.isEmpty == false || favoriteBusinesses?.isEmpty == false
    }
}
