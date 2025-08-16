import Foundation

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
