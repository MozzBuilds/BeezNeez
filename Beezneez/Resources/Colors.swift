import Foundation
import SwiftUI

struct Colors {


    // MARK: - Stock Colours
    static let black = Color.black
    static let white = Color.white
    
    // MARK: - Misc
    static let splashBackground = Color("")
    static let appBackground = Color("")
    static let tabViewBackground = Color("")
    static let tabItemTint = Color("")
    
    // MARK: - Text
    static let title = Color("")
    static let subtitle = Color("")
    static let body = Color("")
    static let bodyEmphasis = Color("")

    // MARK: - Fields
    static let fieldBackground = Color("")
    static let fieldBorder = Color("")
    static let fieldText = Color("")
    
    // MARK: - Buttons
    static let primaryButtonText = Color("")
    static let primaryButtonBorder = Color("")
    static let primaryButtonBackground = Color("")
    
    static let secondaryButtonText = Color("")
    static let secondaryButtonBorder = Color("")
    static let secondaryButtonBackground = Color("")
    
    static let tertiaryButtonText = Color("")
    static let tertiaryButtonBorder = Color("")
    static let tertiaryButtonBackground = Color("")
    
    static let disabledButtonBackground = Color("")
    static let disabledButtonBorder = Color("")
    static let disabledButtonText = Color("")
    
    static let warningButtonText = Color("")
    static let warningButtonBorder = Color("")
    static let warningButtonBackground = Color("")
    
    
    // MARK: - Helper Methods
    static func customColor(r: CGFloat, g: CGFloat, b: CGFloat) -> Color {
        customColor(r: r, g: g, b: b, a: 1)
        /// Returns an rgb color, zero transparancy
    }
    
    static func customColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> Color {
        Color(red: r/255, green: g/255, blue: b/255, opacity: a)
        /// returns an rbg color, with transparancy set to alpha (0 = completely transparant, 1 = zero transparancy)
    }
}
