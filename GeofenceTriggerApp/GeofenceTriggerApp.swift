//
//  GeofenceTriggerAppApp.swift
//  GeofenceTriggerApp
//
//  Created by umud on 6.12.2024.
//

import SwiftUI
import UIKit
import UserNotifications
import GeofenceTrigger

@main
struct GeofenceTriggerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                //LocationView()
                StartView()
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        // Bildirim izinlerini istemek
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        return true
    }
    
    // Bildirim tıklandığında aksiyon
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Geofencing izlemeyi durdur
        GeofenceTrigger.Geofence.shared.stopGeofenceMonitoring()
        
        // Aktif bildirimleri temizle
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        completionHandler()
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Uygulama on planda tum bildirimleri temizle
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Uygulama on planda tum bildirimleri temizle
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
