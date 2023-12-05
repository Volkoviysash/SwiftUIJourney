//
//  LocalNotifications.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 04.12.2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func sceduleNotification() {
        // MARK: - Notification content
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This is so coool!"
        content.sound = .default
        content.badge = 1
        
        // MARK: - Trigger types
        // time
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 55
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100, // meters from center
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let regionTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        // MARK: - Request creating
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: calendarTrigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

struct LocalNotificationsView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission"){
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule notification"){
                NotificationManager.instance.sceduleNotification()
                print("Schedule notification")
            }
            Button("Cancel notification"){
                NotificationManager.instance.cancelNotification()
                print("Schedule notification")
            }
        }
    }
}

struct LocalNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsView()
    }
}
