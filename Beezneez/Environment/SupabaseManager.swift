import Foundation
import OSLog
import Supabase
import Auth
import Realtime

@MainActor
class SupabaseManager: ObservableObject {
    
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    @Published var session: Session?
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    private init() {
        guard let url = URL(string: CurrentEnvironment.supabaseURL) else {
            fatalError("Invalid Supabase URL in configuration")
        }
        
        self.client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: CurrentEnvironment.supabaseAnonKey
        )
        
        configureAuth()
        setupAuthListener()
    }
    
    private func configureAuth() {
        // Set custom storage if needed
        Task {
            await MainActor.run {
                _ = client.auth
            }
        }
    }
    
    private func setupAuthListener() {
        Task {
            for await (event, session) in client.auth.authStateChanges {
                await handleAuthStateChange(event: event, session: session)
            }
        }
    }
    
    private func handleAuthStateChange(event: AuthChangeEvent, session: Session?) async {
        if CurrentEnvironment.isLoggingEnabled {
            Logger.createLog(type: .info, message: " Auth State Changed: \(event.rawValue)")
        }
        
        switch event {
        case .initialSession, .signedIn:
            self.session = session
            self.isAuthenticated = session != nil
            if session != nil {
                await fetchCurrentUser()
            }
        case .signedOut, .userDeleted:
            self.session = nil
            self.isAuthenticated = false
            self.currentUser = nil
        case .tokenRefreshed, .userUpdated:
            self.session = session
            if session != nil {
                await fetchCurrentUser()
            }
        default:
            break
        }
    }
    
    private func fetchCurrentUser() async {
        guard let userId = session?.user.id.uuidString else {
            print("No user ID available")
            return
        }
        
        do {
            let response = try await client
                .from("users")
                .select()
                .eq("auth_user_id", value: userId)
                .single()
                .execute()
            
            // Custom decoder for database timestamps
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Handle both ISO8601 and timestamp formats
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                if let dateString = try? container.decode(String.self) {
                    // Try ISO8601 first
                    if let date = ISO8601DateFormatter().date(from: dateString) {
                        return date
                    }
                    // Try without milliseconds
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    formatter.timeZone = TimeZone(secondsFromGMT: 0)
                    if let date = formatter.date(from: dateString) {
                        return date
                    }
                }
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date")
            }
            
            let userData = response.data
            let user = try decoder.decode(User.self, from: userData)
            await MainActor.run {
                self.currentUser = user
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    
    func checkSession() async {
        do {
            let session = try await client.auth.session
            await MainActor.run {
                self.session = session
                self.isAuthenticated = true
            }
            await fetchCurrentUser()
        } catch {
            await MainActor.run {
                self.session = nil
                self.isAuthenticated = false
                self.currentUser = nil
            }
        }
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        await MainActor.run {
            self.session = nil
            self.isAuthenticated = false
            self.currentUser = nil
        }
    }
}
