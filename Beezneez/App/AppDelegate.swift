import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // TODO: - Required if notifications are to be shown
//        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
}


// TODO: - Implement something like this for any notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
    // TODO: - Optional function to handle a user tapping on a notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        let application = UIApplication.shared
//        let userInfo = response.notification.request.content.userInfo
//
//        switch application.applicationState {
//            case .active:
//                // Print or do something
//            case .inactive:
//                // as above
//            case .background:
//                // do something
//        }
//
//        completionHandler() // Execute something based upon the notification itself
//    }
}
