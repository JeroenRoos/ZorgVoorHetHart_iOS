//
//  ServiceHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyServiceHomeViewController: UIViewController
{
    @IBOutlet weak var myActualView: UIView!
    
    @IBOutlet weak var txtDisclaimerInfo: UITextView!
    @IBOutlet weak var txtDisclaimerTitle: UILabel!
    
    @IBOutlet weak var txtLogout: UILabel!
    @IBOutlet weak var imgLogout: UIImageView!
    
    @IBOutlet weak var imgAutomaticLogin: UIImageView!
    @IBOutlet weak var switchAutomaticLogin: UISwitch!
    @IBOutlet weak var txtAutomaticLogin: UILabel!
    
    @IBOutlet weak var imgDailyNotification: UIImageView!
    @IBOutlet weak var txtDailyNotification: UILabel!
    @IBOutlet weak var switchDailyNotification: UISwitch!
    
    @IBOutlet weak var imgWeeklyMeasurement: UIImageView!
    @IBOutlet weak var txtWeeklyMeasurement: UILabel!
    @IBOutlet weak var switchWeeklyMeasurement: UISwitch!
    
    @IBOutlet weak var txtMyAccount: UILabel!
    @IBOutlet weak var switchBigText: UISwitch!
    @IBOutlet weak var txtMySettings: UILabel!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var imgBigText: UIImageView!
    @IBOutlet weak var txtBigText: UILabel!
    
    @IBOutlet weak var txtWeightHeight: UILabel!
    @IBOutlet weak var imgWeightHeight: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Service"
        self.hideKeyboardWhenTappedAround()
        
        myView.backgroundColor = UIColor(rgb: 0xEBEBEB)
        myActualView.backgroundColor = UIColor(rgb: 0xEBEBEB)
        
        txtMySettings.text = "Mijn instellingen"
        txtMySettings.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtMyAccount.text = "Mijn Account"
        txtMyAccount.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtDisclaimerTitle.text = "Disclaimer"
        txtDisclaimerTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        imgBigText.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtBigText.text = "Grotere tekst"
        txtBigText.font = txtBigText.font.withSize(12)
        switchBigText.setOn(false, animated: false)
        
        imgDailyNotification.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtDailyNotification.text = "Dagelijkse herinneringen voor uw metingen"
        txtDailyNotification.font = txtBigText.font.withSize(12)
        switchDailyNotification.setOn(false, animated: false)
        
        imgWeeklyMeasurement.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtWeeklyMeasurement.text = "Weekelijks uw metingen opsturen naar uw consulent"
        txtWeeklyMeasurement.font = txtBigText.font.withSize(12)
        switchWeeklyMeasurement.setOn(false, animated: false)
        
        imgWeightHeight.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtWeightHeight.text = "Uw lengte en gewicht aanpassen"
        txtWeightHeight.font = txtBigText.font.withSize(12)
        
        imgAutomaticLogin.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtAutomaticLogin.text = "Automatisch inloggen"
        txtAutomaticLogin.font = txtBigText.font.withSize(12)
        switchAutomaticLogin.setOn(false, animated: false)
        
        imgLogout.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtLogout.text = "Uitloggen"
        txtLogout.font = txtBigText.font.withSize(12)
        
        txtDisclaimerInfo.text = "Deze app is met de grootst mogelijke zorgvuldigheid samengesteld. Wij kunnen echter niet garanderen dat de app altijd zonder onderbrekingen, fouten of gebreken beschikbaar zal zijn of werken en dat de verschafte informatie volledig, juist of up-to-date is."
        txtDisclaimerInfo.backgroundColor = UIColor(rgb: 0xF8F8F8)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
