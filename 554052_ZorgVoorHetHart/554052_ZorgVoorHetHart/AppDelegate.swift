//
//  AppDelegate.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 13/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor(rgb: 0x1BC1B7)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        // Initialize the notifications, the first time the user starts the app the app needs approval to send notifications
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
            { }
            else
            { }
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
        // Determine which deeplink is used
        let urlString = url.absoluteString
        let array = urlString.split(separator: ":", maxSplits: 1).map(String.init)
        
        // Get the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // If the activate account deeplink is used send the user to the correct ViewController
        if (array[1].contains("login"))
        {
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "activateAccountViewController") as! MyAccountActivatedViewController
            destinationViewController.activationToken = String(array[1])
            
            let navigationController = self.window?.rootViewController as! UINavigationController
            navigationController.pushViewController(destinationViewController, animated: true)
        }
        // If the reset password deeplink is used send the user to the correct ViewController
        else if (array[1].contains("resetpassword"))
        {
            let path = array[1].split(separator: "/")
            
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
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "554052_ZorgVoorHetHart")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

