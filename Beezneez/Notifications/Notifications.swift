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
