enum ApprovalStatus: String, Codable, CaseIterable {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"
    case autoApproved = "auto_approved"
}
