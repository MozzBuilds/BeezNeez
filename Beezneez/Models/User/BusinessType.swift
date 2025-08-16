
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
