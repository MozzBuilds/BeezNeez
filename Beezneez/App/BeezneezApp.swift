import SwiftUI

@main
struct BeezneezApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
//
//
//@MainActor
//class AppBecameActiveDelegate: NSObject {
//    @Dependency(\.userRepository) private var userRepository
//    
//    func applicationDidBecomeActive() {
//        checkTrackingPermissions()
//        
//        /// Disabled due to splash screen delays and app store rejection
////        fetchRemoteFeatureFlags()
//        
//        if let activeUser = try? userRepository.activeUser() {
//            
//            if activeUser.isTutor() {
//                let displayFromViewController = UIViewController.topMostViewController()
//                
//                // Do not display views if they are already displayed.
//                if !(displayFromViewController is TUTRequestRefundViewController),
//                   !(displayFromViewController is TUTLateLessonCancellationViewController),
//                   !(displayFromViewController is UIAlertController),
//                   displayFromViewController?.isBeingPresented == false
//                {
//                    TutorManager.sharedInstance.fetchRefundRequests()
//                        .unwrap(next: { next in
//                            if !next.data.isEmpty {
//                                displayFromViewController?.present(TUTRequestRefundViewController.create(refundRequest: next.data[0]), animated: true, completion: nil)
//                            }
//                        }, error: { _ in })
//                }
//            }
//            
//            Task {
//                do {
//                    _ = try await userRepository.fetchUser()
//                } catch AuthenticationError.banned {
//                    NotificationsBroadcaster.broadcast(notification: .banned)
//                }
//            }
//        }
//    }
//    
//    private func checkTrackingPermissions() {
//        ATTrackingManager.requestTrackingAuthorization { _ in }
//    }
//    
//    private func fetchRemoteFeatureFlags() {
//        let user = try? userRepository.activeUser()
//        Task {
//            await RemoteFeatureFlag.instance.start(
//                userUuid: user?.uuid ?? nil,
//                properties: user?.getUserProperties() ?? nil
//            )
//        }
//    }
//}
//
//private extension User {
//    func getUserProperties() -> [String: Any] {
//        var signUpDate = ""
//        if let createdAt = createdAt {
//            signUpDate = Service.ISODateTimeFormatter.string(from: createdAt)
//        }
//        
//        return [
//            "domainCountry": "GB",
//            "lessonCount": statistics?.lessonsCompleted ?? 0,
//            "partialPostcode": address?.postcodeDistrict ?? "N/A",
//            "role": isTutor() ? "tutor" : "student",
//            "signupDate": signUpDate,
//        ]
//    }
//}
