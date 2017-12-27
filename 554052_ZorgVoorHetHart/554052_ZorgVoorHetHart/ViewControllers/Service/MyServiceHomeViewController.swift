//
//  ServiceHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyServiceHomeViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var myActualView: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var txtDisclaimerInfo: UITextView!
    @IBOutlet weak var txtDisclaimerTitle: UILabel!
    
    @IBOutlet weak var txtLogout: UILabel!
    @IBOutlet weak var imgLogout: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    
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
    @IBOutlet weak var btnWeightHeight: UIButton!
    
    var popupLogoutActive: Bool = false
    var popupLengthWeightActive: Bool = false
    @IBOutlet weak var imgPopupBackground: UIImageView!
    @IBOutlet weak var imgPopup: UIImageView!
    @IBOutlet weak var txtPopupTitle: UILabel!
    @IBOutlet weak var txtPopupLength: UILabel!
    @IBOutlet weak var txtPopupWeight: UILabel!
    @IBOutlet weak var inputPopupLength: UITextField!
    @IBOutlet weak var inputPopupWeight: UITextField!
    @IBOutlet weak var btnPopupLeft: UIButton!
    @IBOutlet weak var btnPopupRight: UIButton!
    
    
    // Save Settings in UserDefaults
    // https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults
    let defaults = UserDefaults.standard
    private let service: UserService = UserService()
    
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
        switchBigText.setOn(defaults.bool(forKey: "bigText"), animated: false)
        switchDailyNotification.addTarget(self, action: #selector(switchBigTextChanged(_:)), for: .valueChanged)
        
        imgDailyNotification.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtDailyNotification.text = "Dagelijkse herinneringen voor uw metingen"
        txtDailyNotification.font = txtBigText.font.withSize(12)
        switchDailyNotification.setOn(defaults.bool(forKey: "dailyNotifications"), animated: false)
        switchDailyNotification.addTarget(self, action: #selector(switchDailyNotificationChanged(_:)), for: .valueChanged)
        
        imgWeeklyMeasurement.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtWeeklyMeasurement.text = "Weekelijks uw metingen opsturen naar uw consulent"
        txtWeeklyMeasurement.font = txtBigText.font.withSize(12)
        switchWeeklyMeasurement.setOn(defaults.bool(forKey: "sendWeeklyMeasurement"), animated: false)
        switchWeeklyMeasurement.addTarget(self, action: #selector(switchWeeklyMeasurementChanged(_:)), for: .valueChanged)
        
        imgWeightHeight.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtWeightHeight.text = "Uw lengte en gewicht aanpassen"
        txtWeightHeight.font = txtBigText.font.withSize(12)
        
        imgAutomaticLogin.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtAutomaticLogin.text = "Automatisch inloggen"
        txtAutomaticLogin.font = txtBigText.font.withSize(12)
        switchAutomaticLogin.setOn(defaults.bool(forKey: "automaticLogin"), animated: false)
        switchAutomaticLogin.addTarget(self, action: #selector(switchAutomaticLoginChanged(_:)), for: .valueChanged)
        
        imgLogout.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtLogout.text = "Uitloggen"
        txtLogout.font = txtBigText.font.withSize(12)
        
        txtDisclaimerInfo.text = "Deze app is met de grootst mogelijke zorgvuldigheid samengesteld. Wij kunnen echter niet garanderen dat de app altijd zonder onderbrekingen, fouten of gebreken beschikbaar zal zijn of werken en dat de verschafte informatie volledig, juist of up-to-date is."
        txtDisclaimerInfo.backgroundColor = UIColor(rgb: 0xF8F8F8)
        
        setPopupUI()
    }
    
    private func setPopupUI()
    {
        imgPopupBackground.alpha = 0.5
        
        txtPopupLength.text = "Lengte (cm)"
        txtPopupLength.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        txtPopupWeight.text = "Gewicht (KG)"
        txtPopupWeight.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        inputPopupLength.placeholder = "0"
        inputPopupLength.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPopupLength.layer.borderWidth = 0
        inputPopupLength.keyboardType = UIKeyboardType.numberPad
        self.inputPopupLength.delegate = self
        
        if (User.loggedinUser?.length != nil)
        {
            inputPopupLength.text = String((User.loggedinUser?.length)!)
        }
        
        inputPopupWeight.placeholder = "0"
        inputPopupWeight.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPopupWeight.layer.borderWidth = 0
        inputPopupWeight.keyboardType = UIKeyboardType.numberPad
        self.inputPopupWeight.delegate = self
        
        if (User.loggedinUser?.weight != nil)
        {
            inputPopupWeight.text = String((User.loggedinUser?.weight)!)
        }
        
        setPopupActive(withValue: true)
    }
    
    @IBAction func btnLogout_OnClick(_ sender: Any)
    {
        popupLogoutActive = true
        imgPopupBackground.isHidden = false
        imgPopup.isHidden = false
        txtPopupTitle.isHidden = false
        txtPopupLength.isHidden = true
        txtPopupWeight.isHidden = true
        inputPopupLength.isHidden = true
        inputPopupWeight.isHidden = true
        btnPopupLeft.isHidden = false
        btnPopupRight.isHidden = false
        
        txtPopupTitle.text = "Weet u zeker dat u wilt uitloggen?"
        txtPopupTitle.font = txtPopupTitle.font.withSize(12)
        
        btnPopupRight.setTitle("Annuleren", for: .normal)
        btnPopupRight.setTitleColor(UIColor.white, for: .normal)
        btnPopupRight.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnPopupLeft.setTitle("Uitloggen", for: .normal)
        btnPopupLeft.setTitleColor(UIColor.white, for: .normal)
        btnPopupLeft.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        myScrollView.scrollToTop(animated: true)
        myScrollView.isScrollEnabled = false
    }
    
    @IBAction func btnWeightHeight_OnClick(_ sender: Any)
    {
        setPopupActive(withValue: false)
        popupLengthWeightActive = true
        
        txtPopupTitle.text = "Uw lengte en gewicht aanpassen"
        txtPopupTitle.font = txtPopupTitle.font.withSize(12)
        
        btnPopupRight.setTitle("Opslaan", for: .normal)
        btnPopupRight.setTitleColor(UIColor.white, for: .normal)
        btnPopupRight.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnPopupLeft.setTitle("Annuleren", for: .normal)
        btnPopupLeft.setTitleColor(UIColor.white, for: .normal)
        btnPopupLeft.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        myScrollView.scrollToTop(animated: true)
        myScrollView.isScrollEnabled = false
    }
    
    @IBAction func btnPopupRight_OnClick(_ sender: Any)
    {
        if (popupLengthWeightActive)
        {
            // Update lenght and weight
            let weight = Int(inputPopupWeight.text!)
            let length = Int(inputPopupLength.text!)
            
            service.updateLengthAndWeight(withSuccess: { (message: String) in
                self.setPopupActive(withValue: true)
                self.popupLogoutActive = false
                self.myScrollView.isScrollEnabled = true
            }, orFailure: { (error: String) in
                // failure
            }, andLength: length!, andWeight: weight!)
        }
        else
        {
            setPopupActive(withValue: true)
            popupLogoutActive = false
            myScrollView.isScrollEnabled = true
        }
    }
    
    @IBAction func btnPopupLeft_OnClick(_ sender: Any)
    {
        if (popupLengthWeightActive)
        {
            inputPopupLength.text = ""
            inputPopupWeight.text = ""
            popupLengthWeightActive = false
            setPopupActive(withValue: true)
        }
        else
        {
            // Perform logout code (clear caches if they exist, clear loggedinUser)
            self.dismiss(animated: true, completion:{ })
            User.loggedinUser = nil
        }
        myScrollView.isScrollEnabled = true
    }
    //vanaf 16
    private func setPopupActive(withValue value: Bool)
    {
        imgPopupBackground.isHidden = value
        imgPopup.isHidden = value
        txtPopupTitle.isHidden = value
        txtPopupLength.isHidden = value
        txtPopupWeight.isHidden = value
        inputPopupLength.isHidden = value
        inputPopupWeight.isHidden = value
        btnPopupLeft.isHidden = value
        btnPopupRight.isHidden = value
    }
    
    @objc func switchBigTextChanged(_ mySwitch: UISwitch)
    {
        let value = mySwitch.isOn
        defaults.set(value, forKey: "bigText")
    }
    
    @objc func switchDailyNotificationChanged(_ mySwitch: UISwitch)
    {
        let value = mySwitch.isOn
        defaults.set(value, forKey: "dailyNotifications")
    }
    
    @objc func switchWeeklyMeasurementChanged(_ mySwitch: UISwitch)
    {
        let value = mySwitch.isOn
        defaults.set(value, forKey: "sendWeeklyMeasurement")
    }
    
    @objc func switchAutomaticLoginChanged(_ mySwitch: UISwitch)
    {
        let value = mySwitch.isOn
        defaults.set(value, forKey: "automaticLogin")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
