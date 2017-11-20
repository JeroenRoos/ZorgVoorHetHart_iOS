//
//  MyTabBarController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 20/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTabBarItems()
    }
    
    func setTabBarItems()
    {
     
        //self.navigationItem.hidesBackButton = true
        
        // Unselected color:    737474          24x24 - 48x48 - 72x72
        // Selected color:      E84A4A          24x24 - 48x48 - 72x72
        
        let metingTab = (self.tabBar.items?[0])! as UITabBarItem
        metingTab.image = UIImage(named: "ic_meting_unselected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        metingTab.selectedImage = UIImage(named: "ic_meting_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        metingTab.title = "Meting"
        metingTab.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        metingTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0x737474)], for: UIControlState.normal)
        metingTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0xE84A4A)], for: UIControlState.selected)
        
        let dagboekTab = (self.tabBar.items?[1])! as UITabBarItem
        dagboekTab.image = UIImage(named: "ic_dagboek_unselected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        dagboekTab.selectedImage = UIImage(named: "ic_dagboek_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        dagboekTab.title = "Dagboek"
        dagboekTab.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        dagboekTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0x737474)], for: UIControlState.normal)
        dagboekTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0xE84A4A)], for: UIControlState.selected)
        
        
        let contactTab = (self.tabBar.items?[2])! as UITabBarItem
        contactTab.image = UIImage(named: "ic_contact_unselected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        contactTab.selectedImage = UIImage(named: "ic_contact_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        contactTab.title = "Contact"
        contactTab.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        contactTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0x737474)], for: UIControlState.normal)
        contactTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0xE84A4A)], for: UIControlState.selected)
        
        let serviceTab = (self.tabBar.items?[3])! as UITabBarItem
        serviceTab.image = UIImage(named: "ic_service_unselected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        serviceTab.selectedImage = UIImage(named: "ic_service_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        serviceTab.title = "Service"
        serviceTab.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        serviceTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0x737474)], for: UIControlState.normal)
        serviceTab.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(rgb: 0xE84A4A)], for: UIControlState.selected)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
