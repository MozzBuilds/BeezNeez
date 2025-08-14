import Foundation

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
