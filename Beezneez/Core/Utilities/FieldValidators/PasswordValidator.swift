import Foundation

enum CreatePassswordFieldType {
    case firstPassword
    case secondPassword
}

struct PasswordValidator {
    
    static let allowedSpecialCharacters = "!@#$%£^&*()-_=+[]{}|\\;:'\",.<>/?"
    
    static func validateCurrentPassword(_ password: String) -> FieldValidState {
        .valid
    }
    
    static func validatePassword(_ first: String, compareTo second: String? = nil, email: String? = nil) -> FieldValidState {
        
        if let second {
            
            if second.isEmpty || !isValidPassword(second, email: email) {
                return .nonValid
            }
            
            if second != first {
                return .nonMatch
            }
        }
        
        if first.isEmpty || !isValidPassword(first, email: email) {
            return .nonValid
        }
        
        return .valid
    }
    
    private static func isValidPassword(_ password: String, email: String? = nil) -> Bool {
         
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
         
        if let email {
            if password == email {
                return false
            }
        }

         guard password.count >= 8 && password.count <= 16 else {
             return false
         }
         
         /// Check for forbidden characters
 //        let forbiddenCharacterSet = CharacterSet(charactersIn: "$^&()-_=+[]{}|\\;:',.<>/?")
 //        if password.rangeOfCharacter(from: forbiddenCharacterSet) != nil {
 //            return false
 //        }
         
         /// Check for the presence of at least three of the following character types
         var characterTypesCount = 0
         
         if password.rangeOfCharacter(from: .uppercaseLetters) != nil {
             characterTypesCount += 1
         }
         
         if password.rangeOfCharacter(from: .lowercaseLetters) != nil {
             characterTypesCount += 1
         }
         
         if password.rangeOfCharacter(from: .decimalDigits) != nil {
             characterTypesCount += 1
         }
         
         let specialCharacterSet = CharacterSet(charactersIn: allowedSpecialCharacters)
         if password.rangeOfCharacter(from: specialCharacterSet) != nil {
             characterTypesCount += 1
         }
         
         guard characterTypesCount >= 3 else {
             return false
         }
         
         return true
     }
}
