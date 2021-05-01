//
//  NotificationManager.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    var notificationPermission: Bool {
        get {
            UserDefaults.standard.bool(forKey: "notificationPermission")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "notificationPermission")
        }
    }
    
    func requestNotificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.notificationPermission = true
            } else {
                self.notificationPermission = false
            }
            
            completion()
        }
    }
    
    private func getIdentifier(for title: String, on date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let identifier = "\(title)\(hour)\(minute)"
        
        return identifier
    }
    
    func scheduleRepeatedNotification(title: String, for days: [String], on date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Let's get moving!"
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let requestIdentifier = "\(title)\(hour)\(minute)"
        
        for day in days {
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.weekday = Constants.DayToCalendarInt[day]
            dateComponents.timeZone = .current
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    
    func cancelNotifications(for alarm: Alarm) {
        let identifier = getIdentifier(for: alarm.name!, on: alarm.time!)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
}
