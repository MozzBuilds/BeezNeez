import Foundation
import OSLog

class TokenService {
    
    func storeJWTInKeychain(jwt: String, key: String) {
        
        guard let data = jwt.data(using: .utf8) else {
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        /// Delete any existing item with the same key
        SecItemDelete(query as CFDictionary)
        
        /// Add the new item to the Keychain
        _ = SecItemAdd(query as CFDictionary, nil)
        
        Logger.createLog(type: .info, message: "Successfully stored token")
    }
    
    /// Using the specific unique key
    func getJWTFromKeychain(key: String) -> String? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}
