//
//  MyNewMeasurementFinishedViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 27/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import UserNotifications
let defaults = UserDefaults.standard

class MyNewMeasurementFinishedViewController: UIViewController
{
    @IBOutlet weak var btnNotNow: UIButton!
    @IBOutlet weak var btnCheckDiary: UIButton!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtInfo: UILabel!
    var editingMeasurement: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        initUserInterface()
        
        // Set the notifications for a reminder of the measurement the next day
        setNotificationNextMeasurement()
    }
    
    private func setNotificationNextMeasurement()
    {
        // Because users can change the notification settings for your app at any time, check if the app is authorized
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .authorized &&
                defaults.bool(forKey: "dailyNotifications"))
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
                content.body = NSString.localizedUserNotificationString(forKey: "Het is weer tijd voor uw dagelijkse meting!", arguments: nil)
                
                // Configures a notification relative to the current time (84600 seconds == 23h 30m)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 84600, repeats: false)
                
                // Create the request object.
                let request = UNNotificationRequest(identifier: "dailyMeasurement", content: content, trigger: trigger)
                
                center.add(request) { (error : Error?) in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
                }
            }
        }
    }
    @IBAction func btnNotNow_OnClick(_ sender: Any)
    {
        //self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func btnCheckDiary_OnClick(_ sender: Any)
    {
        let lstViewControllers = self.tabBarController?.viewControllers!
        let navigationController = lstViewControllers![1]
        let viewController = navigationController.childViewControllers[0] as! MyMeasurementsDiaryHomeViewController
        viewController.updateMeasurements = true
        self.tabBarController?.selectedIndex = 1
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    private func initUserInterface()
    {
        btnCheckDiary.setTitle("Bekijk dagboek", for: .normal)
        btnCheckDiary.setTitleColor(UIColor.white, for: .normal)
        btnCheckDiary.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnNotNow.setTitle("Niet nu", for: .normal)
        btnNotNow.setTitleColor(UIColor.white, for: .normal)
        btnNotNow.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        txtTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        txtInfo.text = "U kunt gemakkelijk een overzicht van al uw metingen zien onder dagboek"
        txtInfo.font = txtInfo.font.withSize(12)
        
        if (editingMeasurement)
        {
            self.title = "Meting bewerken afgerond"
            txtTitle.text = "U heeft het bewerken van uw meting succesvol afgerond!"
        }
        else
        {
            self.title = "Nieuwe meting afgerond"
            txtTitle.text = "U heeft uw meting succesvol afgerond!"
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
