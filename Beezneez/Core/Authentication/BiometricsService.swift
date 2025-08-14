import LocalAuthentication
import OSLog

class BiometricsService {
    
    func authenticateBiometrics(successCompletion: @escaping () -> Void, failureCompletion: @escaping (Error) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Required for secure login") { success, error in
                if success {
                    DispatchQueue.main.async {
                        Logger.createLog(type: .debug, message: "Biometric Login Successful")
                        successCompletion()
                    }
                } else {
                    if let error = error as NSError? {
                        Logger.createLog(type: .debug, message: "Biometric Login Failed", error: error)
                        DispatchQueue.main.async {
                            failureCompletion(error)
                        }
                    }
                }
            }
        } else {
            // Called when face ID is not available or not set up
            // Need to call the failure block for it not being available
            // Can either make a custom error and return it with the failure block
            // Or tell this method to return a bool or something else and handle that?
                // Or split this method up to say
                // If biometrics enabled and available, do the above
                // Else call for the other 2FA method e.g. text/email code
            
        }
    }
}
