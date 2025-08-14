import Foundation

struct NameValidator {
        
    static func validateName(_ name: String) -> FieldValidState {
        
        if name.isEmpty || !isValidName(name) {
            return .nonValid
        }
        
        return .valid
    }
    
    private static func isValidName(_ name: String) -> Bool {
        
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard nameIsValidLength(name) else {
            return false
        }
        
        guard nameDoesNotContainForbiddenCharacters(name) else {
            return false
        }

        return true
    }

    static func configureName(_ name: String) -> String {
        
        let whiteSpaceTrimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let charactersToTrim = CharacterSet(charactersIn: ".\u{2026}") //using the unicode of ellipsis to be recognized as it considered as 1 charachter
        let  modifiedText = whiteSpaceTrimmed.components(separatedBy: charactersToTrim).joined(separator: "")
        return modifiedText
     }
    
    private static func nameIsValidLength(_ name: String) -> Bool {
        name.count >= 1 && name.count <= 32
    }
    
    private static func nameDoesNotContainForbiddenCharacters(_ name: String) -> Bool {

        let forbiddenCharacterList = "!@#$%*<>^/&?="
        let forbiddenCharacterSet = CharacterSet(charactersIn: forbiddenCharacterList)
        let emojiRejexPattern = try? NSRegularExpression(pattern: "\\p{RI}{2}|(\\p{Emoji}(\\p{EMod}|\\x{FE0F}\\x{20E3}?|[\\x{E0020}-\\x{E007E}]+\\x{E007F})|[\\p{Emoji}&&\\p{Other_symbol}])(\\x{200D}(\\p{Emoji}(\\p{EMod}|\\x{FE0F}\\x{20E3}?|[\\x{E0020}-\\x{E007E}]+\\x{E007F})|[\\p{Emoji}&&\\p{Other_symbol}]))*" , options: .caseInsensitive) //for copy&paste entered emojis
        let range = NSRange(location: 0, length: name.utf16.count)
        if emojiRejexPattern?.firstMatch(in: name, options: [], range: range) != nil || name.rangeOfCharacter(from: forbiddenCharacterSet) != nil {
            return false
        }
        return true
    }
}
