//
//  ServiceHomeViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 23/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import SwiftSpinner

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
    @IBOutlet weak var txtMySettings: UILabel!
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var txtLength: UILabel!
    @IBOutlet weak var imgLength: UIImageView!
    @IBOutlet weak var btnLength: UIButton!
    
    @IBOutlet weak var txtWeight: UILabel!
    @IBOutlet weak var imgWeight: UIImageView!
    @IBOutlet weak var btnWeight: UIButton!
    
    var popupLogoutActive: Bool = false
    var popupLengthActive: Bool = false
    var popupWeightActive: Bool = false
    @IBOutlet weak var imgPopupBackground: UIImageView!
    @IBOutlet weak var imgPopup: UIImageView!
    @IBOutlet weak var txtPopupTitle: UILabel!
    @IBOutlet weak var txtPopup: UILabel!
    @IBOutlet weak var inputPopup: UITextField!
    @IBOutlet weak var btnPopupLeft: UIButton!
    @IBOutlet weak var btnPopupRight: UIButton!
    @IBOutlet weak var errorLabelPopup: UILabel!
    
    @IBOutlet weak var txtFAQ: UILabel!
    @IBOutlet weak var imgFAQ: UIImageView!
    @IBOutlet weak var txtDisclaimer: UILabel!
  
    let defaults = UserDefaults.standard
    private let service: UserService = UserService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Service"
        self.hideKeyboardWhenTappedAround()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
        
        // Set the popup UI to hidden
        setPopupHidden(withValue: true)
    }
    
    // Set the UI for the popup
    private func setPopupUI()
    {
        // Check which popup is active and set the UI
        if (popupLengthActive)
        {
            txtPopup.text = "Lengte (cm)"
            txtPopupTitle.text = "Uw lengte aanpassen"
            
            // Set the current length of the user in the textfield
            if (User.loggedinUser?.length != nil)
            {
                inputPopup.text = String((User.loggedinUser?.length)!)
            }
        }
        else
        {
            txtPopup.text = "Gewicht (KG)"
            txtPopupTitle.text = "Uw gewicht aanpassen"
            
            // Set the current weight of the user in the textfield
            if (User.loggedinUser?.weight != nil)
            {
                inputPopup.text = String((User.loggedinUser?.weight)!)
            }
        }
        
        btnPopupRight.setTitle("Opslaan", for: .normal)
        btnPopupRight.setTitleColor(UIColor.white, for: .normal)
        btnPopupRight.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        btnPopupLeft.setTitle("Annuleren", for: .normal)
        btnPopupLeft.setTitleColor(UIColor.white, for: .normal)
        btnPopupLeft.backgroundColor = UIColor(rgb: 0xA9A9A9)
        
        myScrollView.scrollToTop(animated: true)
        myScrollView.isScrollEnabled = false
        
        inputPopup.layer.borderWidth = 0
    }
    
    // Called whe the user presses the logout button
    @IBAction func btnLogout_OnClick(_ sender: Any)
    {
        // Check if any popups are active to make sure it is not called when the user doesn't want it to
        if (!popupLengthActive && !popupWeightActive && !popupLogoutActive)
        {
            popupLogoutActive = true
            imgPopupBackground.isHidden = false
            imgPopup.isHidden = false
            txtPopupTitle.isHidden = false
            txtPopup.isHidden = true
            inputPopup.isHidden = true
            btnPopupLeft.isHidden = false
            errorLabelPopup.isHidden = true
            btnPopupRight.isHidden = false
            
            txtPopupTitle.text = "Weet u zeker dat u wilt uitloggen?"
            txtPopupTitle.font = txtPopupTitle.font.withSize(12)
            
            btnPopupRight.setTitle("Annuleren", for: .normal)
            btnPopupRight.setTitleColor(UIColor.white, for: .normal)
            btnPopupRight.backgroundColor = UIColor(rgb: 0xE84A4A)
            
            btnPopupLeft.setTitle("Uitloggen", for: .normal)
            btnPopupLeft.setTitleColor(UIColor.white, for: .normal)
            btnPopupLeft.backgroundColor = UIColor(rgb: 0xA9A9A9)
            
            // Scroll to the top to view the popup and disable scrolling
            myScrollView.scrollToTop(animated: true)
            myScrollView.isScrollEnabled = false
        }
    }
    
    // Called when the user presses the button for editing length
    @IBAction func btnLength_OnClick(_ sender: Any)
    {
        // Check if any popups are active to make sure it is not called when the user doesn't want it to
        if (!popupLengthActive && !popupWeightActive && !popupLogoutActive)
        {
            popupLengthActive = true
            setPopupHidden(withValue: false)
            setPopupUI()
            errorLabelPopup.isHidden = true
        }
    }
    
    // Called when the user presses the button for editing weight
    @IBAction func btnWeight_OnClick(_ sender: Any)
    {
        // Check if any popups are active to make sure it is not called when the user doesn't want it to
        if (!popupLengthActive && !popupWeightActive && !popupLogoutActive)
        {
            popupWeightActive = true
            setPopupHidden(withValue: false)
            setPopupUI()
            errorLabelPopup.isHidden = true
        }
    }
    
    // Called when the user presses the FAQ button
    @IBAction func btnFAQ_OnClick(_ sender: Any)
    {
        // ...
    }
    
    // Called when the user presses the right button in the popup
    @IBAction func btnPopupRight_OnClick(_ sender: Any)
    {
        // Check which popup is active
        if (popupLengthActive)
        {
            // Check if the input is valid
            if (!(inputPopup.text?.isEmpty)! &&
                inputPopup.isValidNumberInput(withMinValue: 67, andMaxValue: 251))
            {
                SwiftSpinner.show("Bezig met het aanpassen van uw lengte...")
                let length = Int(inputPopup.text!)
                
                // Network request to update the length
                service.updateLengthOrWeight(withSuccess: { () in
                    User.loggedinUser?.length = length!
                    self.setPopupHidden(withValue: true)
                    self.popupLengthActive = false
                    self.errorLabelPopup.isHidden = true
                    self.myScrollView.isScrollEnabled = true
                    SwiftSpinner.hide()
                }, orFailure: { (error: String, title: String) in
                    SwiftSpinner.hide()
                    self.showAlertBox(withMessage: error, andTitle: title)
                }, andLength: length!, andWeight: nil)
            }
        }
        else if (popupWeightActive)
        {
            // Check if the input is valid
            if (!(inputPopup.text?.isEmpty)! &&
                inputPopup.isValidNumberInput(withMinValue: 30, andMaxValue: 594))
            {
                SwiftSpinner.show("Bezig met het aanpassen van uw gewicht...")
                let weight = Int(inputPopup.text!)
                
                // Network request to update the weight
                service.updateLengthOrWeight(withSuccess: { () in
                    User.loggedinUser?.weight = weight!
                    self.setPopupHidden(withValue: true)
                    self.errorLabelPopup.isHidden = true
                    self.popupWeightActive = false
                    self.myScrollView.isScrollEnabled = true
                    SwiftSpinner.hide()
                }, orFailure: { (error: String, title: String) in
                    SwiftSpinner.hide()
                    self.showAlertBox(withMessage: error, andTitle: title)
                }, andLength: nil, andWeight: weight)
            }
        }
        else
        {
            // If any of the other popup is active, close the popup
            setPopupHidden(withValue: true)
            popupLogoutActive = false
            myScrollView.isScrollEnabled = true
        }
    }
    
    // The function that will be called when the user stops editing the length/weight input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func popupDidEndEditing(_ textField: UITextField)
    {
        // Check which popup is active
        if (popupLengthActive)
        {
            // Check and set error message if the textfield is empty
            textField.setErrorMessageEmptyField(withLabel: errorLabelPopup, andText: "Lengte kan niet leeg zijn")
            
            // Check and set error message if the length is not valid
            textField.setErrorMessageInvalidLength(withLabel: errorLabelPopup, andText: "Lengte heeft geen geldige waarde")
        }
        else
        {
            // Check and set error message if the textfield is empty
            textField.setErrorMessageEmptyField(withLabel: errorLabelPopup, andText: "Gewicht kan niet leeg zijn")
            
            // Check and set error message if the length is not valid
            textField.setErrorMessageInvalidWeight(withLabel: errorLabelPopup, andText: "Gewicht heeft geen geldige waarde")
        }
    }
    
    // Called when the left button in the popup is called
    @IBAction func btnPopupLeft_OnClick(_ sender: Any)
    {
        // Check which popup is active
        if (popupLengthActive || popupWeightActive)
        {
            inputPopup.text = ""
            popupLengthActive = false
            errorLabelPopup.isHidden = true
            popupWeightActive = false
            setPopupHidden(withValue: true)
        }
        else
        {
            // This means the logout button is pressed. Remove the credentials from the keychain and set the automatic login UserDefault back to false
            defaults.set(false, forKey: "automaticLogin")
            KeychainService.remove(service: KeychainService().emailService, account: KeychainService().keychainAccount)
            KeychainService.remove(service: KeychainService().passwordService, account: KeychainService().keychainAccount)
            
            // Dismiss the current Navigation/Tab/ViewController and return to the login screen
            self.dismiss(animated: true, completion:{ })
            User.loggedinUser = nil
        }
        myScrollView.isScrollEnabled = true
    }
    
    // Set the UI for the popup hidden or visible
    private func setPopupHidden(withValue value: Bool)
    {
        imgPopupBackground.isHidden = value
        imgPopup.isHidden = value
        txtPopupTitle.isHidden = value
        txtPopup.isHidden = value
        inputPopup.isHidden = value
        btnPopupLeft.isHidden = value
        btnPopupRight.isHidden = value
    }
    
    // Called when the switch for the daily notifications is switched
    @objc func switchDailyNotificationChanged(_ mySwitch: UISwitch)
    {
        // Get the value from the switch and update the user defaults 
        let value = mySwitch.isOn
        defaults.set(value, forKey: "dailyNotifications")
    }
    
    // Called when the switch for the weekly measurements is switched
    @objc func switchWeeklyMeasurementChanged(_ mySwitch: UISwitch)
    {
        // Get the value from the switch and update the user defaults
        let value = mySwitch.isOn
        defaults.set(value, forKey: "sendWeeklyMeasurement")
    }
    
    // Called when the switch for the automatic login is switched
    @objc func switchAutomaticLoginChanged(_ mySwitch: UISwitch)
    {
        // Get the value from the switch and update the user defaults
        let value = mySwitch.isOn
        defaults.set(value, forKey: "automaticLogin")
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        myView.backgroundColor = UIColor(rgb: 0xEBEBEB)
        myActualView.backgroundColor = UIColor(rgb: 0xEBEBEB)
        
        txtMySettings.text = "Mijn instellingen"
        txtMySettings.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtMyAccount.text = "Mijn Account"
        txtMyAccount.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        txtDisclaimerTitle.text = "Informatie"
        txtDisclaimerTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        imgDailyNotification.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtDailyNotification.text = "Dagelijkse herinneringen voor uw metingen"
        txtDailyNotification.font = txtDailyNotification.font.withSize(12)
        switchDailyNotification.setOn(defaults.bool(forKey: "dailyNotifications"), animated: false)
        switchDailyNotification.addTarget(self, action: #selector(switchDailyNotificationChanged(_:)), for: .valueChanged)
        
        imgWeeklyMeasurement.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtWeeklyMeasurement.text = "Weekelijks uw metingen opsturen naar uw consulent"
        txtWeeklyMeasurement.font = txtWeeklyMeasurement.font.withSize(12)
        switchWeeklyMeasurement.setOn(defaults.bool(forKey: "sendWeeklyMeasurement"), animated: false)
        switchWeeklyMeasurement.addTarget(self, action: #selector(switchWeeklyMeasurementChanged(_:)), for: .valueChanged)
        
        imgLength.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtLength.text = "Uw lengte aanpassen"
        txtLength.font = txtLength.font.withSize(12)
        
        imgWeight.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtWeight.text = "Uw Gewicht aanpassen"
        txtWeight.font = txtWeight.font.withSize(12)
        
        imgAutomaticLogin.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtAutomaticLogin.text = "Automatisch inloggen"
        txtAutomaticLogin.font = txtAutomaticLogin.font.withSize(12)
        switchAutomaticLogin.setOn(defaults.bool(forKey: "automaticLogin"), animated: false)
        switchAutomaticLogin.addTarget(self, action: #selector(switchAutomaticLoginChanged(_:)), for: .valueChanged)
        
        imgLogout.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtLogout.text = "Uitloggen"
        txtLogout.font = txtLogout.font.withSize(12)
        
        imgFAQ.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtFAQ.text = "Veelgestelde vragen"
        txtFAQ.font = txtFAQ.font.withSize(12)
        txtDisclaimer.text = " Disclaimer"
        txtDisclaimer.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        txtDisclaimer.backgroundColor = UIColor(rgb: 0xF8F8F8)
        txtDisclaimer.isHidden = true
        
        txtDisclaimerInfo.text = "Disclaimer:\n\nDeze app is met de grootst mogelijke zorgvuldigheid samengesteld. Wij kunnen echter niet garanderen dat de app altijd zonder onderbrekingen, fouten of gebreken beschikbaar zal zijn of werken en dat de verschafte informatie volledig, juist of up-to-date is."
        txtDisclaimerInfo.backgroundColor = UIColor(rgb: 0xF8F8F8)
        
        // Popup UI
        imgPopupBackground.alpha = 0.5
        inputPopup.placeholder = "0"
        inputPopup.placeholderTextColor = UIColor.gray
        inputPopup.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPopup.layer.borderWidth = 0
        inputPopup.keyboardType = UIKeyboardType.numberPad
        self.inputPopup.delegate = self
        inputPopup.addTarget(self, action: #selector(popupDidEndEditing(_:)), for: .editingDidEnd)
        inputPopup.layer.borderColor = UIColor.red.cgColor
        
        errorLabelPopup.textColor = UIColor.red
        errorLabelPopup.font = errorLabelPopup.font.withSize(10)
        errorLabelPopup.isHidden = true
        
        txtPopupTitle.font = txtPopupTitle.font.withSize(12)
        txtPopup.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
