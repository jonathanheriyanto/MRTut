//
//  NotificationHandler.swift
//  MRTJ
//
//  Created by Febrian Daniel on 23/07/23.
//

import Foundation
import UserNotifications
import CoreLocation
import Firebase
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
            Messaging.messaging().subscribe(toTopic: "lebakBulus") { error in
                print("Subscribed to lebak bulus topic")
            }
        case .fatmawati:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "fatmawatiIndomaret") { error in
                print("Subscribed to fatmawati Indomaret topic")
            }
        case .cipeteRaya:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "lebakBulus") { error in
                print("Subscribed to lebak bulus topic")
            }
        case .hajiNawi:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "hajiNawi") { error in
                print("Subscribed to haji nawi topic")
            }
        case .blokA:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "blokA") { error in
                print("Subscribed to blok a topic")
            }
        case .blokM:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "blokM") { error in
                print("Subscribed to blok m topic")
            }
        case .asean:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "asean") { error in
                print("Subscribed to asean topic")
            }
        case .senayan:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "senayan") { error in
                print("Subscribed to senayan topic")
            }
        case .istora:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "istore") { error in
                print("Subscribed to istora mandiri topic")
            }
        case .benHil:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "bendunganHilir") { error in
                print("Subscribed to bendungan hilir topic")
            }
        case .setiabudi:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "setiabudi") { error in
                print("Subscribed to setiabudi astra topic")
            }
        case .dukuhAtas:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "dukuhAtas") { error in
                print("Subscribed to dukuh atas bni topic")
            }
        case .bundaranHI:
            notificationforRegions(region: region)
            Messaging.messaging().subscribe(toTopic: "bundaranHI") { error in
                print("Subscribed to bundaran HI topic")
            }
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
    }
}

