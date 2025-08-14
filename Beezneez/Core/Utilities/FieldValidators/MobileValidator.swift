import Foundation

struct MobileValidator {

    /// Assuming only UK mobile numbers are valid, e.g. 07123456789
        
    static func validateMobileNumber(_ number: String) -> FieldValidState {
        
        if number.isEmpty || !isValidMobilePhoneNumber(number) {
            return .nonValid
        }
        
        return .valid
    }
    
    private static func isValidMobilePhoneNumber(_ number: String) -> Bool {
        
        let number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let validUKNumberRegex = "^07\\d{9}$" // Simple regex for now, just checks it starts with 07 and is 11 digits long
        
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", validUKNumberRegex)

        guard numberPredicate.evaluate(with: number) else {
            return false
        }
                
        return true
    }
}
