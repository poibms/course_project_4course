//
//  AppDelegate.swift
//  CoreData-Blog
//
//  Created by Cem Nisan on 5.03.2022.
//

import UIKit
import UserNotifications

@main
final class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate
{
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("User gave permissions for local notifications")
            }
        }

        if #available(iOS 13.0, *) {
            return true
        } else {
            app.router.start()
        }
        return true
    }
}

