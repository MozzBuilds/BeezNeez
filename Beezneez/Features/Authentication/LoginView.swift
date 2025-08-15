import SwiftUI
import AuthenticationServices
import Supabase

// MARK: - Login View
struct LoginView: View {
    @EnvironmentObject var supabaseManager: SupabaseManager
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showError = false
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // App Logo/Title
                VStack(spacing: 16) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("Appointly")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Book appointments with ease")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Apple Sign In Button
                SignInWithAppleButton(
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        handleSignInWithApple(result)
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .padding(.horizontal, 40)
                .disabled(isLoading)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                Spacer()
                    .frame(height: 100)
            }
        }
        .alert("Sign In Error", isPresented: $showError) {
            Button("OK") {
                errorMessage = nil
            }
        } message: {
            Text(errorMessage ?? "An unknown error occurred")
        }
    }
    
    private func handleSignInWithApple(_ result: Result<ASAuthorization, Error>) {
        Task {
            await signInWithApple(result)
        }
    }
    
    @MainActor
    private func signInWithApple(_ result: Result<ASAuthorization, Error>) async {
        isLoading = true
        
        do {
            switch result {
            case .success(let authorization):
                guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                      let identityToken = appleIDCredential.identityToken,
                      let idToken = String(data: identityToken, encoding: .utf8) else {
                    throw AuthError.invalidCredentials
                }
                
                // Sign in with Supabase Auth
                try await supabaseManager.client.auth.signInWithIdToken(
                    credentials: .init(
                        provider: .apple,
                        idToken: idToken
                    )
                )
                
                // Get the session to get the auth user ID
                let session = try await supabaseManager.client.auth.session
                let authUserId = session.user.id.uuidString
                
                // Check if user exists in our users table
                let existingUserResponse = try? await supabaseManager.client
                    .from("users")
                    .select()
                    .eq("auth_user_id", value: authUserId)
                    .single()
                    .execute()
                
                if existingUserResponse?.data != nil {
                    // User exists, just update last login
                    try await supabaseManager.client
                        .from("users")
                        .update([
                            "last_login_at": ISO8601DateFormatter().string(from: Date())
                        ])
                        .eq("auth_user_id", value: authUserId)
                        .execute()
                } else {
                    // Create new user in our users table
//                    let newUser = [
//                        "id": UUID().uuidString,
//                        "auth_user_id": authUserId,
//                        "auth_provider": "apple",
//                        "auth_provider_id": appleIDCredential.user,
//                        "email": appleIDCredential.email ?? session.user.email ?? "",
//                        "first_name": appleIDCredential.fullName?.givenName ?? "",
//                        "last_name": appleIDCredential.fullName?.familyName ?? "",
//                        "preferred_contact_method": "email",
//                        "is_active": true
//                    ] as [String: Any]
//                    
//                    try await supabaseManager.client
//                        .from("users")
//                        .insert(newUser)
//                        .execute()
                }
                
                // The auth state listener in SupabaseManager will handle the rest
                
            case .failure(let error):
                throw error
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.showError = true
                self.isLoading = false
            }
        }
        
        isLoading = false
    }
}

// MARK: - Auth Error
enum AuthError: LocalizedError {
    case invalidCredentials
    case networkError
    case userCreationFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid Apple ID credentials. Please try again."
        case .networkError:
            return "Network error. Please check your connection."
        case .userCreationFailed:
            return "Failed to create user account. Please try again."
        }
    }
}
