import Foundation

struct EmailValidator {
    
    static func validateEmail(_ first: String, compareTo second: String? = nil) -> FieldValidState {
        
        if let second {
            
            if second.isEmpty || !isValidEmail(second) {
                return .nonValid
            }
            
            if second != first {
                return .nonMatch
            }
        }
        
        if first.isEmpty || !isValidEmail(first) {
            return .nonValid
        }
        
        return .valid
    }
    
    private static func isValidEmail(_ email: String) -> Bool {
        
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailRegex = "[A-Z0-9a-z.]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else {
            return false
        }
        
        guard !email.hasPrefix(".") else {
            return false
        }
        
        let components = email.split(separator: "@")
        guard components.count == 2 else {
            return false
        }
        
        let domain = String(components[1])
        guard domain.contains(".") && !domain.hasPrefix(".") && !domain.hasSuffix(".") else {
            return false
        }
        
        let emailLength = email.count
        let minimumLength = 5
        let maximumLength = 254
        
        guard emailLength >= minimumLength && emailLength <= maximumLength else {
            return false
        }
                
        return true
    }
}
