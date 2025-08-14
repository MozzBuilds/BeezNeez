import Foundation
import SwiftUI

struct Colors {


    // MARK: - Stock Colours
    static let black = Color.black
    static let white = Color.white
    
    // MARK: - Buttons

    // MARK: - Text
    
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
