import Foundation
import OSLog

public enum CurrentEnvironment {
    
    // MARK: - API Configuration
    
    static var supabaseURL: String {
        (try? EnvironmentService.value(for: "SUPABASE_URL")) ?? ""
    }
    
    static var supabaseAnonKey: String {
        (try? EnvironmentService.value(for: "SUPABASE_ANON_KEY")) ?? ""
    }
    
    static var googleClientId: String {
        (try? EnvironmentService.value(for: "GOOGLE_CLIENT_ID")) ?? ""
    }
    
    // MARK: - Feature Flags
    
    static var isLoggingEnabled: Bool {
        (try? EnvironmentService.value(for: "ENABLE_LOGGING")) ?? false
    }
    
    static var isTestUsersEnabled: Bool {
        (try? EnvironmentService.value(for: "ENABLE_TEST_USERS")) ?? false
    }
}
