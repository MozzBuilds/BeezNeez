import Foundation

// Real rough thought on how it will work
// user has some personal details, that's mandatory
// user can follow multiple businesses and have muliple appoinments
// user can also own multiple businesses

//struct UserProfile {
//    let id: String
//    let email: String?
//    let phone: String?
//    let name: String
//    
//    /// User is a client only
//    var followedBusinesses: [Business] = []
//    var clientAppointments: [Appointment] = []
//
//    /// User has a business
//    var ownedBusinesses: [Business] = []
//    
//    /// Helpers
//    var hasBusinesses: Bool { !ownedBusinesses.isEmpty }
//    var hasClientProfile: Bool { !clientAppointments.isEmpty || !followedBusinesses.isEmpty }
//}
