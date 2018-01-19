//
//  MyLoginViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 15/11/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit
import CryptoSwift
import SwiftSpinner

class MyLoginViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var checkboxStayLoggedin: CheckboxHelper!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    
    let service: UserService = UserService()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Inloggen"
        self.hideKeyboardWhenTappedAround()
        
        // Initialize the User Interface for this ViewController
        initUserInterface()
    }
    
    // Set the login credentials to empty, this is needed because you are returned to this ViewController when loggin out
    override func viewWillAppear(_ animated: Bool)
    {
        inputEmail.text = ""
        inputPassword.text = ""
    }
    
    // Called when the user pressed the "Login" button, this method wil check all the user input and determine the validity
    @IBAction func btnLogin_OnClick(_ sender: Any)
    {
        // Check all the input fields for validity
        if (!(inputEmail.text?.isEmpty)! &&
            !(inputPassword.text?.isEmpty)! &&
            inputEmail.isValidEmail())
        {
            SwiftSpinner.show("Bezig met inloggen...")
            let email = inputEmail.text!
            let trimmedEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            // Hash the password with Sha512 (CryptoSwift CocaoPod). This way the password will not be in plaintext when send to the API
            let password = inputPassword.text
            let hashedPassword = password?.sha512()
            
            self.btnLogin.isEnabled = false
            
            // Perform the Login network request
            service.login(withSuccess: { (user: User) in
                
                // Get the Value from the "Stay Loggedin" checkbox
                let value = self.checkboxStayLoggedin.isChecked
            
                // Set the value from the checkbox in the user defaults
                self.defaults.set(value, forKey: "automaticLogin")
                
                // If the user decided to enable automatic login, store the credentials in the keychain
                if (value)
                {
                    self.storeCredentialsInKeyChain(withPassword: hashedPassword!, andEmail: trimmedEmail)
                }
                
                User.loggedinUser = user
                self.btnLogin.isEnabled = true
                SwiftSpinner.hide()
                
                // Perform the segue to the next ViewController
                self.performSegue(withIdentifier: "loginFinish", sender: self)
                self.navigationController?.popToRootViewController(animated: false)
            }, orFailure: { (error: String, title: String) in
                // Hide the spinner and show the alert box if something went wrong during the request
                SwiftSpinner.hide()
                self.showAlertBox(withMessage: error, andTitle: title)
                self.btnLogin.isEnabled = true
            }, andEmail: trimmedEmail, andPassword: hashedPassword!)
        }
        else
        {
            // If the input isn't valid, go through all the checks for each input field, this wil display the error message if this wasn't already the case
            emailDidEndEditing(inputEmail)
            passwordDidEndEditing(inputPassword)
        }
    }
    
    // Stores the user credentials in the Keychain
    private func storeCredentialsInKeyChain(withPassword password: String,
                                            andEmail email: String)
    {
        // Get the "service" and the "account" that is used to store the credentials in the Keychain
        let passwordService = KeychainService().passwordService
        let emailService = KeychainService().emailService
        let account = KeychainService().keychainAccount
        
        // Save the password and the email address in the Keychain
        KeychainService.save(service: passwordService, account: account, data: password)
        KeychainService.save(service: emailService, account: account, data: email)
    }
    
    // The function that will be called when the user stops editing the email input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func emailDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorEmail, andText: "Email kan niet leeg zijn")
        
        // Check and set error message if the email address is not valid
        textField.setErrorMessageInvalidEmail(withLabel: errorEmail, andText: "Dit is geen correct emailadres")
    }
    
    // The function that will be called when the user stops editing the password input field, this will determine if the name is correct and show an error message when this isn't the case
    @objc func passwordDidEndEditing(_ textField: UITextField)
    {
        // Check and set error message if the textfield is empty
        textField.setErrorMessageEmptyField(withLabel: errorPassword, andText: "Wachtwoord kan niet leeg zijn")
    }
    
    // Initialize the User Interface for this ViewController
    private func initUserInterface()
    {
        btnLogin.setTitle("Inloggen", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.backgroundColor = UIColor(rgb: 0xE84A4A)
        
        checkboxStayLoggedin.setTitle("Ingelogd blijven", for: .normal)
        checkboxStayLoggedin.setTitleColor(UIColor.black, for: .normal)
        checkboxStayLoggedin.isChecked = defaults.bool(forKey: "automaticLogin")
        
        btnForgotPassword.setTitle("Wachtwoord vergeten?", for: .normal)
        btnForgotPassword.setTitleColor(UIColor.black, for: .normal)
        
        errorEmail.textColor = UIColor.red
        errorEmail.font = errorEmail.font.withSize(10)
        errorEmail.isHidden = true
        
        inputEmail.placeholder = "Voer uw e-mailadres in"
        inputEmail.placeholderTextColor = UIColor.gray
        inputEmail.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputEmail.layer.borderWidth = 0
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        self.inputEmail.delegate = self
        inputEmail.text = ""
        inputEmail.addTarget(self, action: #selector(emailDidEndEditing(_:)), for: .editingDidEnd)
        inputEmail.layer.borderColor = UIColor.red.cgColor
        
        errorPassword.textColor = UIColor.red
        errorPassword.font = errorPassword.font.withSize(10)
        errorPassword.isHidden = true
        
        inputPassword.placeholder = "Voer uw wachtwoord in"
        inputPassword.placeholderTextColor = UIColor.gray
        inputPassword.isSecureTextEntry = true
        inputPassword.backgroundColor = UIColor(rgb: 0xEBEBEB)
        inputPassword.layer.borderWidth = 0
        inputPassword.addTarget(self, action: #selector(passwordDidEndEditing(_:)), for: .editingDidEnd)
        self.inputPassword.delegate = self
        inputPassword.layer.borderColor = UIColor.red.cgColor
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
