import UserNotifications
import OSLog

class Notifications {
    
    /// Schedule a local notification
    class func scheduleNotification(identifier: String, title: String, body: String, afterSeconds: Double) {

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .none
        
        let intervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: afterSeconds, repeats: false)
        
        let notificationRequest = UNNotificationRequest(identifier: identifier, content: content, trigger: intervalTrigger)

        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                Logger.createLog(type: .error, message: "Could not add notification", error:error)
            } else {
                Logger.createLog(type: .info, message: "Notification queued with identifier: \(identifier)")
            }
        }
    }
    
    /// Get the user consent
    class func askForNotificationConsent() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                Logger.createLog(type: .info, message: "User consented to Local Notifications")
            } else {
                Logger.createLog(type: .info, message: "User has not consented to Local Notications")
            }
        }
    }
}
//
//class AppNotificationsDelegate: NSObject, UNUserNotificationCenterDelegate {
//    
//    var testSanityCheck = 0
//    
//    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
//        
//        // Change this to your preferred presentation option
//        completionHandler([.banner, .sound, .list])
//    }
//    
//    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        defer { completionHandler() }
//        
//        @Dependency(\.messagingProvider) var provider
//
//        if let channelID = provider.channelIDFromNotification(response) {
//            DispatchQueue.main.async {
//                // Stream link
//                AppDelegate.shared.load(link: .streamChannel(cid: channelID))
//            }
//        } else {
//            // Regular notification
//            let userInfo = response.notification.request.content.userInfo
//            let type = userInfo["notificationType"] as? String
//            Ampli.instance.pushNotificationClicked(type: type)
//            
//            guard let link = Linkable(dictionary: userInfo) else { return }
//            
//            /// Our backend will continue to send push notifications for system messages
//            /// This ensures that if the user has Stream Chat enabled, the conversation is loaded in the Stream UI
//            Task {
//                var link = link
//                if case let .message(uuid) = link {
//                    let channelID = provider.createChannelId("")
//                    link = .streamChannel(cid: channelID)
//                }
//                
//                logger.info("[AppNotificationsDelegate] Navigating to link from Push Notification")
//                
//                await AppDelegate.shared.load(link: link)
//            }
//        }
//    }
//    
//    func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
//        guard let identifier = userInfo["notification_id"] as? String else {
//            logger.info("[AppNotificationsDelegate] Remote Notification missing notification_id")
//            return .noData
//        }
//        
//        guard let notificationType = (userInfo["type"] as? String), notificationType == "remove-notification" else { return .noData }
//        
//        logger.info("[AppNotificationsDelegate] Removing delivered notifications")
//        
//        UNUserNotificationCenter
//            .current()
//            .removeDeliveredNotifications(withIdentifiers: [identifier])
//        
//        return .noData
//    }
//    
//    func setToken(deviceToken: Data) {
//        if deviceToken.isEmpty {
//            logger.info("[AppNotificationsDelegate] New APNs token received was empty")
//            return
//        }
//        
//        logger.info("[AppNotificationsDelegate] New APNs token received")
//        
//        StorageUtils.setApnsToken(deviceToken)
//        
//        Messaging.messaging().apnsToken = deviceToken /// Register APNS token with firebase
//    }
//}
