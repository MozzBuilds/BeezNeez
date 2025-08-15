import Foundation
import OSLog

enum LogType {
    case info
        /// General info. User logged in. User consented to permissions
    case debug
        /// For developer info, parameters passed between classes for example
    case error
        /// Non-critical errors. Hinder the users experience e.g. cannot update a new device
    case critical
        /// Showstopping errors, user cannot log in, phone is jailbroken, app isn't supported on this iOS
}

extension Logger {
    
    static let shared = CurrentEnvironment.isLoggingEnabled ? Logger() : nil
    
    static func createLog(type: LogType, message: String, error: Error? = nil) {
        
        var logMessage = "\(message)"
        
        if let error {
            logMessage += " - \(error.localizedDescription)"
        }
        
        switch type {
            
        case .info:
            shared?.info("\(logMessage)")
        case .debug:
            shared?.debug("\(logMessage)")
        case .error:
            shared?.error("\(logMessage)")
        case .critical:
            shared?.critical("\(logMessage)")
        }
    }
}
