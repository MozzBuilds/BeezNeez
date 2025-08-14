//
//  Extensions.swift
//  TemplateApp
//
//  Created by Colin Morrison on 06/06/2023.
//

import Foundation
import SwiftUI

// Useful extensions uncovered during development that could be reused again

extension String {
    
    var localized: String {
        String(localized: String.LocalizationValue(self))
        // Grabs the localized version of a string if it exists
        // Usage would be something like:
            // let string = "alert_ok".localized
        // This was created because for some components SwiftUI will use the localized string from a key automatically, but for others it would not
    }
}

extension UIImage {
    
    static func coloredImage(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
        
        let size = CGSize(width: width, height: height)
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
        // Used for placeholders whilst we're still waiting on assets. Allows us to use a colored bloc as an image and resize it as we need to, so when the asset is ready it's a simple swap over
        // Usage example:
            // let image = coloredImage(color: .cyan, width: 200, height: 200)
    }
}

extension View {
    
    /// Allows the creation of a corner radius on only one or more corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// Toggle for setting the hidden state of a view
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    
    /// Allows  to change the color of placeHolder text in TextFields
    func placeholder<Content: View>(
        
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension Decimal {
    
    /// Converts a decimal number into a GBP string "£12.34" for example
    /// Should probably instead be a function with current currencies available / reading users local currency, but for now we only use GBP
    var asCurrency: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "£"
        numberFormatter.maximumFractionDigits = 2

        return numberFormatter.string(from: NSDecimalNumber(decimal: self))
    }
}

extension UINavigationController {

  open override func viewWillLayoutSubviews() {
      /// Hides the "Back" text that appears on someView when the stack is NavigationView > TabVIew > someView
      /// Note it was only visible when opening someView, then a subView, then going back to someView
      super.viewWillLayoutSubviews()
      navigationBar.topItem?.backButtonDisplayMode = .minimal
  }
}

extension Alert {
    
    /// Generic alert with OK and Cancel actions, localized
    static func okCancel(title: String, message: String, action: @escaping () -> Void) -> Alert {
        Alert(title: Text(title),
                     message: Text(message),
                     primaryButton: .destructive(Text("CANCEL")),
                     secondaryButton: .default(Text("OK"), action: action))
    }
    
    /// Alert for showing errors only
    static func genericErrorAlert(message: String) -> Alert {
        Alert(title: Text("Could not proceed"), message: Text(message))
    }
}
