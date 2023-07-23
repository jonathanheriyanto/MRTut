//
//  NotificationHandler.swift
//  MRTJ
//
//  Created by Febrian Daniel on 23/07/23.
//

import Foundation
import UserNotifications
import CoreLocation
import SwiftUI

class NotificationHandler: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    var notificationCenter = UNUserNotificationCenter.current()
    
    var timeNotified: TimeInterval = 1
    var timeNotifiedRegion: TimeInterval = 2
    
    var identifierRegion = "Region-Based Notification"
    
//    @State var isPresented: Bool = true
    
    func requestUserNotification() {
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("permission not granted")
            } else {
                print("permission granted")
            }
        }
    }
    
    func handleEnterEvent(forRegion region: CLRegion!) {
        let content = UNMutableNotificationContent()
        content.title = .mrtJ
        content.body = "You are inside \(region.identifier) station area"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNotified, repeats: false)
        let identifier = region.identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        content.userInfo["type"] = "enterEvent"
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            } else {
                print("notifications added")
            }
        }
    }
    
    func handleExitEvent(forRegion region: CLRegion!) {
        let content = UNMutableNotificationContent()
        content.title = .mrtJ
        content.body = "You are outside \(region.identifier) station area"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNotified, repeats: false)
        let identifier = region.identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        content.userInfo["type"] = "exitEvent"
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            } else {
                print("notifications added")
            }
        }
    }
    
    func notificationforRegions(region: CLRegion!) {
        let content = UNMutableNotificationContent()
        content.title = .mrtJ
        content.body = "Ini notifikasi khusus \(region.identifier)"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNotifiedRegion, repeats: false)
        let request = UNNotificationRequest(identifier: identifierRegion, content: content, trigger: trigger)
        
        content.userInfo["type"] = "regionBasedEvent"
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            } else {
                print("notifications added")
            }
        }
    }
    
    func handleRegionBasedEvent(forRegion region: CLRegion!) {
        switch region.identifier {
        case .lebakBulus:
            notificationforRegions(region: region)
        case .fatmawati:
            notificationforRegions(region: region)
        case .cipeteRaya:
            notificationforRegions(region: region)
        case .cipeteRaya:
            notificationforRegions(region: region)
        case .blokA:
            notificationforRegions(region: region)
        case .blokM:
            notificationforRegions(region: region)
        case .asean:
            notificationforRegions(region: region)
        case .senayan:
            notificationforRegions(region: region)
        case .istora:
            notificationforRegions(region: region)
        case .benHil:
            notificationforRegions(region: region)
        case .setiabudi:
            notificationforRegions(region: region)
        case .dukuhAtas:
            notificationforRegions(region: region)
        case .bundaranHI:
            notificationforRegions(region: region)
        default:
            break
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.notification.request.identifier
        
        print(identifier)
        
        if let userInfo = response.notification.request.content.userInfo as? [String: Any],
           let notificationType = userInfo["type"] as? String {
            
            switch notificationType {
            case "enterEvent":
                break
            case "exitEvent":
                break
            case "regionBasedEvent":
                break
            default:
                break
            }
        }
        completionHandler()
    }
}

