//
//  MyForgotPasswordDeeplinkViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen Roos on 28/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import CryptoSwift
import SwiftSpinner

class MyPasswordResetDeeplinkViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var inputPasswordCheck: UITextField!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var errorPasswordCheck: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    var resetToken: String = ""
    let service: UserService = UserService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Wachtwoord herstellen"
        self.hideKeyboardWhenTappedAround()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    // The function that will be called when the user stops editing the password input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func passwordDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorPassword, andText: "Wachtwoord kan niet leeg zijn")
    }
    
    // The function that will be called when the user stops editing the password input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func passwordCheckDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorPasswordCheck, andText: "Wachtwoord kan niet leeg zijn")
        
        // Check and set error message if the password is identical with the first password
        textField.setErrorMessagePasswordIdentical(withLabel: errorPasswordCheck, andText: "De wachtwoorden komen niet overeen", andOtherPassword: inputPassword)
    }
    
    // Called when the user pressed the "Verander Wachtwoord" button, this method wil check all the user input and determine the validity
    @IBAction func btnFinish_OnClick(_ sender: Any)
    {
        // Check the user input
        if (!(inputPassword.text?.isEmpty)! &&
            !(inputPasswordCheck.text?.isEmpty)! &&
            inputPassword.text == inputPasswordCheck.text)
        {
            SwiftSpinner.show("Bezig met het aanpassen van uw wachtwoord...")
            self.btnFinish.isEnabled = false
            
            // Hash the password with Sha512 (CryptoSwift CocaoPod). This way the password will not be in plaintext when send to the API
            let password = inputPassword.text!
            let hashedPassword = password.sha512()
            
            // Perform the resetPassword network request
            service.resetPassword(withSuccess: { () in
                self.btnFinish.isEnabled = true
                SwiftSpinner.hide()
                self.performSegue(withIdentifier: "resetSuccess", sender: self)
            }, orFailure: { (error: String, title: String) in
                self.btnFinish.isEnabled = true
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
            }, andPassword: hashedPassword,
               andPasswordCheck: hashedPassword,
               andToken: resetToken)
        }
        else
        {
            // If the input isn't valid, go through all the checks for the input fields, this wil display the error message if this wasn't already the case
            passwordDidEndEditing(inputPassword)
            passwordCheckDidEndEditing(inputPasswordCheck)
        }
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        txtTitle.text = "U kunt uw wachtwoord hier aanpassen. Vul uw nieuwe wachtwoord in in de onderstaande velden."
        txtTitle.font = txtTitle.font.withSize(12)
        
        btnFinish.setTitle("Aanpassen", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.backgroundColor = UIColor(rgb: 0x1BC1B7)
        
        errorPassword.textColor = UIColor.red
        errorPassword.font = errorPassword.font.withSize(10)
        errorPassword.isHidden = true
        
        inputPassword.placeholder = "Vul uw nieuwe wachtwoord in"
        inputPassword.placeholderTextColor = UIColor.gray
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.isSecureTextEntry = true
        inputPassword.addTarget(self, action: #selector(passwordDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPassword.delegate = self
        inputPassword.layer.borderColor = UIColor.red.cgColor
        
        errorPasswordCheck.textColor = UIColor.red
        errorPasswordCheck.font = errorPasswordCheck.font.withSize(10)
        errorPasswordCheck.isHidden = true
        
        inputPasswordCheck.placeholder = "Herhaal uw nieuwe wachtwoord in"
        inputPasswordCheck.placeholderTextColor = UIColor.gray
        inputPasswordCheck.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPasswordCheck.layer.borderWidth = 0
        inputPasswordCheck.isSecureTextEntry = true
        inputPasswordCheck.addTarget(self, action: #selector(passwordCheckDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPasswordCheck.delegate = self
        inputPasswordCheck.layer.borderColor = UIColor.red.cgColor
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
