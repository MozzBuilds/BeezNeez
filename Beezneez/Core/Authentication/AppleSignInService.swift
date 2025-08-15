//
//  AppleSignInService.swift
//  Beezneez
//
//  Created by Colin Morrison on 14/08/2025.
//
//
//struct AppleCredentials: Codable, Equatable, Hashable {
//    let userId: String
//    let token: Data?
//    let email: String?
//    let firstName: String?
//    let lastName: String?
//    
//    /**
//     Store the credentials locally as Apple only provides the email and name on the first successful attempt
//     */
//    func persist() -> AppleCredentials {
//        if let firstName = firstName, let lastName = lastName, let email = email, let token = token {
//            return createCacheUser(userId, token, email, firstName, lastName)
//        }
//        
//        if let cacheCreds = StorageUtils.getAppleUserCredentials(), cacheCreds.userId == userId {
//            return updateCacheUser(cacheCreds)
//        }
//
//        return self
//    }
//    
//    private func updateCacheUser(_ cacheCreds: AppleCredentials) -> AppleCredentials {
//        let creds = AppleCredentials(userId: userId, token: token, email: cacheCreds.email, firstName: cacheCreds.firstName, lastName: cacheCreds.lastName)
//        StorageUtils.setAppleUserCredentials(user: creds)
//        return creds
//    }
//    
//    private func createCacheUser(_ userId: String, _ token: Data, _ email: String, _ firstName: String, _ lastName: String) -> AppleCredentials {
//        let creds = AppleCredentials(userId: userId, token: token, email: email, firstName: firstName, lastName: lastName)
//        StorageUtils.setAppleUserCredentials(user: creds)
//        return creds
//    }
//}

//class AppleAuthenticationService: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
//    
//    private typealias AuthorizationCheckedContinuation = CheckedContinuation<AppleCredentials, Error>
//    
//    private var authorizationContinuation: AuthorizationCheckedContinuation?
//    
//    func requestAuthentication() async throws -> AppleCredentials {
//        try await withCheckedThrowingContinuation { (continuation: AuthorizationCheckedContinuation) in
//            self.authorizationContinuation = continuation
//            
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.email, .fullName]
//            
//            let authorisationController = ASAuthorizationController(authorizationRequests: [request])
//            authorisationController.delegate = self
//            authorisationController.presentationContextProvider = self
//            authorisationController.performRequests()
//        }
//    }
//    
//    @MainActor func presentationAnchor(for _: ASAuthorizationController) -> ASPresentationAnchor {
//        UIApplication.shared.getKeyWindow()!
//    }
//    
//    func authorizationController(controller _: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            let credentials = AppleCredentials(
//                userId: appleIDCredential.user,
//                token: appleIDCredential.identityToken,
//                email: appleIDCredential.email,
//                firstName: appleIDCredential.fullName?.givenName,
//                lastName: appleIDCredential.fullName?.familyName
//            )
//            authorizationContinuation?.resume(returning: credentials)
//        default: return
//        }
//    }
//    
//    func authorizationController(controller _: ASAuthorizationController, didCompleteWithError error: Error) {
//        authorizationContinuation?.resume(throwing: error)
//    }
//}
//
//extension DependencyValues {
//    var appleAuthenticationService: AppleAuthenticationService {
//        get { self[AppleAuthenticationService.self] }
//        set { self[AppleAuthenticationService.self] = newValue }
//    }
//}
//
//extension AppleAuthenticationService: DependencyKey {
//    static var liveValue = AppleAuthenticationService()
//}
