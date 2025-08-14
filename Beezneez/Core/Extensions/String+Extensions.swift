import Foundation

extension String {
    
    var localized: String {
        String(localized: String.LocalizationValue(self))
        // Grabs the localized version of a string if it exists
        // Usage would be something like:
            // let string = "alert_ok".localized
        // This was created because for some components SwiftUI will use the localized string from a key automatically, but for others it would not
    }
}
