import Foundation
import Supabase

@MainActor
class SupabaseManager: ObservableObject {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    @Published var session: Session?
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    private init() {
        // Use configuration from plist/xcconfig
        guard let url = URL(string: AppConfiguration.supabaseURL) else {
            fatalError("Invalid Supabase URL in configuration")
        }
        
        self.client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: AppConfiguration.supabaseAnonKey,
            options: SupabaseClientOptions(
                auth: SupabaseAuthClientOptions(
                    storage: KeychainLocalStorage(),
                    redirectToURL: URL(string: "beezneez://auth-callback")
                ),
                realtime: RealtimeClientOptions(
                    logger: AppConfiguration.isLoggingEnabled ? ConsoleLogger() : nil
                ),
                global: GlobalOptions(
                    logger: AppConfiguration.isLoggingEnabled ? ConsoleLogger() : nil
                )
            )
        )
        
        setupAuthListener()
    }
    
    private func setupAuthListener() {
        Task {
            for await state in client.auth.authStateChanges {
                handleAuthStateChange(state)
            }
        }
    }
    
    private func handleAuthStateChange(_ state: AuthChangeEvent) {
        // Log in debug environments
        if AppConfiguration.environment.isDebugEnabled {
            print("🔐 Auth State Changed: \(state.event)")
        }
        
        switch state.event {
        case .signedIn:
            self.session = state.session
            self.isAuthenticated = true
            Task { await fetchCurrentUser() }
        case .signedOut:
            self.session = nil
            self.isAuthenticated = false
            self.currentUser = nil
        default:
            break
        }
    }
    
    private func fetchCurrentUser() async {
        // Implementation
    }
}
