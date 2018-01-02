//
//  AppDelegate.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 13/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor(rgb: 0x1BC1B7)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        initNotifications()
        
        return true
    }
    
    // Because users can change the notification settings for your app at any time, you can use the getNotificationSettingsWithCompletionHandler: method of the shared UNUserNotificationCenter object to get your app’s authorization status at any time.
    private func initNotifications()
    {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
            if (granted)
            {
                let generalCategory = UNNotificationCategory(identifier: "GENERAL",
                                                             actions: [],
                                                             intentIdentifiers: [],
                                                             options: .customDismissAction)
                
                // Register the category.
                center.setNotificationCategories([generalCategory])
                
                let content = UNMutableNotificationContent()
                content.sound = UNNotificationSound.default()
                content.categoryIdentifier = "dailyMeasurement"
                content.title = NSString.localizedUserNotificationString(forKey: "Bloeddruk meting", arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: "Het is weer tijd voor uw dagelijkse meting!",
                                                                        arguments: nil)
                
                // Configure the trigger for a 7am wakeup.
                var dateInfo = DateComponents()
                dateInfo.hour = 18
                dateInfo.minute = 00
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
                
                // Create the request object.
                let request = UNNotificationRequest(identifier: "dailyMeasurement", content: content, trigger: trigger)
                
                center.add(request) { (error : Error?) in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
                }
            }
            else
            {
                
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Used for opening the application from a URL
    func application (_ application: UIApplication,
                      open url: URL,
                      sourceApplication: String?,
                      annotation: Any) -> Bool
    {
        let urlString = url.absoluteString
        let array = urlString.split(separator: ":", maxSplits: 1).map(String.init)
        print(array[1])
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (array[1].contains("login"))
        {
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "activateAccountViewController") as! MyAccountActivatedViewController
            destinationViewController.activationToken = String(array[1])
            
            let navigationController = self.window?.rootViewController as! UINavigationController
            navigationController.pushViewController(destinationViewController, animated: true)
        }
        else if (array[1].contains("resetpassword"))
        {
            let path = array[1].split(separator: "/")
            print(path[0])
            print(path[1])
            
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "passwordResetDeeplinkViewController") as! MyPasswordResetDeeplinkViewController
            destinationViewController.resetToken = String(path[1])
            
            let navigationController = self.window?.rootViewController as! UINavigationController
            navigationController.pushViewController(destinationViewController, animated: true)
        }
        else
        {
            // Something went wrong
        }
        
        return true
    }
}

