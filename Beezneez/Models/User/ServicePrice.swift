import Foundation

struct ServicePrice: Codable, Identifiable {
    var id = UUID().uuidString
    var serviceName: String
    var price: Double
    var duration: Int? // minutes, if different from default
    var description: String?
}
