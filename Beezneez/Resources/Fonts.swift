import SwiftUI

struct Fonts {
    static private let baseFont = CurrentScheme.baseFont ?? "Arial"
    
    static let titleCaption = Font.custom("\(baseFont)-Bold", size: 12)
    static let titleBase = Font.custom("\(baseFont)-Bold", size: 16)
    static let titleMedium = Font.custom("\(baseFont)-Bold", size: 18)
    static let titleLarge = Font.custom("\(baseFont)-Bold", size: 20)
    static let titleXL = Font.custom("\(baseFont)-Bold", size: 24)
    static let title2XL = Font.custom("\(baseFont)-Bold", size: 32)
    static let title3XL = Font.custom("\(baseFont)-Bold", size: 40)
    static let title4XL = Font.custom("\(baseFont)-Bold", size: 48)
    
    static let bodyCaption = Font.custom("\(baseFont)-Regular", size: 12)
    static let bodyBase = Font.custom("\(baseFont)-Regular", size: 16)
    static let bodyMedium = Font.custom("\(baseFont)-Regular", size: 18)
    static let bodyLarge = Font.custom("\(baseFont)-Regular", size: 20)
    static let bodyXL = Font.custom("\(baseFont)-Regular", size: 24)
    static let body2XL = Font.custom("\(baseFont)-Regular", size: 32)
    static let body3XL = Font.custom("\(baseFont)-Regular", size: 40)
    static let body4XL = Font.custom("\(baseFont)-Regular", size: 48)
}
